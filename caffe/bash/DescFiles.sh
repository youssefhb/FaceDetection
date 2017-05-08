#!/bin/bash


POS_IMG_DIR='/data/AFLW/cropped/227'
NEG_IMG_DIR='/data/negativesImages/227x227'



###################################
#   Generate Positive Description 
###################################
function createPosDescFile {

  OUTPUT_FILE=posImagesList-${WIDTH}x${HEIGHT}.txt
  
  rm  ./${OUTPUT_FILE}  
  FILES=`find ${POS_IMG_DIR} -type f | xargs ls -1`
  for file in $FILES
  do
        echo $file
        echo $file 1  >> ${CURRENT_DIR}/${OUTPUT_FILE}     
        
  done
}



###################################
#   Generate Negative Description 
###################################
function createNegDescFile {

  OUTPUT_FILE=negImagesList-${WIDTH}x${HEIGHT}.txt
  rm  ./${OUTPUT_FILE}  
  FILES=`find ${NEG_IMG_DIR} -type f | xargs ls -1`
  for file in $FILES
  do
        echo $file
        echo $file 1  >> ${CURRENT_DIR}/${OUTPUT_FILE}     
        
  done
}


########################
# Call of the function
########################

createPosDescFile

createNegDescFile