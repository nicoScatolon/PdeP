import armas.*
import coliseo.*

class Mirmillon {
	const property destreza = 15
	var property vida = 100
	var fuerza = 10
	var arma
	var armadura

	method puedeCombatir() {return vida > 0}

	method poderAtaque() {
		return arma.poderAtaque() + fuerza
	}

	method defensa() {
		return armadura.defensa(self) + self.destreza()
	}

	method atacar(unGladiador) {
		unGladiador.recibirAtaque(self.poderAtaque())
	}
	method recibirAtaque(poderAtaque) {
		vida = vida - ( poderAtaque - self.defensa() )
	}
	method pelearContra(unGladiador) {
		self.atacar(unGladiador)
		unGladiador.atacar(self)
	}
	method masFuerte(){
		return self
	}
	method curar(){
		vida = 100
	}
	method armarGrupoCon(gladiador) {
		const grupo = new Grupo(nombre = "Mirmillolandia")
		grupo.agregarGladiador(self)
		grupo.agregarGladiador(gladiador)
		return grupo
	}
	
}

class Dimachaerus {
	var destreza
	const fuerza = 10
	var armas = [ ]
	var property vida = 100

	
	method puedeCombatir() {return vida > 0}

	method arma(nuevaArma) {
		armas.add(nuevaArma)
	}

	method quitarArma(arma) {
		armas.remove(arma)
	}

	method poderAtaque() {
		return fuerza + armas.sum({ unArma => unArma.poderAtaque() })
	}

	method atacar(unGladiador) {
		unGladiador.recibirAtaque(self.poderAtaque())
		destreza = destreza + 1
	}

	method recibirAtaque(poderAtaque) {
		vida = vida - ( poderAtaque - self.defensa() )
	}
	method defensa() {
		return destreza / 2
	}
	method pelearContra(unGladiador) {
		self.atacar(unGladiador)
		unGladiador.atacar(self)
	}
	method masFuerte(){
		return self
	}
	method curar(){
		vida = 100
	}
	method armarGrupoCon(gladiador) {
		const grupo = new Grupo(nombre = "D-"+(self.poderAtaque()+gladiador.poderAtaque()))
		grupo.agregarGladiador(self)
		grupo.agregarGladiador(gladiador)
		return grupo
	}
}