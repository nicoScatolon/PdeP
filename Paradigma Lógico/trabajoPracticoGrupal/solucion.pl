/* 1. Modelar lo necesario para representar los jugadores, las civilizaciones y las tecnologías, de la
forma más conveniente para resolver los siguientes puntos.
*/

/*Jugadores y la civilización con la que juegan*/
jugador(ana, romanos).
jugador(beto, incas).
jugador(carola, romanos).
jugador(dimitri, romanos).

/*Jugadores y tecnologias desarrolladas*/
tecnologiaDes(ana, herreria).
tecnologiaDes(ana, forja).
tecnologiaDes(ana, emplumado).
tecnologiaDes(ana, laminas).
tecnologiaDes(beto, herreria).
tecnologiaDes(beto, forja).
tecnologiaDes(beto, fundicion).
tecnologiaDes(carola, herreria).
tecnologiaDes(dimitri, herreria).
tecnologiaDes(dimitri, fundicion).

/*
2. Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería,
forja y o bien desarrolló fundición o bien juega con los romanos.
En los ejemplos, Ana y Beto son expertos en metales, pero Carola y Dimitri no.
*/

expertoEnMetales(Jugador) :-
    jugador(Jugador, _),
    tecnologiaDes(Jugador, herreria),
    tecnologiaDes(Jugador, forja),
    tecnologiaDes(Jugador, fundicion).

expertoEnMetales(Jugador) :-
    jugador(Jugador, romanos),
    tecnologiaDes(Jugador, herreria),
    tecnologiaDes(Jugador, forja).

/*
3. Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
En los ejemplos, los romanos es una civilización popular, pero los incas no.
*/

civilizacionPopular(Civilizacion) :-
    jugador(Jugador, Civilizacion),
    jugador(OtroJugador, Civilizacion),
    Jugador \= OtroJugador.

/*
4. Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.
En los ejemplos, la herrería tiene alcance global, pues Ana, Beto, Carola y Dimitri la desarrollaron
*/

tecnologiaGlobal(Tecnologia) :-
    tecnologiaDes(_, Tecnologia),
    not((jugador(Jugador, _), not(tecnologiaDes(Jugador, Tecnologia)))).

/*
5. Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó todas las
tecnologías que alcanzaron las demás. (Una civilización alcanzó una tecnología cuando algún jugador
de esa civilización la desarrolló).
*/
civilizacionLider(Civilizacion) :-
    jugador(_, Civilizacion),
    not(lider(Civilizacion)).

lider(Civilizacion) :-
    tecnologiaDes(_, Tecnologia),
    not((jugador(Jugador, Civilizacion), tecnologiaDes(Jugador, Tecnologia))).


/*PUNTO 6*/

unidadJugador(ana, unJinete(caballo)).
unidadJugador(ana, unPiquero(1, conEscudo)).
unidadJugador(ana, unPiquero(2, sinEscudo)).
unidadJugador(beto, unCampeon(100)).
unidadJugador(beto, unCampeon(80)).
unidadJugador(beto, unPiquero(1, conEscudo)).
unidadJugador(beto, unJinete(camello)).
unidadJugador(carola, unPiquero(3, sinEscudo)).
unidadJugador(carola, unPiquero(2, conEscudo)).


/*PUNTO 7*/
vidaUnidad(unJinete(camello), 80).
vidaUnidad(unJinete(caballo), 90).
vidaUnidad(unPiquero(1, sinEscudo), 50).
vidaUnidad(unPiquero(2, sinEscudo), 65).
vidaUnidad(unPiquero(3, sinEscudo), 70).
vidaUnidad(unCampeon(Vida), Vida).

vidaUnidad(unPiquero(Nivel, conEscudo), Vida) :- 
    vidaUnidad(unPiquero(Nivel,sinEscudo),VidaSinEscudo), 
    Vida is VidaSinEscudo *1.1.

unidadConMasVida(Jugador, Unidad) :-
    unidadJugador(Jugador, Unidad),
    vidaUnidad(Unidad, Vida),
    not((unidadJugador(Jugador, OtraUnidad),
        Unidad \= OtraUnidad, 
        vidaUnidad(OtraUnidad, OtraVida),
        OtraVida > Vida)).%probar con forall.


/*PUNTO 8*/ 
ventaja(unJinete(_), unCampeon(_)).
ventaja(unCampeon(_), unPiquero(_, _)).
ventaja(unPiquero(_, _), unJinete(_)).
ventaja(unJinete(camello), unJinete(caballo)).

leGanaA(Unidad, OtraUnidad) :- ventaja(Unidad, OtraUnidad).
leGanaA(Unidad, OtraUnidad) :-
    not(ventaja(OtraUnidad, Unidad)),
    vidaUnidad(Unidad, Vida),
    vidaUnidad(OtraUnidad, OtraVida),
    Vida > OtraVida.


/*PUNTO 9*/
sobreviveAsedio(Jugador) :-
    jugador(Jugador, _),
    cantPiqueros(Jugador, conEscudo, Cant1),
    cantPiqueros(Jugador, sinEscudo, Cant2),
    Cant1 > Cant2.

cantPiqueros(Jugador, Tipo, Cant):-
    findall(unPiquero(_, Tipo), unidadJugador(Jugador, unPiquero(_, Tipo)), Lista),
    length(Lista, Cant).

/* PUNTO 10 */
depende(punzon, emplumado).
depende(emplumado,herreria).

depende(horno,fundicion).
depende(fundicion,forja).
depende(forja, herreria).

depende(placas,malla).
depende(malla,laminas).
depende(laminas,herreria).

depende(arado,collera).
depende(collera,molino).

/* Dependencia indirecta: una tecnología depende de otra directamente o indirectamente */
dependeIndirectamente(TecBase, TecDependiente) :- 
    depende(TecBase, TecDependiente).
dependeIndirectamente(TecBase, TecDependiente) :- 
    depende(TecBase, Intermedia), 
    dependeIndirectamente(Intermedia, TecDependiente).

/* Verificar si un jugador puede desarrollar una tecnología */
puedeDesarrollar(Jugador, Tecnologia) :-
    jugador(Jugador,_),
    tecnologia(Tecnologia),
    forall(dependeIndirectamente(Tecnologia, Dependencia), 
    tecnologiaDes(Jugador, Dependencia)),
    not(tecnologiaDes(Jugador, Tecnologia)). % El jugador no debe haber desarrollado la tecnología
/*
puedeDes(Jug,Tecno):-
    listaTecnoJugador(Jug,ListaJ),
    listaDependenciasTecno(Jug,Tecno,ListaD),
    ListaJ = ListaD,
    not(tecnologiaDes(Jug,Tecno)).
    


listaTecnoJugador(Jugador,ListaJ):-
findall(jugador(Jugador,_),(Jugador,_),ListaJ).

listaDependenciasTecno(Jug,Tecno,ListaD):-
    findall(tecnologiaDes(Jug,Dep),dependeIndirectamente(Tecno,Dep),ListaD).*/

tecnologia(herreria).
tecnologia(emplumado).
tecnologia(forja).
tecnologia(laminas).
tecnologia(punzon).
tecnologia(fundicion).
tecnologia(malla).
tecnologia(horno).
tecnologia(placas).
tecnologia(molino).
tecnologia(collera).
tecnologia(arado).
