from keras.layers.core import Flatten, Dense, Dropout
from keras.layers import   Activation, Input, merge
from keras.layers.convolutional import  MaxPooling2D, ZeroPadding2D, Conv2D
from keras.optimizers import SGD
from keras.preprocessing import image
from KerasLayers.Custom_layers import LRN2D
from keras import regularizers
from keras.models import Model
from keras.initializers import Constant,RandomNormal



img_w = 127
img_h = 127


# global constants
NB_CLASS      = 2         # number of classes
LEARNING_RATE = 0.01
MOMENTUM      = 0.9
ALPHA         = 0.0001
BETA          = 0.75
GAMMA         = 0.1
DROPOUT       = 0.5
WEIGHT_DECAY  = 0.0005
LRN2D_norm    = True       # whether to use batch normalization

# Theano - 'th' (channels, width, height)
# Tensorflow - 'tf' (width, height, channels)
DIM_ORDERING = 'th'




def conv2D_lrn2d(x, nb_filter, nb_row, nb_col,
                 padding='same', strides=(1, 1),
                 activation='relu', LRN2D_norm=True, bias_initializer='zeros',kernel_initializer='glorot_uniform',
                 weight_decay=WEIGHT_DECAY, data_format="channels_first",name='conv'):
    '''

        Info:
            Function taken from the Inceptionv3.py script keras github


            Utility function to apply to a tensor a module Convolution + lrn2d
            with optional weight decay (L2 weight regularization).
    '''
    if weight_decay:
        W_regularizer = regularizers.l2(weight_decay)
        b_regularizer = regularizers.l2(weight_decay)
    else:
        W_regularizer = None
        b_regularizer = None


    x = Conv2D(nb_filter, (nb_row, nb_col), bias_regularizer=b_regularizer,
                            activation=activation,
                            data_format="channels_first",
                            padding=padding,
                            strides=strides,
                            bias_initializer='zeros',kernel_initializer='glorot_uniform',
                            kernel_regularizer=W_regularizer, use_bias=False,name=name)(x)


    x = ZeroPadding2D(padding=(1, 1), data_format="channels_first")(x)

    if LRN2D_norm:

        x = LRN2D(alpha=ALPHA, beta=BETA)(x)
        x = ZeroPadding2D(padding=(1, 1), data_format="channels_first")(x)

    return x


def create_model():
    # Define image input layer
    if DIM_ORDERING == 'th':
        INP_SHAPE = (3, img_w, img_h)  # 3 - Number of RGB Colours
        input_layer = Input(shape=INP_SHAPE,name='input_layer')
        CONCAT_AXIS = 1
    elif DIM_ORDERING == 'tf':
        INP_SHAPE = (img_w, img_h, 3)  # 3 - Number of RGB Colours
        input_layer = Input(shape=INP_SHAPE)
        CONCAT_AXIS = 3
    else:
        raise Exception('Invalid dim ordering: ' + str(DIM_ORDERING))

    # ====================================================
    #                Convolution Net Layer 1
    # ====================================================
    conv_1 = conv2D_lrn2d(input_layer,96, 11, 11, strides=(4,4),activation='relu',padding='same',name='conv1')
    conv_1 = MaxPooling2D(pool_size=(3,3),strides=(4,4),name='Max Pooling 1')(conv_1)
    #conv_1 = ZeroPadding2D(padding=(1,1))(conv_1)



    # ====================================================
    #                Convolution Net Layer 2
    # ====================================================
    conv_2 = conv2D_lrn2d(conv_1, 256, 5, 5, strides=(1, 1),activation='relu',
                        bias_initializer=Constant(1),
                        kernel_initializer=RandomNormal(mean=0.0, stddev=0.01,seed=None),
                        padding='same',name='conv2')
    conv_2 = MaxPooling2D(pool_size=(3,3),strides=(2,2),name='Max Pooling 2')(conv_2)
    #conv_2 = ZeroPadding2D(padding=(1, 1))(conv_2)

    

    # ====================================================
    #                Convolution Net Layer 3
    # ====================================================
    conv_3 = conv2D_lrn2d(conv_2, 384, 3, 3, strides=(1, 1), activation='relu',
        padding='same',
        bias_initializer=Constant(1),
        kernel_initializer=RandomNormal(mean=0.0, stddev=0.01,seed=None),name='conv3')
    #conv_3 = MaxPooling2D(strides=(2, 2), pool_size=(2,2))(x)
    #conv_3 = ZeroPadding2D(padding=(1, 1))(conv_2)

    # ====================================================
    #                Convolution Net Layer 4
    # ====================================================
    conv_4 = conv2D_lrn2d(conv_3, 384, 3, 3, strides=(1, 1), activation='relu',
    padding='same',
    bias_initializer=Constant(1),
    kernel_initializer=RandomNormal(mean=0.0, stddev=0.01,seed=None),name='conv4')
    #x = ZeroPadding2D(padding=(1, 1))(x)

    # ====================================================
    #                Convolution Net Layer 5
    # ====================================================
    conv_5 = conv2D_lrn2d(conv_4, 256, 3, 3, strides=(1, 1), activation='relu',
    padding='same',
    bias_initializer=Constant(1),
    kernel_initializer=RandomNormal(mean=0.0, stddev=0.01,seed=None),name='conv5')
    conv_5 = MaxPooling2D(pool_size=(3,3),strides=(2,2),name='Max Pooling 3')(conv_5)


    # Channel 1 - Cov Net Layer 7
    flatten = Flatten(name='Flatten')(conv_5)
    inner_product = Dense(4096, activation='relu',bias_initializer=Constant(1),
    kernel_initializer=RandomNormal(mean=0.0, stddev=0.01,seed=None),name='Dot Product 1')(flatten)
    inner_product = Dropout(DROPOUT,name='Dropout 1')(inner_product)

    # Channel 1 - Cov Net Layer 8
    inner_product = Dense(4096, activation='relu',bias_initializer=Constant(1),
    kernel_initializer=RandomNormal(mean=0.0, stddev=0.01,seed=None),name='Dot Product 2')(inner_product)
    dropout = Dropout(DROPOUT,name='Dropout 2')(inner_product)

    # Final Channel - Cov Net 9
    output = Dense(units=NB_CLASS,activation='softmax',name='Softmax')(dropout)

    alexnet = Model(inputs=input_layer,outputs=output)

    return alexnet