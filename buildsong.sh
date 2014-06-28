#!/bin/bash
# ./buildsong.sh tmp/drake-template.txt output.mp3 drake

# TODO: change later
COMMITS_AUDIO_PATH=${1:0:14}.mp3

cat $1 | say -o $COMMITS_AUDIO_PATH

DRAKE_MIDI="/midi/drake-midi.txt"
DRAKE_INSTRUMENTAL="audio/drake.mp3"

SONIC_ACCESS_ID=6cf9eac8-de22-4190-8813-ee13df780350

# upload commits audio 
RESPONSE=$(curl -Ffile=@$COMMITS_AUDIO_PATH https://api.sonicapi.com/file/upload?access_id=$SONIC_ACCESS_ID)

FILE_ID=$(echo $RESPONSE| grep 'file_id' | cut -d '=' -f 5 | cut -d ' ' -f 1)


if [ $3 == "drake" ] ;then

  # autotune with drake midi  
  curl 'https://api.sonicapi.com/process/elastiqueTune?input_file=https://github.com/evancasey/git-music/blob/master/tmp/drake-temp.aiff&access_id=6cf9eac8-de22-4190-8813-ee13df780350&format=json'

  echo $RESPONSE
 
fi

# download the file and merge with instrumental
#ffmpeg -i $COMMITS_AUDIO_PATH -i $DRAKE_INSTRUMENTAL -filter_complex amerge -c:a libmp3lame -q:a 4 $2
#curl https://api.sonicapi.com/file/download?access_id=$SONIC_ACCESS_ID&file_id=$FILE_ID
#mv $FILE_ID.mp3 $2
