#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Please run this script with root user access"
    exit 1  #cuz we know above is the error, shellscript will exit when we use exit status otherwise even error, it proceeds executing next commands
fi

echo "Installing Nginx"
dnf install nginx -y

if [ $? -ne 0 ]; then                          #we know that after running dnf, nginx is installed, but shell dk so we validate it.
    echo "installing nginx is FAILURE"
    exit 1
else 
    echo "installing nginx is SUCCESS"