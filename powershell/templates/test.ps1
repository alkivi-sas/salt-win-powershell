$test1 =  Test-Path "HKLM:\SOFTWARE\Microsoft\PowerShell\3"
if ($test1) {
$a = "5.0.10586.117"
$b = Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine | foreach{ $_.PowerShellVersion}
$test2 = $a -eq $b
}
else { EXIT 1 }
if ($test2) { EXIT 0 } else { EXIT 1 }

