import pepita.*

object buenosAires {
  const nombre = "Buenos Aires"
  var property position = game.at(8, 4)
  
  method image() = "ciudad.png"
  
  method viajar() {
    pepita.autoPosition(cordoba.position())
  }
  
  method actuar() {
    game.say(self, "Estas en " + nombre)
  }
}

object cordoba {
  const nombre = "Cordoba"
  var property position = game.at(4, 17)
  
  method image() = "ciudad.png"
  
  method viajar() {
    pepita.autoPosition(buenosAires.position())
  }
  
  method actuar() {
    game.say(self, "Estas en " + nombre)
  }
}