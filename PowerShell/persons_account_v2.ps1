<#
Luua etteantud kasutajatele kasutajanimi ja eposti aaderess
KASUTAJANIMI:
eesnimi.perekonnanimi
eesnimes eemaldada tühi ja või sidekriips
eemaldada rõhumärgid ja täpitähed
kasutajanimi on läbivalt väikeste tähtedega
EPOSTI AADRESS:
kasutajanimi@asutus.com
KELLELE TEHA
Sündinud 1990-1999 k.a
UUE FAILI SISU:
Eesnimi;Perenimi;Isikukood;Kasutajanini;Epost
#>

$src = Join-Path -Path $PSScriptRoot -ChildPath ".\Persons.csv"
$dst = Join-Path -Path $PSScriptRoot -ChildPath ".\persons_account_v2.csv"
$domain = "@asutus.com"
$header = "Eesnimi;Perenimi;Sünniaeg;Kasutajanimi;Epost"
$pattern = "dd.MM.yyyy"
$counter = 0

function Remove-Diacritics {
param ([String]$src = [String]::Empty)
  $normalized = $src.Normalize( [Text.NormalizationForm]::FormD )
  $sb = new-object Text.StringBuilder
  $normalized.ToCharArray() | % { 
    if( [Globalization.CharUnicodeInfo]::GetUnicodeCategory($_) -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
      [void]$sb.Append($_)
    }
  }
  $sb.ToString()
}

#Kas uus fail on olemas
if (Test-Path -Path $dst) {
    Remove-Item -Path $dst
}

#Kirjutame uude faili päise
Out-File -FilePath $dst -Append -InputObject $header

$content = [System.IO.File]::ReadAllLines($src,[System.Text.Encoding]::UTF8)

#Loeme originaalfaili ja töötleme ridasi
$content | Select-Object -Skip 1 | ForEach-Object {
    $parts = $_.Split(";") #Tükeldame rea
    $date_str = $parts[2]  #Sünniaeg on 3-s veerus
    $isValid = [DateTime]::ParseExact($date_str, $pattern, $null)
    if($isValid){
        $date = [datetime]::ParseExact($date_str, $pattern, $null)
        if($date.year -ge 1990 -and $date.Year -le 1999){
            $counter++
            $first_name = $parts[0] #Eesnimi on 1-s veerus
            $last_name = $parts[1]  #Perenimi on 2-s veerus

            #Eemaldame tühikud ja sidekriipsud
            $first_name = $firstname -replace " ", ""
            $first_name = $firstname -replace "-", ""

            #Loome kasutajanime
            $user_name = Remove-Diacritics($first_name,$last_name -join ".").ToLower()

            #Loome eposti aadressi
            $email = $user_name + $domain

            #Teeme massiivi veergudes
            $array = $parts[0], $parts[1], $parts[2], $user_name, $email

            #Teeme uue rea faili
            $newline = $array -join ";"
            Out-File $dst -Append -InputObject $newline
        }    
    }
}
Write-Host "Valmis, $counter tk."