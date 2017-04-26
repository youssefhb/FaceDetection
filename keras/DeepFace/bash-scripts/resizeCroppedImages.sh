#!/bin/bash

WIDTH=$1
HEIGHT=$1


WIDTH=256
HEIGHT=256

NUM_POS=400000
NUM_NEG=60000


CURRENT_DIR=`pwd`




##############################
#
# Resizes Negative images 
#
##############################
function prepareNegativeImages {

   	#FILES=`ls /data/dataSets/colorferet/cropped/neg* | sort --version-sort -f`
        FILES=`ls ~/devHome/javaWorking/ImageCrawler/images/* | sort --version-sort -f`
        
        #rm -rf "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/"
        mkdir  -p "/data/dataSets/negativesFromTheWild/${WIDTH}x${HEIGHT}/"
   
        k=1 

        for f in $FILES
        do

      		echo $f
          FILENAME=`echo "$f" | cut -d'/' -f8`		
          echo $FILENAME
          NAME=`echo "$FILENAME" | cut -d'.' -f1`                
      		echo $NAME  - $k

      		convert $f  -resize ${WIDTH}x${HEIGHT}\!  "/data/dataSets/negativesFromTheWild/${WIDTH}x${HEIGHT}/$FILENAME"
      		convert -crop  256x256   $f   "/data/dataSets/negativesFromTheWild/${WIDTH}x${HEIGHT}/${NAME}_%d.png" 

                      #for i in {0..40}; do
                      #file="/data/dataSets/negativesFromTheWild/${WIDTH}x${HEIGHT}/${NAME}_$i.png"
                         
                      #if [ -f "$file" ]; then
          	          #    W=`identify -format %w $file`
          	          #    H=`identify -format %h $file`
          	          #    if [ $W -lt  256  ]  || [  $H -lt  256 ] ; then 
                      #      echo $W $H
                      #      rm  $file
                      #      continue	   
                      #    fi;
                      #  convert $file  -resize ${WIDTH}x${HEIGHT}\! $file                   
                      #fi;
                      #done


                    
                      #convert -crop  ${WIDTH}x${HEIGHT}   $f   "${CURRENT_DIR}/images/neg/${WIDTH}x${HEIGHT}/${NAME}_%d.png"
      		            #echo $IMG_DIR/$f 0  >> ./file_list.txt
                      
                      k=$(($k + 1))    
                    
              if [ "$k" -gt "${NUM_NEG}" ]; then
               break 	
              fi
        
       done  
		

}



########################
# Call of the function
########################



 prepareNegativeImages

 

echo End.

