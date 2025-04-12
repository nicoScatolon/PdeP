%BASE DE CONOCIMIENTO

% apareceEn( Personaje, Episodio, LadoDeLaluz).
apareceEn(luke, elImperioContrataca, luminoso).
apareceEn(luke, unaNuevaEsperanza, luminoso).
apareceEn(vader, unaNuevaEsperanza, oscuro).
apareceEn(vader, laVenganzaDeLosSith, luminoso).
apareceEn(vader, laAmenazaFantasma, luminoso).
apareceEn(c3po, laAmenazaFantasma, luminoso).
apareceEn(c3po, unaNuevaEsperanza, luminoso).
apareceEn(c3po, elImperioContrataca, luminoso).
apareceEn(chewbacca, elImperioContrataca, luminoso).
apareceEn(yoda, elAtaqueDeLosClones, luminoso).
apareceEn(yoda, laAmenazaFantasma, luminoso).

%Maestro(Personaje)
maestro(luke).
maestro(leia).
maestro(vader).
maestro(yoda).
maestro(rey).
maestro(duku).
%caracterizacion(Personaje,Aspecto).
%aspectos:
% ser(Especie,Tamaño)
% humano
% robot(Forma)
caracterizacion(chewbacca,ser(wookiee,10)).
caracterizacion(luke,humano).
caracterizacion(vader,humano).
caracterizacion(yoda,ser(desconocido,5)).
caracterizacion(jabba,ser(hutt,20)).
caracterizacion(c3po,robot(humanoide)).
caracterizacion(bb8,robot(esfera)).
caracterizacion(r2d2,robot(secarropas)).

%elementosPresentes(Episodio, Dispositivos)
elementosPresentes(laAmenazaFantasma, [sableLaser]).
elementosPresentes(elAtaqueDeLosClones, [sableLaser, clon]).
elementosPresentes(laVenganzaDeLosSith, [sableLaser, mascara,
estrellaMuerte]).
elementosPresentes(unaNuevaEsperanza, [estrellaMuerte,
sableLaser, halconMilenario]).
elementosPresentes(elImperioContrataca, [mapaEstelar,
estrellaMuerte] ).

existeDisp(sableLaser).
existeDisp(clon).
existeDisp(mascara).
existeDisp(estrellaMuerte).
existeDisp(halconMilenario).
existeDisp(mapaEstelar).

%precede(EpisodioAnterior,EpisodioSiguiente)
precedeA(laAmenazaFantasma,elAtaqueDeLosClones).
precedeA(elAtaqueDeLosClones,laVenganzaDeLosSith).
precedeA(laVenganzaDeLosSith,unaNuevaEsperanza).
precedeA(unaNuevaEsperanza,elImperioContrataca).

% Creacion de un nuevo episodio

nuevoEpisodio(Heroe, Villano, Extra, Dispositivo):-
    personajesConocidos(Heroe,Villano,Extra),
    heroeJedi(Heroe),
    definicionVillano(Villano),
    extraExotico(Extra,Heroe),
    extraExotico(Extra,Villano),
    dispositivoReconocible(Dispositivo).

personajesConocidos(Heroe,Villano,Extra):-
    apareceEn(Heroe,_,_),
    apareceEn(Villano,_,_),
    apareceEn(Extra,_,_),
    Heroe \= Villano,
    Heroe \= Extra,
    Villano \= Extra.

%DEFINICION HEROE
heroeJedi(Heroe):-
    maestro(Heroe),
    apareceEn(Heroe,_,luminoso),
    forall(apareceEn(Heroe,_,Lado), Lado \=oscuro).

%DEFINICION VILLANO
definicionVillano(Villano):-
    apareceEn(Villano,Episodio1,_),
    apareceEn(Villano,Episodio2,_),
    Episodio1 \= Episodio2,
    ambiguo(Villano).

ambiguo(Personaje):-
    apareceEn(Personaje,Episodio,luminoso),
    apareceEn(Personaje,Episodio,oscuro).
ambiguo(Personaje):-
    apareceEn(Personaje,Episodio1,luminoso),
    apareceEn(Personaje,Episodio2,oscuro),
    precedeA(Episodio1,Episodio2).

%DEFINICION EXTRA
extraExotico(Extra,_):-
    caracterizacion(Extra,robot(Forma)),
    Forma \= esfera.
extraExotico(Extra,_):-
    caracterizacion(Extra,ser(desconocido,_)).
extraExotico(Extra,_):-
    caracterizacion(Extra,ser(Tipo,Tamanio)),
    Tipo \= desconocido,
    Tamanio > 15.
extraExotico(Extra,Personaje):-
    forall(apareceEn(Extra,Episodio,_),apareceEn(Personaje,Episodio,_)).

%DEFINICION DISPOSITIVO

dispositivoReconocible(Dispositivo):-
    existeDisp(Dispositivo),
    findall(Episodio, (elementosPresentes(Episodio, Dispositivos), member(Dispositivo, Dispositivos)), Episodios),
    length(Episodios, Cantidad),
    Cantidad >= 3.





