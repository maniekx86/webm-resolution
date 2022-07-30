# webm-resolution
Example scripts for dynamic resolution webm files

1. Get any video in webm format
2. Extract frames from it using ffmpeg:
`ffmpeg -i ./video.webm ./1/%03d.jpeg`
3. Change resolution of these frames how you want, in this repo there is script to make random size frames from 40x40 to 500x500. Keep only first frame with original resolution for thumb.
4. Convert all frames into webm
```
#!/bin/bash

for filename in ./*.jpeg
do

ffmpeg -i $filename -vcodec vp8 ../2/$filename.webm

done
```
5. Merge all frames using concat demuxer
```
#!/bin/bash

rm filelist
readarray -d '' entries < <(printf '%s\0' *.webm | sort -zV) # reads files by number order to create list for concat
for entry in "${entries[@]}"; do
  echo file \'$entry\'  >> filelist
  echo 'duration 0.04' >> filelist # change this to video framerate (in this case 1/25=0.04)
done

ffmpeg -f concat -i filelist -framerate 25 -video_track_timescale 600 -c copy output.webm # change framerate here too

```
6. Merge audio from original webm file
`ffmpeg -i output.webm -i ./original.webm -c:v copy -c:a libopus -map 0:v:0 -map 1:a:0 done.webm`
