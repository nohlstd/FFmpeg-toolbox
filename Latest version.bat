@echo off
C:
CLS

:MENU
CLS
color 0c
ECHO ===================================
ECHO ====== CREATED BY BLUE DRAGON ======
ECHO ===================================
ECHO 1.  Selection 1  (for .mp4)
ECHO 2.  Selection 2  (for .mkv)
ECHO 3.  Selection 3 (upscaling)
ECHO 4.  Selection 4 (speed up video [bugged])
ECHO ==========PRESS 'Q' TO QUIT=========
ECHO.

SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO Selection1
IF /I '%INPUT%'=='2' GOTO Selection2
IF /I '%INPUT%'=='3' GOTO Selection3
IF /I '%INPUT%'=='4' GOTO Selection4
IF /I '%INPUT%'=='5' GOTO Selection5
IF /I '%INPUT%'=='Q' GOTO Quit

CLS

ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [1-9] or select 'Q' to quit.
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU

:Selection1
Color 0D
echo.
echo Constant fps thingy
echo.
echo.
echo.
echo What's the FPS of your input file?
set /p framespersecondshit=
echo.
echo thanks
timeout 1 >nul
CLS
ffmpeg -v quiet -stats -i input.mp4 -c:v libx264 -crf 1 -preset ultrafast -c:a copy -r %framespersecondshit% outputreencoded.mp4
pause



:Selection2
Color 0D
echo.
echo Constant fps thingy
echo.
echo.
echo.
echo What's the FPS of your input file?
set /p framespersecondshit=
echo.
echo thanks
timeout 1 >nul
CLS
ffmpeg -v quiet -stats -i input.mkv -c:v libx264 -crf 1 -preset ultrafast -c:a copy -r %framespersecondshit% outputreencoded.mkv
pause



:Selection3
Color 0D
echo.
echo.
echo.
echo.
echo What's the Resolution of your input file? ex. "3840x2560" (without brackets)
set /p resolution=
echo.
echo thanks
timeout 1 >nul
CLS
ffmpeg -i input.mp4 -vf scale=%resolution%:flags=lanczos -c:v libx264 -preset slow -crf 21 output_compress_4k.mp4
pause

:Selection4
Color 0D
echo.
echo.
echo.
echo.
echo What's the speed of video you want? ex. "0.5" without brackets (higher equal slower, lower equals faster) 
set /p pts=
echo.
timeout 1 >nul
echo What's the speed of audio you want? ex. "0.5" without brackets (higher equal slower, lower equals faster)
set /p atempo=
timeout 1 >nul
CLS
ffmpeg -i input.mp4 -filter_complex "[0:v]setpts=%pts%*PTS[v];[0:a]atempo=%atempo%[a]" -map "[v]" -map "[a]" output.mp4
pause

:Selection5
Color 0D
echo.
echo.
echo.
echo.
echo What you want output fps?
set /p fpsy=
echo.
timeout 1 >nul
CLS
ffmpeg.exe -i input.mp4 -crf 15 -vf "tmix=frames=4:weights=1, scale=1920x1080:flags=lanczos, fps=%fpsy%" output-resampled.mp4
pause

:Quit