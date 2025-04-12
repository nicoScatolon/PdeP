-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart :: Jugador
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between :: (Eq a, Enum a) => a -> a -> a -> Bool
between n m x = x `elem` [n .. m]

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord a => (t -> a) -> t -> t -> t
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

{-
    1)Sabemos que cada palo genera un efecto diferente, por lo tanto elegir el palo correcto puede ser la diferencia entre
        ganar o perder el torneo.
            A) Modelar los palos usados en el juego que a partir de una determinada habilidad generan un tiro que se compone por 
                velocidad, precisión y altura.
            
-}
type Palo = Habilidad -> Tiro
putter :: Palo
putter habilidad = UnTiro { velocidad = 10, precision = precisionJugador habilidad*2, altura = 0}
madera :: Palo
madera habilidad = UnTiro { velocidad = 100, precision = precisionJugador habilidad `div` 2, altura = 5}
hierros :: Int -> Palo
hierros n habilidad = UnTiro { velocidad = fuerzaJugador habilidad*n, precision = precisionJugador habilidad `div` n, altura = max (n-3) 0}

{-
    b. Definir una constante palos que sea una lista con todos los palos que se pueden usar en el juego.
-}
palos:: [Palo]
palos = [putter,madera,hierros 1,hierros 2,hierros 3,hierros 4,hierros 5,hierros 6,hierros 7,hierros 8,hierros 9,hierros 10]
{-
    2. Definir la función golpe que dados una persona y un palo, obtiene el tiro resultante de usar ese palo con
        las habilidades de la persona
-}
golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo (habilidad jugador)

{-  3. Lo que nos interesa de los distintos obstáculos es si un tiro puede superarlo, y en el caso de poder
        superarlo, cómo se ve afectado dicho tiro por el obstáculo. En principio necesitamos representar los
        siguientes obstáculos:
-}

tiroDetenido :: Tiro
tiroDetenido = UnTiro 0 0 0

data Obstaculo = UnObstaculo{
    tiroPostObstaculo :: Tiro -> Tiro,
    pasarObstaculo :: Tiro -> Bool
}

type PostObstaculo = Tiro -> Tiro
type PasaObstaculo = Tiro -> Bool

superarTunelRampa :: PasaObstaculo
superarTunelRampa tiro = altura tiro == 0 && precision tiro > 90

postTunelRampa :: PostObstaculo
postTunelRampa tiro
    |superarTunelRampa tiro = tiro{velocidad = velocidad tiro*2,precision = 100, altura= 0}
    |otherwise = tiroDetenido


superarLaguna :: Int -> PasaObstaculo
superarLaguna largo tiro = velocidad tiro > 80 && between 1 5 (altura tiro)

postLaguna :: Int -> PostObstaculo
postLaguna largo tiro
    |superarLaguna largo tiro = tiro{altura= altura tiro`div`largo}
    |otherwise = tiroDetenido

superarHoyo :: PasaObstaculo
superarHoyo tiro = between 5 20 (velocidad tiro) && altura tiro ==0 && precision tiro>95

postHoyo ::PostObstaculo
postHoyo _ = tiroDetenido

tunelRampa :: Obstaculo
tunelRampa = UnObstaculo postTunelRampa superarTunelRampa
laguna :: Int -> Obstaculo
laguna n= UnObstaculo (postLaguna n) (superarLaguna n)
hoyo :: Obstaculo
hoyo = UnObstaculo postHoyo superarHoyo
{-
    4.
        a. Definir palosUtiles que dada una persona y un obstáculo, permita determinar qué palos le sirven
            para superarlo
-}

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles persona obstaculo = filter (superaObstaculoConEsePalo persona obstaculo) palos

superaObstaculoConEsePalo :: Jugador -> Obstaculo -> Palo -> Bool
superaObstaculoConEsePalo persona obstaculo palo = pasarObstaculo obstaculo (golpe persona palo)

{-  4.  
        b. Saber, a partir de un conjunto de obstáculos y un tiro, cuántos obstáculos consecutivos se pueden
superar.
Por ejemplo, para un tiro de velocidad = 10, precisión = 95 y altura = 0, y una lista con dos túneles
con rampita seguidos de un hoyo, el resultado sería 2 ya que la velocidad al salir del segundo
túnel es de 40, por ende no supera el hoyo.
BONUS: resolver este problema sin recursividad, teniendo en cuenta que existe una función
takeWhile :: (a -> Bool) -> [a] -> [a] que podría ser de utilidad.
-}

obstaculos1 :: [Obstaculo]
obstaculos1 = [tunelRampa, tunelRampa, hoyo]
obstaculos2 :: [Obstaculo]
obstaculos2 = [laguna 10, tunelRampa]
tiro1 :: Tiro
tiro1 = UnTiro 10 95 0
tiro2 :: Tiro
tiro2 = UnTiro 100 100 2


pasarObstaculosRecursiva :: [Obstaculo] -> Tiro -> Int
pasarObstaculosRecursiva [] _ = 0
pasarObstaculosRecursiva (x:xs) tiro
    | pasarObstaculo x tiro = 1 + pasarObstaculosRecursiva xs (tiroPostObstaculo x tiro)
    | otherwise = 0

pasarObstaculosSinRecursiva :: [Obstaculo] -> Tiro -> Int
pasarObstaculosSinRecursiva obstaculos tiro = length (takeWhile (`pasarObstaculo` tiro) obstaculos)

{-  4.  
        c. Definir paloMasUtil que recibe una persona y una lista de obstáculos y determina cuál es el palo
que le permite superar más obstáculos con un solo tiro
-}


paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil persona obstaculos =  maximoSegun (pasarObstaculosRecursiva obstaculos.golpe persona) palos

{- 5- Dada una lista de tipo [(Jugador, Puntos)] que tiene la información de cuántos puntos ganó cada
niño al finalizar el torneo, se pide retornar la lista de padres que pierden la apuesta por ser el “padre del
niño que no ganó”. Se dice que un niño ganó el torneo si tiene más puntos que los otros niños
-}

--padresPerdedores :: [(Jugador, Puntos)] -> [String]
--padresPerdedores listaJugadores listaPuntos

padresQuePerdieron :: [(Jugador,Puntos)] -> [String]
padresQuePerdieron = map (padre.fst).niniosPerdedores

niniosPerdedores :: [(Jugador,Puntos)] -> [(Jugador,Puntos)]
niniosPerdedores lista = filter ((/= ninioGanador lista).fst) lista

ninioGanador :: [(Jugador,Puntos)] -> Jugador
ninioGanador lista = fst (maximoSegun snd lista)

listaPuntos :: [(Jugador, Integer)]
listaPuntos = [(bart,10),(todd,2),(rafa,15)]