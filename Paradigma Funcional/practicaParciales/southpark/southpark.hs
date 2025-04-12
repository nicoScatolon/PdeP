--Struct de Personajes
data Reparto = UnPersonaje { 
    nombre :: String
    , cantDinero :: Int
    , lvlFelicidad :: Int

} deriving (Show)

butters = UnPersonaje "Butters" 30 50
stan  = UnPersonaje "Stan" 15 25
cartman = UnPersonaje "Cartman" 50 20

type Evento = Reparto -> Reparto

confirmNoNeg :: Int -> Int
confirmNoNeg num
    | num<0 = 0
    | otherwise = num

--Ir a la primaria
irEscuela :: Evento
irEscuela reparto
    | nombre  reparto == "Butters" = reparto {lvlFelicidad = lvlFelicidad reparto + 20} 
    | otherwise  =  reparto {lvlFelicidad = confirmNoNeg(lvlFelicidad reparto - 20)}

--Comer Cheesy Poofs
comerCheesyPoofs :: Int -> Evento
comerCheesyPoofs cantCheesyPoofs reparto = reparto{lvlFelicidad = (lvlFelicidad reparto + 10)*cantCheesyPoofs, cantDinero = (cantDinero reparto - 10)*cantCheesyPoofs} 

--Ir a trabajar
irTrabajo :: String -> Evento
irTrabajo trabajo reparto = reparto{cantDinero = (cantDinero reparto) * (length trabajo)}
--Hacer doble turno
--dobleTurno :: String -> Evento
--dobleTurno trabajo reparto = irTrabajo reparto
--Jugar Wow
jugarWOW :: Int -> Int -> Evento
jugarWOW cantHoras cantAmigos reparto
    |cantHoras > 5 = reparto{lvlFelicidad = (lvlFelicidad reparto + 10)*cantAmigos*5,cantDinero = (cantDinero reparto - 10) * cantHoras}
    |otherwise = reparto{lvlFelicidad = (lvlFelicidad reparto + 10)*cantAmigos*cantHoras,cantDinero = (cantDinero reparto - 10) * cantHoras}
--Actividad Inventada


--()