#!/usr/bin/env python

import random, sys;





def shuffle(neg_file,pos_file,output):


    negLines = open(neg_file).readlines();
    NEG_BATCH = 25

    posLines = open(pos_file).readlines();
    POS_BATCH = 15


    i = 0
    n = len(negLines)

    j = 0
    m = len(posLines)


    outputFile = open(output, "w")

    while i < n and j < m:

        x = 0
        while  x < POS_BATCH and  j < m:
            line = posLines[j]
            outputFile.write(line.strip() +'\n')
        x = x + 1 
        j = j + 1


        k = 0
        while  k < NEG_BATCH and  i < n:
            line = negLines[i]
            outputFile.write(line.strip() +'\n')		
        k = k + 1 
        i = i + 1
            


    outputFile.close()




shuffle('./desc-files/neg-train.txt','./desc-files/pos-train.txt','./desc-files/train_map.txt')
shuffle('./desc-files/neg-validate.txt','./desc-files/pos-validate.txt','./desc-files/val_map.txt')