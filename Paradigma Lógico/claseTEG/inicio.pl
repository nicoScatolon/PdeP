:- use_module(paises).
:- use_module(ocupacion).


%Paises que limitan con paises de otros Continentes
%DISTINTO = X \= Y.
%Prolog es Pseudo-Declarativo

sonLimitrofes(P1,P2) :-limita(P1,P2).
sonLimitrofes(P1,P2) :-limita(P2,P1).

limitaOtroContinente(Pais,OtroPais):-
    pais(Pais,Continente),
    pais(OtroPais,OtroContinente),
    Continente \= OtroContinente,
    sonLimitrofes(Pais,OtroPais).
%not(limitaOtroContinente(mexico,Pais)).


% Un solo igual es comparación 1=2 Falso, 1=1 Verdadero
% is resuelve. X is 1+2. X = 3

%-Predicado que me diga los enemigos de un país, es decir sus limitrofes que no tengan el mismo color.

enemigoDeOtroPais(Pais,OtroPais):-
    ocupa(Color,Pais, Ejercito),
    ocupa(OtroColor,OtroPais, OtroEjercito),
    Color \= OtroColor,
    sonLimitrofes(Pais,OtroPais).

%-Predicado complicado/1 verifica si un país está complicado, es decir, si tiene dos países limítrofes del mismo color y la suma de los ejércitos de ambos países es al menos 5.

paisComplicado(Pais):-
    sonLimitrofes(Pais,OtroPais),
    sonLimitrofes(Pais,Pais2),
    ocupa(Color,Pais2, Ejercito2),
    ocupa(Color,OtroPais,OtroEjercito),
    Ejercito2 + OtroEjercito >= 5.

%-------------

paisComplicado2(Pais):-
    sonLimitrofes(Pais,OtroPais),
    ocupa(Color,OtroPais, Ejercito1),
    ocupa(Color,Pais2,Ejercito2),
    Ejercito1 + Ejercito2 >= 5.


    %sonLimitrofes(Pais,OtroPais2),


    

%-Predicado puede_atacar/1 que determine si un país tiene más ejercitos que uno de sus paises limítrofes que sea de otro color.
%-Un ejercito esFuerte/1 si ninguno de sus países está complicado.