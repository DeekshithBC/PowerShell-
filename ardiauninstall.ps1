$software = "Thermo Scientific Ardia Platform Link"
$uninstalled = (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq $software }) -eq $null

if ($uninstalled) {
    Write-Output "Software is not installed"
    Write-Host "---------->Software is not installed<----------" -ForegroundColor Red -BackgroundColor Yellow
    Exit 0
} else {
    Write-Output "Software is already installed, proceeding with uninstallation"
    $uninstallString = (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq $software }).UninstallString
    $uninstallArguments =     $uninstallString
 
	
    Write-Output "Uninstalling software: $software..."
    $command=$uninstallArguments 

     cmd.exe /c $command /passive
    $uninstalled = (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq $software }) -eq $null
    if ($uninstalled) {
        Write-Host "=================================================="
        Write-Host "Uninstallation of software: $software is successful"

        Write-Host "=================================================="
        Exit 0
    } else {
        Write-Host "==========================================================="
        Write-Output "Uninstallation failed and status is $uninstalled"
        Write-Host "==========================================================="
        Exit 1
    }
}
