#!/bin/bash

WIDTH=$1
HEIGHT=$1


WIDTH=256
HEIGHT=256

NUM_POS=400000
NUM_NEG=60000


CURRENT_DIR=`pwd`



function moveLongList {

  
  OUTPUT_DIR=${CURRENT_DIR}/images/pos/${WIDTH}x${HEIGHT}/
  IMAGES_DIR=${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/
  
  for f in ${IMAGES_DIR}/*; 
  do 
       mv $f ${OUTPUT_DIR}        
  done
  
}


########################
# Call of the function
########################

prepareNegativeImages

 

echo End.

