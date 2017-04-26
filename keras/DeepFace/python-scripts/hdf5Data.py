#!/usr/bin/env python

import h5py
import glob
import os.path
import time
import holopy as hp
import tempfile
import numpy as np

ims = [hp.load(f) for f in glob.glob('/home/devHome/DeepLearning-py/DeepFace/Data/test/face/*.jpg')]
data = np.dstack(ims)

def print_stats(name, tstart, tstop):
    size = os.path.getsize(name+'.hdf5')
    print("{0}: {1:.1f}s, {2}MB".format(name, tstop-tstart, size//1e6))

def write_all_images(name, **options):
    f = h5py.File(name+'.hdf5', 'w')
    f.create_dataset('data', data=data, **options)

def benchmark(name, operation):
    tstart = time.time()
    operation(name)
    tstop = time.time()
    print_stats(name, tstart, tstop)

benchmark('raw', lambda x: write_all_images(x))
benchmark('autochunk', lambda x: write_all_images(x, compression='gzip'))
benchmark('chunk_16x16x100', lambda x: write_all_images(x, compression='gzip', chunks=(16,16,100)))