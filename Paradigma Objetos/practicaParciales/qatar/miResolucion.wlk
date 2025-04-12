class Plato {
  var property azucar

  method calorias() = 3 * azucar + 100
}

class Entrada inherits Plato (azucar = 0) {
    const property bonito = true

}
class Principal inherits Plato () {
    const property bonito
}

class Postre inherits Plato (azucar = 120) {
    const cantColores
    method bonito() = cantColores > 3

}

class Cocinero {
    var especialidad

    method catarPlato(plato) = especialidad.puntaje(plato)

    method cocinar()=
        especialidad.cocinar()

    method cambiarEspecialidad(nuevaEspecialidad) {
        especialidad = nuevaEspecialidad
    }
    	method participar(torneo){
		const platoParticipante = new PlatoPresentado(plato = self.cocinar() , creador = self)
		torneo.agregarPlato(platoParticipante)
	}

}

class Pastelero  {
    const nivelDulzor

    method cocinar() =
        new Postre(cantColores = nivelDulzor / 50)
    

    method puntaje(plato) = 5 * plato.azucar() / nivelDulzor
}

class Chef {
    const calDeseadas

    method puntaje(plato) {
        return if(self.cumpleExpectativas(plato)) 10 else 0
    }

    method cocinar() =
      new Principal(azucar = calDeseadas , bonito = true)
    
    method cumpleExpectativas(plato) = plato.bonito() and plato.calorias()<=calDeseadas
}

class Souschef inherits Chef {
    override method puntaje(plato){
        return if(self.cumpleExpectativas(plato)) super(plato) 
        else plato.calorias()/100
    }
    override method cocinar() =
        new Entrada()
    
}

class PlatoPresentado{
	var plato
	var creador
	method creador() = creador
	method plato() = plato
}
class Torneo{
	const catadores = []
	const platosPresentados = []
	
	method agregarPlato(plato){
		platosPresentados.add(plato)
	}
	
	method cocineroGanador() = 
		if (platosPresentados.isEmpty())
			throw new DomainException(message = "No se presentaron participantes")
		else
			self.platoPresentadoGanador().creador()
	
	method platoPresentadoGanador() = platosPresentados.max({platoPresentado => self.puntajeTotal(platoPresentado.plato())})
	
	method puntajeTotal(plato) = catadores.sum({catador => catador.catarYDarCalificacion(plato)})
}