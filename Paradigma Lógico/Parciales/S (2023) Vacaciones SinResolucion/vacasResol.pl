seVa(dodain,pehuenia).
seVa(dodain,sanMartin).
seVa(dodain,esquel).
seVa(dodain,sarmiento).
seVa(dodain,camarones).
seVa(dodain,playasDoradas).

seVa(alf, bariloche).
seVa(alf, sanMartin).
seVa(alf, elBolson).

seVa(nico, marDelPlata).


seVa(vale, calafate).
seVa(vale, elBolson).
/*
parqueNacional(Nombre).
cerro(Nombre,Altura).
cuerpoAgua(PescaPermitida,TempPromedioAgua).
playa(PromMarea).
excursion(Nombre).
*/


seVa(martu,Destino):- seVa(nico, Destino), seVa(alf,Destino).

%PUNTO 2
% Hechos de las atracciones
parque_nacional(esquel, 'Los Alerces').
excursion(esquel, 'Trochita').
excursion(esquel, 'Trevelin').

cerro(pehuenia, 'Batea Mahuida', 2000).
cuerpo_agua(pehuenia, 'Moquehue', true, 14).
cuerpo_agua(pehuenia, 'Alumine', true, 19).
playa(playasDoradas, 4).

% Reglas para determinar si una atracción es copada
es_copado(parque_nacional(_,_)).
es_copado(cerro(_, _, Altura)) :- Altura > 2000.
es_copado(cuerpo_agua(_, _, true, _)).
es_copado(cuerpo_agua(_, _, _, Temp)) :- Temp > 20.
es_copado(playa(_, DiferenciaMareas)) :- DiferenciaMareas < 5.
es_copado(excursion(_, Nombre)) :- string_length(Nombre, Longitud), Longitud > 7.

% Regla para determinar si un destino tiene todas las atracciones copadas
vacaciones_copadas(Destino) :-
    seVa(_,Destino),
    findall(Attr, (parque_nacional(Destino, Attr); 
        cerro(Destino, Attr, _); 
        cuerpo_agua(Destino, Attr, _, _); 
        playa(Destino, Attr); 
        excursion(Destino, Attr)), Atracciones),
    forall(member(Atraccion, Atracciones), es_copado(Atraccion)).

