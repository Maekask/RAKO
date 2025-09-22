import random
from datetime import datetime

file = "Phython/kodune/andmed.txt"

# 1. Genereerib 20 juhuslikku täisarvu vahemikus 1–100.
arvud = [random.randint(1, 100) for _ in range(20)] # Genereerib 20 juhuslikku täisarvu vahemikus 1–100

# 2. Salvestab need koos tänase kuupäevaga faili andmed.txt.
date = datetime.now().strftime("%d.%m.%Y %H:%M:%S") #  Tänane kuupäev ja aeg
with open(file, "w") as f: # Ava fail kirjutamiseks
    f.write(f"Kuupäev: {date}\n") # Kirjuta kuupäev faili
    f.write("Arvud: " + " ".join(map(str, arvud)) + "\n") # Kirjuta arvud faili  

# 3. Loeb failist need arvud uuesti sisse.
with open(file, "r") as f: # Ava fail lugemiseks
    contents = f.readlines() # Loe kõik read
    loe_arvud = list(map(int, contents[1].strip().split(": ")[1].split())) # Võtab teisest failireast arvud
print("Failist loetud arvud:", loe_arvud)

# 4. Kasutab funktsiooni (enda loodud funktsioon), mis arvutab: summa, keskmise ja suurima arvu.
def arvuta_andmed(arvud):
    summa = sum(arvud) # Arvuta summa
    keskmine = summa / len(arvud) # Arvuta keskmine
    suurim = max(arvud) # Leia suurim arv
    return summa, keskmine, suurim  # Tagasta tulemused
summa, keskmine, suurim = arvuta_andmed(loe_arvud) # Kutsu funktsioon
print(f"Summa: {summa}\nKeskmine: {keskmine}\nSuurim arv: {suurim}") # Prindi tulemused





