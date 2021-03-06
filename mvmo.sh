#!/bin/bash

# Move Movie ver 1.00
# Author: Travis Simmons [simmonstravish@gmail.com]
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Description: Script that moves all video files from subdirectories into a single directory, removes tags, and deletes leftovers
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Parent directory where you keep all the video files. Comment out 'cd' to use current directory
cd /mnt/Grinder/Newshosting
PARENT=`pwd`

# Remove stand alone sample files
rm **/*{S,s}ample* 2>/dev/null

# Remove unwanted files by extention
rm **/*.{nfo,txt,text,png,jpg,jpeg,bmp,doc,mp3,docx,gif,srt,url,nzb} 2>/dev/null

# Remove directories for screens, samples or subtitles that may still contain files
find ./ -type d -iname "sample" -o -iname "sub*" -o -iname "screen*" -exec rm -r {} \; 2>/dev/null

# Move all the video files to main directory
mv **/*.{mkv,mp4,avi,mov,asv,flv,mpg,mwv,mts,mpeg,ogm,webm,m4v} $PARENT 2>/dev/null

# Remove empty directories
find ./ -type d -empty -exec rmdir {} \; 2>/dev/null

# Replace dots with spaces
#for fname in *; do
 # name="${fname%\.*}"
  #extension="${fname#$name}"
  #newname="${name//./ }"
  #newfname="$newname""$extension"
  #if [ "$fname" != "$newfname" ]; then
 #     mv "$fname" "$newfname"
  #fi 
#done

# Remove author tags from files and replace spaces with underscores
ls | while read -r FILE
do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' | tr -d "\'" | sed 's/\[[^]]*\]_//g' | sed 's/\[[^]]*\]//g'`
done


# All finished
NUM=`ls *.{mkv,mp4,avi,mov,asv,flv,mpg,mwv,mts,mpeg,ogm,webm,m4v} 2>/dev/null | wc -l`
echo -e "\e[34m##### $NUM files readied in $PARENT ##### \e[0m"
