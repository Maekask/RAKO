import random

names = ['Mari', 'Jüri', 'Paul', 'Kati']

# Väljasta listis olevad nimed nime kaupa eraldi real.

for name in names:
    print(name)

print() # Tühi rida

# Teist moodi väljastus

for x in range(len(names)):
    print(names[x], random.randint(1, 122)) # Lisab nime kõrvale juhusliku numbri 1-122
print()

# Lihtsalt numbrid

for x in range(1, 5): # 1 kuni 10
    print(x, end=' ') # end=' ' hoiab kõik numbrid ühel real
print('\n') # Kaks reavahetust!

for x in range(0, 10, 2): # 0 kuni 10, sammuga 2
    print(x, end=' | ')

print('\n')

x = 0
while x < len(names):
    print(names[x])
    x += 1 # x = x + 1  
print(x)

# Väljasta listi nimed konsooli iga nimi eraldi real, kuid iga nime ees on järjekorra number. järjekorra number algab ühega. Korrektne rida on järgnev:
# 1. Mari
# 2. Jüri 
# 3. Paul
# 4. Kati
for x in range(len(names)):
    print(f"{x + 1}. {names[x]}")

print()

# TÄIENDUS: tee igale nimele juhuslik vanus, kuid kirjuta see vanus listi nimega ages. Näita tulemust sama for või while loopis. 
# Peale kordust näita nii names, kui ages listi sisu lihsalt nagu listid.py failis näitasime.

ages = []
for x in range(len(names)):
    ages.append(random.randint(1, 122))
    print(f"{x + 1}. {names[x]} - {ages[x]}")       

print(names)
print(ages)