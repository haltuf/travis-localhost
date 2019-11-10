@echo off

setlocal ENABLEDELAYEDEXPANSION

SET versions=php7.1 php7.1low php7.2 php7.2low php7.3 php7.3low
SET input=%*
IF "%~1"=="" SET input=%versions%
IF "%~1"=="all" SET input=%versions%

(for %%a in (%input%) do (
   SET ver=%%a

   @echo on
   echo "Testing ... !ver!"
   docker exec -it -w /var/www/ !ver! vendor/bin/tester tests -C
   @echo off

   IF !ver!==php7.3 (
	docker exec -it -w /var/www/ !ver! vendor/bin/phpstan.phar analyse -l 7 -c phpstan.neon src tests/KdybyTests
        docker exec -it -w /var/www/ !ver! php vendor/bin/phpcs --standard=ruleset.xml --encoding=utf-8 -sp src tests
	docker exec -it -w /var/www/ !ver! vendor/bin/tester --coverage ./coverage.xml --coverage-src ./src -s -p phpdbg -C ./tests/KdybyTests/
   )
))