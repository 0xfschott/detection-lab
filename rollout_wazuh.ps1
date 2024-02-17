$ProgressPreference = 'SilentlyContinue'

Invoke-WebRequest -Uri "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.2-1.msi"  -OutFile "C:\\Users\\vagrant\\wazuh-agent-4.7.2-1.msi"

cd C:\\Users\\vagrant

.\wazuh-agent-4.7.2-1.msi /q WAZUH_AGENT_NAME="Workstation" WAZUH_MANAGER="192.168.128.10"

Function IsServiceInstalled {
        param (
          [string]$serviceName
        )
        $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
        return $service -ne $null
      }

# Wait for Wazuh agent installation to complete
while (-not (IsServiceInstalled "Wazuh")) {
	Write-Host "Waiting for Wazuh agent installation to complete..."
        Start-Sleep -Seconds 5
}

Start-Service -Name "Wazuh"

if ((Get-Service -Name "Wazuh").Status -eq 'Running') {
    Write-Host "Wazuh service started successfully."
} else {
    Write-Host "Failed to start Wazuh service."
}
