#!/usr/bin/env python

from keras.applications.imagenet_utils import preprocess_input
from keras.applications.imagenet_utils import decode_predictions
from keras.utils import np_utils
from keras import backend as K
K.set_image_dim_ordering('th')

from alexnet_base import *
import numpy as np



def load_trained_model():

    # load json and create model
    json_file = open('./model-save/model-alexNet.json', 'r')
    loaded_model_json = json_file.read()
    json_file.close()
    model = model_from_json(loaded_model_json)
    
    # load weights into new model
    model.load_weights("./model-save/model-alexNet.h5")
    print("Loaded model from disk")

    sgd = SGD(lr=0.1, decay=1e-6, momentum=0.9, nesterov=True)

    # evaluate loaded model on test data
    model.compile(loss='binary_crossentropy', optimizer='sgd', metrics=['accuracy'])
    #score = loaded_model.evaluate(X, Y, verbose=0)
    #print("%s: %.2f%%" % (loaded_model.metrics_names[1], score[1]*100))
    return model


if __name__ == "__main__":

	#if len(sys.argv) == 1 :
	#    exit(-1)

    model  = create_model()
    model.load_weights("./model-save/model-alexNet-0.98.hdf5")
    img_path = '/data/dataSets/negativesFromTheWild/256x256/building_63_76.png'  
    print(img_path) 
    img = image.load_img(img_path, target_size=(img_w,img_h))
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = preprocess_input(x)
    print('Input image shape:', x.shape)
    preds = model.predict(x)
    print('Predicted:', preds)
    #score = loaded_model.evaluate(X, Y, verbose=0)
    #print("%s: %.2f%%" % (loaded_model.metrics_names[1], score[1]*100))

