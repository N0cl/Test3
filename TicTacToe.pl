% TicTacToe game.
% 2 players : x / o
% To launch the game : type play.

% Launch the game.
play :- description, start([-, -, -, -, -, -, -, -, -], x).

% Description of the game.
description :-
   write('Welcome to the tictactoe game.'),
   nl,
   show([1, 2, 3, 4, 5, 6, 7, 8, 9]),
   nl.

% Print the 3x3 board as a square.
show([A, B, C, D, E, F, G, H, I]) :-
   write([A, B, C]),
   nl,
   write([D, E, F]),
   nl,
   write([G, H, I]),
   nl.

% Check if the specified element is in the list.
contain(Element, [Element | _]).
contain(Element, [_ | Remain]) :- contain(Element, Remain).

% End of game.
start(Board, x) :-
    win(Board, o).

start(Board, o) :-
    win(Board, x).

start(Board, _) :-
    \+contain(-, Board),
    drawgame(Board).

% Set the next move.
start(Board, x) :-
    show(Board),
    read(Answer),
    put(Board, Answer, NewBoard, x),
    start(NewBoard, o).

start(Board, o) :-
    show(Board),
    read(Answer),
    put(Board, Answer, NewBoard, o),
    nl,
    start(NewBoard, x).

% Legal moves
put([-, B, C, D, E, F, G, H, I], 1 , [S , B, C, D, E, F, G, H, I], S).
put([A, -, C, D, E, F, G, H, I], 2 , [A , S, C, D, E, F, G, H, I], S).
put([A, B, -, D, E, F, G, H, I], 3 , [A , B, S, D, E, F, G, H, I], S).
put([A, B, C, -, E, F, G, H, I], 4 , [A , B, C, S, E, F, G, H, I], S).
put([A, B, C, D, -, F, G, H, I], 5 , [A , B, C, D, S, F, G, H, I], S).
put([A, B, C, D, E, -, G, H, I], 6 , [A , B, C, D, E, S, G, H, I], S).
put([A, B, C, D, E, F, -, H, I], 7 , [A , B, C, D, E, F, S, H, I], S).
put([A, B, C, D, E, F, G, -, I], 8 , [A , B, C, D, E, F, G, S, I], S).
put([A, B, C, D, E, F, G, H, -], 9 , [A , B, C, D, E, F, G, H, S], S).


% Conditions for winning.
win(Board, Sign) :-
   rowwin(Board, Sign),
   winshow(Board, Sign).

win(Board, Sign) :-
   colwin(Board, Sign),
   winshow(Board, Sign).

win(Board, Sign) :-
   diagwin(Board, Sign),
   winshow(Board, Sign).

rowwin([S, S, S, _, _, _, _, _, _], S).
rowwin([_, _, _, S, S, S, _, _, _], S).
rowwin([_, _, _, _, _, _, S, S, S], S).

colwin([S, _, _, S, _, _, S, _, _], S).
colwin([_, S, _, _, S, _, _, S, _], S).
colwin([_, _, S, _, _, S, _, _, S], S).

diagwin([S, _, _, _, S, _, _, _, S], S).
diagwin([_, _, S, _, S, _, S, _, _], S).


% Printed message when a player has won.
winshow(Board, S) :-
   show(Board),
   write(S), write(' win').

% Printed message in case of a draw game.
drawgame(Board) :-
   show(Board),
   write('Draw game...').
