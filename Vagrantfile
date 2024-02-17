Vagrant.configure("2") do |config|
  config.vm.network "private_network", type: "dhcp"
  # Ubuntu VM Configuration
  config.vm.define "wazuh" do |wazuh|
    wazuh.vm.box = "ubuntu/bionic64"
    wazuh.vm.network "private_network", ip: "192.168.128.10"
    wazuh.vm.network "forwarded_port", guest: 443, host: 8443
    wazuh.vm.provision "shell", path: "provision_wazuh.sh"
    wazuh.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end
  end

  config.vm.define "sliver" do |sliver|
    sliver.vm.box = "ubuntu/bionic64"
    sliver.vm.network "private_network",  ip: "192.168.128.11"
    sliver.vm.provision "shell", path: "sliver.sh"
    sliver.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
  end

  config.vm.define "workstation" do |windows_11|
    windows_11.vm.box = "StefanScherer/windows_11"
    windows_11.vm.network "private_network",  ip: "192.168.128.12"
    windows_11.vm.guest = :windows
    windows_11.vm.communicator = "winrm"

    windows_11.vm.provision "shell", path: "rollout_wazuh.ps1", privileged: true
    windows_11.vm.provider "virtualbox" do |v|
      v.gui = true
      v.memory = 4096
      v.cpus = 2
    end
  end
  config.winrm.basic_auth_only = true
  # Adjust WinRM settings for better compatibility/reliability
  config.winrm.max_tries = 5
  config.winrm.timeout = 1800
end