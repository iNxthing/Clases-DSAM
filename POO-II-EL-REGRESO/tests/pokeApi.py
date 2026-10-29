import requests



url ="https://pokeapi.co/api/v2/pokemon/vaporeon"

respuesta =requests.get(url)

datos = respuesta.json()

print(datos)


