#!/bin/bash

NUM1=100
NUM2=200

SUM=$(($NUM1+$NUM2))
echo "sum is $SUM"

#there is no much importance to datatypes in shell-scripting, 
#even if we give a string in NUM2, it will return 100, taking string as 0.