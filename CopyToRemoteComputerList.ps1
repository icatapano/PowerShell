#Created by: Ian Catapano
#Created on: 1/18/2017
#Purpose: This is built to be a reusable PowerShell script for copying a desired file to a list of computers.

$computerList = Get-Content "C:\Users\icatapano\Documents\PowerShell Scripts\Copy Files to Multiple Computers\list.txt"              # Variable to store the list of computers, this list should be a text file.
$targetFile = "C:\Users\icatapano\Documents\PowerShell Scripts\Copy Files to Multiple Computers\Archive Manager for Kiosks.url"      # Variable to store the file that is to be copied to the computers in the list.
$failedList = "C:\Users\icatapano\Documents\PowerShell Scripts\Copy Files to Multiple Computers\failed.txt"                          # Variable to store the file to contain list of computers that the push failed to.
$targetLocation = "Users\Public\Desktop"                                                                                             # Variable to store file path

foreach ($computer in $computerList)
{
    Try 
    {
        Copy-Item $targetFile -Destination \\$computer\C$\$targetLocation
    }

    Catch 
    {
        $computer | Out-File $failedList -append 
    }
}

