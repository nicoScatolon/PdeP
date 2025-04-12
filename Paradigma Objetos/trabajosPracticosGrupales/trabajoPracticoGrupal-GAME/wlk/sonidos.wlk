object sonidos {
  //DEFINICIÓN DE SONIDOS
  const property musicaNivel1 = "theme1.mp3"
  const property musicaMenu = "themeMenu.mp3"
  const property nombreGame = "mario_gametitle.wav"
  const property marioMuere = "marioDead.wav"
  const property marioPierdeVida = "marioPierdeVida.wav"
  const property marioMuerePorFuego = "morirPorFuego.wav"
  const property moverCursor = "cursorNavegar.mp3"
  const property click = "click.mp3"
  const property ganar = "win.wav"
  const property peachLibre = "peachSound.mp3"
  const property peachFeliz = "peachFeliz.mp3"
  const property iniciarNivel = "iniciarNivel.wav"

  var musicaActual = null

  var volumen = 0.25

  method iniciarMusica(song) {
    if(musicaActual == null) {
      if(musicaActual != null) musicaActual.stop()
      musicaActual = game.sound(song)
      musicaActual.shouldLoop(true)
      musicaActual.play()
      musicaActual.volume(volumen)
    }
  }

  method pararMusica() { 
  if(musicaActual != null)  musicaActual.stop() musicaActual = null
  }
  method cambiarVolumen(volACambiar) {
    if(volumen + volACambiar >= 0 && volumen + volACambiar <= 1){
    volumen += volACambiar
    if(musicaActual != null) musicaActual.volume(volumen)}
  }
  method pausarMusica() { 
    if(musicaActual != null)  musicaActual.pause()
  }
  method despausarMusica() { 
    if(musicaActual != null)  musicaActual.resume()
  }

  method iniciarSonido(sonido) {
    const sound = game.sound(sonido)
    sound.volume(volumen)
    sound.play()
  }
}

//LISTAS DE SONIDOS
object listaSonidos{
  const property marioCamina = ["marioWalk1.wav", "marioWalk2.wav", "marioWalk3.wav", "marioWalk4.wav", "marioWalk5.wav", "marioWalk6.wav"]
  const property marioHabla =  ["marioComentario8.wav", "marioComentario7.wav", "marioComentario6.wav", "marioComentario5.wav", "marioComentario4.wav", "marioComentario3.wav", "marioComentario2.wav", "marioComentario1.wav"]
  const property marioSalta =  ["mario_jump1.wav", "mario_jump2.wav", "mario_jump3.wav", "mario_jump4.wav"]

  method iniciarSonido (lista){
    const sound = lista.anyOne()
    sonidos.iniciarSonido(sound)
  }
}