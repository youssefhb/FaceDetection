#/usr/bin/env sh


WIDTH=227
HEIGHT=227
DATABASE_FORMAT=lmdb
DATABASE_NAME=AFLW
DESC_FILE=./desc-files/train/train-shuffledList-227x227.txt

export CAFFE_HOME=~/devhome/DeepLearningTK/caffe

echo Removing old database
rm -rf  "${DATABASE_NAME}.${DATABASE_FORMAT}-${WIDTH}x${HEIGHT}"
rm -rf  "${DATABASE_NAME}.mean.binaryproto-${WIDTH}x${HEIGHT}"


echo Creating ${DATABASE_NAME} database in ${DATABASE_FORMAT} format
${CAFFE_HOME}/build/tools/convert_imageset  --backend ${DATABASE_FORMAT} /data/face-detection-data/  "shuffledList-${WIDTH}x${HEIGHT}.txt"  "${DATABASE_NAME}.${DATABASE_FORMAT}-${WIDTH}x${HEIGHT}"


echo "Computing image mean..."
echo "${CAFFE_HOME}/build/tools/compute_image_mean  --backend ${DATABASE_FORMAT}  ${DATABASE_NAME}.${DATABASE_FORMAT}-${WIDTH}x${HEIGHT}  ${DATABASE_NAME}.mean.binaryproto-${WIDTH}x${HEIGHT}"
${CAFFE_HOME}/build/build/tools/compute_image_mean  --backend ${DATABASE_FORMAT}  "${DATABASE_NAME}.${DATABASE_FORMAT}-${WIDTH}x${HEIGHT}"  "${DATABASE_NAME}.mean.binaryproto-${WIDTH}x${HEIGHT}"

echo End Processing
