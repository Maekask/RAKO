function New-TestFile {
  <#
  .SYNOPSIS
    Loob testifaile määratud arvul juhusliku sisu ja laiendiga.
  .DESCRIPTION
    Fonktsioon loob faile failihalduse harjutamiseks
   .PARAMETER Count
   Mitu faili luua (kohustuslik)
   .PARAMETER Names
   Failinimed mida kasutada. Üks kuni mitu. Vaikimisi $env:USERNAME
    .PARAMETER Path
    Kuhu failid luuakse. Vaikimisi Desktop\katsetus
    .PARAMETER ExtensionFile
    Faililaiendite loetelu. Vaikimisi extension.txt mooduli kaustas
    .EXAMPLE
    New-TestFile -Cont 5
    Loob 5 faili kasutaja sisselogitud kasutajanime failinimeks
    .EXAMPLE
    New-TestFile -Cont 3 -Names "Aruanne", "Mari", "Jüri"
    Loob 3 juhusliku faili etteantud nimedega
  #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1,1000)]
        [int]$Count,

        [Parameter(Mandatory=$false)]
        [string[]]$Names,

        [Parameter(Mandatory=$false)]
        [string]$Path = "$env:USERPROFILE\Desktop\katsetus",

        [Parameter(Mandatory=$false)]
        [string]$ExtensionFile = "$PSScriptRoot\extension.txt"
    )
    #Kui nime puuduvad kasuta kasutajanime
    if (-not $Names -or $Names.Count -eq 0) {
        $Names = @($env:USERNAME)
        Write-Verbose "Kasutan vaikimisi nime $env:USERNAME"
    }

    #Kas laiendite fail on olemas
    if (-not (Test-Path -Path $ExtensionFile)) {
        Write-Error "Faililaiendite faili $ExtensionFile ei leitud"
        Write-Host "Loo laienduste fail ja lisa laiendus"
        return
    }
    #Loe laiendite faili sisu
    $Extensions = Get-Content $ExtensionFile | Where-Object {$_.Trim() -ne ""} | ForEach-Object {$_.Trim()}
    if ($Extensions.Count -eq 0) {
        Write-Error "Faililaiendite faili $ExtensionFile sisu on tühi"
        return
    }

    Write-Verbose "Leitud $($Extensions.Count) laiendit."

    #Loo kaust kui puudub
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
        Write-Host "Loodud kaust $Path"
    }

    #Loome failide loenduri
    $createCount = 0
    $skippedCount = 0
    $createdFiles = @()

    #Genereeri failid
    for($i = 0; $i -lt $Count; $i++) {
        #Vali juhuslik nimi
        $randomName = $Names | Get-Random

        #Vali juhuslik laiend
        $randomExtension = $Extensions | Get-Random

        #Koosta failinimi
        $filename = "$randomName.$randomExtension"
        $fullPath = Join-Path $Path $filename

        #Kas fail on juba olemas
        if (Test-Path $fullPath) {
            Write-Warning "Fail $fullPath juba olemas. Jätan vahele. $filename"
            $skippedCount++
            continue
    }

    #Kas selline kombinatsioon on juba olemas
    if ($createdFiles -contains $filename) {
        Write-Warning "Fail $filename juba loodud selles sessioonis. Jätan vahele."
        $skippedCount++
        continue
    }

    #Genereeri juhuslik sisu
    $contentSize = Get-Random -Minimum 1 -Maximum 1025
    $randomContent = -join ((1..$contentSize) | ForEach-Object { [char](Get-Random -Minimum 32 -Maximum 127) })
    
    #Loo fail
    try {
        Set-Content -Path $fullPath -Value $randomContent -Encoding UTF8 -ErrorAction Stop
        $createCount++
        $createdFiles += $filename
        Write-Verbose "Loodud fail: $filename ($contentSize baiti)" 
    } catch {
        Write-Error "Viga faili loomisel ($filename): $_"
        $skippedCount++
    }
    #Teata tulemustest
    Write-Host "Loodud $createCount faili."
    if($skippedCount -gt 0) {
        Write-Host "Jäetud vahele $skippedCount faili."
    }   
    Write-Host "Failid asuvad kaustas: $Path"

    #Tasta ojekt tulemustega
    [PSCustomObject]@{
        Created = $createCount
        Skipped = $skippedCount
        Location = $Path
        Files = $createdFiles
    
    }

}

}