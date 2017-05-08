#!/usr/bin/env python

import os


# 0 - debug
# 1 - info (still a LOT of outputs)
# 2 - warnings
# 3 - errors
os.environ['GLOG_minloglevel'] = '3' # Sets the logs level. should be called before import caffe


import numpy as np
import matplotlib.pyplot as plt
import caffe
import sys


caffe_root = '/home/youssef/devHome/DeepLearning/caffe/'

# rc Parameters are used to customize all kinds of properties 
plt.rcParams['figure.figsize'] = (7, 7)
plt.rcParams['image.interpolation'] = 'nearest'
plt.rcParams['image.cmap'] = 'gray'


os.system('cls' if os.name == 'nt' else 'clear')
print('\n\n------------------------------------------------------------')
print "  This script is used to display a model learned  Filters"
print('------------------------------------------------------------\n')


caffe.set_mode_gpu()
net = caffe.Net('./deploy.prototxt','FineTuneFeret_iter_20000.caffemodel', caffe.TEST)

 


# input preprocessing: 'data' is the name of the input blob == net.inputs[0]

transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape}) # (10, 3, 227, 227)


transformer.set_transpose('data', (2,0,1)) # transpose dimensions to K x H x W  - Input H x W x K x N  (see caffe/python/io.py  line 123)
transformer.set_mean('data', np.load('models/227x227/bach-10x30/feret.mean.227x227.npy').mean(1).mean(1)) # mean pixel
transformer.set_raw_scale('data', 255)  # the reference model operates on images in [0,255] range instead of [0,1]
transformer.set_channel_swap('data', (2,1,0))  # the reference model has channels in BGR order instead of RGB

# Classify the image by reshaping the net for the single input then doing the forward pass.
net.blobs['data'].reshape(1,3,227,227)
#net.blobs['data'].data[...] = transformer.preprocess('data', caffe.io.load_image(caffe_root + 'examples/images/cat.jpg'))
#net.blobs['data'].data[...] = transformer.preprocess('data', caffe.io.load_image('Feret_3091.jpg'))

#net.blobs['data'].data[...] = transformer.preprocess('data', caffe.io.load_image('Frame-115.jpg'))
net.blobs['data'].data[...] = transformer.preprocess('data', caffe.io.load_image('test1.jpg'))


out = net.forward()
print("Predicted class is #{}.".format(out['prob'][0].argmax()))
print("Predicted class is #{}.".format(out['prob']))

top_k = net.blobs['prob'].data[0].flatten().argsort()[-1:-6:-1]
print top_k



####################################################################################################################################
# The size of convolutional output is calculated as  =  (w - (k - s)) / s     s: Stride, w : image width , k : kernel width
####################################################################################################################################



print('-----------  Network architecture ---------------\n')
for key, blob in net.blobs.items() :
   print'Layer name= {0}    Batch size, channels, width, height= {1}'.format(key, blob.data.shape)
   
print('\n\n')


# Displays the learnable parameters. Max pooling layers will not be displayed, because they don't have any learnable parameters

print('learnable parameters. Max pooling layers will not be displayed, because they don\'t have any learnable parameters : \n ')
for k,v in net.params.items() :
    print 'Learnable Layer {0}  params {1}'.format(k,v[0].data.shape)

#print [(k, v[0].data.shape) for k, v in net.params.items()]


# take an array of shape (n, height, width) or (n, height, width, channels)
# and visualize each (height, width) thing in a grid of size approx. sqrt(n) by sqrt(n)
def vis_square(data,title='Fig',padsize=1, padval=0):
    data -= data.min()
    data /= data.max()
    
    # force the number of filters to be square
    n = int(np.ceil(np.sqrt(data.shape[0])))
    padding = ((0, n ** 2 - data.shape[0]), (0, padsize), (0, padsize)) + ((0, 0),) * (data.ndim - 3)
    data = np.pad(data, padding, mode='constant', constant_values=(padval, padval))
    
    # tile the filters into an image
    data = data.reshape((n, n) + data.shape[1:]).transpose((0, 2, 1, 3) + tuple(range(4, data.ndim + 1)))
    data = data.reshape((n * data.shape[1], n * data.shape[3]) + data.shape[4:])
    plt.title(title)
    plt.imshow(data)


plt.imshow(transformer.deprocess('data', net.blobs['data'].data[0]))

plt.show(block=True)

filters = net.params['conv1'][0].data
vis_square(filters.transpose(0, 2, 3, 1),'Filters')

plt.show(block=True)


feat = net.blobs['conv1'].data[0, :36]
vis_square(feat, 'Conv1 features',padval=1)
plt.show(block=True)


feat = net.blobs['conv2'].data[0, :64]
vis_square(feat, 'Conv2 features',padval=1)
plt.show(block=True)

