%--------------------LISTA DE CONOCIMIENTO--------------------
% disco(artista, nombreDelDisco, cantidad, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

disco(badbunny,unVeranoSinTi,8000,2022).
disco(taylorSwitf,taylorVersion,3000,2022).
disco(taylorSwitf,taylorVersionV2,6000,2022).
disco(jalvarez,perreito,7000,2022).

disco(drake, lastDance, 5000, 2020).
disco(hippie, happy, 5001, 2020).

disco(mana, unFuturoSinTi, 5, 2019).
disco(mana, volveMarta, 5000, 2024).



%manager(artista, manager).
manager(floydRosa, habitual(15)).
manager(tablasDeCanada, internacional(cachito, canada)).
manager(rodrigoMalo, trucho(tito)).

manager(mana,copado(5000)).

% habitual(porcentajeComision) 
% internacional(nombre, lugar)
% trucho(nombre)

% residencia(Pais,Porcentaje)
residencia(canada,5).
residencia(mexico,15).


%-------------------------RESOLUCION---------------------------
% 1- Clasicos
clasico(Artista):-
    disco(Artista,loMejorDe,_,_).
clasico(Artista):-
    disco(Artista,_,Ventas,_),
    Ventas > 100000.

% 2- Cantidades Vendidas
cantidadesVendidas(Artista,VentasTotales):-
    disco(Artista,_,_,_),
    findall(Ventas,disco(Artista,_,Ventas,_), ListaVentas),
    sumlist(ListaVentas, VentasTotales).
    
% 3- Derechos De Autor
derechosDeAutor(Artista,ImporteTotal):-
    cantidadesVendidas(Artista,VentasTotales),
    GananciaNeta is VentasTotales * 100,
    pagoManager(Artista,GananciaNeta,PagoManager),
    ImporteTotal is GananciaNeta - PagoManager.

pagoManager(Artista,_,0):-
    not(manager(Artista,_)).

pagoManager(Artista,Ventas,PagoManager):-
    manager(Artista,habitual(Porcentaje)),
    aplicarPorcentaje(Ventas,Porcentaje,PagoManager).

pagoManager(Artista,Ventas,PagoManager):-
    manager(Artista,internacional(_,Pais)),
    residencia(Pais,Porcentaje),
    aplicarPorcentaje(Ventas,Porcentaje,PagoManager).

pagoManager(Artista,Ventas,Ventas):-
    manager(Artista,trucho(_)).

pagoManager(Artista,_,PagoManager):-
    manager(Artista,copado(PagoManager)).

aplicarPorcentaje(Neto, Porcentaje, Pago) :-
    Pago is Neto * Porcentaje / 100.
    
% 4- Number One
namberuan(Artista,Anio):-
    disco(Artista,_,Cantidad,Anio),
    not(manager(Artista,_)),
    forall((disco(OtroArtista, _, OtraCantidad, Anio), 
        not(manager(OtroArtista, _))),
        Cantidad >= OtraCantidad).

% 5- Teorico
/*
 Debido a la forma que esta hecho el predicado de "derechosDeAutor", que es el
afectado en caso de que se cree un nuevo tipo de manager, no habría que hacer
mucho para que funcione, simplemente crear un nuevo manager/2, y
crear un nuevo pagoManager/3, debido a la flexibilidad del predicado no es un gran problema, y
se pueden agregar cuantos tipos de manager se desee.
 El concepto que nos ayuda es el polimorfismo. 
Se logra cuando se definen múltiples cláusulas para un mismo predicado. 
Permite que cada tipo de manager se maneje de manera 
específica sin afectar el funcionamiento de otros tipos que ya estan
definidos.

 EJEMPLO
El Manager de Mana es copado, solo le cobra los servicios, (transporte, horas de Estudio, etc),
sin importar cuanto facturo en el anio. 
(Está integrado al código, pero se debería poder con cualquier nuevo tipo)

*/
