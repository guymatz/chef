#!/bin/bash

EXIT_CODE=$(/bin/cat $1)
if [ $EXIT_CODE -ne 0 ]
then
    echo "Exit code is: $(EXIT_CODE)"
    exit 2
else
    echo "Exit code is 0. All is well"
    exit 0
fi
