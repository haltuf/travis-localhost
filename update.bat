@echo off

setlocal ENABLEDELAYEDEXPANSION

SET versions=php7.1 php7.1low php7.2 php7.2low php7.3 php7.3low
SET input=%*
IF "%~1"=="" SET input=%versions%
IF "%~1"=="all" SET input=%versions%

(for %%a in (%input%) do (
   SET ver=%%a
   SET stub=!ver:~-3!

   IF !stub!==low (
	SET cm=--prefer-lowest
   ) ELSE (
	SET cm=
   )

   @echo on
   echo "Updating ... !ver!"
   echo docker exec -it -w /var/www/ !ver! composer update --prefer-dist --prefer-stable !cm!
   docker exec -it -w /var/www/ !ver! composer update --prefer-dist --prefer-stable !cm!
   @echo off
))