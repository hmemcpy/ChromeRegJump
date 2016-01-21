REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.hmemcpy.chrome.regjump" /ve /t REG_SZ /d "%~dp0nativehost.json" /f
IF NOT EXIST .\regjump\regjump.exe @powershell.exe -ExecutionPolicy Bypass -File ".\Install-Regjump.ps1"
