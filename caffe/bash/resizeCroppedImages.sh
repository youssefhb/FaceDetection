#!/bin/bash

WIDTH=227
HEIGHT=227
NUM_POS=150000
NUM_NEG=100000


POS_IMG_DIR='/data/AFLW/cropped/227'
INPUT_NEG_IMG_DIR='/data/negativesImages/wild'
OUTPUT_NEG_IMG_DIR='/data/negativesImages/'


CURRENT_DIR=`pwd`

####################################################
#
# Resizes images of folders  000200-00000*
#
####################################################
function preparePositiveImages {

    echo start preparing Positive Images

    rm -rf ./images/"${WIDTH}x${HEIGHT}"
    mkdir ./images/"${WIDTH}x${HEIGHT}"
    IMG_DIR=./images/"${WIDTH}x${HEIGHT}"

    echo Resize images ..
    IMAGES_FOLDER='/data/dataSets/colorferet/cropped'


    FILES=`ls $IMAGES_FOLDER | sort --version-sort -f`

    rm  ./file_list.txt 

    k=1

    for f in $FILES
    do
            FILE_NAME=`echo $f | cut -d '.' -f1`
            echo "file name=$FILE_NAME  -  $k"
	    convert $IMAGES_FOLDER/$f  -resize  ${WIDTH}x${HEIGHT}\!  "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"

            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 10 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_10_rotated'.jpg            
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 15 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_15_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 20 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_20_rotated'.jpg            
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 25 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_25_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 30 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_30_rotated'.jpg            
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 35 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_35_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 40 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_40_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT 45 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'_45_rotated'.jpg


            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -10 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__10_rotated'.jpg            
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -15 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__15_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -20 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__20_rotated'.jpg            
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -25 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__25_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -30 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__30_rotated'.jpg            
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -35 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__35_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -40 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__40_rotated'.jpg
            convert "${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$f"  -distort SRT -45 ${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/$FILE_NAME'__45_rotated'.jpg
          
	    #echo $IMG_DIR/$f 1  >> ./file_list.txt
 
             k=$(( $k + 1 ))
          
             if [ "$k" -gt "${NUM_POS}" ]
		   then
	               break 	
             fi

	     
    done
}

##########################################
#
# Resizes Negative images and rotate it
#
##########################################

function prepareNegImages {

    echo start preparing Positive Images

    rm -rf ./images/neg/"${WIDTH}x${HEIGHT}"
    mkdir ./images/neg/"${WIDTH}x${HEIGHT}"
    IMG_DIR=./images/neg/"${WIDTH}x${HEIGHT}"

    echo Resize images ..
    IMAGES_FOLDER='/home/NegativeImages/frames'


    FILES=`ls $IMAGES_FOLDER | sort --version-sort -f`

    rm  ./file_list.txt 

    k=1

    for f in $FILES
    do
          FILE_NAME=`echo $f | cut -d '.' -f1`
          echo "file name=$FILE_NAME  -  $k"
	  convert $IMAGES_FOLDER/$f  -resize  ${WIDTH}x${HEIGHT}\!  "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"

          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 10 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_10_rotated'.jpg            
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 15 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_15_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 20 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_20_rotated'.jpg            
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 25 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_25_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 30 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_30_rotated'.jpg            
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 35 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_35_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 40 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_40_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT 45 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'_45_rotated'.jpg


          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -10 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__10_rotated'.jpg            
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -15 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__15_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -20 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__20_rotated'.jpg            
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -25 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__25_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -30 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__30_rotated'.jpg            
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -35 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__35_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -40 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__40_rotated'.jpg
          convert "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$f"  -distort SRT -45 ${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/$FILE_NAME'__45_rotated'.jpg
          
	    #echo $IMG_DIR/$f 1  >> ./file_list.txt
 
             k=$(( $k + 1 ))
          
             if [ "$k" -gt "${NUM_NEG}" ]
		   then
	               break 	
             fi

	     
    done
}


##############################
#
# Resizes Negative images -- Generate multiple negative image from one.
#
##############################
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



######################################################################
#
#  deletes files that don't have dimension ${WIDTH}x${HEIGHT}
#
######################################################################
function cleanNegativeImg {
  echo "cleanNegativeImg"
  IMAGES_DIR="${OUTPUT_NEG_IMG_DIR}/${WIDTH}x${HEIGHT}/"  
  FILES=`ls ${IMAGES_DIR} | sort --version-sort -f`
  for f in $FILES
  do
    echo $f
    FILE_NAME=`echo "$f" | cut -d'.' -f1`
    #convert ${IMAGES_DIR}$f  -resize  ${WIDTH}x${HEIGHT}\!  "${IMAGES_DIR}$f"
    
    W=`identify -format %w ${IMAGES_DIR}$f`
    H=`identify -format %h ${IMAGES_DIR}$f`
    if [ $W -lt  ${WIDTH}  ]  || [  $H -lt  ${HEIGHT} ] ; then 
         echo $W $H
         rm  ${IMAGES_DIR}$f
         continue
         #convert ${IMAGES_DIR}$f  -resize  ${WIDTH}x${HEIGHT}\!  "${IMAGES_DIR}$f"
    fi;   
    #convert "${IMAGES_DIR}$f"  -distort SRT  10 ${IMAGES_DIR}/$FILE_NAME'_10_rotated'.jpg    
    #convert "${IMAGES_DIR}$f"  -distort SRT -10 ${IMAGES_DIR}/$FILE_NAME'__10_rotated'.jpg    
  done
  
}

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


function createDescFile {

  NEG_OUTPUT_FILE=negImagesList-${WIDTH}x${HEIGHT}.txt
  POS_OUTPUT_FILE=posImagesList-${WIDTH}x${HEIGHT}.txt
  rm  ./${NEG_OUTPUT_FILE}
  rm  ./${POS_OUTPUT_FILE} 

  IMAGES_DIR=${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/
  
  FILES=`ls ${IMAGES_DIR} | sort --version-sort -f`
  for f in $FILES
  do
        echo $f
        #echo $f 1  >> ${CURRENT_DIR}/${OUTPUT_FILE}
 
        if  [[ $f == Frame* ]] ;
		then                     
		    echo $f 0  >> ${CURRENT_DIR}/${NEG_OUTPUT_FILE}
		else
		    echo $f 1  >> ${CURRENT_DIR}/${POS_OUTPUT_FILE}
	fi
        
  done
  
}



function moveLongList {

  
  OUTPUT_DIR=${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/
  IMAGES_DIR=${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/
  
  for f in ${IMAGES_DIR}/Frame*; 
  do 
       mv $f ${OUTPUT_DIR}        
  done
  
}

function moveBackNegList { 
  
  IMAGES_DIR=${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}
  OUTPUT_DIR=${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/  

  for f in ${IMAGES_DIR}/Frame*; 
  do 
       mv $f ${OUTPUT_DIR}        
  done
  
}


function createAdaboostDescFile {

  rm  ${CURRENT_DIR}/PubFigPos.desc
  rm  ${CURRENT_DIR}/PubFigNeg.desc

  #IMAGES_DIR=${CURRENT_DIR}/images/${WIDTH}x${HEIGHT}/
  IMAGES_DIR=${CURRENT_DIR}/images/50x50/
  cd ${IMAGES_DIR}
  FILES=`ls | sort --version-sort -f`
  for f in $FILES
  do
        echo $f
        if  [[ $f == neg* ]] ;
		then                     
		    echo ${IMAGES_DIR}$f  >> ${CURRENT_DIR}/PubFigNeg.desc
		else
		    #echo ${IMAGES_DIR}$f 1 0 0 ${WIDTH} ${HEIGHT} >> ${CURRENT_DIR}/PubFigPos.desc
                     echo ${IMAGES_DIR}$f 1 0 0 ${WIDTH} ${HEIGHT} 
	fi
        
  done
  
}



########################
# Call of the function
########################

 #preparePositiveImages

 #prepareNegImages
 
 #cropNegativeWildImages

 cleanNegativeImg

 #createNegDescFile
 #createPosDescFile 
 #moveLongList


 #createDescFile

 #createAdaboostDescFile

 

echo End.

