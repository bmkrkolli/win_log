#!powershell
#Requires -Module Ansible.ModuleUtils.Legacy

$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name '_ansible_check_mode' -type 'bool' -default $false

try {
    $os = get-wmiobject Win32_OperatingSystem;
    $lbt = $os.ConverttoDateTime($os.LastBootupTime);
    $cpu = get-wmiobject win32_processor | Measure -property LoadPercentage -Average | %{$_.Average};
    $MemInfo = get-wmiobject Win32_PerfFormattedData_PerfOS_Memory; 
    $am = $MemInfo.AvailableMBytes;
    $tm = get-wmiobject Win32_ComputerSystem | %{[Math]::Round($_.TotalPhysicalMemory/1MB)};
    $um = [Math]::Round(100-(($am/$tm)*100));
    $pageinfo = get-wmiobject Win32_PageFileUsage;
    $pct = [Math]::Round(($pageinfo.CurrentUsage/$pageinfo.AllocatedBaseSize)*100,2);
    $dsk = GWMI Win32_LogicalDisk -Filter "DriveType='3'" | Select Name, @{LABEL='Used'; EXPRESSION={(100 - [Math]::Round(($_.FreeSpace/$_.Size)*100, 2))}};
    $l1 = New-Object psobject -Property @{Host = $os.CSName; OS = $os.Caption; 
        LastBootUpTime = ($lbt.DateTime).replace(",",""); CPULoad = $cpu; MemoryLoad = $um; 
        PageFileLoad = $pct; DiskLoad = $dsk; }; 

    $result = @{
        failed = $false
        changed = $false
        msg = ""
        rc = 0
        stderr = ""
        stdout = $l1
        stdout_lines = $l1 | ConvertTo-Json
    }
}
catch {
    $result = @{
        failed = $true
        changed = $false
        msg = "Failed to Get Level 1 Diagnosis Information"
        rc = 1
        stderr = $PSItem
        stdout = ""
        stdout_lines = ""
    }
}

Exit-Json $result;