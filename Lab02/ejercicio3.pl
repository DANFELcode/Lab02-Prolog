
es_meta(Estado) :-
    length(Estado, 8).


no_ataca(NuevaFila, Existentes) :-
    length(Existentes, N),
    ColNueva is N + 1,
    no_ataca_aux(NuevaFila, ColNueva, Existentes, 1).

no_ataca_aux(_, _, [], _).
no_ataca_aux(NuevaFila, ColNueva, [Fila|Resto], ColActual) :-
    NuevaFila =\= Fila,                          % misma fila
    abs(NuevaFila - Fila) =\= abs(ColNueva - ColActual), % diagonal
    ColSig is ColActual + 1,
    no_ataca_aux(NuevaFila, ColNueva, Resto, ColSig).


% Agrega una reina en la siguiente columna con alguna fila válida
sucesor(Estado, Sucesor) :-
    length(Estado, N),
    N < 8,
    member(Fila, [1,2,3,4,5,6,7,8]),
    no_ataca(Fila, Estado),
    append(Estado, [Fila], Sucesor).


% Caso base: el estado actual es la meta
dfs(EstadoActual, _Visitados, EstadoActual) :-
    es_meta(EstadoActual).

% Paso recursivo: expandir un sucesor no visitado
dfs(EstadoActual, Visitados, SolucionFinal) :-
    sucesor(EstadoActual, Sucesor),
    \+ member(Sucesor, Visitados),
    dfs(Sucesor, [Sucesor|Visitados], SolucionFinal).


solucion(Solucion) :-
    EstadoInicial = [],
    dfs(EstadoInicial, [EstadoInicial], Solucion).
