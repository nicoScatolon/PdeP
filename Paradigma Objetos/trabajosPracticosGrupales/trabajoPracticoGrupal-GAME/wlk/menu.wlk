import nivel1.*
import sonidos.*

//MENU GENERAL
class Menu {
  var property image
  var property botones
  var property mousePosition
  var property position = game.origin()

  method iniciar() {
    game.addVisual(self)
    game.addVisual(cursor)
    cursor.iniciar(botones, mousePosition)
    botones.forEach({ boton => game.addVisual(boton) })
  }

  method cerrar() {
    game.allVisuals().forEach({ n => game.removeVisual(n) })
  }
}


//MENU PRINCIPAL
object menuPrincipal inherits Menu(image = "menuPrincipal.jpg", botones = [botonJugar, botonControles, botonComoJugar, botonSalir], mousePosition = 5){
  method inicioPrincipal(){
    self.iniciar()
    sonidos.iniciarSonido(sonidos.nombreGame())
    sonidos.iniciarMusica(sonidos.musicaMenu())
    keyboard.i().onPressDo { sonidos.cambiarVolumen(0.05) }
    keyboard.k().onPressDo { sonidos.cambiarVolumen(-0.05) }
    keyboard.up().onPressDo({ cursor.desplazar(-1) })
    keyboard.down().onPressDo({ cursor.desplazar(1) })
    keyboard.enter().onPressDo({ cursor.seleccionar() })
  }
}

//MENU CONTROLES Y CÓMO JUGAR
const menuControles = new Menu (image = "controlesMenu.jpg", botones = [botonVolver], mousePosition = 3)

const menuComoJugar = new Menu (image = "comoJugar.jpg", botones = [botonVolver], mousePosition = 3)

//MENU SALIR
class MenuFinal {
  const sonido
  const property image
  const property position = game.origin()
  const tiempo

  method actuar() {
    menuPausa.actuando(true)
    game.addVisual(self)
    sonidos.iniciarSonido(sonido)
    sonidos.pararMusica()
    game.schedule(tiempo, { game.stop() })
  }
}

//MENU PERDER, GANAR Y PAUSA
object menuPerder inherits MenuFinal (image = "menuPerder.png", sonido = sonidos.marioMuere(), tiempo = 500) {}

object menuGanar inherits MenuFinal (image = "menuGanar.png", sonido = sonidos.ganar(), tiempo = 10000) {
  override method actuar() {
    super()
    game.addVisual(corazonWin)
    game.onTick(200,"Cambiar foto", { corazonWin.cambiarImagen() })
  }
}

object corazonWin {
  var property image = "corazonPequeno.png"
  var property position = game.at(7, 7)
  var index = 0

  method cambiarImagen() {
    if(index < 1) {
      index += 1 
      image = "corazonGrande.png"
    }
    else {
      index = 0
      image = "corazonPequeno.png"
    }
  }
}

object menuPausa inherits MenuFinal (image = "menuPausa.png", sonido = sonidos.click(), tiempo = 20) {
  var property actuando = false

  override method actuar() {
    if(actuando) {
      game.removeVisual(self)
      sonidos.despausarMusica()
      actuando = false
    }
    else {
      sonidos.pausarMusica()
      game.addVisual(self)
      actuando = true
    }
  }

  method comprobacionPara(unaFuncion) { if(!actuando) unaFuncion.apply() }
}


//CURSOR
object cursor {
  var indice = 0
  var botonesActuales = menuPrincipal.botones()
  var property position = botonesActuales.get(indice).position().right(5)
  
  method image() = "mouse.png"
  
  method iniciar(botones, mousePosition) {
    botonesActuales = botones
    indice = 0
    position = botonesActuales.get(indice).position().right(mousePosition)
  }

  method nuevaPosition(newPosition) { position = newPosition }

  method desplazar(desplazamiento) {
    const nuevoIndice = indice + desplazamiento
    if (nuevoIndice >= 0 and nuevoIndice < botonesActuales.size()) {
      sonidos.iniciarSonido(sonidos.moverCursor())
      indice = nuevoIndice
      position = botonesActuales.get(indice).position().right(5)
    }
  }

  method seleccionar() {
    sonidos.iniciarSonido(sonidos.click())
    botonesActuales.get(indice).actuar()
  }
}

//BOTONES MENÚ
class Boton {
  const ejeX
  const ejeY
  const imagen
  var property position = game.at(ejeX, ejeY)
  
  method image() = imagen

  method actuar()
}

object botonJugar inherits Boton(imagen = "botonJugar.png", ejeX = 1.5, ejeY = 5) {
  override method actuar() {
    sonidos.pararMusica()
    menuPrincipal.cerrar()
    nivel1.cargarNivel()
  }
}

object botonControles inherits Boton(imagen="botonControles.png", ejeX = 1.5, ejeY = 4) {
  override method actuar() {
    menuPrincipal.cerrar()
    menuControles.iniciar()
  }
}

object botonComoJugar inherits Boton(imagen = "botonComoJugar.png", ejeX = 1.5, ejeY = 3) {
  override method actuar() {
    menuPrincipal.cerrar()
    menuComoJugar.iniciar()
  }
}

object botonSalir inherits Boton(imagen = "botonSalir.png", ejeX = 1.5, ejeY = 2) {
  override method actuar() {
    sonidos.pararMusica()
    menuPrincipal.cerrar()
    game.addVisual(menuPrincipal)
    sonidos.iniciarSonido(listaSonidos.marioHabla().get(2))
    game.schedule(500, { game.stop() })
  }
}

object botonVolver inherits Boton(imagen = "botonAtras.png", ejeX = 10.5, ejeY = 1) {
  override method actuar() {
    menuControles.cerrar()
    menuPrincipal.iniciar()
  }
}