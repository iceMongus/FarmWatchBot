REM Developer acrefawn. Contact me: t.me/acrefawn
REM I recommend that you do not touch the options below unless you know what you are doing.
@ECHO off
SETLOCAL EnableExtensions EnableDelayedExpansion
MODE CON cols=70 lines=40
shutdown.exe /A 2>NUL 1>&2
DEL /Q /F "update.bat" 2>NUL 1>&2
SET ver=1.9.7
SET mn=Phnx
SET firstrun=0
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET dt0=%%A
TITLE %mn%_autorun(%dt0%)
:hardstart
CLS
COLOR 1F
ECHO +===================================================================+
ECHO              AutoRun v.%ver% for %mn% Miner - by Acrefawn
ECHO             ETH: 0x4a98909270621531dda26de63679c1c6fdcf32ea
ECHO                 BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +===================================================================+
REM Attention. Change the options below only if you really need to.
REM Name miner .log file. [in English, without special symbols and spaces]
SET log=log*.txt
REM Name config .ini file. [in English, without special symbols and spaces]
SET config=Config_e%mn%.ini
REM Check to see if autorun.bat has already been started. [0 - false, 1 - true]
SET cmddoubleruncheck=1
REM Allow computer to be restarted. [0 - false, 1 - true]
SET pcrestart=1
REM Default config.
SET gpus=0
SET allowrestart=1
SET hashrate=0
SET minerprocess=PhoenixMiner.exe
SET minerpath=%minerprocess%
SET commandserver1=%minerpath% -pool eu1.ethermine.org:4444 -wal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr197 -coin eth -log 1
SET commandserver2=%minerpath% -pool eu1.ethermine.org:4444 -wal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr197 -coin eth -log 1
SET commandserver3=%minerpath% -pool eu1.ethermine.org:4444 -wal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr197 -coin eth -log 1
SET commandserver4=%minerpath% -pool eu1.ethermine.org:4444 -wal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr197 -coin eth -log 1
SET commandserver5=%minerpath% -pool eu1.ethermine.org:4444 -wal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr197 -coin eth -log 1
SET overclockprogram=0
SET msiaprofile=0
SET msiatimeout=120
SET restartoverclockprogram=0
SET minertimeoutrestart=72
SET computertimeoutrestart=0
SET noonrestart=0
SET midnightrestart=0
SET internetcheck=1
SET tempcheck=1
SET environments=1
SET sharetimeout=1
SET runtimeerrors=5
SET hashrateerrors=5
SET bat=%mn%e_miner.bat
SET pingserver=google.com
SET cputimeout=5
SET rigname=%COMPUTERNAME%
SET chatid=0
SET everyhourinfo=0
SET approgram=0
SET approcessname=TeamViewer.exe
SET approcesspath=C:\Program Files (x86)\TeamViewer\TeamViewer.exe
REM I recommend that you do not touch the options below unless you know what you are doing.
SET ptos=0
SET hrdiff=00
SET mediff=00
SET ssdiff=00
SET allowsend=0
SET queue=1
SET lastsharediff=0
SET serversamount=0
SET errorscounter=0
SET switchtodefault=0
SET tprt=WYHfeJU
SET rtpt=d2a
SET prt=AAFWKz6wv7
SET rtp=%rtpt%eV6i
SET tpr=C8go_jp8%tprt%
SET /A num=(3780712+3780711)*6*9
SET warningslist=/C:".*reached.*"
SET errorscancel=/C:".*Connected.*"
SET criticalerrorslist=/C:".*CUDA-capable.*"
SET errorslist=/C:".*GPU .* hangs.*"
SET interneterrorslist=/C:"Can.*t resolve.*" /C:".*Unable to read pool response.*" /C:".*Reconnecting.*" /C:".*Connection closed by the pool.*"
IF %cmddoubleruncheck% EQU 1 (
	tasklist.exe /V /NH /FI "imagename eq cmd.exe"| findstr.exe /V /R /C:".*%mn%_autorun(%dt0%)"| findstr.exe /R /C:".*%mn%_autorun.*" 2>NUL 1>&2 && (
		ECHO This script is already running...
		ECHO Current window will close in 15 seconds.
		timeout.exe /T 15 /nobreak >NUL
		EXIT
	)
)
:checkconfig
timeout.exe /T 3 /nobreak >NUL
IF NOT EXIST "%config%" (
	SET serversamount=5
	GOTO createconfig
)
FOR /F "eol=# delims=" %%a IN (%config%) DO SET "%%a"
FOR %%A IN (gpus allowrestart hashrate commandserver1 overclockprogram msiaprofile msiatimeout restartoverclockprogram minertimeoutrestart computertimeoutrestart noonrestart noonrestart midnightrestart internetcheck tempcheck environments sharetimeout runtimeerrors hashrateerrors minerprocess minerpath bat pingserver cputimeout rigname chatid everyhourinfo approgram approcessname approcesspath) DO IF NOT DEFINED %%A GOTO corruptedconfig
FOR /F "eol=# delims=" %%A IN ('findstr.exe /R /C:"commandserver.*" %config%') DO SET /A serversamount+=1
FOR /L %%A IN (1,1,%serversamount%) DO (
	FOR %%B IN (commandserver%%A) DO IF NOT DEFINED %%B GOTO corruptedconfig
)
findstr.exe /C:"%ver%" %config% >NUL || (
	timeout.exe /T 3 /nobreak >NUL
	CALL :inform "1" "false" "0" "Your %config% is out of date." "2"
	GOTO createconfig
)
IF EXIST "%~n0.log" FOR %%A IN (%~n0.log) DO IF %%~ZA GEQ 1000000 DEL /F /Q "%~n0.log" 2>NUL 1>&2
FOR %%A IN (%~n0.bat) DO IF %%~ZA LSS 4400 EXIT
FOR %%B IN (%config%) DO IF %%~ZB LSS 3450 GOTO corruptedconfig
timeout.exe /T 3 /nobreak >NUL
CALL :inform "1" "false" "0" "%config% loaded." "2"
IF %queue% GTR %serversamount% SET queue=1
GOTO start
:corruptedconfig
CALL :inform "1" "false" "%config% file error. The file is corrupted. Please check it..." "1" "1"
:createconfig
IF EXIST "%config%" MOVE /Y %config% Backup_%config% >NUL && ECHO Created backup of your old %config%.
> %config% ECHO # Configuration file v. %ver%
>> %config% ECHO # =================================================== [GPU]
>> %config% ECHO # Set how many GPU devices are enabled.
>> %config% ECHO gpus=%gpus%
>> %config% ECHO # Allow computer restart if number of loaded GPUs is not equal to number of enabled GPUs. [0 - false, 1 - true]
>> %config% ECHO allowrestart=%allowrestart%
>> %config% ECHO # Set the total average hashrate of this Rig. Best to set slightly below your reported hashrate. If your miners hasrate drops below the value you set here the script will restart your miner.
>> %config% ECHO hashrate=%hashrate%
>> %config% ECHO # =================================================== [Miner]
>> %config% ECHO # Set the main server mining command here to auto-create %bat% file if it is missing or wrong. [keep default order]
>> %config% ECHO commandserver1=%commandserver1%
IF DEFINED commandserver2 >> %config% ECHO # When the main server fails, %~n0.bat will switch to the additional server below immediately. [in order]
IF DEFINED commandserver2 >> %config% ECHO # Configure miner command here. Old %bat% will be removed and a new one will be created with this value. [keep default order] internetcheck=1 required.
IF DEFINED commandserver2 >> %config% ECHO # The default number of servers is 5, however, you can add or remove as many as you need. e.g. you can have servers 1 2 3 or you can have 1 2 3 4 5 6 7 8 9. There is no upper limit - e.g. you can have 1000 if you want. The minimum is 1.
IF %serversamount% GTR 1 FOR /L %%A IN (2,1,%serversamount%) DO (
	FOR %%B IN (commandserver%%A) DO IF DEFINED %%B >> %config% ECHO %%B=!commandserver%%A!
)
>> %config% ECHO # =================================================== [Overclock program]
>> %config% ECHO # Autorun and check to see if already running of GPU Overclock program. [0 - false, 1 - true XTREMEGE, 2 - true AFTERBURNER, 3 - true GPUTWEAK, 4 - true PRECISION, 5 - true AORUSGE, 6 - true THUNDERMASTER]
>> %config% ECHO overclockprogram=%overclockprogram%
>> %config% ECHO # Additional option to auto-enable Overclock Profile for MSI Afterburner. Please, do not use this option if it is not needed. [0 - false, 1 - Profile 1, 2 - Profile 2, 3 - Profile 3, 4 - Profile 4, 5 - Profile 5]
>> %config% ECHO msiaprofile=%msiaprofile%
>> %config% ECHO # Set MSI Afterburner wait timer after start. Important on weak processors. [default - 120 sec, min value - 1 sec]
IF %gpus% GEQ 1 SET /A msiatimeout=%gpus%*15
>> %config% ECHO msiatimeout=%msiatimeout%
>> %config% ECHO # Allow Overclock programs to be restarted when miner is restarted. Please, do not use this option if it is not needed. [0 - false, 1 - true]
>> %config% ECHO restartoverclockprogram=%restartoverclockprogram%
>> %config% ECHO # =================================================== [Timers]
>> %config% ECHO # Restart MINER every X hours. Set value of delay [in hours] between miner restarts. Note - this will be the number of hours the miner has been running. [0 - false, 1-999 - scheduled hours delay]
>> %config% ECHO minertimeoutrestart=%minertimeoutrestart%
>> %config% ECHO # Restart COMPUTER every X hours. Set value of delay [in hours] between computer restarts. Note - this will be the number of hours the miner has been running. [0 - false, 1-999 - scheduled hours delay]
>> %config% ECHO computertimeoutrestart=%computertimeoutrestart%
>> %config% ECHO # Restart miner or computer every day at 12:00. [1 - true miner, 2 - true computer, 0 - false]
>> %config% ECHO noonrestart=%noonrestart%
>> %config% ECHO # Restart miner or computer every day at 00:00. [1 - true miner, 2 - true computer, 0 - false]
>> %config% ECHO midnightrestart=%midnightrestart%
>> %config% ECHO # =================================================== [Other]
>> %config% ECHO # Enable Internet connectivity check. [0 - false, 1 - true full, 2 - true without server switching]
>> %config% ECHO # Disable Internet connectivity check only if you have difficulties with your connection. [ie. high latency, intermittent connectivity]
>> %config% ECHO internetcheck=%internetcheck%
>> %config% ECHO # Enable 0C - 5C temperature error check. [0 - false, 1 - true]
>> %config% ECHO tempcheck=%tempcheck%
>> %config% ECHO # Enable additional environments. Please do not use this option if it is not needed, or if you do not understand its function. [0 - false, 1 - true]
>> %config% ECHO # GPU_FORCE_64BIT_PTR 0, GPU_MAX_HEAP_SIZE 100, GPU_USE_SYNC_OBJECTS 1, GPU_MAX_ALLOC_PERCENT 100, GPU_SINGLE_ALLOC_PERCENT 100
>> %config% ECHO environments=%environments%
>> %config% ECHO # Enable last share timeout check. Your miner sends and receives shares - if there is a delay of more than 15 minutes between the send/receive, the script will think that the miner is stuck and restart the miner. [0 - false, 1 - true]
>> %config% ECHO sharetimeout=%sharetimeout%
>> %config% ECHO # Number of errors before computer restart. Once the threshold is reached, the computer will restart. [5 - default, only numeric values]
>> %config% ECHO runtimeerrors=%runtimeerrors%
>> %config% ECHO # Number of hashrate errors before miner restart. Once the threshold is reached, the miner will restart. [5 - default, only numeric values]
>> %config% ECHO hashrateerrors=%hashrateerrors%
>> %config% ECHO # Name miner file process. Only change this if you have changed the default name of your %minerprocess% file. [in English, without special symbols and spaces]
>> %config% ECHO minerprocess=%minerprocess%
>> %config% ECHO # Path to miner. Do not change if the script and miner are in the same folder. Only use this option if you plan to switch between multiple miners. [in English, without special symbols and spaces]
>> %config% ECHO minerpath=%minerpath%
>> %config% ECHO # Name start mining .bat file. [in English, without special symbols and spaces]
>> %config% ECHO bat=%bat%
>> %config% ECHO # Name server for ping. Default is google.com - change if you have difficulty reaching Google servers. [in English, without special symbols and spaces]
>> %config% ECHO pingserver=%pingserver%
>> %config% ECHO # Slowdown script for weak CPUs. Increase this value incrementally [1 by 1] if your hashrate drops because of script. This may slow down the responsiveness of the script. [5 - default, only numeric values]
>> %config% ECHO cputimeout=%cputimeout%
>> %config% ECHO # =================================================== [Telegram notifications]
>> %config% ECHO # To enable Telegram notifications enter here your chatid, from Telegram @FarmWatchBot. [0 - disable]
>> %config% ECHO chatid=%chatid%
>> %config% ECHO # Name your Rig. [in English, without special symbols]
>> %config% ECHO rigname=%rigname%
>> %config% ECHO # Enable hourly statistics through Telegram. [0 - false, 1 - true full, 2 - true full in silent mode, 3 - true short, 4 - true short in silent mode, 5 - disable useless Telegram notifications]
>> %config% ECHO everyhourinfo=%everyhourinfo%
>> %config% ECHO # =================================================== [Additional program]
>> %config% ECHO # Enable additional program check on startup. [ie. TeamViewer, Minergate, Storj etc] [0 - false, 1 - true]
>> %config% ECHO approgram=%approgram%
>> %config% ECHO # Process name of additional program. [Press CTRL+ALT+DEL to find the process name]
>> %config% ECHO approcessname=%approcessname%
>> %config% ECHO # Path to file of additional program. [ie. C:\Program Files\TeamViewer\TeamViewer.exe]
>> %config% ECHO approcesspath=%approcesspath%
CALL :inform "1" "false" "0" "Default %config% created. Please check it." "2"
timeout.exe /T 3 /nobreak >NUL
GOTO hardstart
:ctimer
CLS
ECHO +===================================================================+
ECHO               Scheduled computer restart, please wait...
ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                              Restarting...
ECHO +===================================================================+
CALL :inform "0" "true" "Scheduled computer restart, please wait..." "Scheduled computer restart, please wait... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
timeout.exe /T 3 /nobreak >NUL
:restart
IF %pcrestart% EQU 0 GOTO hardstart
COLOR 4F
CALL :screenshot
CALL :inform "1" "false" "Computer restarting..." "1" "0"
CALL :kill "1" "1" "1" "1"
shutdown.exe /T 60 /R /F /C "Your computer will restart after 60 seconds. To cancel restart, close this window and START %~n0.bat manually."
EXIT
:switch
CLS
ECHO +===================================================================+
ECHO             Attempting to switch to the main pool server...
ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                           Miner restarting...
ECHO +===================================================================+
CALL :inform "1" "true" "Attempting to switch to the main pool server..." "Attempting to switch to the main pool server... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
SET switchtodefault=0
SET queue=1
timeout.exe /T 3 /nobreak >NUL
GOTO start
:mtimer
CLS
ECHO +===================================================================+
ECHO                 Scheduled miner restart, please wait...
ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                              Restarting...
ECHO +===================================================================+
CALL :inform "0" "true" "Scheduled miner restart, please wait..." "Scheduled miner restart, please wait... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
timeout.exe /T 3 /nobreak >NUL
GOTO start
:error
CLS
COLOR 4F
SET /A errorscounter+=1
IF %errorscounter% GTR %runtimeerrors% (
	ECHO +===================================================================+
	ECHO                Too many errors, need clear GPU cache...
	ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
	ECHO                         Computer restarting...
	ECHO +===================================================================+
	CALL :inform "1" "true" "Too many errors. Threshold of *%runtimeerrors%* runtime errors reached. A restart of the computer to clear GPU cache is required. Restarting..." "Too many errors. Threshold of %runtimeerrors% runtime errors reached. A restart of the computer to clear GPU cache is required. Restarting... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
	timeout.exe /T 3 /nobreak >NUL
	GOTO restart
)
ECHO +===================================================================+
ECHO                          Something is wrong...
ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                           Miner restarting...
ECHO +===================================================================+
CALL :inform "1" "false" "Miner restarting, please wait..." "Miner restarting, please wait... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
CALL :screenshot
timeout.exe /T 3 /nobreak >NUL
:start
SET chatid=%chatid: =%
SET gpus=%gpus: =%
SET hashrate=%hashrate: =%
IF %tempcheck% EQU 1 SET errorslist=%errorslist% /C:".* [0-5]C .*"
IF %environments% EQU 1 FOR %%a IN ("GPU_FORCE_64BIT_PTR 0" "GPU_MAX_HEAP_SIZE 100" "GPU_USE_SYNC_OBJECTS 1" "GPU_MAX_ALLOC_PERCENT 100" "GPU_SINGLE_ALLOC_PERCENT 100") DO SETX %%~a 2>NUL 1>&2 && ECHO %%~a.
IF %environments% EQU 0 FOR %%a IN ("GPU_FORCE_64BIT_PTR" "GPU_MAX_HEAP_SIZE" "GPU_USE_SYNC_OBJECTS" "GPU_MAX_ALLOC_PERCENT" "GPU_SINGLE_ALLOC_PERCENT") DO REG DELETE HKCU\Environment /F /V %%~a 2>NUL 1>&2 && ECHO %%~a successfully removed from environments.
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET dt1=%%A
SET mh1=1%dt1:~4,2%
SET dy1=1%dt1:~6,2%
SET hr1=1%dt1:~8,2%
SET me1=1%dt1:~10,2%
SET ss1=1%dt1:~12,2%
SET /A mh1=%mh1%-100
SET /A dy1=%dy1%-100
SET /A hr1=%hr1%-100
SET /A me1=%me1%-100
SET /A ss1=%ss1%-100
SET /A dtdiff1=%hr1%*60*60+%me1%*60+%ss1%
IF NOT EXIST "%minerpath%" (
	ECHO "%minerprocess%" is missing. Please check the directory for missing files. Exiting...
	PAUSE
	EXIT
)
tasklist.exe /FI "IMAGENAME eq werfault.exe" 2>NUL| find.exe /I /N "werfault.exe" >NUL && CALL :killwerfault
tasklist.exe /FI "IMAGENAME eq %minerprocess%" 2>NUL| find.exe /I /N "%minerprocess%" >NUL && (
	taskkill.exe /T /F /IM "%minerprocess%" 2>NUL 1>&2 || (
		CALL :inform "1" "false" "Unable to kill %minerprocess%. Retrying..." "1" "1"
		GOTO error
	)
	timeout.exe /T 4 /nobreak >NUL && taskkill.exe /T /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq *%bat%*" 2>NUL 1>&2
	CALL :inform "1" "false" "0" "Process %minerprocess% was successfully killed." "2"
)
ECHO Please wait 30 seconds or press any key to continue...
ECHO This wait is needed to prevent GPUs crashes. It also allows you to connect via TeamViewer to close the script before the miner launches in case of critical errors or BSOD.
timeout.exe /T 30 >NUL
IF NOT EXIST "Logs" MD Logs && ECHO Folder Logs created.
IF NOT EXIST "Screenshots" MD Screenshots && ECHO Folder Screenshots created.
IF %overclockprogram% GEQ 1 IF %overclockprogram% LEQ 6 (
	FOR /F "tokens=%overclockprogram% delims= " %%A IN ("Xtreme MSIAfterburner GPUTweakII PrecisionX_x64 AORUS THPanel") DO (
		SET overclockprocessname=%%A
	)
	FOR /F "tokens=%overclockprogram% delims=," %%A IN ("\GIGABYTE\XTREME GAMING ENGINE\,\MSI Afterburner\,\ASUS\GPU TweakII\,\EVGA\Precision XOC\,\GIGABYTE\AORUS GRAPHICS ENGINE\,\Thunder Master\") DO (
		SET overclockprocesspath=%%A
	)
)
IF DEFINED overclockprocessname IF DEFINED overclockprocesspath IF NOT EXIST "%programfiles(x86)%%overclockprocesspath%" (
	ECHO Incorrect path to %overclockprocessname%.exe. Default install path required to function. Please reinstall the software using the default path.
	SET overclockprogram=0
)
IF %overclockprogram% NEQ 0 (
	IF %firstrun% NEQ 0 IF %restartoverclockprogram% EQU 1 (
		tskill.exe /A /V %overclockprocessname% 2>NUL 1>&2
		CALL :inform "1" "false" "0" "Process %overclockprocessname%.exe was successfully killed." "2"
	)
	timeout.exe /T 5 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %overclockprocessname%.exe" 2>NUL| find.exe /I /N "%overclockprocessname%.exe" >NUL || (
		START "" "%programfiles(x86)%%overclockprocesspath%%overclockprocessname%.exe" && (
			CALL :inform "0" "true" "%overclockprocessname%.exe was started." "1" "1"
			SET firstrun=0
		) || (
			CALL :inform "1" "false" "Unable to start %overclockprocessname%.exe." "1" "1"
			SET overclockprogram=0
			GOTO error
		)
	)
)
IF %msiaprofile% GEQ 1 IF %msiaprofile% LEQ 5 IF %overclockprogram% EQU 2 (
	IF %firstrun% EQU 0 (
		ECHO Waiting %msiatimeout% sec. MSI Afterburner to fully load the profile for each GPU or press any key to continue... It is recommended to wait for minimum 15 sec. for each GPU load.
		timeout.exe /T %msiatimeout% >NUL
	)
	"%programfiles(x86)%%overclockprocesspath%%overclockprocessname%.exe" -Profile%msiaprofile% >NUL && ECHO MSI Afterburner profile %msiaprofile% activated.
	SET firstrun=1
)
IF %approgram% NEQ 0 IF NOT EXIST "%approcesspath%" (
	ECHO Incorrect path to %approcessname%.
	SET approgram=0
)
IF %approgram% NEQ 0 (
	timeout.exe /T 5 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %approcessname%" 2>NUL| find.exe /I /N "%approcessname%" >NUL || (
		START /MIN "%approcessname%" "%approcesspath%" && (
			CALL :inform "0" "true" "%approcessname% was started." "1" "1"
		) || (
			CALL :inform "1" "false" "Unable to start %approcessname%." "1" "1"
			SET approgram=0
			GOTO error
		)
	)
)
IF EXIST "%log%" (
	MOVE /Y %log% Logs\miner_%mh1%.%dy1%_%hr1%.%me1%.log 2>NUL 1>&2 && (
		CALL :inform "1" "false" "0" "%log% moved to Logs folder as miner_%mh1%.%dy1%_%hr1%.%me1%.log" "2"
		IF EXIST "%~dp0Logs\*.log" FOR /F "skip=30 usebackq delims=" %%a IN (`DIR /B /A:-D /O:-D /T:W "%~dp0Logs\"`) DO DEL /F /Q "%~dp0Logs\%%~a" 2>NUL 1>&2
		IF EXIST "%~dp0Logs\*.jpg" FOR /F "skip=30 usebackq delims=" %%a IN (`DIR /B /A:-D /O:-D /T:W "%~dp0Screenshots\"`) DO DEL /F /Q "%~dp0Screenshots\%%~a" 2>NUL 1>&2
	) || (
		CALL :inform "1" "false" "Unable to rename or access %log%. Attempting to delete %log% and continue..." "1" "1"
		DEL /Q /F "%log%" 2>NUL 1>&2
		IF EXIST "%log%" (
			CALL :inform "1" "false" "Unable to delete %log%." "1" "1"
			GOTO error
		)
	)
)
> %bat% ECHO @ECHO off
>> %bat% ECHO TITLE %bat%
>> %bat% ECHO REM Configure the miners command line in %config% file. Not in %bat% - any values in %bat% will not be used.
IF %queue% GEQ 1 IF %queue% LEQ %serversamount% >> %bat% ECHO !commandserver%queue%!
REM Default pool server settings for debugging. Will be activated only in case of mining failed on all user pool servers, to detect errors in the configuration file. Will be deactivated automatically in 30 minutes and switched back to settings of main pool server. To be clear, this will mean you are mining to my address for 30 minutes, at which point the script will then iterate through the pools that you have configured in the configuration file. I have used this address because I know these settings work. If the script has reached this point, CHECK YOUR CONFIGURATION FILE or all pools you have specified are offline. You can also change the address here to your own.
IF %queue% EQU 0 >> %bat% ECHO %minerpath% -pool eu1.ethermine.org:4444 -wal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr197 -coin eth -log 1
>> %bat% ECHO EXIT
timeout.exe /T 3 /nobreak >NUL
START "%bat%" "%bat%" && (
	CALL :inform "1" "false" "Miner was started." "Miner was started. Script v.%ver%." "Miner was started at %Time:~-11,8%"
	FOR /F "tokens=3,4 delims=/:= " %%a IN ('findstr.exe /R /C:".*%minerprocess%" %bat%') DO (
		ECHO %%b| findstr.exe /V /I /R /C:".*stratum.*" /C:".*ssl.*" /C:".*stratum.*tcp.*" /C:".*stratum.*tls.*" /C:".*http.*" /C:".*https.*" /C:".*log.*"| findstr.exe /R /C:".*\..*" >NUL && (
			SET curservername=%%b
		)
		ECHO %%a| findstr.exe /V /I /R /C:".*stratum.*" /C:".*ssl.*" /C:".*stratum.*tcp.*" /C:".*stratum.*tls.*" /C:".*http.*" /C:".*https.*" /C:".*log.*"| findstr.exe /R /C:".*\..*" >NUL && (
			SET curservername=%%a
		)
	)
	timeout.exe /T 15 /nobreak >NUL
) || (
	CALL :inform "1" "false" "Unable to start miner." "1" "1"
	GOTO error
)
IF NOT DEFINED curservername SET curservername=unknown
IF NOT EXIST "%log%" (
	findstr.exe /R /C:".*-log 1.*" %bat% 2>NUL 1>&2 || (
		CALL :inform "1" "false" "%log% is missing. Ensure *-log 1* option is added to the miners command line." "%log% is missing. Ensure -log 1 option is added to the miners command line." "2"
		GOTO error
	)
	CALL :inform "1" "false" "%log% is missing. Probably %minerprocess% hangs..." "1" "1"
	GOTO restart
) ELSE (
	findstr.exe /R /C:".*%minerprocess% -pool.*-log 1.*" %bat% 2>NUL 1>&2 || (
		CALL :inform "1" "false" "Ensure *%minerpath% -pool -log 1* options added to the miners command line in this order." "Ensure %minerpath% -pool -log 1 options added to the miners command line in this order." "2"
	)
	ECHO log monitoring started.
	ECHO Collecting information. Please wait...
	timeout.exe /T 25 /nobreak >NUL
)
SET hashrateerrorscount=0
SET oldhashrate=0
SET firstrun=0
SET gpucount=0
:check
SET interneterrorscount=1
SET lastinterneterror=0
SET minhashrate=0
SET hashcount=0
SET lasterror=0
SET sumresult=0
SET sumhash=0
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET dt2=%%A
SET mh2=1%dt2:~4,2%
SET dy2=1%dt2:~6,2%
SET hr2=1%dt2:~8,2%
SET me2=1%dt2:~10,2%
SET ss2=1%dt2:~12,2%
SET /A mh2=%mh2%-100
SET /A dy2=%dy2%-100
SET /A hr2=%hr2%-100
SET /A me2=%me2%-100
SET /A ss2=%ss2%-100
SET /A dtdiff2=%hr2%*60*60+%me2%*60+%ss2%
SET /A nextreqtime=%me2%+7
IF %ptos% GTR %nextreqtime% SET ptos=0
IF %dy2% GTR %dy1% (
	SET /A dtdiff=^(%dy2%-%dy1%^)*86400-%dtdiff1%+%dtdiff2%
) ELSE (
	IF %mh2% NEQ %mh1% (
		CALL :inform "0" "true" "New month reached - Miner must be restarted to ensure accurate runtime, please wait..." "1" "1"
		GOTO hardstart
	)
	IF %dtdiff2% GEQ %dtdiff1% (
		SET /A dtdiff=%dtdiff2%-%dtdiff1%
	) ELSE (
		SET /A dtdiff=%dtdiff1%-%dtdiff2%
	)
)
SET /A hrdiff=%dtdiff%/60/60
SET /A mediff=%dtdiff% %% 3600/60
SET /A ssdiff=%dtdiff% %% 60
IF %hrdiff% LSS 10 SET hrdiff=0%hrdiff%
IF %mediff% LSS 10 SET mediff=0%mediff%
IF %ssdiff% LSS 10 SET ssdiff=0%ssdiff%
IF %midnightrestart% EQU 1 IF %dy2% NEQ %dy1% GOTO mtimer
IF %midnightrestart% EQU 2 IF %dy2% NEQ %dy1% GOTO ctimer
IF %minertimeoutrestart% GEQ 1 IF %hrdiff% GEQ %minertimeoutrestart% GOTO mtimer
IF %computertimeoutrestart% GEQ 1 IF %hrdiff% GEQ %computertimeoutrestart% GOTO ctimer
IF %hrdiff% GEQ 1 IF %hr2% EQU 12 (
	IF %noonrestart% EQU 1 GOTO mtimer
	IF %noonrestart% EQU 2 GOTO ctimer
)
IF %switchtodefault% EQU 1 IF %hrdiff% EQU 0 IF %mediff% GEQ 30 GOTO switch
FOR %%A IN (%log%) DO (
	IF %%~ZA GTR 70000000 (
		CALL :inform "0" "true" "Miner must be restarted, large log file size, please wait..." "1" "1"
		GOTO hardstart
	)
)
IF %hrdiff% GEQ 96 (
	CALL :inform "0" "true" "Miner must be restarted, large log file size, please wait..." "1" "1"
	GOTO hardstart
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "delims=" %%N IN ('findstr.exe /I /R %criticalerrorslist% %errorslist% %warningslist% %interneterrorslist% %log%') DO SET "lasterror=%%N"
IF "%lasterror%" NEQ "0" (
	IF %internetcheck% GEQ 1 (
		ECHO "%lasterror%"| findstr.exe /I /R %interneterrorslist% 2>NUL 1>&2 && (
			FOR /F "delims=" %%n IN ('findstr.exe /I /R %interneterrorslist% %errorscancel% %log%') DO SET lastinterneterror=%%n
			ECHO !lastinterneterror!| findstr.exe /I /R %interneterrorslist% >NUL && (
				ECHO Something is wrong with your Internet connection. Waiting for confirmation of connection error in case miner cannot automatically reconnect...
				timeout.exe /T 120 >NUL
				FOR /F "delims=" %%n IN ('findstr.exe /I /R %interneterrorslist% %errorscancel% %log%') DO SET lastinterneterror=%%n
				ECHO !lastinterneterror!| findstr.exe /I /R %interneterrorslist% >NUL && (
					CALL :inform "1" "false" "%lasterror%" "1" "0"
					ping.exe %pingserver%| find.exe /I "TTL=" >NUL && (
						CLS
						COLOR 4F
						CALL :kill "0" "0" "1" "1"
						IF %internetcheck% NEQ 2 SET switchtodefault=1
						IF %internetcheck% NEQ 2 SET /A queue+=1
						SET /A errorscounter+=1
						ECHO +===================================================================+
						ECHO         Check %config% file for errors or pool is offline...
						ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
						IF %internetcheck% NEQ 2 ECHO                 Miner restarting with changed values...
						ECHO +===================================================================+
						IF !queue! GTR %serversamount% SET queue=0
						IF %internetcheck% NEQ 2 CALL :inform "1" "false" "Pool server was switched to *!queue!*. Please check your *%config%* file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online." "Pool server was switched to !queue!. Please check your %config% file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online." "2"
						IF %internetcheck% EQU 2 CALL :inform "1" "false" "Please check your *%config%* file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online. Miner restarting..." "Please check your %config% file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online. Miner restarting..." "2"
						GOTO start
					) || (
						CALL :inform "1" "false" "Something is wrong with your Internet connection. Please check your connection." "Something is wrong with your Internet connection. Please check your connection. Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
						:tryingreconnect
						CLS
						COLOR 4F
						ECHO +===================================================================+
						ECHO                 Something is wrong with your Internet...
						ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
						ECHO                        Attempting to reconnect...
						ECHO +===================================================================+
						IF %hrdiff% EQU 0 IF %mediff% LEQ 15 IF %interneterrorscount% GTR 60 GOTO restart
						IF %hrdiff% EQU 0 IF %mediff% GTR 15 IF %interneterrorscount% GTR 15 GOTO restart
						IF %hrdiff% GTR 0 IF %interneterrorscount% GTR 15 GOTO restart
						ECHO Attempt %interneterrorscount% to restore Internet connection.
						SET /A interneterrorscount+=1
						FOR /F "delims=" %%n IN ('findstr.exe /I /R %interneterrorslist% %errorscancel% %log%') DO SET lastinterneterror=%%n
						ECHO !lastinterneterror!| findstr.exe /I /R %errorscancel% && (
							ECHO +===================================================================+
							ECHO                     Connection has been restored...
							ECHO                           Continue mining...
							ECHO +===================================================================+
							CALL :inform "1" "false" "Something was wrong with your Internet connection. Connection has been restored. Continue mining..." "1" "0"
							GOTO check
						)
						ping.exe %pingserver%| find.exe /I "TTL=" >NUL && GOTO reconnected || (
							timeout.exe /T 60 /nobreak >NUL
							GOTO tryingreconnect
						)
						:reconnected
						ECHO +===================================================================+
						ECHO                     Connection has been restored...
						ECHO                           Miner restarting...
						ECHO +===================================================================+
						CALL :inform "1" "false" "Something was wrong with your Internet connection. Connection has been restored. Miner restarting..." "Something was wrong with your Internet connection. Connection has been restored. Miner restarting... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
						GOTO start
					)
				)
			)
		)
	)
	ECHO "%lasterror%"| findstr.exe /I /R %errorslist% 2>NUL && (
		CALL :inform "1" "false" "%lasterror%" "1" "0"
		GOTO error
	)
	ECHO "%lasterror%"| findstr.exe /I /R %criticalerrorslist% 2>NUL && (
		CALL :inform "1" "false" "%lasterror%" "1" "0"
		GOTO restart
	)
	ECHO "%lasterror%"| findstr.exe /I /R %warningslist% 2>NUL && (
		CLS
		COLOR 4F
		ECHO +===================================================================+
		ECHO                       Temperature limit reached...
		ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
		ECHO +===================================================================+
		CALL :inform "1" "false" "0" "%curtemp%." "2"
		IF %hrdiff% EQU 0 IF %mediff% LEQ 10 (
			CALL :kill "1" "1" "1" "1"
			CALL :inform "1" "false" "%curtemp%.%%%%0A%%%%0ATemperature limit reached. Process %minerprocess% was successfully killed. GPUs will now *STOP MINING*. Please ensure your GPUs have enough air flow. Use */startover* command to begin mining again, or restart *%~n0.bat* manually.%%%%0A%%%%0A*Waiting for users input...*" "Please ensure your GPUs have enough air flow. GPUs will now STOP MINING. Miner ran for %hrdiff%:%mediff%:%ssdiff%." "Please ensure your GPUs have enough air flow. GPUs will now STOP MINING. Waiting for users input..."
			SET waituserinput=1
			GOTO commands
		)
		CALL :inform "1" "false" "%curtemp%.%%%%0A%%%%0ATemperature limit reached. Fans may be stuck. Attempting to restart computer..." "Temperature limit reached. Fans may be stuck." "2"
		GOTO restart
	)
)
timeout.exe /T %cputimeout% /nobreak >NUL
tasklist.exe /FI "IMAGENAME eq werfault.exe" 2>NUL| find.exe /I /N "werfault.exe" >NUL && CALL :killwerfault
tasklist.exe /FI "IMAGENAME eq %minerprocess%" 2>NUL| find.exe /I /N "%minerprocess%" >NUL || (
	CALL :inform "1" "false" "Process %minerprocess% crashed..." "1" "1"
	GOTO error
)
IF %overclockprogram% NEQ 0 (
	timeout.exe /T %cputimeout% /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %overclockprocessname%.exe" 2>NUL| find.exe /I /N "%overclockprocessname%.exe" >NUL || (
		CALL :inform "1" "false" "Process %overclockprocessname%.exe crashed..." "1" "1"
		GOTO error
	)
)
IF %approgram% EQU 1 (
	timeout.exe /T %cputimeout% /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %approcessname%" 2>NUL| find.exe /I /N "%approcessname%" >NUL || (
		CALL :inform "1" "false" "%approcessname% crashed..." "1" "1"
		START /MIN "%approcessname%" "%approcesspath%" && (
			CALL :inform "0" "true" "%approcessname% was started." "1" "1"
		) || (
			CALL :inform "1" "false" "Unable to start %approcessname%." "1" "1"
			SET approgram=0
			GOTO error
		)
	)
)
IF %firstrun% EQU 0 (
	timeout.exe /T %cputimeout% /nobreak >NUL
	FOR /F "delims=" %%A IN ('findstr.exe /R /C:".*main.*pcie.*" %log%') DO SET /A gpucount+=1
	IF !gpucount! EQU 0 SET gpucount=1
	IF %gpus% EQU 0 SET gpus=!gpucount!
)
IF %firstrun% EQU 0 (
	IF %gpus% GTR %gpucount% (
		IF %allowrestart% EQU 1 (
			CLS
			COLOR 4F
			ECHO +===================================================================+
			ECHO               Failed to load all GPUs. Number of GPUs: !gpucount!/%gpus%
			ECHO                          Miner ran for %hrdiff%:%mediff%:%ssdiff%
			ECHO                         Computer restarting...
			ECHO +===================================================================+
			CALL :inform "1" "false" "Failed to load all GPUs. Number of GPUs *%gpucount%/%gpus%*." "Failed to load all GPUs. Number of GPUs %gpucount%/%gpus%." "2"
			GOTO restart
		) ELSE (
			CALL :inform "1" "false" "Failed to load all GPUs. Number of GPUs *%gpucount%/%gpus%*." "Failed to load all GPUs. Number of GPUs %gpucount%/%gpus%." "2"
			SET /A hashrate=%hashrate%/%gpus%*%gpucount%
		)
	)
	IF %gpus% LSS %gpucount% (
		CALL :inform "1" "false" "Loaded too many GPUs. This must be set to a number higher than *%gpus%* in your *%config%* file under *gpus*. Number of GPUs *%gpucount%/%gpus%*." "Loaded too many GPUs. This must be set to a number higher than %gpus% in your %config% file under gpus. Number of GPUs: %gpucount%/%gpus%." "2"
		IF %allowrestart% EQU 1 GOTO restart
	)
	SET firstrun=1
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "tokens=7 delims=. " %%A IN ('findstr.exe /R /C:".*speed: .*/s.* shares.*" %log%') DO (
	SET lasthashrate=%%A
	IF %%A LSS %hashrate% SET /A minhashrate+=1
	IF %%A EQU 0 SET /A minhashrate+=1
	SET /A hashcount+=1
	SET /A sumhash=sumhash+%%A
	SET /A sumresult=sumhash/hashcount
	IF !minhashrate! GEQ 99 GOTO passaveragecheck
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "delims=" %%A IN ('findstr.exe /R /C:".*GPU.*: .*C .*" %log%') DO SET curtempcache=%%A
IF DEFINED curtempcache (
	FOR /F "tokens=2-20 delims=GPU" %%a IN ("%curtempcache%") DO (
		SET curtemp=Temp:
		SET gpunum=0
		FOR %%A IN ("%%a" "%%b" "%%c" "%%d" "%%e" "%%f" "%%g" "%%h" "%%i" "%%j" "%%k" "%%l" "%%m" "%%n" "%%o" "%%p" "%%q" "%%r" "%%s") DO (
			IF !gpunum! LSS %gpus% (
				FOR /F "tokens=2 delims=:C " %%B IN (%%A) DO (
					IF "%%B" NEQ "" IF %%B GEQ 0 (
						IF %%B LSS 70 SET curtemp=!curtemp! G!gpunum! %%BC,
						IF %%B GEQ 70 SET curtemp=!curtemp! G!gpunum! *%%BC*,
						SET /A gpunum+=1
					)
				)
			)
		)
		IF "!curtemp!" EQU "Temp:" SET curtemp=unknown
		IF "!curtemp!" NEQ "unknown" SET curtemp=!curtemp:~0,-1!
	)
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "delims=" %%A IN ('findstr.exe /R /C:".*GPU.* .*/s.*" %log%') DO SET curspeedcache=%%A
IF DEFINED curspeedcache (
	FOR /F "tokens=8-26 delims=:" %%a IN ("%curspeedcache%") DO (
		SET curspeed=Speed:
		SET gpunum=0
		FOR %%A IN ("%%a" "%%b" "%%c" "%%d" "%%e" "%%f" "%%g" "%%h" "%%i" "%%j" "%%k" "%%l" "%%m" "%%n" "%%o" "%%p" "%%q" "%%r" "%%s") DO (
			IF !gpunum! LSS %gpus% (
				FOR /F "tokens=1 delims=. " %%B IN (%%A) DO (
					IF "%%B" NEQ "" IF %%B GEQ 0 (
						SET curspeed=!curspeed! G!gpunum! %%B,
						SET /A gpunum+=1
					)
				)
			)
		)
		IF "!curspeed!" EQU "Speed:" SET curspeed=unknown
		IF "!curspeed!" NEQ "unknown" SET curspeed=!curspeed:~0,-1!
		ECHO !curspeed!| findstr.exe /R /C:".* 0 .*" 2>NUL 1>&2 && SET /A minhashrate+=1
		IF !minhashrate! GEQ 99 GOTO passaveragecheck
	)
)
timeout.exe /T %cputimeout% /nobreak >NUL
IF "%sumresult%" NEQ "0" IF %sumresult% LSS %oldhashrate% IF %sumresult% LSS %hashrate% (
	IF %hashrateerrorscount% GEQ %hashrateerrors% (
		:passaveragecheck
		CALL :inform "1" "false" "Low hashrate. Average: *%sumresult%/%hashrate%* Last: *%lasthashrate%/%hashrate%*." "Low hashrate. Average: %sumresult%/%hashrate% Last: %lasthashrate%/%hashrate%." "2"
		GOTO error
	)
	CALL :inform "0" "true" "Abnormal hashrate. Average: *%sumresult%/%hashrate%* Last: *%lasthashrate%/%hashrate%*." "Abnormal hashrate. Average: %sumresult%/%hashrate% Last: %lasthashrate%/%hashrate%." "2"
	SET /A hashrateerrorscount+=1
)
IF "%sumresult%" NEQ "0" IF %sumresult% NEQ %oldhashrate% SET oldhashrate=%sumresult%
IF %sharetimeout% EQU 1 IF %ptos% LSS %me2% (
	timeout.exe /T %cputimeout% /nobreak >NUL
	SET /A ptos=%me2%+5
	SET lastsharediff=0
	SET lastsharemin=1%dt1:~10,2%
	FOR /F "tokens=4 delims=:" %%A IN ('findstr.exe /R /C:".*Share accepted.*" %log%') DO SET lastsharemin=1%%A
	SET /A lastsharemin=!lastsharemin!-100
	IF !lastsharemin! GEQ 0 IF %me2% GTR 0 (
		IF !lastsharemin! EQU 0 SET lastsharemin=59
		IF !lastsharemin! LSS %me2% SET /A lastsharediff=%me2%-!lastsharemin!
		IF !lastsharemin! GTR %me2% SET /A lastsharediff=!lastsharemin!-%me2%
		IF !lastsharemin! GTR 50 IF %me2% LEQ 10 SET /A lastsharediff=60-!lastsharemin!+%me2%
		IF !lastsharemin! LEQ 10 IF %me2% GTR 50 SET /A lastsharediff=60-%me2%+!lastsharemin!
		IF !lastsharediff! GTR 15 (
			CALL :inform "0" "false" "Long share timeout... *!lastsharemin!/%me2%*." "Long share timeout... !lastsharemin!/%me2%." "2"
			GOTO error
		)
	)
)
IF NOT DEFINED curtemp SET curtemp=unknown
IF NOT DEFINED curspeed SET curspeed=unknown
CLS
COLOR 1F
ECHO +===================================================================+
ECHO              AutoRun v.%ver% for %mn% Miner - by Acrefawn
ECHO             ETH: 0x4a98909270621531dda26de63679c1c6fdcf32ea
ECHO                 BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +============================================================[%Time:~-5,2%]===+
ECHO Process %minerprocess% is running for %hrdiff%:%mediff%:%ssdiff% [%errorscounter%/%runtimeerrors%].
ECHO Rig [%rigname%] using [%gpucount%/%gpus%] GPUs.
IF "%curservername%" NEQ "unknown" ECHO Server: %curservername%
IF "%sumresult%" NEQ "0" IF DEFINED lasthashrate (
	ECHO +===================================================================+
	ECHO Total current speed: %lasthashrate%/%hashrate% [%minhashrate%/99]
	ECHO Total average speed: %sumresult%/%hashrate% [%hashrateerrorscount%/%hashrateerrors%]
	IF "%curspeed%" NEQ "unknown" (
		ECHO Current GPU speed:
		ECHO - %curspeed:~7%.
	)
	IF "%curtemp%" NEQ "unknown" (
		ECHO Current GPU temp:
		ECHO - %curtemp:~6%.
	)
)
ECHO +===================================================================+
IF %overclockprogram% NEQ 0 IF %overclockprogram% NEQ 2 ECHO Process %overclockprocessname%.exe is running...
IF %overclockprogram% EQU 2 (
	IF %msiaprofile% GEQ 1 IF %msiaprofile% LEQ 5 ECHO Process %overclockprocessname%.exe [Profile %msiaprofile%] is running...
	IF %msiaprofile% LSS 1 IF %msiaprofile% GTR 5 ECHO Process %overclockprocessname%.exe is running...
)
IF %overclockprogram% EQU 0 ECHO [Disabled] GPU Overclock monitor
IF "%midnightrestart%" EQU "0" ECHO [Disabled] Autorestart at 00:00
IF "%midnightrestart%" NEQ "0" ECHO [Enabled]  Autorestart at 00:00
IF "%noonrestart%" EQU "0" ECHO [Disabled] Autorestart at 12:00
IF "%noonrestart%" NEQ "0" ECHO [Enabled]  Autorestart at 12:00
IF "%minertimeoutrestart%" EQU "0" ECHO [Disabled] Autorestart miner every hour
IF "%minertimeoutrestart%" NEQ "0" ECHO [Enabled]  Autorestart miner every %minertimeoutrestart%h 
IF "%computertimeoutrestart%" EQU "0" ECHO [Disabled] Autorestart computer every hour
IF "%computertimeoutrestart%" NEQ "0" ECHO [Enabled]  Autorestart computer every %computertimeoutrestart%h
IF %sharetimeout% EQU 0 ECHO [Disabled] Last share timeout check
IF %sharetimeout% EQU 1 ECHO [Enabled]  Last share timeout check
IF "%chatid%" EQU "0" ECHO [Disabled] Telegram notifications
IF "%chatid%" NEQ "0" ECHO [Enabled]  Telegram notifications using chatid [%chatid%]
IF "%approgram%" EQU "0" ECHO [Disabled] Additional program autorun
IF "%approgram%" EQU "1" ECHO [Enabled]  Additional program autorun using [%approcessname%]
ECHO +===================================================================+
ECHO Now I will take care of your miner and you can relax...
SET statusmessage=Running for *%hrdiff%:%mediff%:%ssdiff%*
IF "%curservername%" NEQ "unknown" SET statusmessage=%statusmessage% on %curservername%
IF "%sumresult%" NEQ "0" SET statusmessage=%statusmessage%%%%%0AAverage hash: *%sumresult%*
IF DEFINED lasthashrate SET statusmessage=%statusmessage%%%%%0ALast hash: *%lasthashrate%*
IF "%curspeed%" NEQ "unknown" SET statusmessage=%statusmessage%%%%%0A%curspeed%
IF "%curtemp%" NEQ "unknown" SET statusmessage=%statusmessage%%%%%0A%curtemp%
IF "%chatid%" NEQ "0" (
	IF %me2% LSS 30 SET allowsend=1
	IF %me2% GEQ 30 IF %allowsend% EQU 1 (
		IF %everyhourinfo% EQU 1 CALL :inform "1" "false" "%statusmessage%" "0" "0"
		IF %everyhourinfo% EQU 2 CALL :inform "1" "true" "%statusmessage%" "0" "0"
		IF %everyhourinfo% EQU 3 CALL :inform "1" "false" "Online, *%hrdiff%:%mediff%:%ssdiff%*, *%lasthashrate%*" "0" "0"
		IF %everyhourinfo% EQU 4 CALL :inform "1" "true" "Online, *%hrdiff%:%mediff%:%ssdiff%*, *%lasthashrate%*" "0" "0"
		SET allowsend=0
	)
)
GOTO check
:screenshot
powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; Add-type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen; $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $graphic = [System.Drawing.Graphics]::FromImage($bitmap); $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size); $bitmap.Save('Screenshots\miner_%mh1%.%dy1%_%hr1%.%me1%.jpg');" 2>NUL 1>&2
EXIT /b
:kill
IF "%~1" EQU "1" IF %overclockprogram% NEQ 0 timeout.exe /T 2 /nobreak >NUL && taskkill.exe /T /F /IM "%overclockprocessname%" 2>NUL 1>&2 && ECHO Process %overclockprocessname% was successfully killed.
IF "%~2" EQU "1" IF %approgram% EQU 1 timeout.exe /T 2 /nobreak >NUL && taskkill.exe /F /IM "%approcessname%" 2>NUL 1>&2 && ECHO Process %approcessname% was successfully killed.
IF "%~3" EQU "1" timeout.exe /T 2 /nobreak >NUL && taskkill.exe /T /F /IM "%minerprocess%" 2>NUL 1>&2 && ECHO Process %minerprocess% was successfully killed.
IF "%~4" EQU "1" timeout.exe /T 4 /nobreak >NUL && taskkill.exe /T /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq *%bat%*" 2>NUL 1>&2
timeout.exe /T 5 /nobreak >NUL
EXIT /b
:killwerfault
taskkill.exe /T /F /IM "werfault.exe" 2>NUL 1>&2 && ECHO Process werfault.exe was successfully killed.
tskill.exe /A /V werfault 2>NUL 1>&2 && ECHO Process werfault.exe was successfully killed.
EXIT /b
:inform
IF "%~5" NEQ "0" IF "%~5" NEQ "1" IF "%~5" NEQ "2" ECHO %~5
IF "%~5" EQU "1" ECHO %~3
IF "%~5" EQU "2" ECHO %~4
IF "%~4" NEQ "0" IF "%~4" NEQ "1" >> %~n0.log ECHO [%Date%][%Time:~-11,8%] %~4
IF "%~4" EQU "1" >> %~n0.log ECHO [%Date%][%Time:~-11,8%] %~3
IF "%everyhourinfo%" EQU "5" IF "%~1" EQU "0" EXIT /b
IF "%~3" NEQ "0" IF "%~3" NEQ "" IF "%chatid%" NEQ "0" powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%num%:%prt%-%rtp%dp%tpr%/sendMessage?parse_mode=markdown&disable_notification=%~2&chat_id=%chatid%&text=*%rigname%:* %~3')" 2>NUL 1>&2
EXIT /b