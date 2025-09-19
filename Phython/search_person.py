""" TÄIENDUS: Näita mitu nime leiti. Leiti xx nime. """
import csv

filename = 'data/Persons.csv'
total = 0

phrase = input('Sisesta otsitav fraas (min. 2 märki): ')
if len(phrase) > 1:
    with open(filename, 'r', encoding='utf-8') as f:
        contents = csv.reader(f, delimiter=';')
        for row in contents:
            prhase = phrase.lower() # Tee väiketähtedeks
            first = row[0].lower() # Tee väiketähtedeks (eesnimi)
            last = row[1].lower() # Tee väiketähtedeks (perekonnanimi)
            if prhase in first or prhase in last:
                print(';'.join(row)) # Tee list stringiks
                total += 1

        print(f'Leitud nimede arv: {total}')

else:
    print('Liiga lühike fraas!')

