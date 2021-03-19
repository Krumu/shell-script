#!/bin/bash

echo -n "Enter your Filename: "
read FILE

if [ -d $FILE ]; then # -d FILENAME 파일이 디렉토리면 참
    echo "File is a Directory"
elif [ -f $FILE ]; then 
    echo "File is a regular file"
else
    echo "Not Found"
    exit 33
fi
