membru(X,[X|_]) :- !.
membru(X,[_|T]) :- membru(X,T).
 
vocala('a'). vocala('e'). vocala('i'). vocala('u'). vocala('o'). vocala('y').
consoana(X) :- not(vocala(X)).
diftong('a','i'). diftong('e','a'). diftong('o','a'). diftong('y','a'). diftong('e','u').
hiat('a','e'). hiat('a','i'). hiat('o','e'). hiat('i','e').
afiseaza([]) :- nl, !.
afiseaza([H|T]) :- write(H), afiseaza(T).
 
grupexceptie(['l','p','t']). grupexceptie(['m','p','t']). grupexceptie(['n','c','t']). grupexceptie(['n','c','s']). grupexceptie(['n','d','v']). grupexceptie(['r','c','t']). grupexceptie(['r','t','f']). grupexceptie(['s','t','m']).
grupexceptie([C1,C2]) :- membru(C1, ['b','c','d','f','g','h','p','t','v']),membru(C2,['l','r']).
 
desparte([],[]) :- !.
desparte([X],[X]) :- !.
desparte([X,Y],[X,Y]) :- vocala(X), vocala(Y), diftong(X,Y),!.
desparte([X,Y],[X,'-',Y]) :- vocala(X), vocala(Y), hiat(X,Y),!.
desparte([X,Y],[X,Y]) :- vocala(X), consoana(Y),!.
desparte([X,Y],[X,Y]) :- consoana(X), vocala(Y),!.
desparte([X|T],[X|L]) :- consoana(X), desparte(T,L).
 
% regula 1 si 1b
desparte([X,Y,Z|T],[X,'-',Y|L]) :- vocala(X), consoana(Y), vocala(Z),desparte([Z|T],L), !.
% regula 1a
desparte([X,Y|T],[X|L]) :- vocala(X), vocala(Y), diftong(X,Y), desparte([Y|T],L).
% regula 1c
% ch etc.
% regula 2 exceptiile
desparte([V1,C1,C2,V2|T],[V1,'-',C1,C2|L]) :- grupexceptie([C1,C2]), desparte([V2|T],L),!.
% regula 2
desparte([V1,C1,C2,V2|T],[V1,C1,'-',C2|L]) :- desparte([V2|T],L).
% regula 3
% intai exceptiile
desparte([V1,C1,C2,C3,V2|T],[V1,C1,C2,'-',C3|L]) :- grupexceptie([C1,C2,C3]), desparte([V2|T],L),!.
% apoi regula
desparte([V1,C1,C2,C3,V2|T],[V1,C1,'-',C2,C3|L]) :- desparte([V2|T],L).
% regula 4
desparte([X,Y|T],[X,'-'|L]) :- vocala(X), vocala(Y), hiat(X,Y), desparte([Y|T],L).
run :- write("Dati cuvantul: "), readln(Cuvant),
string_chars(Cuvant,Lista), afiseaza(Lista), nl, desparte(Lista,Silabe), afiseaza(Silabe).
 
run(Cuvant) :- string_chars(Cuvant, Lista), afiseaza(Lista), nl,
        desparte(Lista, Silabe), afiseaza(Silabe).
 
test :-
        run("prietenie").