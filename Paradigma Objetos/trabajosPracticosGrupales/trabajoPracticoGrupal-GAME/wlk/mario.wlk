import sonidos.*
import personajes.*
import barril.*
import items.*
import elementosModificables.*
import menu.menuPerder

object mario {
  const property marioGirando = ["marioMuriendo1.png", "marioMuriendo2.png", "marioMuriendo3.png", "marioMuriendo4.png", "marioMuriendo1.png"] 
  var property position = new MutablePosition(x = 0, y = 2)
  var property saltando = false
  var property andar = false
  var property mirarDer = true
  var property vida = 3
  var property puedeCaer = true
  var property escalable = false
  var escalando = false
  var property colisionable = false
  var imagen = "marioD.png"
  const property items = []

  method image() = imagen

  method detener() {
  }

  method caminar(donde) {
    var voy
    var imagen1
    var imagen2
    if(donde == 0) {
      imagen1 = "marioD.png"
      imagen2 = "marioDD.png"
      voy = self.position().right(1)
      self.mirarDer(true)
    }
    else {
      imagen1 = "marioI.png"
      imagen2 = "marioII.png"
      voy = self.position().left(1)
      self.mirarDer(false)
    }
    if(self.dentroDePantalla(voy) and !self.escalando()) {
      if(andar) {
        imagen = imagen1
        andar = false
      }
      else {
        imagen = imagen2
        game.schedule(500, { imagen = imagen1 andar = false })
        andar = true
      }
      self.position(voy)
      listaSonidos.iniciarSonido(listaSonidos.marioCamina())
    }
  }

  method dentroDePantalla(pos) = ((pos.x() > -1) and (pos.x() < game.width()) 
    and (pos.y() > -1) and (pos.y() < game.height()))

  method saltar() {
    if(not(saltando)) {
      var imagenOld
      listaSonidos.iniciarSonido(listaSonidos.marioSalta())
      self.saltando(true)
      andar = false
      if(mirarDer) { imagen= "marioUpD.png" imagenOld = "marioD.png" }
      else { imagen= "marioUpI.png" imagenOld = "marioI.png" }
      self.position(self.position().up(1))
      game.schedule(500, {
      if(not(self.enBase())) self.position(self.position().down(1)) 
        game.schedule(20,  { imagen = imagenOld })
        self.saltando(false)
      })
    }
  }

  method escalar(donde) {
    if(self.puedoEscalar(donde) and not(saltando)) {
      self.position(self.position().up(donde))
      escalando = true
      if(mirarDer){ imagen = "marioEscala1D.png" 
      mirarDer=false
      }
      else {
        imagen = "marioEscala1I.png" 
        mirarDer=true
      }
    }
    else if(escalando) {
      escalando = false
      if(mirarDer) imagen = "marioD.png" else imagen = "marioI.png"
    }
  }

  method escalando() = !self.enBase() and escalando

  method puedoEscalar(donde) {
      return if(donde == 1) {
      self.sobreEscalera(position)
      } 
      else self.sobreEscalera(position.down(1))
  }

  method sobreEscalera(pos) {
    return game.getObjectsIn(pos).any({ n => n.escalable()})
  }
  method enBase() {
    const bloqueDeAbajo = self.position().down(1)
    return game.getObjectsIn(bloqueDeAbajo).any({ n => n.colisionable()})
  }

  method caer() {
    if(!self.enBase()and !self.sobreEscalera(position))
    {
      const nuevaPos = self.position().down(1)
      if (!self.dentroDePantalla(nuevaPos)) self.quitarVida()
      else if(self.puedeCaer() and not(self.saltando())) {
      self.position(nuevaPos)
    }}
  }

  method agregarItem(unItem) {
    items.add(unItem)
    game.removeVisual(unItem)
    if(items.size() == 3) peach.libre()
    else sonidos.iniciarSonido(sonidos.peachFeliz())
  }

  method quitarVida() {
    if(vida > 1) {
      vida -= 1
      sonidos.iniciarSonido(sonidos.marioPierdeVida())
      corazones.quitarCorazon()
      self.reaparecer()
      }
    else {
      if (mirarDer) imagen = "marioDeadD.png"
        else imagen = "marioDeadI.png"
        menuPerder.actuar()
    }
  }
  
  method reaparecer() {
    self.position(game.at(1, 2))
    imagen = "marioD.png"
  }

  method disparar(pistola) {
    const imagenOld = imagen
    pistola.usarBala()
    if(mirarDer) imagen = "marioDisparaD.png" else imagen = "marioDisparaI.png"
    game.schedule(250, { imagen = imagenOld })
    const bala = new Bala(numeroBala = pistola.cantidadBalas(), direccion = self.mirarDer())
    bala.iniciar()
  }
}