#!/usr/bin/env python


#write to file
train = open('train.txt', 'w')
val = open('val.txt', 'w')
#read faces 
aflw_file = open('aflw.list', 'r')

num_lines = sum(1 for line in open('aflw.list', 'r'))
print(num_lines)
count = 0
for line in aflw_file.readlines():
	value = line.split(" ")
	out = value[0];	
	if("crop_images/face/" in out) :
		out = out + " 1"
	else:
		out = out + " 0"	
	print(out)	
	count = count + 1
	
	if(count < (num_lines - ((num_lines) / (10)))):
		train.write(out+"\n") 
	else:
		val.write(out+"\n")   

aflw_file.close()
train.close()
val.close()


