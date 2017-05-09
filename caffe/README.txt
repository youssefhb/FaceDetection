1 - Prepare Postive images
------------------------------
./python/crop_aflw.py


2 - use image crawler to download negative images
---------------------------------------------------


3 - Crop and resize negative images
---------------------------------------------------
./bash/cropNegImages.sh


4 - Generate description Files
---------------------------------------------------
./bash/DescFiles.sh



4 - Split the data to : Train, test and validation
---------------------------------------------------
./python/splitData.py



5 - Shuffle the Data
---------------------------------------------------
./bash/DescFiles.sh



6 - Copy the negative and postive images to the same folder
------------------------------------------------------------
cp /data/AFLW/cropped/227/0/*    /data/face-detection-data/
cp /data/AFLW/cropped/227/2/*    /data/face-detection-data/
cp /data/AFLW/cropped/227/3/*    /data/face-detection-data/
for f in /data/negativesImages/227x227/*; do cp  $f  /data/face-detection-data; done


7 - Specify the size of the image to resize to 
    and create the database in leveldb or LMDB
---------------------------------------------------
./bash/create_db.sh


7 - train the model
-------------------
./bash/train_aflw.sh