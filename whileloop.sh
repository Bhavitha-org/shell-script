#!/bin/bash

# count=1

# while [ $count -le 5 ] 
# do
#     echo "Count is $count"
#     sleep 1
#     ((count++)) 
# done

while IFS= read -r line; #Internal field seperator, reads lines in file and 
do
    echo "$line" #prints each line.
done < script1.sh 