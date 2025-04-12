basico :: String -> Float
basico cargo
    | cargo == "titular" = 149000
    | cargo == "adjunto" = 116000
    | cargo == "ayudante" = 66000
    | otherwise = error "Cargo"

antiguedad :: Float -> Float
antiguedad anios
    |anios >= 3 && anios < 5   = 0.2
    | anios >= 5 && anios < 10  = 0.3
    | anios >= 10 && anios < 24 = 0.5
    | anios >= 24 = 1.2
    | otherwise =  0.0

cantHoras :: Float -> Float
cantHoras x = x / 10

funcion :: String -> Float -> Float -> Float
funcion cargo hrs anios= (basico cargo) * fromIntegral (round (cantHoras hrs)) * (1 + antiguedad anios)