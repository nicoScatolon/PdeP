import menu.*
import sonidos.*
import mario.*
import nivel1.*
import barril.*

//PEACH
object peach {
  var property position = game.at(2, 13)
  var property colisionable = false 
  var property escalable = false
  var indice = 0
  var property liberable = false
  var conMario = false
  var imagen = "peach3.png"
  const imagenes = ["peach3.png","peach1.png","peach2.png"]

  method image() = imagen

  method moverse() {
    if(!conMario) {
      if(indice < 2) indice += 1 else indice = 0
        imagen = imagenes.get(indice)
    }
  }
    
  method actuar() {
    if(liberable){
      conMario = true
      menuGanar.actuar()
    }
  }
  method libre() {
    sonidos.iniciarSonido(sonidos.peachLibre())
    carcel.abrir()
    liberable = true
  }
}

//CARCEL
object carcel {
  var property position = game.at(1, 13)
  var imagen = "celdaCerrada.png"

  method image() = imagen

  var property colisionable = false
  var property escalable = false

  method abrir() {
    imagen = "celdaAbierta.png"
  }
}

object objetoInvisible {
  const property position = peach.position().right(1)
  method actuar() {
    peach.actuar()
  }
}

//MONO DONKEY
object donkey {
  var property colisionable = false 
  var property escalable = false
  var indice = 0
  var property contadorBarriles = 0
  var property position = game.at(11, 11)
  var image = "donkeyy.png"
	const serieBarril = ["donkey4.png", "donkey1.png", "donkey3.png"]

  method image() = image

  method actuar() {}
  
  method lanzarBarril() {
    contadorBarriles += 1
    if(indice < 2) indice += 1 else indice = 0
    image = serieBarril.get(indice)
    if(indice == 2) { const barril = new Barril(numeroBarril = contadorBarriles) game.addVisual(barril) barril.iniciar() }
  }
}