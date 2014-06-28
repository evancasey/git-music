#!/bin/bash

# create commits audio file
cat $1 | say -o tmp/commits.aiff

TIM="goodbye"

if [ $3 == "drake" ] ;then

  TIM="hello"
  echo "$TIM"
  # merge with secondary audio file
  #ffmpeg -i tmp/commits.aiff -i $2 -filter_complex amerge -c:a libmp3lame -q:a 4 output.mp3

fi


# upload to 


