#!/usr/bin/env python

import glob, os


POS_IMG = '/dataSets/AFLW/output/face/'
faces = open('./desc-files/faces.txt', 'w')

NEG_IMG = '/data/dataSets/negativesFromTheWild/256x256/'
non_faces = open('./desc-files/non-faces.txt', 'w')

os.chdir(POS_IMG)
for file in glob.glob("*"):
    faces.write(POS_IMG+file+'	1'+'\n')


os.chdir(NEG_IMG)
for file in glob.glob("*"):
    non_faces.write(NEG_IMG+file+'	0'+'\n')

faces.close()
non_faces.close()