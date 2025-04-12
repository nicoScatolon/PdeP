import solucion.personas

//-----------------EMOCIONES-----------------
class Emocion {
  var property intensidad

  var property contEventos = 0

  method condicionAdicionalLiberarse()

  method puedeLiberarse() = self.intensidadAlta() and self.condicionAdicionalLiberarse()
  
  method liberarse(evento) {
    contEventos += 1
    if(self.puedeLiberarse()){
      self.modificarIntensidad(evento.impacto())
      self.accionDistintiva(evento)
    }
  }
  method accionDistintiva(evento) {}

  method modificarIntensidad(valor) {
    intensidad += valor
  }

  method intensidadAlta() = intensidad > personas.maxIntensidad()
}

class Furia inherits Emocion (intensidad = 100) {
  const palabrotas = []

  override method condicionAdicionalLiberarse() = palabrotas.any({palabrota => palabrota.size() > 7})

  override method accionDistintiva(evento) {
    palabrotas.remove(palabrotas.head())}
  
  method aprenderPalabrota(nuevaPalabrota) {
    palabrotas.add(nuevaPalabrota)
  }
  method olvidarPalabrota(palabrota) {
    palabrotas.remove(palabrota)
  }
}

class Alegria inherits Emocion {
  override method condicionAdicionalLiberarse() = contEventos % 2 == 0
  
  override method modificarIntensidad(valor){
    if(valor >= 0)
      intensidad += valor
    else
      intensidad += valor*(-1) 
  }
}

class Tristeza inherits Emocion {
  var causa = "Melancolia"
  override method condicionAdicionalLiberarse() =  causa != "Melancolia"

  method modificarCausa(nuevaCausa){
    causa = nuevaCausa
  }

  override method accionDistintiva(evento) { 
    self.modificarCausa(evento.descripcion())
  }
}

class EmocionDistinta inherits Emocion {
  override method condicionAdicionalLiberarse() =  contEventos > intensidad
}

class Desagrado inherits EmocionDistinta{} 
class Temor inherits EmocionDistinta{}
//No son objetos porque no aclara que la intensidad es fija como en furia

//-----------------INTENSAMENTE 2-----------------

class Ansiedad inherits Emocion {
  var property nivelAnsiedad = 0

  override method condicionAdicionalLiberarse() = nivelAnsiedad < 50

  override method accionDistintiva(evento) {
    self.incrementarNivelAnsiedad(evento.impacto())
  }

  method incrementarNivelAnsiedad(valor) {
    nivelAnsiedad += (valor / 10)
  }

}

//esta nueva emocion, es polimorfica ya que al llamarla actua igual que las demas, pero internamente
//va incrementando el nivel de ansiedad, hasta que no puede hacerse mas.
//se utiliza herencia, porq hereda los metodos de la clase principal y solamente modifica lo necesario,
//esto ayuda para no repetir codigo y hacer mas facil la lectura.
