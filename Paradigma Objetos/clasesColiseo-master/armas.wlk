class ArmaFilosa {
	var longitud
	var filo

	method poderAtaque() {
		return longitud * filo
	}
}

class ArmaContundente {
	var peso

	method poderAtaque() {
		return peso
	}
}

object casco {
	method defensa(unGladiador) {
		return 5
	}
}

object escudo {
	const defensa = 10
	method defensa(unGladiador) {
		return defensa + unGladiador.destreza() / 10
	}
}