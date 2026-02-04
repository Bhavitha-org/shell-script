# #!/bin/bash

# echo "Enter your username"
# read USERNAME

# echo "your username is $USERNAME"

# echo "Enter your password"
# read -s PASSWORD              #-s hiding password while entering

# TIME_STAMP=$(date)
# echo "command executed at $TIME_STAMP"

START_TIME=$(date +%s)
 echo "script started at $START_TIME"

sleep 10 &

 END_TIME=$(date +%s)
 echo "script ended at $END_TIME"

 echo "script executed in $(($END_TIME-$START_TIME)) sec"



