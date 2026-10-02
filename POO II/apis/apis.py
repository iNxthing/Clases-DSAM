import requests


url = "https://pokeapi.co/api/v2/pokemon/ditto"


respuesta = requests.get(url)

datos = respuesta.json()
print("Nombre:", datos["name"])
print("ID:", datos["id"])
print("Altura:", datos["height"])
print("Peso:", datos["weight"])
print("Tipos:")
for tipo in datos["types"]:
    print("-", tipo["type"]["name"])