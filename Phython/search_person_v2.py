filename = 'data/Persons.csv'
total = 0

phrase = input('Sisesta otsitav fraas (min. 2 märki): ')

if len(phrase.strip()) > 1:
    phrase = phrase.strip().lower() # Eemalda tühikud ja tee väiketähtedeks
    f = open(filename, 'r', encoding='utf-8') # Ava fail lugemiseks
    contents = f.readlines()[1:] # Alates teisest reast
    f.close() # Sulge fail
    for line in contents:
        line = line.strip() # Korrasta rida (eemalda reavatus reast \n)
        if phrase in line.lower():
            print(line)
            total += 1
    print(f'Leitud nimede arv: {total}')
else:
    print('Otsingu fraas on liiga lühike!')