$userList = Get-Content "C:\checkAD\userNames.txt"

foreach ($Item in $userList)
{
$temp = $Item.ToLower()
$user =  Get-ADUser -Filter {SamAccountName -eq $temp}
    if ($user -eq $null)
    {
        "$Item does not exist" | Out-file C:\checkAD\NotExistingAccounts.txt -encoding default -append
    }
    else
    {
        if ((Get-ADUser -Identity $Item).Enabled -eq 'True')
        {
            $Item | Out-file C:\checkAD\existingAccountsEnabled.txt -encoding default -append
        }
        else
        {
            $Item | Out-file C:\checkAD\existingAccountsDisabled.txt -encoding default -append
        }
    }
}