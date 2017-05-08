#!/bin/bash

WIDTH=227
HEIGHT=227

NUM_NEG=100000



INPUT_NEG_IMG_DIR='/data/negativesImages/wild'
OUTPUT_NEG_IMG_DIR='/data/negativesImages/'


CURRENT_DIR=`pwd`




##############################################################################
#
# Resizes Negative images -- Generate multiple negative image from one.
#
##############################################################################
function cropNegativeWildImages {

  find ${INPUT_NEG_IMG_DIR} -type f | rename 's/ /_/g'

  FILES=`find ${INPUT_NEG_IMG_DIR}  | xargs ls -1`  
  OUTPUT_DIR="${OUTPUT_NEG_IMG_DIR}/${WIDTH}x${HEIGHT}"

  rm -rf "${OUTPUT_DIR}"
  mkdir  "${OUTPUT_DIR}"  

  k=1 


  for f in $FILES
  do

  FILENAME=`echo "$f" | cut -d'/' -f5`
  echo "${FILENAME}"
  NAME=`echo "$FILENAME" | cut -d'.' -f1`
  echo $NAME  - $k

  convert "$f"  -resize  "${WIDTH}x${HEIGHT}"\!  "${OUTPUT_DIR}/${NAME}.png"
  convert -crop  "${WIDTH}x${HEIGHT}"\!   $f     "${OUTPUT_DIR}/${NAME}_%d.png"
  k=$(($k + 1))    
      
  if [ "$k" -gt "${NUM_NEG}" ]
    then
           break  
    fi

  done  

}



########################
# Call of the function
########################

 
cropNegativeWildImages

cleanNegativeImg

 

echo End.

