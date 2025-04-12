//GENERADOR DE ESCALERAS
class Escalera {
    const ejeXBase
    const ejeYBase
    const alto

    method crearEscalera() {
        (0..alto).forEach({ i =>
            const pixel = new Pixel(ejeXPixel = ejeXBase, 
                                    ejeYPixel = ejeYBase + i, 
                                    colisionable = false , 
                                    escalable = true)
            game.addVisual(pixel)
        })
    }
}

//GENERADOR DE BASES
class Base {
  const ejeXBase
  const ejeYBase
  const ancho
 
  method crearPiso() {
    (0..ancho).forEach({ i =>
        const pixel = new Pixel(ejeXPixel = ejeXBase + i, 
                                ejeYPixel = ejeYBase, 
                                colisionable = true , 
                                escalable = false)
      game.addVisual(pixel)
    })
  }
}

//PIXELES
class Pixel {
    const ejeXPixel
    const ejeYPixel
    var property colisionable 
    var property escalable

    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() {
        return if(escalable) {"escaleraPixel.png"} 
        else{"pixelBase.png"}
    }
    
    method actuar() {} 

    method detener() {}
}


//GENERADOR DE CORAZONES
object corazones { 
    const x = 11
    const y = 14
    const cant = 3
    const corazones = []
    
    method agregarCorazon() {
        (1..cant).forEach({ i =>
            const corazon = new Corazon(ejeXPixel = x + i, ejeYPixel = y)
            corazones.add(corazon) 
            game.addVisual(corazon)
        })
    }
    
    method quitarCorazon() { 
        const corazon = corazones.last()
        corazon.quitarCorazon()
        corazones.remove(corazon)
    }
}

//PIXEL CORAZÓN
class Corazon {
    const ejeXPixel
    const ejeYPixel
    var imagen = "marioVida.png"

    var property colisionable = false 
    var property escalable = false 

    method position() = game.at(ejeXPixel, ejeYPixel)

    method image() = imagen

    method quitarCorazon() {
        imagen = "marioVidaDead.png"
    }

    method actuar() {}
}

