# This is the lab 1 persistence salt for Threat Hunting Fall 2024 by Behnjamin Barlow


#This simulates a common persistence method using run keys.
registry_run_key:
  reg.present:
    - name: HKCU\Software\Microsoft\Windows\CurrentVersion\Run\LabScript
    - vdata: "C:\\Windows\\System32\\notepad.exe"
    - vtype: REG_SZ
    - order: 1


#This simulated a scheduled task for persistence 
schedule_persistence_task:
  task.create_task:
    - name: Lab1_Persistence_Task
    - action_type: Execute
    - cmd: "C:\\Windows\\System32\\calc.exe"
    - trigger_type: Logon
    - user_name: "SYSTEM"
    - order: 2


#This emulated persistence through the Startup folder
startup_folder_persistence:
  file.symlink:
    - name: "C:\\Users\\user\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\notepad.lnk"
    - target: "C:\\Windows\\System32\\notepad.exe"
    - order: 3


#This is to Simulate Network connection persistence 
network_script:
  file.managed:
    - name: "C:\\temp\\network_persistence.ps1"
    - contents: |
        while ($true) {
            try {
                $tcpClient = New-Object System.Net.Sockets.TcpClient("127.0.0.1", 4444)
                $tcpClient.Close()
            } catch {}
            Start-Sleep -Seconds 60
        }
    - order: 4


network_persistence_task:
  task.create_task:
    - name: Lab_Network_Persistence
    - action_type: Execute
    - cmd: "powershell.exe -ExecutionPolicy Bypass -File C:\\temp\\network_persistence.ps1"
    - trigger_type: Minute
    - repeat_interval: 1
    - user_name: "SYSTEM"
    - order: 5
