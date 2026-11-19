@echo off
cd /d e:\codebuddy\workspace\christmas-tree\tools
node record.mjs 30 1080 1920 > vrec.log 2>&1
set newest=
for /f "delims=" %%f in ('dir /b /o-d out\*.webm') do (if not defined newest set newest=%%f)
ffmpeg -y -i "out\%newest%" -c:v libx264 -crf 14 -preset medium -pix_fmt yuv420p -movflags +faststart "..\christmas-vertical.mp4" > vffmpeg.log 2>&1
echo VDONE>> vrec.log
