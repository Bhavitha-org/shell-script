#!/bin/bash

set -e          #whenever set -e feels an error it will send signal to ERR
                #trap 'Commands to run' ERR -> trap syntax
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR       #$LINENO, $BASH_COMMAND are default variables

echo "Hello world"
echo "this is set-trap script"
echoo "there is error in this line"
echo "this is the final line"