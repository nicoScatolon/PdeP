object personas {
  var property  maxIntensidad = 100

  method modificarMaxIntensidad(valor) {
    maxIntensidad += valor
  }
}

//-----------------PERSONAS-----------------
class Persona {
  var edad
  
  const emociones = []
    
  method esAdolecente() = edad > 12 && edad < 19

  method agregarEmocion(nuevaEmocion) {
    emociones.add(nuevaEmocion)
  } 

  method porExplotarEmocionalmente() { 
    emociones.all({emocion => emocion.puedeLiberarse()}) 
  } 

  method vivirEvento(evento) {
    evento.afectar(emociones)
  }

  method crecer() { //No es necesario
    edad += 1
  }
}


//-----------------EVENTOS-----------------
class Evento {
  var property impacto 
  const property descripcion

  method afectar(emociones) {
    emociones.forEach({emocion => emocion.liberarse(self)})
  }
}

//-----------------GRUPO DE PERSONAS-----------------
class GrupoPersonas {
  const personas = []
  
  method agregarPersona(persona) {
    personas.add(persona)
  }
  
  method vivirEvento(evento) {
    personas.forEach({persona => persona.vivirEvento(evento)})
  }
}

