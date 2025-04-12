import guerreros.*
import arsenal.*

//ZONA//
class Zona {
    method puedePasar(algo) 

    method tratarDePasar(guerrero) {
      if(!self.puedePasar(guerrero))
        throw new DomainException(message = "El guerrero " + guerrero + " no puede atravesar " + self)
      else self.consecuencia(guerrero)
  }
  
  method consecuencia(unIndividuo) 
}

class ZonaPoderosa inherits Zona {
  var property poderNecesario

  override method puedePasar(algo) = algo.poder() > poderNecesario

  override method consecuencia(algo) {}
}

class ZonaPeligrosa inherits Zona {
  const vidaAPerder

  override method puedePasar(algo) = algo.estaArmado()

  override method consecuencia(algo) {
    algo.modificarVida(vidaAPerder * (-1))
  }
}

//REGIÓN//
class Region {
  const property camino
  
  method agregarZona(zona) {
    camino.add(zona)
  }
  method reiniciar() {
    camino.clear()
  }

  method puedePasar(algo) = camino.all({ unaZona => unaZona.puedePasar(algo) })
  
  method atravesar(algo) {
    if (self.puedePasar(algo))
    camino.forEach({ unaZona => unaZona.tratarDePasar(algo)})
  }
}

//REQUERIMIENTOS EXTRA//
class ZonaRequerimientoElemento inherits ZonaPeligrosa {
  const property cantidadRequerida
  const property nombreElemento

  override method puedePasar(algo) = algo.tieneElem(nombreElemento,cantidadRequerida)
}
class RequerimientoGuerrero inherits Zona {
  var property nombCondicion
  
  override method puedePasar(algo) = algo.pasarUnaCondicion(nombCondicion)

  override method consecuencia(algo) {}
}

//ZONAS CONOCIDAS (WKO)//
const gondor = new Region(camino = [lebennin, minasTirith])
const lebennin = new ZonaPoderosa(poderNecesario = 1500)
const minasTirith = new ZonaPeligrosa(vidaAPerder = 10)

const caminoDeGondor = new Region(camino = [lebennin, minasTirith])

object lossarnach inherits Zona {
  override method puedePasar(algo) = algo.vida() > 5

  override method consecuencia(unIndividuo) {unIndividuo.modificarVida(1)}
}