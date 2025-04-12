object pepita {
  var energia = 100

  method energia() = energia
  method estaCansada() = energia <= 20

  method vola(metros) {
    energia = energia - metros * 10
  }
  method comer(comida) {
    energia = energia + comida.energia()
  }
}

object alpiste{
  method energia() = 5
}

object milanesa {
  var gramos=0

  method definirGramos(cuantos) {gramos=cuantos}
  method energia() = 4 * gramos 
}

object manzana {
  var porcentajeMad = 0
  var calorias = 50

  method energia() = calorias
  method cuantoMadura() = porcentajeMad 

  method madura() {
    porcentajeMad += 10
    if(porcentajeMad < 100) calorias *= 1.1
    if(porcentajeMad == 100) calorias = 100
    if(porcentajeMad > 100 and calorias > 0) calorias -= 20
  }
}