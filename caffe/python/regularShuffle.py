#!/usr/bin/env python

import random, sys;


def shuffleData(faces_file,non_faces_file,shuffled_file):
    negLines = open(non_faces_file).readlines();
    NEG_BATCH = 40

    posLines = open(faces_file).readlines();
    POS_BATCH = 20


    i = 0
    n = len(negLines)

    j = 0
    m = len(posLines)


    outputFile = open(shuffled_file, "w")

    while i < n and j < m:

            x = 0
            while  x < POS_BATCH and  j < m:
                line = posLines[j]
                outputFile.write(line.replace('\"',''))
                x = x + 1 
                j = j + 1


            k = 0
            while  k < NEG_BATCH and  i < n:
                line = negLines[i]
                outputFile.write(line.replace('\"',''))		
                k = k + 1 
                i = i + 1
                


    outputFile.close()




#############################
#  Training Data
#############################
faces_file='./desc-files/train/faces-train-227x227.txt'
non_faces_file='./desc-files/train/non-faces-train-227x227.txt'
shuffled_file='./desc-files/train/train-shuffledList-227x227.txt'

shuffleData(faces_file,non_faces_file,shuffled_file)

#############################
#  Training Data
#############################
faces_file='./desc-files/validation/faces-validate-227x227.txt'
non_faces_file='./desc-files/validation/non-faces-validate-227x227.txt'
shuffled_file='./desc-files/validation/validation-shuffledList-227x227.txt'

shuffleData(faces_file,non_faces_file,shuffled_file)


