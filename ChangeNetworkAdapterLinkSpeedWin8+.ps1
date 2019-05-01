<#
Written by: Ian Catapano
Date:       8/10/2015
Purpose:    To remotely change the speed and duplex setting on a computer to fix speed issues on Windows 8 and newer OS PCs.
#>

$Option = ""
$Opt = 12

while ($Opt -ne 0)
{
    $TargetComputer = ""

    $TargetComputer = Read-Host "What is the name of the computer that you want to change the NIC link speed on?"
    Invoke-Command -Computer $TargetComputer -ScriptBlock{Get-NetAdapterAdvancedProperty -Name Eth* | Format-Table DisplayName,DisplayValue}

    $Option = Read-Host "Enter 1 to change to 100/Full, 2 to change to Auto Negotiation, or 0 to exit."
    if ($Option -eq 1) { Invoke-Command -Computer $TargetComputer -ScriptBlock{Set-NetAdapterAdvancedProperty -DisplayName 'Speed & Duplex' -DisplayValue '100 Mbps Full Duplex'} }
        elseif ($Option -eq 2) { Invoke-Command -Computer $TargetComputer -ScriptBlock{Set-NetAdapterAdvancedProperty -DisplayName 'Speed & Duplex' -DisplayValue 'Auto Negotiation'} }
        elseif ($Option -eq 0) {exit}
        else {Read-Host "Invalid entry, please try again.Enter 1 to change to 100/Full, 2 to change to Auto Negotiation, or 0 to exit."}
    Invoke-Command -Computer $TargetComputer -ScriptBlock{Get-NetAdapterAdvancedProperty -Name Eth* | Format-Table DisplayName,DisplayValue}
    $Opt = Read-Host "Enter 1 to change the link speed of another computer or 0 to exit."
}