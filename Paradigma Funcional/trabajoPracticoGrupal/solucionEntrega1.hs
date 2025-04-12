--Struct de Ciudades
data Ciudad = UnaCiudad { nombre :: String
            , anioFundacion :: Int
            , atracciones :: [String]
            , costoVida :: Float } deriving (Show)

--Ciudades Predefinidas
baradero = UnaCiudad "Baradero" 1615 ["Parque del Este", "Museo Alejandro Barbich"] 150
nullish = UnaCiudad "Nullish" 1800 [] 140
caletaOlivia = UnaCiudad "Caleta Olivia" 1901 ["El Gorosito", "Faro Costanera"] 120
maipu = UnaCiudad "Maipú" 1878 ["Fortín Kakel"] 115
azul = UnaCiudad "Azul" 1832 ["Teatro Espanol", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"] 190

--          //Funciones//
--      //Punto 1//
--Definir valor ciudadSobria
valorCiudad :: Ciudad -> Float
valorCiudad ciudad
    | anioFundacion ciudad < 1800 = 5 * (1800 - fromIntegral (anioFundacion ciudad))
    | null (atracciones ciudad)  = 2 * (costoVida ciudad)
    | otherwise = 3 * (costoVida ciudad)

--      //Punto 2//
--Atraccion copada
--Es copada si empieza por vocal
esVocal :: String -> Bool
esVocal cadena = (head cadena) `elem` ['A', 'a', 'E', 'e', 'I', 'i', 'O', 'o', 'U', 'u']

atraccionCopada :: Ciudad -> Bool
atraccionCopada ciudad = any esVocal (atracciones ciudad)

--Población sobria
--Es sobria si la suma de las atracciones da menos a n
--siendo n un valor definido por el usuario
longAtracciones :: Ciudad -> [Int]
longAtracciones ciudad = map (length) (atracciones ciudad)

ciudadSobria :: Ciudad -> Int -> Bool
ciudadSobria ciudad limite 
    | null (atracciones ciudad) = False
    | otherwise = all (> limite) (longAtracciones ciudad)

--Nombre raro
--Tiene nombre raro si tiene menos de 5 letras
nombreRaroCiudad :: Ciudad -> Bool
nombreRaroCiudad ciudad = length (nombre ciudad) < 5

--      //Punto 3//
--Sumar una nueva atraccion
--incrementa el costo de vida un 20%
agregarAtraccion:: Ciudad->String->Ciudad
agregarAtraccion ciudad nuevaAtraccion= ciudad{costoVida= costoVida ciudad*1.2, atracciones = atracciones ciudad ++ [nuevaAtraccion]}

--Crisis
--baja el costo de vida un 10% y 
--cierra la ultima atraccion de la lista
crisis :: Ciudad -> Ciudad
crisis ciudad 
    |null (atracciones ciudad) = ciudad{costoVida= (costoVida ciudad)* 0.9} 
    |otherwise = ciudad{costoVida = costoVida ciudad* 0.9 , atracciones= init(atracciones ciudad)}

--Remodelacion
--se incremente el costo de vida X
--le agrega el prefijo "New" al nombre
dePorcentajeAFloat:: Float -> Float
dePorcentajeAFloat x = 1 + (x/100)

remodelacion::Ciudad->Float->Ciudad
remodelacion ciudad porcentaje = ciudad {costoVida = (costoVida ciudad)*(dePorcentajeAFloat porcentaje) , nombre = "New " ++ (nombre ciudad)}

--Reevaluacion
--Si la ciudad es sobria, con un limite indicado por el usuario,
--se aumenta el costoVida un 10%, caso contrario baja 3 puntos.
reevaluacion::Ciudad-> Int ->Ciudad
reevaluacion ciudad limite
        |ciudadSobria ciudad limite == True = ciudad{costoVida = (costoVida ciudad)*1.1}
        |otherwise = ciudad{costoVida = (costoVida ciudad) - 3}

--      //Punto 4//
transfNoPara :: Ciudad -> Float -> Int-> Ciudad
transfNoPara ciudad porcentaje limite = reevaluacion (crisis (remodelacion ciudad porcentaje)) limite