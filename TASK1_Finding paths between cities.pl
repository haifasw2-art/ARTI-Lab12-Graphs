% ============================================================
% Lab 10 - Graphs
% Task 1: Finding paths between cities
% ------------------------------------------------------------
% The map is a DIRECTED graph: road(From, To) means there is
% an arrow from From to To in the figure.
% travel(From, To, Path) finds a path without visiting any
% city twice (same pattern as go/3 and go/4 in the maze).
%
% City names start with a capital letter, so they are written
% in single quotes, e.g. 'Makkah'.
% ============================================================

% ---------------- Facts: the roads (arrows) ----------------
road('Makkah',  'Madinah').
road('Makkah',  'Riyadh').
road('Madinah', 'Makkah').
road('Madinah', 'Taif').
road('Madinah', 'Tabuk').
road('Taif',    'Tabuk').
road('Taif',    'Dammam').
road('Tabuk',   'Taif').
road('Riyadh',  'Dammam').
road('Dammam',  'Riyadh').
road('Dammam',  'Qatif').
road('Qatif',   'Dammam').
road('Qatif',   'Madinah').

% ---------------- Rules ----------------
% travel(From, To, Path)
% Start with the visited list [From], then reverse the result
% so the path reads from the start city to the goal city.
travel(From, To, Path) :-
    path(From, To, [From], P),
    reverse(P, Path).

% path(From, To, Visited, Path)
% Base case: we are already at the goal city
path(X, X, Visited, Visited).

% Recursive case: take a road to a city we have not visited yet
path(X, Y, Visited, Path) :-
    road(X, Z),
    \+ member(Z, Visited),        % avoid going round in circles
    path(Z, Y, [Z|Visited], Path).

% ------------------------------------------------------------
% Tests (press ; for more answers):
% ?- travel('Dammam','Madinah',P).
%    P = ['Dammam', 'Qatif', 'Madinah'] ;
%    false.
%
% ?- travel('Riyadh','Makkah',P).
%    P = ['Riyadh', 'Dammam', 'Qatif', 'Madinah', 'Makkah'] ;
%    false.
%
% ?- travel('Makkah','Riyadh',P).
%    P = ['Makkah', 'Madinah', 'Taif', 'Dammam', 'Riyadh'] ;
%    P = ['Makkah', 'Madinah', 'Tabuk', 'Taif', 'Dammam', 'Riyadh'] ;
%    P = ['Makkah', 'Riyadh'] ;
%    false.
%
% ?- travel('Makkah','Madinah',P).
%    P = ['Makkah', 'Madinah'] ;
%    P = ['Makkah', 'Riyadh', 'Dammam', 'Qatif', 'Madinah'] ;
%    false.
% ------------------------------------------------------------
