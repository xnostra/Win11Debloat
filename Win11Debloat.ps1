param (
    [switch]$Silent,
    [switch]$RemoveApps,
    [switch]$DisableTelemetry,
    [string[]]$KeepApps
)

function Write-Log($message) {
    if (-not $Silent) {
        Write-Output $message
    }
}

Write-Log "-------------------------------------------------------------"
Write-Log " Win11Debloat.ps1 - Custom Fork with KeepApps Support"
Write-Log "-------------------------------------------------------------"

if ($RemoveApps) {
    Write-Log "[+] Scanning installed apps..."

    $AppList = Get-AppxPackage -AllUsers | Select-Object -ExpandProperty Name | Sort-Object -Unique

    foreach ($appName in $AppList) {
        if ($KeepApps -and $KeepApps -contains $appName) {
            Write-Log "[>] Skipping $appName (in KeepApps)"
            continue
        }

        Write-Log "[-] Removing $appName..."
        try {
            Get-AppxPackage -AllUsers -Name $appName | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        } catch {
            Write-Log "[!] Failed to remove ${appName}: $($_.Exception.Message)"
        }
    }
}

if ($DisableTelemetry) {
    Write-Log "[+] Disabling telemetry..."

    try {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
        Write-Log "[✓] Telemetry disabled."
    } catch {
        Write-Log "[!] Failed to disable telemetry: $($_.Exception.Message)"
    }
}

Write-Log "[✓] Script completed."

if (-not $Silent) {
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}
