
data Fremens = UnFremen{
    nombre :: String,
    nivelTolerancia :: Float,
    titulos :: [Titulo],
    cantReconocimientos :: Int
}deriving (Eq, Show)

type Titulo = String

juan, pedro, franco, stilgar :: Fremens
stilgar = UnFremen "Stilgar" 150 ["Guia"] 3
juan = UnFremen "Juan" 150 ["Domador"] 2
pedro = UnFremen "Pedro" 250 ["Domador"] 4
franco = UnFremen "Franco" 150 ["Guia","Domador"] 1

domador, hazmeReir, principiante :: Titulo
domador = "Domador"
hazmeReir = "Hazme Reir"
principiante = "Principiante"

listaPer :: [Fremens]
listaPer = [stilgar,juan,pedro,franco]

aplicarPorcentaje :: Float -> Int -> Float
aplicarPorcentaje num porcentaje = num + num * fromIntegral porcentaje / 100


-- PUNTO 1 - LOS FREMENS
--1a)
recibirReconocimiento :: Fremens -> Fremens
recibirReconocimiento frem = frem {cantReconocimientos= 1 + cantReconocimientos frem }

--1b)
candidatoASerElegido :: Fremens -> Bool
candidatoASerElegido frem = elem domador (titulos frem) && nivelTolerancia frem > 100

--1c)
hallarElegido :: [Fremens] -> Fremens
hallarElegido listaFremens = foldl1 mayorReconocimiento (crearListaCandidatos listaFremens)

crearListaCandidatos :: [Fremens] -> [Fremens]
crearListaCandidatos [] = []
crearListaCandidatos (x:xs)
    |candidatoASerElegido x = x : crearListaCandidatos xs
    | otherwise = crearListaCandidatos xs

mayorReconocimiento :: Fremens -> Fremens -> Fremens
mayorReconocimiento frem1 frem2
    |cantReconocimientos frem1 > cantReconocimientos frem2 = frem1
    |otherwise = frem2

-- PUNTO 2 - GUSANOS DE ARENA
data Gusanos = UnGusano {
    longitud :: Float,
    nivelIdratacion :: Int,
    descripcion :: String
}deriving (Eq, Show)

gusano1,gusano2,gusano3,gusano4,gusano5 :: Gusanos
gusano1 = UnGusano 10 5 "rojo con lunares"
gusano2 = UnGusano 8 1 "dientes puntiagudos"
gusano3 = UnGusano 15 2 "PEPE"
gusano4 = UnGusano 9 4 "JUAN"
gusano5 = UnGusano 50 3 "FEDEE"

listGus1,listGus2 :: [Gusanos]
listGus1 = [gusano1,gusano3,gusano5]
listGus2 = [gusano2, gusano4]
--2a)
nacimientoCria :: Gusanos -> Gusanos -> Gusanos
nacimientoCria gus1 gus2 = gus1{nivelIdratacion = 0, longitud = aplicarPorcentaje (mayorLongitud gus1 gus2) 10, descripcion = descripcion gus1 ++ " - " ++ descripcion gus2}

mayorLongitud :: Gusanos -> Gusanos -> Float
mayorLongitud gus1 gus2
    |longitud gus1 > longitud gus2 = longitud gus1
    |otherwise = longitud gus2

aparearLista :: [Gusanos] -> [Gusanos] -> [Gusanos]
aparearLista [] _ = []
aparearLista _ [] = []
aparearLista (x:xs) (y:ys) = nacimientoCria x y : aparearLista xs ys

--PUNTO 3 - MISIONES
modificarFremen :: Fremens -> Float -> [Titulo] -> Int -> Fremens
modificarFremen fremen tol titl cantRec = fremen {nivelTolerancia = tol, titulos = titulos fremen ++ titl, cantReconocimientos = cantReconocimientos fremen + cantRec}

--DOMAR AL GUSANO DE ARENA
intentarDomar :: Fremens -> Gusanos -> Bool
intentarDomar fremen gusano = nivelTolerancia fremen >= longitud gusano

