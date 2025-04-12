atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).

atiende(lucas,martes,10,20).

atiende(juanC,sabado,18,22).
atiende(juanC,domingo,18,22).

atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,20).

atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).

atiende(martu,miercoles,23,24).

%Punto 1
%Vale atiende los mismos días y horarios que dodain y juanC.
atiende(vale, Dia, HoraInicio, HoraFinal):-
    atiende(dodain,Dia,HoraInicio,HoraFinal).

atiende(vale, Dia, HoraInicio, HoraFinal):-
    atiende(juanC, Dia, HoraInicio, HoraFinal).

%Punto 2
quienAtiende(Persona,Dia,HoraPuntual):-
    atiende(Persona,Dia,HoraInicio,HoraFin),
    between(HoraInicio,HoraFin,HoraPuntual).

%Punto3

foreverAlone(Persona, Dia, Hora):-
    quienAtiende(Persona,Dia,Hora),
    not((quienAtiende(OtraPersona,Dia,Hora), OtraPersona \= Persona)).

%Punto4

posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).
  
  combinar([], []).
  combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
  combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).

%Punto 5

