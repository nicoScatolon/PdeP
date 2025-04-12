# Tom y Jerry (y Nibbles también!)

## Parte 1: velocidad máxima
Hacer un sistema en wollok que modele al gato tom y a los ratones jerry y nibbles 

El sistema tiene dos casos de uso principales: 
* Indicar que tom comió un ratón ( aclarando cuál ratón comió)  
* Indicar que tom corrió una distancia (aclarando cuantos metros). 

Lo que nos interesa de tom es saber la velocidad máxima a la que puede correr.

La velocidad máxima depende de la energía que tenga. 

La energía va a variar según vaya comiendo ratones y corriendo por ahí:

* Cuando tom corre, su energía disminuye en `cantidad de metros que corrió / 2` 
* Cuando tom come un ratón, su energía aumenta en `12 + el peso del ratón` 
* La velocidad máxima de tom es `5 + energía/10`

Tom comienza con 50 de energía

Existen 2 ratones.

* Jerry, cuyo peso es la `edad * 20`. Al inicio tiene 2 años, pero puede modificarse 
* Nibbles, cuyo peso es 35, siempre

Nota: Acá se trabaja polimorfismo, ordenes, consulta y estado del objeto.

### Caso de prueba

- Al inicio, la velocidad máxima de Tom es 10 (su energía es 50)
- Si come a Jerry, la velocidad máxima pasa a ser  15.2 (su energía es 102)
- Si corre 24 metros, entonces su velocidad máxima pasa a ser 14 (su energía es 90)
- Si come a Nibbles, pasa a tener de velocidad máxima 18.7 (su energía es 137)
- si jerry cumple años (3 años de edad), y luego tom lo vuelve a comer, pasaría a tener 25.9 (su energia es 209)  
- si corre 38 metros su velocidad pasa a ser 24 (su energia es 190)

## Parte 2:  Poder y Querer comer.

Se agrega como requerimientos 
* Saber si tom puede comer un ratón que está a cierta distancia (indicando la distancia)
* Saber si tom quiere comer un ratón que está a cierta distancia (indicando el ratón y la distancia)

Puede comer si tiene energía suficiente para recorrer esa distancia. Es
decir, la energía que gastaría en correr la distancia es menor a su propia
energía

Tom quiere comer un ratón que está a cierta distancia si puede comerlo 
(punto anterior) y además  la energía que va a gastar en correr 
la distancia hasta el ratón es menor a la energía que va a recibir 
por comérselo.

Nota: Acá se busca ser capaz de evitar la duplicación de código (subtareas), 
y manejar correctamente métodos booleanos de consulta

### Casos de prueba

- Al inicio, Tom no puede comer a Jerry si está a 120 metros (ya que gastaría 60 
de energía y solo tiene 50), tampoco quiere comerlo porque no puede.

- Tom puede comer a Nibbles está a 96 de distancia, (gastaría 48 de energia)
Pero no lo va a querer comer, porque a pesar de poder, solo recibíra 47 de energia 

- En cambio si Nibbles está a 60 metros, tom lo puede comer (gastaría 30 de energía)
y también lo va a querer comer (recibiría 47).

