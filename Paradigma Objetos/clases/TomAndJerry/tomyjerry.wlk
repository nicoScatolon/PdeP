object tom {
	var property energia = 50

	method energiaGastada(distancia) = distancia / 2

	method energiaGanada(raton) = 12 + raton.energia()
	
	method comer(raton) {
		energia += self.energiaGanada(raton)
	}
	
	method correr(distancia){
		energia-=self.energiaGastada(distancia)
	}
	
	method velocidadMaxima()  = 5 + energia / 10

	method puedeComer(distancia) = 
		self.energiaGastada(distancia) < energia

    method quiereComer(raton, distancia) = 
		(self.puedeComer(distancia)) && (self.energiaGanada(raton) > self.energiaGastada(distancia))
}

object jerry {
	var edad = 2

	method energia() = edad * 20

	method crecer() {
		edad += 1
	}
}

object nibbles {
	method energia() = 35 
}


