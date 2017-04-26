#!/usr/bin/env python

import numpy as np
import pandas as pd
import os
import shutil



DATA_DIR='/home/devHome/DeepLearning-py/DeepFace/Data'


def moveData(filename,dir):
    with open(filename) as fp:
        for line in fp:
            shutil.copy2(line.rstrip()  ,dir)


#moveData('./python-scripts/desc-files/pos-test.txt',DATA_DIR+'/test/face')
moveData('./python-scripts/desc-files/pos-train.txt',DATA_DIR+'/train/face')
#moveData('./python-scripts/desc-files/pos-validate.txt',DATA_DIR+'/validation/face')


#moveData('./python-scripts/desc-files/neg-test.txt',DATA_DIR+'/test/non-face')
#moveData('./python-scripts/desc-files/neg-train.txt',DATA_DIR+'/train/non-face')
#moveData('./python-scripts/desc-files/neg-validate.txt',DATA_DIR+'/validation/non-face')