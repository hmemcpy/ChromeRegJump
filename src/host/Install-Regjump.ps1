function Install-RegJump {
    $source = "https://live.sysinternals.com/regjump.exe"
    $destination = Join-Path -Path $PSScriptRoot -ChildPath "regjump\regjump.exe" 

    $strText = "Download RegJump.exe from $source to $destination ?" 
    $popUp = New-Object -ComObject Wscript.Shell
    $answer = $popup.Popup($strText,30,"Please Confirm",4+32+256)
    if ($answer -eq 6) {
        try{ Invoke-WebRequest "$source" -OutFile "$destination" -Verbose -Debug }
        catch { $popup.Popup("Something went wrong, you will have to download regjump.exe yourself and place it in $destination",30,"Download failed",16) }
    }
}

Install-RegJump 