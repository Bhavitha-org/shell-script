#!/bin/bash

# for i in {1..100}
# do 
#     echo $i 
# done


USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo "please run this script with root user access" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE() {
if [ $1 -ne 0 ]; then
    echo "$2 is...FAILURE" | tee -a $LOGS_FILE  
    exit 1
else 
    echo "$2 is...SUCCESS" | tee -a $LOGS_FILE     #-a is append 
fi
}


for package in $@
do
    dnf list installed $package  &>> LOGS_FILE
    if [ $? -ne 0 ]; then                              #instead of blindly installing package first we check whether the package is already installed or not
        echo "$package not installed...installing"
        dnf install $package -y   &>> LOGS_FILE
        VALIDATE $? "Installing $package"
    else 
        echo "$package already installed...SKIPPING"
    fi
done