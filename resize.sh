#!/bin/bash

sizex=0
sizey=0

for filename in ./*.jpeg
do

sizex=$(shuf -i 20-250 -n 1)
sizex=$(echo $sizex+1 | bc)
sizey=$(shuf -i 20-250 -n 1)
sizey=$(echo $sizey+1 | bc)
ffmpeg -i $filename -vf scale="$sizex:$sizey" ../2/$filename

done
