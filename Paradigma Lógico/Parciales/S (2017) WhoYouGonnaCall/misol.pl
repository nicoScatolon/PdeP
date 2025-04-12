herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradora, cera, aspiradora(300)]).

% Punto 1
herramienta(egon,aspiradora(200)).
herramienta(egon,trapeador).
herramienta(peter,trapeador).
herramienta(winston,varitaDeNeutrones).

herramienta(egon,plumero).

% Punto 2
satisfaceNecesidad(Nombre, Herramienta):-
    herramienta(Nombre,Herramienta).

satisfaceNecesidad(Nombre, aspiradora(PotenciaRequerida)):-
    herramienta(Nombre,aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

% Punto 3
puedeHacerTarea(Nombre,Tarea):-
    herramientasRequeridas(Tarea,_),
    herramienta(Nombre,varitaDeNeutrones).

puedeHacerTarea(Nombre,Tarea):-
    herramienta(Nombre,_),
    herramientasRequeridas(Tarea, _),
    forall(requiereHerramienta(Tarea,Herramienta), 
    satisfaceNecesidad(Nombre,Herramienta)).

requiereHerramienta(Tarea,Herramienta):-
    herramientasRequeridas(Tarea,ListaDeHerramientas),
    member(Herramienta, ListaDeHerramientas).
/*

puedeHacerTareaV2(Nombre,Tarea):-
    herramientasRequeridas(Tarea,_),
    herramienta(Nombre,varitaDeNeutrones).

puedeHacerTareaV2(Nombre,Tarea):-
    herramienta(Nombre,_),
    herramientasRequeridas(Tarea,ListaHerrReq),
    tieneTodas(Nombre,ListaHerrReq).
    
tieneTodas(Nombre,[Herr | Resto]):-
    herramienta(Nombre,Herr),
    tieneTodas(Nombre,Resto).
tieneTodas(_,[]).
*/    
% Punto 4
tareaPedida(fausto,ordenarCuarto,50).
tareaPedida(fausto,encerarPisos,100).
tareaPedida(fausto,limpiarBanio,50).
tareaPedida(pedro,limpiarTecho,10).
tareaPedida(pepe,limpiarBanio,10).


precio(ordenarCuarto, 400).
precio(limpiarTecho, 200).
precio(cortarPasto, 300).
precio(limpiarBanio, 100).
precio(encerarPisos, 200).

cobrar(Cliente,Tarea,PrecioTotal):-
    tareaPedida(Cliente,Tarea,Mts),
    precio(Tarea,Precio),
    PrecioTotal is Precio*Mts.



dispuestoA(ray,Cliente):-
    tareaPedida(Cliente,_,_),
    forall(tareaPedida(Cliente,Tarea,_), Tarea\=limpiarTecho).

dispuestoA(winston,Cliente):-
    cobrar(Cliente,_,PrecioTotal),
    PrecioTotal > 500.

dispuestoA(peter,_).

dispuestoA(egon,Cliente):-
    tareaPedida(Cliente,_,_),
    forall(tareaPedida(Cliente,Tarea,_), not(tareaCompleja(Tarea))).

tareaCompleja(limpiarTecho).
tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,[_,_| Resto]),
    Resto \= [].

%Punto 6

