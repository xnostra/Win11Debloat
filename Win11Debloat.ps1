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
    Write-Log "[+] Removing apps..."

    # Example hardcoded list of apps (replace this with the actual logic used in original script)
    $AppList = @(
        @{ Name = 'MicrosoftTeams' },
        @{ Name = 'MSTeams' },
        @{ Name = 'QuickAssist' },
        @{ Name = 'XboxGameOverlay' },
        @{ Name = 'Solitaire' },
        @{ Name = 'ZuneMusic' },
        @{ Name = 'ZuneVideo' }
    )

    foreach ($app in $AppList) {
        $appName = $app.Name

        if ($KeepApps -and $KeepApps -contains $appName) {
            Write-Log "[>] Skipping $appName (in KeepApps)"
            continue
        }

        # Replace with actual app removal logic
        Write-Log "[-] Removing $appName..."
        # Example (disabled to prevent real execution):
        # Get-AppxPackage -Name $appName | Remove-AppxPackage -ErrorAction SilentlyContinue
    }
}

if ($DisableTelemetry) {
    Write-Log "[+] Disabling telemetry..."

    # Add real telemetry disabling logic here
    # Example (disabled):
    # Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
}

Write-Log "[✓] Done."

if (-not $Silent) {
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
