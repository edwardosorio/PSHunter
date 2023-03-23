# PSHunter
PSHunter - Find PowerShell Scripts with some keywords - Post-Exploitation Tool

# ¿How it works? :

Let's download the PSHunter.ps1 file or clone the repository :

```bash
git clone https://github.com/edwardosorio/PSHunter.git

cd PSHunter

```

Now we just need to upload the PSHunter.ps1 file to the Windows Target and execute with powershell.

```bash
PS C:\Users\Test> powershell -ep bypass
Windows PowerShell
Copyright (C) Microsoft Corporation. Todos los derechos reservados.

Prueba la nueva tecnología PowerShell multiplataforma https://aka.ms/pscore6

PS C:\Users\Test> D:

PS D:\> .\PSHunter.ps1


 -[ PSHunter - Another Simple Post-Exploitation tool - @_mrpack ]-
        - Find PowerShell Scripts with some keywords -


[+] The File D:\Downloads\gen-aws-creds.ps1 has the keyword: [key]
[+] The File D:\Downloads\gen-aws-creds.ps1 has the keyword: [secret]
[+] The File D:\Downloads\gen-aws-creds.ps1 has the keyword: [AWS]


PS D:\>

```

And now we need to check every single file that contains the keywords.

```bash

PS D:\>cat "D:\Downloads\gen-aws-creds.ps1"

$aws_cred_obj = $aws_cred | ConvertFrom-Json
$aws_cred_expiration = $now.AddSeconds($aws_cred_obj.lease_duration)
$aws_cred_access_key = $aws_cred_obj.data.access_key
$aws_cred_secret_key = $aws_cred_obj.data.secret_key
$aws_cred_lease_id = $aws_cred_obj.lease_id

if ($aws_cred_access_key -and $aws_cred_secret_key) {
    $env:AWS_SECRET_ACCESS_KEY=$aws_cred_secret_key
    $env:AWS_ACCESS_KEY_ID=$aws_cred_access_key
    write-host -ForegroundColor Cyan "generated AWS credentials:"
    write-host "lease_id: $($aws_cred_obj.lease_id)"
    write-host "lease_expiration: $($aws_cred_expiration)"
} else {
    write-warning "Unable to generate AWS credentials."
    exit 1;
}

# stash creds
$stash_response = $(vault write cubbyhole/aws_creds access_key_id=$aws_cred_access_key secret_access_key=$aws_cred_secret_key expiration=$aws_cred_expiration lease_id=$aws_cred_lease_id 2>&1)

if ($stash_response -notmatch '^Success') {
    write-warning "Unable to stash generated AWS credentials in vault"
} else {
    write-host "Stashed credentials in vault"
}
......


```

# Conclusions :

- Everything that we can automate will help us to get better results in our Red Team Exercises.
