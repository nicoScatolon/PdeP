import guerreros.*
import zonas.*

//ARMAS//
class Espada {
  const portador
  var property multiplicadorDePoder //entre 1 y 20

  method poderOtorgado() = multiplicadorDePoder * portador.poderOrigen()
}

class Baculo {
  var property poderOtorgado
}

class Daga inherits Espada {
  override method poderOtorgado() = super() / 2
}

class Hacha {
  const longitudMango
  const pesoHoja

  method poderOtorgado() = longitudMango * pesoHoja
}

class Item {
  method efecto() {
  }
}

//ARMAS CONOCIDAS (WKO)//
object glamdring {
  var property origen = new Elfo(destrezaPropia = 1)

  method poderOtorgado() = 10 * origen.poderOrigen()
  
  method nuevoOrigen(newOrigen) {
    origen = newOrigen
  }
}

const baculo = new Baculo(poderOtorgado = 400)