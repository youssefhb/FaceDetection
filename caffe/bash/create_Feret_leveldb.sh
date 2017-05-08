#/usr/bin/env sh


WIDTH=227
HEIGHT=227


echo Removing old database
#rm -rf  "feret.leveldb-${WIDTH}x${HEIGHT}"
#rm -rf  "feret.mean.binaryproto-${WIDTH}x${HEIGHT}"


echo Creating feret database in leveldb format
../../caffe/build/tools/convert_imageset  --backend leveldb ./images/"${WIDTH}x${HEIGHT}"/  "shuffledList-${WIDTH}x${HEIGHT}.txt"  "feret.leveldb-${WIDTH}x${HEIGHT}"


echo "Computing image mean..."
echo "../../caffe/build/tools/compute_image_mean  --backend leveldb  feret.leveldb-${WIDTH}x${HEIGHT}  feret.mean.binaryproto-${WIDTH}x${HEIGHT}"
../../caffe/build/tools/compute_image_mean  --backend leveldb  "feret.leveldb-${WIDTH}x${HEIGHT}"  "feret.mean.binaryproto-${WIDTH}x${HEIGHT}"

echo End Processing