domarGusanosArena :: Fremens -> Gusanos -> Fremens
domarGusanosArena fremen gusano
    |intentarDomar fremen gusano = modificarFremen fremen (100 + nivelTolerancia fremen) [domador] 0
    |otherwise = modificarFremen fremen (aplicarPorcentaje (nivelTolerancia fremen) (-10)) [] 0

--DESTRUIR AL GUSANO DE ARENA
intentarDestruir :: Fremens -> Gusanos -> Bool
intentarDestruir fremen gusano = elem domador (titulos fremen) && nivelTolerancia fremen < longitud gusano / 2

destruirGusanoArena :: Fremens -> Gusanos -> Fremens
destruirGusanoArena fremen gusano
    |intentarDestruir fremen gusano = modificarFremen fremen (100 + nivelTolerancia fremen) [] 1
    |otherwise = modificarFremen fremen (aplicarPorcentaje (nivelTolerancia fremen) (-20)) [] 0

--INVOCAR AL GUSANO DE ARENA
{-
Dado un Fremen y Un gusano, se quere saber si logra invocarlo/llamarlo, para ello requere tener un minimo de tolerancia que sea mayor a 3 veces la longitud del gusano. El gusano saldrá UNICAMENTE si esta deshidratado (nivelIdratacion<3). Si logra que salga se le asignará el titulo de "Principiante" y aumentará su tolerancia 50 unidades. En caso que no lo logre se le otorga el titulo de "Hazme Reir" y la tolerancia baja un 15%-}
intentarInvocar :: Fremens -> Gusanos -> Bool
intentarInvocar fremen gusano = nivelTolerancia fremen > 3 * longitud gusano && nivelIdratacion gusano < 3

invocarGusano :: Fremens -> Gusanos -> Fremens
invocarGusano fremen gusano
    |intentarInvocar fremen gusano = modificarFremen fremen (50 + nivelTolerancia fremen) [principiante] 0
    |otherwise = modificarFremen fremen (aplicarPorcentaje (nivelTolerancia fremen) (-15)) [hazmeReir] 0

--3a
misionColectiva :: [Fremens] -> (Fremens -> Gusanos -> Fremens) -> Gusanos -> [Fremens]
misionColectiva listaFremens mision gusano = map (`mision` gusano) listaFremens
--3b
difElegido :: [Fremens] -> (Fremens -> Gusanos -> Fremens) -> Gusanos -> Bool
difElegido listaFremens mision gusano = hallarElegido (misionColectiva listaFremens mision gusano) == hallarElegido listaFremens
elegirColectivamente :: [Fremens] -> (Fremens -> Gusanos -> Fremens) -> Gusanos -> Fremens
elegirColectivamente listaFremens mision gusano = hallarElegido (misionColectiva listaFremens mision gusano)
--4a) Simular realizacion colectiva de una mision punto 3a
--PUNTO 4
tribuInfinita :: Fremens -> [Fremens]
tribuInfinita fremen = fremen : tribuInfinita fremen

{-
4a) Se ejecutará infinitamente, devolviendo el struct modificado de la mision, no hay problema que sea infinito

prueba:
ghci> misionColectiva (tribuInfinita juan) invocarGusano gusano1
[UnFremen {nombre = "Juan", nivelTolerancia = 127.5, titulos = ["Domador","Hazme Reir"], cantReconocimientos = 2},UnFremen {nombre = "Juan", nivelTolerancia = 127.5, titulos = ["Domador","Hazme Reir"], cantReconocimientos = 2}

4b) No hay problema, ya que apenas encuentre uno que si sea candidado, saldrá, no hay problema que sea infinita.

4c) No se terminarán de ejecutar nunca ya que esta esperando que se termine de recorrer el vector para hacer la verificación, y al ser infinito nunca termina. Una posible solución es crear una función recursiva que permita encontrarlo dependiendo una determinada max cantidad de Fremens

prueba:
ghci> elegirColectivamente  (tribuInfinita juan) invocarGusano gusano1
Interrupted.
-}
