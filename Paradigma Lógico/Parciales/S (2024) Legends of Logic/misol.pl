
% PARTE 1: POKEDEX
pokemon(pikachu,electrico).
pokemon(charizard,fuego).
pokemon(venusaur,planta).
pokemon(blastoise,agua).
pokemon(totodile,agua).
pokemon(snorlax,normal).
pokemon(rayquaza,dragon).
pokemon(rayquaza,volador).

inventario(ash,pikachu).
inventario(ash,charizard).
inventario(brock,snorlax).
inventario(misty,blastoise).
inventario(misty,venusaur).
inventario(misty,arceus).

% Punto 1
multipleTipo(Nombre):-
    pokemon(Nombre,Tipo1),
    pokemon(Nombre,Tipo2),
    Tipo1 \= Tipo2.

% Punto 2
esLegendario(Nombre):-
    multipleTipo(Nombre),
    not(inventario(_,Nombre)).

% Punto 3
esMisterioso(Nombre):-
    pokemon(Nombre,_),
    not(inventario(_,Nombre)).

esMisterioso(Nombre):-
    pokemon(Nombre,Tipo),
    not((pokemon(Nombre2, Tipo), Nombre \= Nombre2)).

% PARTE2: MOVIMIENTOS
%tipos de movimientos

fisico(mordedura,95).
fisico(placaje, 50).

especial(impactrueno,40,electrico).
especial(garraDragon,100,dragon).

defensivo(proteccion, 10).
defensivo(alivio,100).

%movimientos
movimiento(pikachu,mordedura).
movimiento(pikachu,impactrueno).

movimiento(charizard,garraDragon).
movimiento(charizard,mordedura).

movimiento(blastoise,proteccion).
movimiento(blastoise,placaje).

movimiento(arceus,impactrueno).
movimiento(arceus,garraDragon).
movimiento(arceus,proteccion).
movimiento(arceus,placaje).
movimiento(arceus,alivio).

%danioAtaque(Movimiento,Daño)
danioAtaque(Mov,Danio):-
    defensivo(Mov,_),
    Danio is 0.

danioAtaque(Mov,Danio):-
    fisico(Mov,Potencia),
    Danio is Potencia.

danioAtaque(Mov,Danio):-
    especial(Mov,Potencia,Tipo),
    multiplicadorTipo(Tipo,Mult),
    Danio is Potencia * Mult.

multiplicadorTipo(dragon,3).
multiplicadorTipo(Tipo,1.5):-
    tipoBasico(Tipo).
multiplicadorTipo(Tipo,1):-
    Tipo \= dragon,
    not(tipoBasico(Tipo)).

tipoBasico(fuego).
tipoBasico(agua).
tipoBasico(planta).
tipoBasico(normal).

%Punto 2
capOfensiva(Pokemon,DanioTotal):-
    movimiento(Pokemon,_),
    findall(Danio, danioAtaquePokemon(Pokemon, Danio), Lista),
    sumlist(Lista, DanioTotal).

danioAtaquePokemon(Pokemon, Danio):-
    movimiento(Pokemon, Mov), 
    danioAtaque(Mov, Danio).

%Punto 3
entrenadorPicante(Entrenador):-
    inventario(Entrenador,_),
    forall(inventario(Entrenador,Pokemon), capOfensivaAlta(Pokemon)).

capOfensivaAlta(Pokemon):-
    esMisterioso(Pokemon).

capOfensivaAlta(Pokemon):-
    capOfensiva(Pokemon,DanioTotal),
    DanioTotal > 200.

