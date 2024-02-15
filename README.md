# Detection Lab with Wazuh (EDR) and Sliver (C2)

To test malware before red team or purple team engagements, you might need a detection lab to monitor the behaviour of your agent that can be set up quickly. 
The following virtual machines are created via Vagrant for this purpose:
* **Wazuh:** The open source EDR Wazuh is made accessible via the host machine
* **Windows 11 Workstation:** This VM is used to run the malware
* **Sliver:** Sliver is installed on a VM as a C2 server to check callbacks from the Windows VM

## Setup

The following command spins up the lab. The provided Vagrantfile is written for VirtualBox, so that one might need to be adjusted based on the used virtualisation provider.

```
vagrant up
```

### Wazuh 
At first the Wazuh server is automatically deployed. The server provides a dashboard to view event codes from registered agents.
The Wazuh web application can be accessed on the host machine on https://192.168.64.10:

![image](https://github.com/0xfschott/detection-lab/assets/17066401/64e4ff6a-8637-4e8b-800a-2b59e38d5ae8)

The login credentials are generated during the setup process and can be found in the Vagrant console output:

```
 wazuh: 15/02/2024 19:47:35 INFO: --- Wazuh dashboard ---
    wazuh: 15/02/2024 19:47:35 INFO: Starting Wazuh dashboard installation.
    wazuh: 15/02/2024 19:48:03 INFO: Wazuh dashboard installation finished.
    wazuh: 15/02/2024 19:48:03 INFO: Wazuh dashboard post-install configuration finished.
    wazuh: 15/02/2024 19:48:03 INFO: Starting service wazuh-dashboard.
    wazuh: 15/02/2024 19:48:03 INFO: wazuh-dashboard service started.
    wazuh: 15/02/2024 19:48:27 INFO: Initializing Wazuh dashboard web application.
    wazuh: 15/02/2024 19:48:28 INFO: Wazuh dashboard web application initialized.
    wazuh: 15/02/2024 19:48:28 INFO: --- Summary ---
    wazuh: 15/02/2024 19:48:28 INFO: You can access the web interface https://<wazuh-dashboard-ip>:443
    wazuh:     User: admin
    wazuh:     Password: RandomlyGeneratedPassword
```

### Windows 11 workstation

The workstation is automatically registered on the Wazuh server and starts the Wazuh agent as a service by running the PowerShell script `rollout_wazuh.ps1`.
You should now see the Workstation and its events under "Agents" in the Wazuh dashboard:

![image](https://github.com/0xfschott/detection-lab/assets/17066401/ab0a2f61-0c0f-460e-aae7-1c1238e4d80e)

### Sliver

The sliver VM can be accessed by SSH with the following command:

```
>vagrant ssh sliver
```

Sliver is already installed and can be started with `sliver`:

![image](https://github.com/0xfschott/detection-lab/assets/17066401/be7c538b-e5a9-4ea4-b50c-59f0cfb77305)

Have fun tweaking your payloads!

