@echo off

set "MWDIR=%~dp0"
set "MY_COMPOSER_DIR="
set "MY_COMPOSER_PROJECT="

:parseArgs
:: asks for the -foo argument and store the value in the variable FOO

call:getArgWithValue "-dir" "MY_COMPOSER_DIR" "%~1" "%~2" && shift && shift && goto :parseArgs
call:getArgWithValue "-name" "MY_COMPOSER_PROJECT" "%~1" "%~2" && shift && shift && goto :parseArgs

:: =====================================================================

if "%MY_COMPOSER_DIR%"=="" (
  echo Use argument -dir to specify directory
  exit /b 1
)

for %%f in (%MY_COMPOSER_DIR%) do set lastDir=%%~nxf
if "%MY_COMPOSER_PROJECT%"=="" (
  echo Argument -name not specified, using %lastDir%
  SET "MY_COMPOSER_PROJECT=%lastDir%"
)

if not exist "%MWDIR%/projects/%MY_COMPOSER_PROJECT%" mkdir "%MWDIR%/projects/%MY_COMPOSER_PROJECT%"
if not exist "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.1" mkdir "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.1"
if not exist "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.1-lowest" mkdir "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.1-lowest"
if not exist "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.2" mkdir "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.2"
if not exist "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.2-lowest" mkdir "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.2-lowest"
if not exist "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.3" mkdir "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.3"
if not exist "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.3-lowest" mkdir "%MWDIR%/projects/%MY_COMPOSER_PROJECT%/php7.3-lowest"

docker-compose -f %MWDIR%docker-compose.yml up --build

goto:eof

:: =====================================================================
:: This function sets a variable from a cli arg with value
:: 1 cli argument name
:: 2 variable name
:: 3 current Argument Name
:: 4 current Argument Value
:getArgWithValue
if "%~3"=="%~1" (
  if "%~4"=="" (
    REM unset the variable if value is not provided
    set "%~2="
    exit /B 1
  )
  set "%~2=%~4"
  exit /B 0
)
exit /B 1
goto:eof


:: =====================================================================
:: This function sets a variable to value "TRUE" from a cli "flag" argument
:: 1 cli argument name
:: 2 variable name
:: 3 current Argument Name
:getArgFlag
if "%~3"=="%~1" (
  set "%~2=TRUE"
  exit /B 0
)
exit /B 1
goto:eof
