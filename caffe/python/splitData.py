#!/usr/bin/env python

import numpy as np
import pandas as pd
import os


WIDTH=227
HEIGHT=227

FACES_FILE='faces-'+str(WIDTH)+'x'+str(HEIGHT)+'.txt'
NON_FACES_FILE='non-faces-'+str(WIDTH)+'x'+str(HEIGHT)+'.txt'

def train_validate_test_split(df, train_percent=.85, validate_percent=.1, seed=None):
    np.random.seed(seed)
    perm = np.random.permutation(df.index)
    m = len(df)
    train_end = int(train_percent * m)
    validate_end = int(validate_percent * m) + train_end
    train = df.ix[perm[:train_end]]
    validate = df.ix[perm[train_end:validate_end]]
    test = df.ix[perm[validate_end:]]
    return train, validate, test



def splitData(prefix,filename):

    df = pd.read_csv(filename,sep = "\n")
    #print (df)


    train, validate, test = train_validate_test_split(df)


    filename='./desc-files/test/' + prefix+'-test-'+str(WIDTH)+'x'+str(HEIGHT)+'.txt'
    os.remove(filename) if os.path.exists(filename) else None
    test.to_csv(filename, header=None, index=None, sep=' ', mode='a')

    filename='./desc-files/validation/' + prefix+'-validate-'+str(WIDTH)+'x'+str(HEIGHT)+'.txt'
    os.remove(filename) if os.path.exists(filename) else None
    validate.to_csv(filename, header=None, index=None, sep=' ', mode='a')

    filename='./desc-files/train/' + prefix+'-train-'+str(WIDTH)+'x'+str(HEIGHT)+'.txt'
    os.remove(filename) if os.path.exists(filename) else None
    train.to_csv(filename, header=None, index=None, sep=' ', mode='a')
    





splitData(prefix='faces',filename='./desc-files/'+FACES_FILE)
splitData(prefix='non-faces',filename='./desc-files/'+NON_FACES_FILE)