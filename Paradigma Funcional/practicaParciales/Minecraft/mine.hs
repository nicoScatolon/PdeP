data Personaje = UnPersonaje {
    nombre:: String,
    puntaje:: Int,
    inventario:: [Material]
} deriving Show

steve :: Personaje
steve = UnPersonaje "Steve" 1000 [sueter, fogata, pollo, pollo]
type Material = String

data Receta = UnaReceta {
    objetoResultante :: String,
    materialesNecesarios :: [Material],
    tiempoNecesario :: Int
}deriving Show

fogata,lana,agujas, tintura, fosforo, madera,polloAsado,pollo,sueter,hielo,lobos,iglues :: Material
fogata = "Fogata"
fosforo = "Fosforo"
madera = "Madera"
pollo = "Pollo"
polloAsado = "Pollo Asado"
sueter = "Sueter"
hielo = "Hielo"
iglues = "Iglues"
lobos = "Lobos"
lana = "Lana"
agujas = "Agujas"
tintura = "Tintura"

recetaFogata,recetaPolloAsado,recetaSueter  :: Receta

recetaFogata = UnaReceta fogata [madera,fosforo] 10
recetaPolloAsado = UnaReceta polloAsado [fogata, pollo] 300
recetaSueter = UnaReceta sueter [lana, agujas, tintura] 600

listaReceta :: [Receta]
listaReceta = [recetaFogata,recetaPolloAsado,recetaSueter]

--CRAFT
-- Punto 1
comprobacionContiene :: Personaje -> Receta -> Bool
comprobacionContiene pj receta = all (tieneMaterial pj) (materialesNecesarios receta)

tieneMaterial :: Personaje -> Material -> Bool
tieneMaterial pj mat = mat `elem` inventario pj

eliminarObjeto :: [Material] -> Material -> [Material]
eliminarObjeto [] _ = []
eliminarObjeto (x:xs) n
    |x == n = xs
    |otherwise = x : eliminarObjeto xs n

agregarMaterial :: [Material] -> Material -> [Material]
agregarMaterial lista n = lista ++ [n]

--
intentarCraftear :: Personaje -> Receta -> Personaje
intentarCraftear pj receta
    |comprobacionContiene pj receta = craftear pj receta
    |otherwise = pj{puntaje = puntaje pj - 100}

craftear :: Personaje -> Receta -> Personaje
craftear pj receta = pj{puntaje = puntaje pj + tiempoNecesario receta * 10, inventario = foldl eliminarObjeto (inventario pj) (materialesNecesarios receta) ++ [objetoResultante receta]}

--Punto 2
--2a)
encontrarCrafteables :: Personaje -> [Receta] -> [Material]
encontrarCrafteables _ [] = []
encontrarCrafteables pj (x:xs)
    |permiteDuplicar pj x = objetoResultante x : encontrarCrafteables pj xs
    |otherwise = encontrarCrafteables pj xs

permiteDuplicar :: Personaje -> Receta -> Bool
permiteDuplicar pj receta = 2*puntaje pj <= puntaje (craftear pj receta)
--2b)
craftearLista :: Personaje -> [Receta] -> Personaje
craftearLista = foldl craftear

--2c)


mayorPuntajeEnOrden :: Personaje -> [Receta] -> Bool
mayorPuntajeEnOrden pj listaRecetas= puntaje (craftearLista pj listaRecetas) > puntaje (craftearLista pj (reverse listaRecetas))

--MINE
--1
data Bioma = UnBioma{
    elementoNecesario :: Material,
    elementosPropios :: [Material]
}   deriving Show

biomaArtico :: Bioma
biomaArtico = UnBioma sueter [hielo,iglues,lobos]

type Herramienta = [Material] -> Material
hacha, espada:: Herramienta
hacha = last
espada = head
pico :: Int -> Herramienta
pico = flip (!!)

posicionMitad :: Herramienta
posicionMitad lista = pico (length lista `div` 2) lista

minar :: Herramienta -> Personaje -> Bioma -> Personaje
minar herr pj bioma
    |tieneMaterial pj (elementoNecesario bioma) = pj{inventario = inventario pj ++ [herr (elementosPropios bioma)], puntaje = puntaje pj + 50}
    |otherwise = pj
-- 

generadorMateriales :: Material -> [Material]
generadorMateriales mat = mat : generadorMateriales mat