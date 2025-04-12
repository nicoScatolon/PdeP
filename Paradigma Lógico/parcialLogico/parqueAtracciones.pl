persona(nina, 22 , 160).
persona(marcos, 8 , 132).
persona(osvaldo, 13, 129).
persona(pedro,2,120).
persona(juan,13,160).
persona(nico,14,150).


atraccion(trenFantasma,edad(12)).
atraccion(montaniaRusa,altura(130)).
atraccion(maquinaTiquetera,sinReq).
atraccion(toboganGigante,altura(150)).
atraccion(rioLento, sinReq).
atraccion(piscinaDeOlas,edad(5)).


%REQUERIMIENTOS
%1
puedeSubir(Persona, Atraccion):-
    atraccion(Atraccion,edad(EdadMin)),
    persona(Persona, Edad, _),
    Edad >= EdadMin.

puedeSubir(Persona,Atraccion):-
    atraccion(Atraccion,altura(AltMin)),
    persona(Persona,_,Altura),
    Altura >= AltMin.
 
puedeSubir(Persona,Atraccion):-
    atraccion(Atraccion,sinReq),
    persona(Persona,_,_).

parque(acuatico,toboganGigante).
parque(acuatico,rioLento).
parque(acuatico,piscinaDeOlas).

parque(deLaCosta,trenFantasma).
parque(deLaCosta,montaniaRusa).
parque(deLaCosta,maquinaTiquetera).

%2
esParaElle(Persona,Parque):-
    persona(Persona,_,_),
    parque(Parque,_),
    forall(parque(Parque,Atraccion),puedeSubir(Persona,Atraccion)).

%3
grupo(adolescentes,osvaldo).
grupo(adolescentes,pedro).
grupo(adolescentes,juan).
grupo(adolescentes,nico).

grupo(adultos,nina).
grupo(adultos,marcos).
grupo(adultos,osvaldo).

malaIdea(Nombre,Parque):-
    grupo(Nombre,_),
    parque(Parque,_),
    forall(parque(Parque,Atraccion), not(subenTodos(Nombre,Atraccion))).

subenTodos(NombreGrupo,Atraccion):-
    grupo(NombreGrupo,Persona),
    atraccion(Atraccion,_),
    forall(grupo(NombreGrupo,Persona),puedeSubir(Persona,Atraccion)).


%Programas
programa([toboganGigante,piscinaDeOlas]).
programa([toboganGigante,piscinaDeOlas,toboganGigante]).
programa([toboganGigante,piscinaDeOlas,trenFantasma,maquinaTiquetera]).
%1
programaLogico(Programa):-
    mismoParque(Programa),
    noJuegosRepetidos(Programa).

mismoParque(Programa):-
    programa(Programa),
    parque(NombParque,_),
    forall(member(Atraccion,Programa), perteneceAlParque(Atraccion,NombParque)).
    
perteneceAlParque(Atraccion,Parque):-
    atraccion(Atraccion,_),
    parque(Parque,ListaAtracciones),
    member(Atraccion,ListaAtracciones).

noJuegosRepetidos([]).
noJuegosRepetidos([Juego | Resto]):-
    not(member(Juego, Resto)),
    noJuegosRepetidos([Resto]).
%2
% Regla hastaAca/3
hastaAca(_, [], []).
hastaAca(Persona, [Atraccion | Resto], [Atraccion | SubPrograma]):-
    puedeSubir(Persona, Atraccion),
    hastaAca(Persona, Resto, SubPrograma).
hastaAca(Persona, [Atraccion | _], []):-
    persona(Persona,_,_),
    not(puedeSubir(Persona, Atraccion)).

%Pasaportes

juegoComun(maquinaTiquetera,200).
juegoComun(trenFantasma,1000).
juegoComun(rioLento,300).

juegoPremium(montaniaRusa).
juegoPremium(piscinaDeOlas).
juegoPremium(toboganGigante).

pasaporte(nina,basico(2000)).
pasaporte(osvaldo,basico(500)).
pasaporte(pedro,premium).
pasaporte(marcos,flex(3000,montaniaRusa)).
pasaporte(juan,premium).
pasaporte(nico,basico(1500)).


puedeSubirConPasaporte(Persona,Atraccion):-
    puedeSubir(Persona,Atraccion),
    pasaporte(Persona,Pasaporte),
    loHabilita(Pasaporte,Atraccion).


loHabilita(premium,_).

loHabilita(basico(Puntos),Atraccion):-
    juegoComun(Atraccion, PuntosRequeridos),
    Puntos >= PuntosRequeridos.

loHabilita(flex(Puntos,_),Atraccion):-
    loHabilita(basico(Puntos),Atraccion).
loHabilita(flex(_,Atraccion),Atraccion):-
    juegoPremium(Atraccion).



    
