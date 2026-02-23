power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).

villain_list([
    villain(riddler, 90,  [logica, sigilo]),
    villain(bane,    240, [fuerza])
]).

%Un estado es objetivo si la lista de villanos esta vacia, 
%es decir los villanos ya fueron derrotado sin importar la energia y superpoderes
%que tenga Batman
es_objetivo(estado([], _, _)).

%Batman pasa al siguiente estado o decisión si el poder puede dañar al villano
%Batman tiene suficiente energia para usarlo, y se genera la nueva salud del villano
siguiente_estado(
    estado([villain(Nombre, Salud, Debilidades) | RestoVillanos], Poderes, Energia),
    estado(NuevosVillanos, Poderes, NuevaEnergia)
) :-
    member(power(NombrePoder, Daño, Costo), Poderes),
    member(NombrePoder, Debilidades),
    Energia >= Costo,
    NuevaEnergia is Energia - Costo,
    NuevaSalud   is Salud   - Daño,
    (NuevaSalud =< 0
        -> NuevosVillanos = RestoVillanos
        ;  NuevosVillanos = [villain(Nombre, NuevaSalud, Debilidades) | RestoVillanos]
    ).

%DFS algoritmo
dfs(EstadoActual, _) :-
    es_objetivo(EstadoActual).

dfs(EstadoActual, Visitados) :-
    siguiente_estado(EstadoActual, EstadoSiguiente),
    \+ member(EstadoSiguiente, Visitados),
    dfs(EstadoSiguiente, [EstadoSiguiente | Visitados]).

batman_can_win(EnergiaMaxima) :-
    power_list(Superpoderes),
    villain_list(Villanos),
    EstadoInicial = estado(Villanos, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]).