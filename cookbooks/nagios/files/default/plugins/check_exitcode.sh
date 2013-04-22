#!/bin/bash

EXIT_CODE=$(/bin/cat $1)
if [ $EXIT_CODE -ne 0 ]
then
    exit 2
else
    exit 0
fi
