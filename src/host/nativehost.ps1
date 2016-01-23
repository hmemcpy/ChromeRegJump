function Respond {
    [Parameter(Mandatory=$true)]
    Param([string]$response)
    
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

function Start-RegEdit {
	Param([string]$target="HKCU")

    #put value in LastKey as if that's the key the user was in a previous run
    $regedit = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit"
    Set-ItemProperty -Path $regedit -Name LastKey -Value $target -Type String

    #start regedit (-m for new instance)
    Start-Process -FilePath $env:windir\regedit.exe -ArgumentList "-m" -Verb runas
}

try {
	$reader = New-Object System.IO.BinaryReader([System.Console]::OpenStandardInput())
    $len = $reader.ReadInt32()
    $buf = $reader.ReadBytes($len)
    $msg = [System.Text.Encoding]::UTF8.GetString($buf)

    $obj = $msg | ConvertFrom-Json
    if ($obj.Status -eq "validate") {
        return Respond @{message="ok"}
    }
    
	Start-RegEdit -Path $obj.Text

} finally {
    $reader.Dispose()
}