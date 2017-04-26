#!/usr/bin/env python

import random, sys;

lines = open('file_list.txt').readlines();
random.shuffle(lines); 
#print ''.join(lines)

outputFile = open("shuffled_list.txt", "w")
outputFile.write("%s" % ''.join(lines))
outputFile.close()
