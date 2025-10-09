Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Clear-Host # puhasta ekraan
Get-Date # kuva kuupäev ja kellaaeg

$username = Read-Host -Prompt "Sisesta oma kasutajanimi"
if($username -eq $env:USERNAME) {
    Write-Host "Õige kasutajanimi"
}else {
    Write-Host "Vale kasutajanimi $username, eeldati: $env:USERNAME"
}

[int]$year = Read-Host "Sisesta aasta"
if($year -eq (Get-Date).Year) { 
    Write-Host "Käesolev aasta"
}else {
    Write-Host "Mõni teine aasta: $year"
}

#Massiiv
$nums = @() # Tühi massiiv
$nums += 5
$nums += 2
$nums += 6
$nums += Get-Random -Minimum 1 -Maximum 10

Write-Host $nums
Write-Host $nums[-1]
Write-Host $nums[$nums.Length - 1]

$num = 0
$num += 5
$num += 3
$num += Get-Random -Minimum 1 -Maximum 10

Write-Host $num

<#Liida kokku kaks juhusliku numbrit. Mõlemad vahemikus 1-10#>
$random = (Get-Random -Minimum 1 -Maximum 10) + (Get-Random -Minimum 1 -Maximum 10)

Write-Host $random

