#!/usr/bin/env python

import numpy as np
import pandas as pd
import os


def train_validate_test_split(df, train_percent=.6, validate_percent=.2, seed=None):
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


    os.remove('./desc-files/' + prefix+'-test.txt') if os.path.exists('./desc-files/'+prefix+'-test.txt') else None
    os.remove('./desc-files/' + prefix+'-validate.txt') if os.path.exists('./desc-files/'+prefix+'-validate.txt') else None
    os.remove('./desc-files/' + prefix+'-train.txt') if os.path.exists('./desc-files/'+prefix+'-train.txt') else None


    test.to_csv('./desc-files/' + prefix+'-test.txt', header=None, index=None, sep=' ', mode='a')
    validate.to_csv('./desc-files/' + prefix+'-validate.txt', header=None, index=None, sep=' ', mode='a')
    train.to_csv('./desc-files/' + prefix+'-train.txt', header=None, index=None, sep=' ', mode='a')




splitData(prefix='pos',filename='./desc-files/faces.txt')
splitData(prefix='neg',filename='./desc-files/non-faces.txt')