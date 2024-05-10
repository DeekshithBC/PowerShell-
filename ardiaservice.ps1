$software = "Thermo Scientific Ardia Platform Link";
$installed = (Get-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null 

#CENextGenWebSoftware Services
$ThermoScientificArdiaDeviceIntegratorService = "Thermo Scientific Ardia Device Integrator Service"
$ThermoScientificArdiaDeviceRegistrationService = "Thermo Scientific Ardia Device Registration Service"
$ThermoScientificArdiaInstrumentServiceFacade = "Thermo Scientific Ardia Instrument Service Facade"
$ThermoScientificArdiaProxyClient="Thermo Scientific Ardia Proxy Client"
$ThermoScientificArdiaLocalDeviceService="Thermo Scientific Ardia Local Device Service"
$RabbitMQ="RabbitMQ"
#function to verify CENextGenWebSoftware exists, return 1 if exists, return 0 if doesn't exist
function IsServiceExists([string]$ServiceName)
{
	 Write-Host "========================================"
	 Write-Host "Checking for service: $ServiceName"
	 #Check for service
	$service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
	if($service -eq $null)
	{
		return 0
	} else {
		return 1
	}
	 
}

#Check if Thermo Scientific Ardia Platform Link is installed, if true then check for services
If(-Not $installed) {
    Write-Host "---------->Software: $software is not installed ----------" -ForegroundColor Red -BackgroundColor Yellow
    Exit 0
}else {
	Write-Output "Software: $software is installed, checking services......."
	#Check for Service Thermo Scientific Ardia Device Integrator Service
	if(IsServiceExists $ThermoScientificArdiaDeviceIntegratorService){
    $serviceStatus = Get-Service -Name $ThermoScientificArdiaDeviceIntegratorService | Select-Object -ExpandProperty Status
   	Write-Output "Pass >> Service: $ThermoScientificArdiaDeviceIntegratorService  exists Status: $serviceStatus"
	}else
	{
		Write-Output "Fail >>Service: $ThermoScientificArdiaDeviceIntegratorService does not exists"
	}
	#Check for Service Thermo Scientific Ardia Device Registration Service
	if(IsServiceExists $ThermoScientificArdiaDeviceRegistrationService){
 $serviceStatus = Get-Service -Name $ThermoScientificArdiaDeviceRegistrationService | Select-Object -ExpandProperty Status
		Write-Output "Pass >> Service: $ThermoScientificArdiaDeviceRegistrationService exists Status: $serviceStatus"
	}else
	{
		Write-Output "Fail >>Service: $ThermoScientificArdiaDeviceRegistrationService does not exists"
	}
	#Check for Service Thermo Scientific Ardia Instrument Service Facade
	if(IsServiceExists $ThermoScientificArdiaInstrumentServiceFacade){
 $serviceStatus = Get-Service -Name $ThermoScientificArdiaInstrumentServiceFacade | Select-Object -ExpandProperty Status
		Write-Output "Pass >> Service: $ThermoScientificArdiaInstrumentServiceFacade exists Status: $serviceStatus"
	}else
	{
		Write-Output "Fail >>Service: $ThermoScientificArdiaInstrumentServiceFacade does not exists"
	}
          #Check for Service Thermo Scientific Ardia Local Device Service
	if(IsServiceExists $ThermoScientificArdiaLocalDeviceService){
$serviceStatus = Get-Service -Name $ThermoScientificArdiaLocalDeviceService | Select-Object -ExpandProperty Status
		Write-Output "Pass >> Service: $ThermoScientificArdiaLocalDeviceService exists Status: $serviceStatus"
	}else
	{
		Write-Output "Fail >>Service: $ThermoScientificArdiaLocalDeviceService does not exists "
	}	
       #Check for Service Thermo Scientific Ardia Proxy Client
	if(IsServiceExists $ThermoScientificArdiaProxyClient){
$serviceStatus = Get-Service -Name $ThermoScientificArdiaProxyClient | Select-Object -ExpandProperty Status
		Write-Output "Pass >> Service: $ThermoScientificArdiaProxyClient exists  Status: $serviceStatus"
	}else
	{
		Write-Output "Fail >>Service: $ThermoScientificArdiaProxyClient does not exists"
	}
         #Check for Service RabbitMQ
	if(IsServiceExists $RabbitMQ){
$serviceStatus = Get-Service -Name $RabbitMQ | Select-Object -ExpandProperty Status
		Write-Output "Pass >> Service: $RabbitMQ exists Status: $serviceStatus"
	}else
	{
		Write-Output "Fail >>Service: $RabbitMQ does not exists"
	}
  	
	 
}





	