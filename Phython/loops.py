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
