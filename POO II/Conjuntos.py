# Conjuntos / Sets
equipo_A = {"Ana","Luis","Pedro","Marta","Sofia"}
equipo_B = {"Pedro","Sofia","Carlos","Lucia","Javier"}


print(equipo_A & equipo_B) #  Interseccion{'Pedro', 'Sofia'}

print(equipo_A - equipo_B) # Diferencia {'Luis', 'Marta', 'Ana'}

print(equipo_B - equipo_A) # {'Carlos', 'Lucia', 'Javier'}

print(equipo_A ^ equipo_B) # Diferencia Simetrica{'Javier', 'Lucia', 'Luis', 'Carlos', 'Marta', 'Ana'}

print(equipo_A | equipo_B) # Union {'Javier', 'Luis', 'Marta', 'Ana', 'Sofia', 'Lucia', 'Pedro', 'Carlos'}