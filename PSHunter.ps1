Write-Host ""
Write-Host ""
Write-Host " -[ PSHunter - Another Simple Post-Exploitation tool - @_mrpack ]- "
Write-Host "        - Find PowerShell Scripts with some keywords -           "
Write-Host ""
Write-Host ""



$folderPath = "C:\"
$searchTerms = @("password", "key", "secret", "ssh", "AWS")

Get-ChildItem -Path $folderPath -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    if($_.Extension -eq ".ps1") {
        $filePath = $_.FullName
        $fileContent = Get-Content $filePath -ErrorAction SilentlyContinue
        foreach($term in $searchTerms) {
            if($fileContent -match $term) {
                Write-Host "[+] The File $filePath has the keyword: [$term] "
            }
        }
    }
}