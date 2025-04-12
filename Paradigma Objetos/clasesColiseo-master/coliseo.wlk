
class Grupo {
	const gladiadores = []
	var property nombre
	
	method agregarGladiador(gladiador) {
		gladiadores.add(gladiador)
	}
	method quitarGladiador(gladiador) {
		gladiadores.remove(gladiador)
	}
	method masFuerte(){
		var gladiadoresDisponibles = gladiadores.filter{gla=>gla.puedeCombatir()}
		if (gladiadoresDisponibles.isEmpty()) throw new Exception("No hay gladiadores que puedan combatir") 
		return gladiadoresDisponibles.max{gla=>gla.poderAtaque()}
	}
	method combatir(adversario){
		3.times{
			self.masFuerte().pelear(adversario.masFuerte())
		}
	}
	method curar(){
		gladiadores.forEach{gla=>gla.curar()}
	}

}

object coliseo {
	const combatientes = []
	
	method agregarCombatiente(combatiente){
		combatientes.add(combatiente)
	}
	method curarATodos(){
		combatientes.forEach{com=>com.curar()}
	}
	method combateSucesivo(unGrupo){
		combatientes.forEach{com=>unGrupo.combatir(com)}
	}
}