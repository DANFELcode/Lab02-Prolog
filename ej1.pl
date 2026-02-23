
%  PROBLEMA DE LA RANA - DFS

% Coordenadas de las ubicaciones
ubicacion(orilla_inicial, 0, 5).
ubicacion(piedra1,        2, 4).
ubicacion(piedra2,        5, 6).
ubicacion(piedra3,        8, 4).
ubicacion(piedra4,        5, 0).
ubicacion(orilla_final,  10, 5).

% Capacidad de la rana: distancia máxima de salto.
salto_maximo(4.0).

% distancia_euclidiana(+X1,+Y1,+X2,+Y2, -Dist)
distancia_euclidiana(X1, Y1, X2, Y2, Dist) :-
    Dist is sqrt((X2 - X1)^2 + (Y2 - Y1)^2).

%La rana puede saltar, si Lugar 1 y Lugar 2 existen, y la distancia euclidiana
%es menor a el maxSalto
puede_saltar(Lugar1, Lugar2) :-
    ubicacion(Lugar1, X1, Y1),
    ubicacion(Lugar2, X2, Y2),
    distancia_euclidiana(X1, Y1, X2, Y2, Dist),
    salto_maximo(MaxSalto),
    Dist =< MaxSalto.

%Verifica si el salto especifico es valido, desde lugarActual a LugarSiguiente
siguiente_estado(pos(LugarActual), pos(LugarSiguiente)) :-
    ubicacion(LugarActual, _, _),       
    ubicacion(LugarSiguiente, _, _),   
    LugarSiguiente \= LugarActual,      
    puede_saltar(LugarActual, LugarSiguiente).


es_objetivo(pos(orilla_final)).

% Caso base: el estado actual ya es el objetivo.
dfs(EstadoActual, Visitados, Solucion) :-
    es_objetivo(EstadoActual),
    reverse(Visitados, Solucion).

% Caso recursivo: expandir al siguiente estado no visitado.
dfs(EstadoActual, Visitados, Solucion) :-
    siguiente_estado(EstadoActual, EstadoSiguiente),
    \+ member(EstadoSiguiente, Visitados),      % verificar que ya no haya sido visitado
    dfs(EstadoSiguiente, [EstadoSiguiente | Visitados], Solucion).

buscar_solucion(Solucion) :-
    EstadoInicial = pos(orilla_inicial),
    dfs(EstadoInicial, [EstadoInicial], Solucion).