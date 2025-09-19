def welcome():
    """Väljastab statilise tervitus teksti."""
    print('Tere, kuidas läheb?')

def welcome_name(name):
    """Väljastab tervituse koos nimega."""
    return f'Tere, {name}!'

def division(number1, number2):
    """Jagab kaks arvu ja tagastab tulemuse.
        Args:
            number1 (float): jagatav arv
            number2 (float): jagaja (ei tohi olla null )
            
        Returns:
            float: jagatise väärtus
        """
    if number2 != 0:
        return number1 / number2
    return -1

def introduce(name, age=25):
    """Loob lihtsa tutvustava lause.

    :param name: Isiku nimi
    :type name: str
    :param age: Isiku vanus (vaikimisi25)
    :type age: int, valikuline
    :return: Tekstiline tutvustuse vorm
    'Tema nimi <nimi> ja ta on <vanus> aastane!'
    :rtype: str  
    """
    return f'Tema on {name} ja ta on {age} aastane!'
    
welcome()
print(welcome_name('Mart'))

kukimuki = welcome_name('Kukimuki')
print(kukimuki)

a = 10
b = 5
print(division(a, b))
print(division(b, 0))
print(division(b, a))
print(division(0, b))

print(introduce('Mart'))
print(introduce('Mart',42))

"""
Ülesanne: Loo list viie nimega. Väljasta viie nime tervitus.
Igat nime peab eraldi tervitama. Kasuta for loopi.
"""
names = ['Mari', 'Jüri', 'Paul', 'Kati', 'Jaan']
for name in names:
    print(welcome_name(name))


