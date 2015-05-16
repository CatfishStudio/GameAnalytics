:user_configuration

:: Path to Flex SDK
set FLEX_SDK=C:\Users\Catfish\AppData\Local\FlashDevelop\Apps\flexairsdk\4.6.0+16.0.0
::set FLEX_SDK=C:\Users\Catfish\AppData\Local\FlashDevelop\Apps\flexsdk\4.6.0


:validation
if not exist "%FLEX_SDK%" goto flexsdk
goto succeed

:flexsdk
echo.
echo ERROR: incorrect path to Flex SDK in 'bat\SetupSDK.bat'
echo.
echo %FLEX_SDK%
echo.
if %PAUSE_ERRORS%==1 pause
exit

:succeed
set PATH=%FLEX_SDK%\bin;%PATH%
