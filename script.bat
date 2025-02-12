@echo off
setlocal enabledelayedexpansion

set "project=%~dp0"

for %%A in ("%~dp0.") do set "project_name=%%~nxA"

set webxml=%project%\web.xml
set dispatcherxml=%project%\dispatcher-servlet.xml

set web=%project%web\
set src=%project%src\
set lib=%project%lib\
set assets=%project%assets\
set temp=%project%\%project_name%
set temp_src=%project%\%project_name%\temp_src
set webapps=C:\Program Files\Apache Software Foundation\Tomcat 8.5\webapps\

if exist "%temp%" (
    rd /s /q "%temp%"
)

mkdir "%temp%"
mkdir "%temp_src%"

mkdir "%temp%\WEB-INF"
mkdir "%temp%\assets"
mkdir "%temp%\WEB-INF\classes"
mkdir "%temp%\WEB-INF\lib"
mkdir "%temp%\WEB-INF\jsp"

@REM copie element assets
xcopy /s /e  "%assets%" "%temp%\assets"

@REM copie element web
xcopy /s /e  "%web%" "%temp%\WEB-INF\jsp"

@REM complilation des java files

set "classpath"

for /r "%src%" %%D in (*.java) do (
    copy "%%D" "%temp_src%"
)

for /F "delims=" %%i in ("%temp%\libs.txt") do set "classpath=!classpath!%%i;"

@REM copie des fichiers XML
copy "%webxml%" "%temp%\WEB-INF"
copy "%dispatcherxml%" "%temp%\WEB-INF"

@REM copie elements lib ( .jar )
xcopy /s /e "%lib%" "%temp%\WEB-INF\lib"
cd %temp_src%

javac -parameters -d "%temp%\WEB-INF\classes" -cp "%lib%\*;." *.java

cd ..

rmdir /s /q "%temp_src%"

cd ..

cd %project_name%

if exist "%webapps%%project_name%.war" (
    del "%webapps%%project_name%.war"
)

@REM transformation du fichier temporaire en war l
jar -cvf "%temp%.war" .

xcopy "%temp%.war" "%webapps%"

del "%temp%.war" 
@REM del "%webapps%%project_name%.war" 

cd ..
rmdir /s /q "%project_name%"
