"""
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
"""
import csv
import unicodedata

src = 'data/Persons.csv' # Allikas
dst = 'data/Persons-accounts.csv' # Sihtkoht
header = 'Eesnimi;Perenimi;Isikukood;Kasutajanimi;Epost' # Uue faili päis
domain = '@asutus.com' # Domeen

def strip_accents(s):
   return ''.join(c for c in unicodedata.normalize('NFD', s)
                  if unicodedata.category(c) != 'Mn')

with open(src, 'r', encoding='utf-8') as f: # Lugemiseks algne
    with open(dst, 'w', encoding='utf-8') as d: # Kirjutamiseks uus
        contents = csv.reader(f, delimiter=';') # Faili sisus muutujasse
        d.write(header + '\n') # Kirjuta päis reavahetusega
        next(contents) # Jäta esimene rida vahele ehk siis päis

        for row in contents:
            date = row[2] # Kuupäev eraldi muutujasse
            year = int(date.split('.')[2]) # Võta aastanumber
            if year >= 1990 and year <= 1999: # Kui aasta 1990-1999 k.a
                first_name = row[0] # Eesnimi
                last_name = row[1] # Perekonnanimi
                # Eemalda tühikud ja sidekriipsud
                first_name = first_name.replace(' ','')
                first_name = first_name.replace('-','')
                # Kasutajanime loomine
                username = '.'.join([first_name, last_name]).lower() # Koosta kasutajanimi ja tee väikesteks tähtedeks
                username = strip_accents(username) # Eemalda rõhumärgid ja täpitähed

                #Eposti loomine
                email = username + domain # Koosta eposti aadress

                # Uue rea loomine
                new_line = ';'.join(row[:2] + [row[-1], username, email])
                d.write(new_line + '\n') # Kirjuta uus rida faili

            




    
