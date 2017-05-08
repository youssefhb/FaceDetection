#/usr/bin/bash

WIDTH=50
HEIGHT=50

DATASET_PATH="/home/youssef/devHome/cvDeepLearning/FacePrediction/images/${WIDTH}x${HEIGHT}/Feret"
IMAGE_EXTENSION=*.jpg


export  DATASET=${DATASET_PATH}${IMAGE_EXTENSION}
POSITIVE_LIST=`ls  ${DATASET}`



A_PATH_OUTPUT=feret_images_desc_abolute_path.txt
R_PATH_OUTPUT=feret_images_desc_relatif_path.txt

rm $A_PATH_OUTPUT $R_PATH_OUTPUT


# Rename the file by removing the spaces.
#for f in $DATASET_PATH*\ *; do mv "$f" "${f// /_}"; done

echo Preparing the Feret Face  DataSet of directory.
pwd



for file in $POSITIVE_LIST;
do
 CLASS=1 
 
 # Gets the filename from the absolute path
 filename=`printf -- '%s \n' $file  | awk -F "/" '{print $NF}'`
 printf -- '%s   %s \n' $filename $CLASS  >> $R_PATH_OUTPUT
 printf -- '%s   %s \n' $file $CLASS  >> $A_PATH_OUTPUT
done;



DATASET_PATH="/home/youssef/devHome/cvDeepLearning/FacePrediction/images/${WIDTH}x${HEIGHT}/neg"
IMAGE_EXTENSION=*.png


export  DATASET=${DATASET_PATH}${IMAGE_EXTENSION}
NEGATIVE_LIST=`ls  ${DATASET}`

for file in $NEGATIVE_LIST;
do
 CLASS=2
 
 # Gets the filename from the absolute path
 filename=`printf -- '%s \n' $file  | awk -F "/" '{print $NF}'`
 printf -- '%s   %s \n' $filename $CLASS  >> $R_PATH_OUTPUT
 printf -- '%s   %s \n' $file $CLASS  >> $A_PATH_OUTPUT
done;







#for i in {1..3019}; do 


#DATASET_PATH="/home/youssef/devHome/cvDeepLearning/FacePrediction/images/${WIDTH}x${HEIGHT}/neg${i}_"
#IMAGE_EXTENSION=*.png
#export  DATASET=${DATASET_PATH}${IMAGE_EXTENSION}
#POSITIVE_LIST=`ls  ${DATASET}`

#for file in $POSITIVE_LIST;
#do
# CLASS=2 
 
 # Gets the filename from the absolute path
 #filename=`printf -- '%s \n' $file  | awk -F "/" '{print $NF}'`
 #printf -- '%s   %s \n' $filename $CLASS  >> $R_PATH_OUTPUT
 #printf -- '%s   %s \n' $file $CLASS  >> $A_PATH_OUTPUT
#done;
#done;
