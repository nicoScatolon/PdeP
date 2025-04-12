object text {
  const property verde = "00FF00FF"
  const property amarillo = "FFFF00"
  const property rojo = "FF0000FF"
  const property position = game.at(18, 0)
  
  method textColor() = verde

  
  method text() = "Energía: " + pepita.energia()
}

object pepita {
  var energia = 1000
  var imagen = "pepitaDer.png"
  var property position = game.center()
  
  method image() = imagen
  
  //POSICIÓN 
  method position(newPos) {
    self.vola(1)
    position = newPos
  }
  
  method autoPosition(newPos) {
    position = newPos
    self.endGame()
  }
  
  method positionDer(newPos) {
    self.position(newPos)
    imagen = "pepitaDer.png"
  }
  
  method positionIzq(newPos) {
    self.position(newPos)
    imagen = "pepitaIzq.png"
  }
  
  method energia() = energia
  
  method estaCansada() = energia <= 50
  
  method endGame() {
    if (energia <= 0) {
      imagen = "pepitaDead.png"
      game.boardGround("fondoLOSE.jpg")
      game.say(self, "Me voy al otro mundo :(")
      game.schedule(1000, { game.stop() })
    } else {
      if (energia <= 20) game.say(self, "Ya no puedo más, tengo hambre!!!")
    }
  }
  
  method vola(metros) {
    energia -= metros * 10
  }
  
  //COMER
  method comer(comida) {
    energia += comida.energia()
  }
}

object alpiste {
  const x = 0.randomUpTo(20).truncate(0)
  const y = 0.randomUpTo(20).truncate(0)
  var property position = game.at(x, y)
  
  method image() = "apliste.png"
  
  method energia() = 5
  
  method delete() {
    game.removeVisual(self)
  }
  
  method actuar() {
    pepita.comer(self)
    game.say(pepita, "Ñam Ñam")
    game.schedule(100, { self.delete() })
  }
}

object milanesa {
  const x = 0.randomUpTo(20).truncate(0)
  const y = 0.randomUpTo(20).truncate(0)
  var property position = game.at(x, y)
  
  method image() = "milanesa.png"
  
  method energia() = 40 * 1.randomUpTo(25).truncate(0)
  
  method delete() {
    game.removeVisual(self)
  }
  
  method actuar() {
    pepita.comer(self)
    game.say(pepita, "Ñam Ñam")
    game.schedule(100, { self.delete() })
  }
}

object manzana {
  var porcentajeMad = 0
  var calorias = 50
  var imagen = "manzana.png"
  const x = 0.randomUpTo(20).truncate(0)
  const y = 0.randomUpTo(20).truncate(0)
  var property position = game.at(x, y)
  
  method image() = imagen
  
  method energia() = calorias
  
  method cuantoMadura() = porcentajeMad
  
  method madura() {
    porcentajeMad += 10
    if (porcentajeMad < 100) {
      calorias *= 1.1
      imagen = "manzana.png"
    }
    if (porcentajeMad == 100) {
      calorias = 100
      imagen = "manzanaCasiPodrida.png"
    }
    if ((porcentajeMad > 100) and (calorias > 0)) {
      calorias -= 20
      imagen = "manzanaPodrida.png"
    }
  }
  
  method actuar() {
    pepita.comer(self)
    game.say(pepita, "Ñam Ñam")
    game.schedule(100, { self.delete() })
  }
  
  method delete() {
    game.removeVisual(self)
  }
}

object avion {
  var property position = game.at(
    0.randomUpTo(20).truncate(0),
    0.randomUpTo(20).truncate(0)
  )
  
  method image() = "avion.png"
  
  method movete() {
    const x = 0.randomUpTo(20).truncate(0)
    const y = 0.randomUpTo(20).truncate(0)
    
    position = game.at(x, y)
  }
  
  method actuar() {
    self.movete()
    pepita.autoPosition(position)
    game.schedule(100, { game.removeVisual(self) })
  }
}

object nido {
  var property position = game.at(17, 17)
  
  method image() = "nido.png"
  
  method actuar() {
    game.boardGround("fondoWIN.jpg")
    game.say(self, "LLEGUE!!!!!")
    game.schedule(1000, { game.stop() })
  }
}

