# Import
from datetime import datetime

name = 'mart mäekask' # String ehk sõne
age = 25 # Täisarv (integer)
height = 1.79 # Ujukomaarv (float)

print(name, age, height) 

# Kasutaja Mart Mäekask vanuses 25 aastat ja pikkusega 1.79 meetrit istub lauataga.
print(f'Kasutaja {name.title()} vanuses {age} aastat ja pikkusega {height} meetrit istub lauataga.')

print('Kasutaja ' + name.title() + ' vanuses ' + str(age) + ' aastat ja pikkusega ' + str(height) + ' meetrit istub lauataga.')

# Arvutamine

birth_year = datetime.now().year - age # Jooksev aasta - vanus

print (birth_year)

name = name.title() # korrasta nime ja kasuta sama muutujat

print(name[1]) # Väljunbd: a
print(name[1:4]) # Väljund: art
print(name[5:]) # Väljund: Mäekask
print(name[:4]) # Väjund: Mart
print(name[::-1]) #Väljund: ksakeäM traM

age = input('Sisesta vanus: ')
age = int(age)
if age < 1 or age > 122:
    print('Vanus on vales vahemikus (Lubatud on 1-122)')
elif age < 18:
    print('Alaealine')
elif age < 65:
    print('Tööealine')
elif age < 100:
    print('Pensionär')
else:
    print('Pikaealine')


place = input('Sisesta elukoht: ')
print(f'Sisestati {place}')

if len(place) > 1 and len(place) <=7:
    print(f'Lühikese nimega koht {place.title()}')
elif len(place) > 7:
    print(f'Pika nimega koht {place.title()}')
else:
    print('Nimi liiga lühike.')

# Väljasta muutuja andmetüübid

print(type(name))
print(type(age))
print(type(height))
print(type(place))