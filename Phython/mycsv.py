filename = 'data/Create-MyCSV-v.csv'
column = 0 # Veerg mida kokku liita
total = 0 # Veerus summa

with open(filename, 'r') as f:
    contents = f.readlines() # Loeb faili sisu muutjasse
    for line in contents: # Rea kaupa läbi käimine
        line = line.strip() # Eemaldab tühikud reavahetuse
        parts = line.split(';') # Tükeldab smikoolonist
        if parts[column].isdigit(): # Kontrollib kas on numbrid
            total += int(parts[column]) # Liidab kokku
            
            
print(total) # Tulemus
