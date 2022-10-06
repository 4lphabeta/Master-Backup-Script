@echo off
echo version 1.3.2
rem Change the following 2 file paths
setlocal enabledelayedexpansion
set master="H:\Vortex\Users\Affinitus Development New\Master.accdb"
set backupdir="H:\Vortex\FW_Backups"

set htafile=^"%cd%\Progress_Bar.hta^"

echo wscript.quit MsgBox ("Do you want to delete old backups?", 4, "WARNING") > yesno.vbs
wscript //nologo yesno.vbs
set value=%errorlevel%
del yesno.vbs
start mshta.exe %htafile%
set dcheck=0
if "%value%"=="6" (
	forfiles /p %backupdir% /d -30 /c "cmd /c set dcheck=1"
	if "%dcheck%"=="1" (
		forfiles /p %backupdir% /d -30 /c "cmd /c del @file"
		echo Files older than 30 days deleted		
	) else (
		echo No files deleted
	)
)

copy %master% %backupdir%

set masternoquotes=!master:"=%""%!
set "str=%masternoquotes%"
set "result=%str:\=" & set "result=%"
set mastername=%result%
 
for /f "tokens=1-3 delims=/ " %%i in ("%date%") do (
    set day=%%i
    set month=%%j
    set year=%%k   
)
 
set datestr=%day%-%month%-%year%
set datestr=%datestr:~0,8%
echo %datestr%

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
set timetrim=%hour%%min%
echo %timetrim%

set mastertrim=!mastername:.accdb=%""%!
set mastertrim=!mastertrim:.mdb=%""%!
echo %mastertrim%

set masternew=^"%mastertrim%^"" BKP "%datestr%"@"%timetrim%
echo %masternew%

set extn=%mastername:~-3%
set extn=!extn:"=%""%!
set extn1=%mastername:~-5%
set extn1=!extn1:"=%""%!

if "%extn%"=="mdb" (
	if exist %backupdir%"\"%masternew%.mdb DEL /F %backupdir%"\"%masternew%.mdb
	ren %backupdir%"\"^"%mastername%^" %masternew%.mdb
	echo mdb version	
)   else if "%extn1%"=="accdb" (
    if exist %backupdir%"\"%masternew%.accdb DEL /F %backupdir%"\"%masternew%.accdb
    ren %backupdir%"\"^"%mastername%^" %masternew%.accdb
    echo accdb version
)

taskkill /F /IM mshta.exe
 
echo BACKUP COMPLETE
echo wscript.quit MsgBox ("Backup Complete", 0+vbSystemModal, "Master Backup Script") > ok.vbs
wscript //nologo ok.vbs
del ok.vbs

:strlen <resultVar> <stringVar>
(   
    setlocal EnableDelayedExpansion
    (set^ tmp=!%~2!)
    if defined tmp (
        set "len=1"
        for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            if "!tmp:~%%P,1!" NEQ "" ( 
                set /a "len+=%%P"
                set "tmp=!tmp:~%%P!"
            )
        )
    ) else (
        set len=0
    )
)
( 
    endlocal
    set "%~1=%len%"
    exit /b
)