#!powershell
Write-Host "OS:" (gwmi Win32_OperatingSystem).Caption;
$cpu=gwmi win32_processor | Measure -property LoadPercentage -Average | %{$_.Average};
$MemInfo = gwmi Win32_PerfFormattedData_PerfOS_Memory;
$am=$MemInfo.AvailableMBytes;
$tm=gwmi Win32_ComputerSystem | %{[Math]::Round($_.TotalPhysicalMemory/1MB)};
$um=[Math]::Round(100-(($am/$tm)*100));
$pageinfo=gwmi Win32_PageFileUsage;
$pct=[Math]::Round(($pageinfo.CurrentUsage/$pageinfo.AllocatedBaseSize)*100,2);
$lbt=gwmi win32_operatingsystem | select @{LABEL='LastBootUpTime'; EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}};
Write-Host ";  Last Bootup Time:" $lbt.LastBootUpTime;
Write-Host ";  CPU Utilization:" $cpu "%;  RAM Utilization:" $um "%";
Write-Host ";  Total RAM(in MB):" $tm ";  Pagefile Utilization:" $pct "%;  Disk Utilization: ";
GWMI Win32_LogicalDisk -Filter "DriveType='3'" | %{Write-Host $_.Name "=>" (100 - [Math]::Round(($_.FreeSpace/$_.Size)*100, 2)) "%; ";};