$software = "Thermo Scientific Ardia Platform Link"
$installed = (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null
$Arguments = '/install /passive /debuglog"C:\AutomationForEXEFile\CENextGenWebSoftware\logs\installerlog.txt"'
$Filepath = "C:\deekshith\Ardia_Platform_Link_Setup.exe"

If($installed) {
    Write-Output "Software is already installed"
    Write-Host "---------->Software is already installed<----------" -ForegroundColor Red -BackgroundColor Yellow
    Exit
} else {
    Write-Output "Software is not already installed, proceeding with installation"    
    Write-Output "Copy set.exe file to project folder"
  
    Write-Output "File copy is completed"
    Write-Output "Installing software: $software......."
    Start-Process -FilePath $Filepath -ArgumentList $Arguments -Verb RunAs -Wait -PassThru

    $CENextGenInstalled = (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null 

    if ($CENextGenInstalled) {
        Write-Host "=================================================="
        Write-Host "Installation of software: $software is successful"
        Write-Host "=================================================="
        Exit 0
    } else {
        Write-Host "==========================================================="
        Write-Output "Installation is failed and status is $CENextGenInstalled"
        Write-Host "==========================================================="
        Exit 1
    }
}
