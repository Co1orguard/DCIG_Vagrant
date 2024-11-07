#This is the persistence part of the Threat Hunting Lab 2(ASYNC) Fall 2024 By Behnjamin Barlow


#This is to Create the harmless DLL and batch script
dll_file:
  file.managed:
    - name: "C:\\temp\\harmless.dll"
    - source: salt://path/to/harmless.dll  # Adjust the path to your actual DLL file
    - makedirs: True
    - order: 1

process_injection_script:
  file.managed:
    - name: "C:\\temp\\inject_process.bat"
    - contents: |
        rundll32.exe C:\\temp\\harmless.dll,EntryPoint
    - makedirs: True
    - order: 2

inject_process:
  cmd.run:
    - name: "C:\\temp\\inject_process.bat"
    - order: 3


#To simulate DLL hijacking, we place a benign DLL with a name similar to an 
#expected DLL in a target application's folder (e.g., C:\Program Files\AppFolder).
dll_hijack:
  file.managed:
    - name: "C:\\Program Files\\Mozilla Firefox\\freeble.dll"
    - contents: |
        # This is a harmless DLL to simulate DLL hijacking.
    - makedirs: True
    - order: 4



#This will simulate persistence using WMI event subscriptions using powershell script
wmi_event_subscription:
  cmd.run:
    - name: |
        $Filter = Set-WmiInstance -Namespace "root\\subscription" -Class __EventFilter -Arguments @{
            Name="LogonScript"; EventNamespace="root\\cimv2"; QueryLanguage="WQL"; 
            Query="SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_LogicalDisk'"
        }
        $Consumer = Set-WmiInstance -Namespace "root\\subscription" -Class CommandLineEventConsumer -Arguments @{
            Name="RunCalc"; CommandLineTemplate="calc.exe"
        }
        $Binding = Set-WmiInstance -Namespace "root\\subscription" -Class __FilterToConsumerBinding -Arguments @{
            Filter=$Filter; Consumer=$Consumer
        }
    - shell: powershell
    - order: 5



#To simulate persistence through PowerShell profile modifications,
#automate a file to open notepad.exe every time PowerShell starts.
powershell_profile_mod:
  file.append:
    - name: "C:\\Users\\%USERPROFILE%\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1"
    - text: "Start-Process notepad.exe"
    - makedirs: True
    - order: 6



#This will Simulate COM hijacking altering regisrty to point at diffrent .exe
com_hijacking:
  reg.present:
    - name: HKCU\Software\Classes\CLSID\{1BF42E4C-4AF4-4CFD-A1A0-CF2960B8F63E}\InProcServer32
    - vdata: "C:\\Windows\\System32\\notepad.exe"
    - vtype: REG_SZ
    - order: 7
