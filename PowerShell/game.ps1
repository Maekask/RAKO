<#
Äraarvamise mäng. Numbrid 1-100
Tagauks
Kui mäng on läbi küsitakse nime ja koos käikudega/sammudega kirjutatakse faili
#>
$pc_nr = Get-Random -Minimum 1 -Maximum 100
[System.Boolean]$game_over = $false
$Global:steps = 0 # globaalne muutuja
$filename = Join-Path -Path $PSScriptRoot -ChildPath "result.txt"

# Write-Host $pc_nr $filename# testimiseks

function writeToFile {
    $name = Read-Host "Mängija nimi"
    ($name, $Global:steps -join ",") | Out-File -FilePath $filename -Append
}

function Show-Scoreboard {
    $content =  Get-Content -Path $filename
    foreach($line in $content) {
        Write-Host $line.split(";")

    }
}

function LetsPlay() {
    [int]$user_nr = Read-Host "Sisesta number 1-100"
    $Global:steps++
    $game_over = $false

    if ($user_nr -eq 1000) {
        Write-Host "Leidsid mu nõrga koha. Õige number on $pc_nr"
    } elseif ($user_nr -gt $pc_nr) {
        Write-Host "väiksem"
    } elseif ($user_nr -lt $pc_nr) {
        Write-Host "suurem"
    } elseif ($user_nr -eq $pc_nr) {
        Write-Host "Õige! Arvasid ära $Global:steps korraga"
        $game_over = $true
    }

    return $game_over
}

while ($game_over -eq $false) {
    $game_over = LetsPlay
    if($game_over) {
        writeToFile
        Show-Scoreboard
        $answer = Read-Host "Kas soovid veel mängida? [J/E]"
        if($answer -eq "J") {
            $pc_nr = Get-Random -Minimum 1 -Maximum 100
            [System.Boolean]$game_over = $false
            $Global:steps = 0
        } else {
            Write-Host "Mäng läbi!"
        }
    }   
}

