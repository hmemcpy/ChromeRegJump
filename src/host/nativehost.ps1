function Respond($response) {
    $msg = $response | ConvertTo-Json

    try {
        $writer = New-Object System.IO.BinaryWriter([System.Console]::OpenStandardOutput())
        $writer.Write([int]$msg.Length)
        $buf = [System.Text.Encoding]::UTF8.GetBytes($msg)
        $writer.Write($buf)
        $writer.Close()
    } finally {
        $writer.Dispose()
    }
}

$regJump = [System.IO.Path]::Combine($PSScriptRoot, "regjump", "regjumsp.exe")

try {
    $reader = New-Object System.IO.BinaryReader([System.Console]::OpenStandardInput())
    $len = $reader.ReadInt32()
    $buf = $reader.ReadBytes($len)
    $msg = [System.Text.Encoding]::UTF8.GetString($buf)

    $obj = $msg | ConvertFrom-Json

    if ($obj.Status -eq "validate") {
        if (-not (Test-Path $regJump)) {
            return Respond @{message="regjump";regJumpPath=[System.IO.Path]::GetDirectoryName($regJump)}
        }

        return Respond @{message="ok"}
    }

    $regJump = [System.IO.Path]::Combine($PSScriptRoot, "regjump", "regjump.exe")
    
    if (-not (Test-Path $regJump)) {

        $wshell = New-Object -ComObject Wscript.Shell
        $popup = @"
Unable to locate 'regjump.exe' in '$([System.IO.Path]::GetDirectoryName($regJump))'

Please download Sysinternals RegJump from the Microsoft website (https://technet.microsoft.com/en-us/sysinternals/bb963880.aspx), 
and place it in the directory above.

Use 'Ctrl-C' to copy this message to the clipboard.
"@
        $wshell.Popup($popup,0,"Chrome Registry Jumper", 0x0 + 0x30)
        return
    }

    $si = New-Object System.Diagnostics.ProcessStartInfo($regJump)
    $si.Arguments = $obj.Text
    $si.Verb = "runas"

    [System.Diagnostics.Process]::Start($si)

} finally {
    $reader.Dispose()
}