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
$dst = Join-Path -Path $PSScriptRoot -ChildPath ".\persons_account_v1.csv"
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

#Loeme originaalfaili ja töötleme ridasi
Import-Csv -Path $src -Delimiter ";" | ForEach-Object {
    $date_str = $_.Sünniaeg
    $isValid = [DateTime]::ParseExact($date_str, $pattern, $null)
    if($isValid){
        $date = [datetime]::ParseExact($date_str, $pattern, $null)
        if($date.year -ge 1990 -and $date.Year -le 1999){
            $counter++
            $first_name = $_.Eesnimi
            $last_name = $_.Perenimi

            #Eemaldame tühikud ja sidekriipsud
            $first_name = $firstname -replace " ", ""
            $first_name = $firstname -replace "-", ""

            #Loome kasutajanime
            $user_name = Remove-Diacritics($first_name,$last_name -join ".").ToLower()

            #Loome eposti aadressi
            $email = $user_name + $domain

            #Teeme massiivi veergudes
            $array = $_.Eesnimi, $_.Perenimi, $_.Sünniaeg, $user_name, $email

            #Teeme uue rea faili
            $newline = $array -join ";"
            Out-File $dst -Append -InputObject $newline
        }    
    }
}
Write-Host "Valmis, $counter tk."