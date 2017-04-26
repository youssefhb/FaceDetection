#!/usr/bin/env python

from keras.models import Model
from keras import regularizers
from keras.utils.visualize_util import plot
from KerasLayers.Custom_layers import LRN2D

from keras.initializers import Constant,RandomNormal

from keras.layers.core import Flatten, Dense, Dropout
from keras.layers import Reshape, Permute, Activation, Input, merge
from keras.layers.convolutional import Convolution2D, MaxPooling2D, ZeroPadding2D, Conv2D
from keras.optimizers import SGD
from keras.utils import np_utils
from keras.preprocessing.image import ImageDataGenerator
from keras.callbacks import ModelCheckpoint
from keras.callbacks import LearningRateScheduler
import math

from keras import backend as K
K.set_image_dim_ordering('th')

from alexnet_base import *





# =================================================
#               Global constants
# =================================================
NB_CLASS = 2         # number of classes
LEARNING_RATE = 0.01
MOMENTUM = 0.9
ALPHA = 0.0001
BETA = 0.75
GAMMA = 0.1
DROPOUT = 0.5
WEIGHT_DECAY = 0.0005
LRN2D_norm = True       # whether to use batch normalization
# Theano - 'th' (channels, width, height)
# Tensorflow - 'tf' (width, height, channels)
DIM_ORDERING = 'th'
class_mode = 'categorical'
#class_mode = 'binary'



# =================================================
# learning rate schedule
# Drops the learning rate by 'drop' every 50 'epochs_drop'
# =================================================
def step_decay(epoch):
    initial_lrate = 0.001
    drop = 0.5
    epochs_drop = 100.0
    lrate = initial_lrate * math.pow(drop, math.floor((1+epoch)/epochs_drop))
    return lrate


# =================================================
#   Saves the model architecture and weights
# =================================================
def saveModel(model):
    # serialize model to JSON
    model_json = model.to_json()
    with open("./model-save/model-alexNet.json", "w") as json_file:
        json_file.write(model_json)
        # serialize weights to HDF5
        model.save_weights("./model-save/model-alexNet.h5")
        print("Saved model to disk")

# =================================================
#       Training and validation data generators
# =================================================
def generateData():

    training_images_dir   ='./Data/train/'
    validation_images_dir ='./Data/validation/'

    img_Data_Gen = ImageDataGenerator(width_shift_range=0.3,
                                    height_shift_range=0.3,
                                    featurewise_center=False,
                                    featurewise_std_normalization=False,
                                    vertical_flip=True)


    train_generator = img_Data_Gen.flow_from_directory(training_images_dir,
                                                        target_size=(img_w, img_h),
                                                        batch_size=60,
                                                        shuffle=True,
                                                        seed=13,
                                                        classes=['face', 'non-face'],
                                                        class_mode=class_mode)


    valid_generator = img_Data_Gen.flow_from_directory(validation_images_dir,            
                                        batch_size=30,
                                        target_size=(img_w, img_h),
                                        shuffle=True,
                                        seed=73,
                                        classes = ['face', 'non-face'],
                                        class_mode=class_mode)
                                        #,save_to_dir='./Data/Img-augmented')


    return  train_generator,valid_generator





# =================================================
#           Train the model from scrach
# =================================================
def train_from_scrach(callbacks_list):

    model = create_model()
    sgd = SGD(lr=0.01, decay=0.0004, momentum=0.9, nesterov=True)

  

    print "compliling the model"
    model.compile(optimizer=sgd,loss=class_mode+'_crossentropy',metrics=['accuracy'])

    model.summary()

    train_generator,validation_generator = generateData()


    # initial_epoch: Epoch at which to start training (useful for resuming a previous training run)
    # teps_per_epoch: Total number of steps (batches of samples) to yield from generator 
    # before declaring one epoch finished and starting the next epoch. 
    # It should typically be equal to the number of unique samples of your dataset divided by the batch size.
    history = model.fit_generator(train_generator,
                        steps_per_epoch=614,
                        validation_data=validation_generator,
                        validation_steps=409,
                        epochs=1000,callbacks=callbacks_list,
                        verbose=1,initial_epoch=0)

    saveModel(model)



# =================================================
#       Resume the training from an epoch
# =================================================
def resume_training_from_snapshot(weights_file,callbacks_list,initialEpoch=0):

    model = create_model()
    sgd = SGD(lr=0.01, decay=0.0004, momentum=0.9, nesterov=True)

    # learning schedule callback
    lrate = LearningRateScheduler(step_decay)

    print "Loads weights from a snapshot"
    # Loads parameters from a snapshot
    model.load_weights(weights_file)

    print "compliling the model"
    model.compile(optimizer=sgd,loss=class_mode+'_crossentropy',metrics=['accuracy'])

    model.summary()

    train_generator,validation_generator = generateData()


    # initial_epoch: Epoch at which to start training (useful for resuming a previous training run)
    # teps_per_epoch: Total number of steps (batches of samples) to yield from generator 
    # before declaring one epoch finished and starting the next epoch. 
    # It should typically be equal to the number of unique samples of your dataset divided by the batch size.
    history = model.fit_generator(train_generator,
                        steps_per_epoch=614,
                        validation_data=validation_generator,
                        validation_steps=20,
                        epochs=1000,callbacks=callbacks_list,
                        verbose=1,initial_epoch=initialEpoch)

    saveModel(model)






# =================================================
#                       M A I N
# =================================================
if __name__ == "__main__":

    # =================================================
    #           Checkpoint strategy
    # =================================================
    #filepath="./model-save/model-alexNet-{epoch:0005d}-{val_acc:.2f}.hdf5"
    filepath="./model-save/model-alexNet-{val_acc:.2f}.hdf5"
    checkpoint = ModelCheckpoint(filepath, monitor='val_acc', verbose=1, save_best_only=True, mode='max')
    # learning schedule callback
    lrate = LearningRateScheduler(step_decay)
    callbacks_list = [checkpoint,lrate]


    #train_from_scrach(callbacks_list)
    resume_training_from_snapshot("./model-save/model-alexNet-0.98.hdf5",callbacks_list,initialEpoch=65)












    








    
    

