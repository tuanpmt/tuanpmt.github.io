#!/bin/bash
# @Author: Tuan PM
# @Date:   2016-10-07 15:43:09
# @Last Modified by:   Tuan PM
# @Last Modified time: 2016-10-07 16:19:11

declare -a ext=("mp3" "aac" "ogg" "flac")
declare -a rate=("8000" "11025" "22050" "44100" "48000")
declare -a bitw=("16")
declare -a channel=("2")

source_file=${1:-source.aac}

echo $source_file


## now loop through the above array
for ext_idx in "${ext[@]}"
do
   for rate_idx in "${rate[@]}"
   do
   	for bitw_idx in "${bitw[@]}"
   	do
   		for channel_idx in "${channel[@]}"
   		do
   			audio_out="${bitw_idx}b-${channel_idx}c-${rate_idx}hz.${ext_idx}"
   			echo "Convert $souce_file to $audio_out"
   			ffmpeg -i $source_file -ar $rate_idx -ac $channel_idx $audio_out
   		done
   	done
   	
   done
done
#ffmpeg -i source.aac 8000hz16b.aac -ar 8000 -ac 2