#/usr/bin/env sh


RESIZE_WIDTH=137
RESIZE_HEIGHT=137
DATABASE_FORMAT=lmdb
DESC_FILE=./desc-files/train/train-shuffledList-227x227.txt

DATABASE_NAME="AFLW.${DATABASE_FORMAT}-${RESIZE_WIDTH}x${RESIZE_HEIGHT}"
MEAN_FILE="AFLW.mean.binaryproto-${WIDTH}x${HEIGHT}"


export CAFFE_HOME=~/devhome/DeepLearningTK/caffe

echo Removing old database
rm -rf  "${DATABASE_NAME}.${DATABASE_FORMAT}-${WIDTH}x${HEIGHT}"
rm -rf  "${DATABASE_NAME}.mean.binaryproto-${WIDTH}x${HEIGHT}"


echo Creating ${DATABASE_NAME} database in ${DATABASE_FORMAT} format
${CAFFE_HOME}/build/tools/convert_imageset -resize_height ${RESIZE_HEIGHT} -resize_width ${RESIZE_WIDTH}  --backend ${DATABASE_FORMAT} /data/face-detection-data/  ${DESC_FILE}  "${DATABASE_NAME}"


echo "Computing image mean..."
echo "${CAFFE_HOME}/build/tools/compute_image_mean  --backend ${DATABASE_FORMAT}  "${DATABASE_NAME}"  ${MEAN_FILE}"
${CAFFE_HOME}/build/build/tools/compute_image_mean  --backend ${DATABASE_FORMAT}  "${DATABASE_NAME}"  "${MEAN_FILE}"

echo End Processing
