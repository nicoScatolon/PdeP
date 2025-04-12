import arsenal.*
import zonas.*

//GUERREROS//

class Guerrero {
  var property vida = 0
  method algo() = vida

  var property parametroPoder = null

  //SUMA O RESTA VIDA//
  method modificarVida(variable) {
    vida += variable
  }

  //ARMAS
  const property armas = []

  method poderArmas() = armas.sum({ arma => arma.poderOtorgado() })

  method agregarArma(unArma) {
    armas.add(unArma)
  }

  method estaArmado() = armas.isEmpty().negate()

  //ITEMS
  const property items = []

  method agregarItem(unItem) {
    items.add(unItem)
  }

  //PODER
  method poderOrigen() = 10 * armas.size()

  method poder() = self.algo() + self.poderArmas() * self.parametroPoder()  

  //ZONAS
  method recorrer(unaZona) {
    if(unaZona.puedePasar(self)) 
      unaZona.consecuencia(self)
  }

  method tieneElem(elemento, cantRequerida) =
    self.cantElem(elemento) >= cantRequerida

  method cantElem(elem) =  self.items()
    .filter({ item => item == elem })
    .size()

  method pasarUnaCondicion(nombCondicion) = nombCondicion.apply(self)
}

class Hobbit inherits Guerrero() {

  override method parametroPoder() = armas.size()
}

class Enano inherits Guerrero() {
  const factorPoder

  override method poderOrigen() = 20
  
  override method parametroPoder() = factorPoder
}

object elfos {
  var property destrezaBase = 2 

  method destrezaBase(nuevaDestreza) {
    destrezaBase = nuevaDestreza
  }
}

class Elfo inherits Guerrero() {  
  var property destrezaPropia

  override method poderOrigen() = 25
  
  method destrezaPropia(nuevaDestreza) {
    destrezaPropia = nuevaDestreza
    }
  override method parametroPoder() = (elfos.destrezaBase() + destrezaPropia)
}

class Humano inherits Guerrero (){
  const limitadorPoder

  override method poderOrigen() = 15 

  override method parametroPoder() = 1/limitadorPoder
}

class Maiar inherits Guerrero (){
  const factorBasico = 15
  const factorBajoAmenaza = 300
  override method parametroPoder() = 2

  override method algo() {
    return if(vida >= 10) (vida * factorBasico) else (vida * factorBajoAmenaza)
  }
}

class Gollum inherits Hobbit {
  override method poder() = super() / 2
}

//PERSONAJES CONOCIDAS (WKO)//

object tom inherits Guerrero(vida = 100) {
  override method poder() = 10000000

  override method estaArmado() = true

  override method recorrer(unaZona) {}
}

object gandalf inherits Maiar(vida = 100, armas = [baculo,glamdring]) {}

class Grupo {
  const listaGuerreros

  method agregarGuerrero(unGuerrero) {
    listaGuerreros.add(unGuerrero)
  }

  method modificarVida(variable) {listaGuerreros.forEach({ guerrero => guerrero.modificarVida(variable) })}
  
  method estaArmado() = listaGuerreros.all({ guerrero => guerrero.estaArmado() })
  
  method poder() = listaGuerreros.min({ guerrero => guerrero.poder() })
  //method poder() = listaGuerreros.sum({ guerrero => guerrero.poder() })
  //ATRAVESAR ZONAS
  method atravesar(region) {listaGuerreros.forEach({ guerrero => guerrero.atravesar(region) })} 

  method tieneElem(elemento, cantRequerida) = listaGuerreros.sum({ guerrero => guerrero.cantElem(elemento) }) >= cantRequerida

  method pasarUnaCondicion(nombCondicion) = listaGuerreros.any({ guerrero => guerrero.pasarUnaCondicion(nombCondicion) })
}