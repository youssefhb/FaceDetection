#!/bin/bash

WIDTH=227
HEIGHT=227

FACES_FILE=faces-${WIDTH}x${HEIGHT}.txt
NON_FACES_FILE=non-faces-${WIDTH}x${HEIGHT}.txt

POS_IMG_DIR='/data/AFLW/cropped/227'
NEG_IMG_DIR='/data/negativesImages/227x227'

CURRENT_DIR=`pwd`

###################################
#   Generate Positive Description 
###################################
function createPosDescFile {

  
  
  rm  "./desc-files/${FACES_FILE}"  
  FILES=`find ${POS_IMG_DIR} -type f | xargs ls -1 |  cut -d'/' -f7`
  for file in $FILES
  do
        echo $file
        echo $file 1  >> "./desc-files/${FACES_FILE}"     
        
  done
}



###################################
#   Generate Negative Description 
###################################
function createNegDescFile {

  rm  "./desc-files/${NON_FACES_FILE}"  
  FILES=`find ${NEG_IMG_DIR} -type f | xargs ls -1 |  cut -d'/' -f5`
  for file in $FILES
  do
        echo $file
        echo $file 0  >> "./desc-files/${NON_FACES_FILE}"     
        
  done
}


########################
# Call of the function
########################

createPosDescFile

createNegDescFile