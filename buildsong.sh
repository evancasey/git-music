#!/bin/bash

# create commits audio file
cat $1 | say -o temp.aiff

# merge with secondary audio file
ffmpeg -i temp.aiff -i $2 -filter_complex amerge -c:a libmp3lame -q:a 4 output.mp3

# upload to 


