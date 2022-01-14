% question 1 maze 2

% block 1,5
block((1,5), (2,5)).
block((1,5), (1,4)).

% block 1,4
block((1,4), (1,5)).
block((1,4), (2,4)).
block((1,4), (1,3)).

% block 1,3
block((1,3), (1,4)).
block((1,3), (1,2)).

% block 1,2
block((1,2), (1,3)).
block((1,2), (2,2)).
block((1,2), (1,1)).

% block 1,1
block((1,1), (1,2)).
block((1,1), (2,1)).

% block 2,5
block((2,5), (1,5)).
block((2,5), (2,4)).
block((2,5), (3,5)).

% block 2,4
block((2,4), (2,5)).
block((2,4), (1,4)).

% block 2,2 
block((2,2), (1,2)).
block((2,2), (2,1)).
block((2,2), (3,2)).

% block 2,1 
block((2,1), (1,1)).
block((2,1), (2,2)).
block((2,1), (3,1)).

% block 3,5
block((3,5), (2,5)).
block((3,5), (4,5)).

% block 3,2
block((3,2), (2,2)).
block((3,2), (3,1)).
block((3,2), (4,2)).

% block 3,1
block((3,1), (2,1)).
block((3,1), (3,2)).
block((3,1), (4,1)).

% block 4,5
block((4,5), (3,5)).
block((4,5), (5,5)).

% block 4,3
block((4,3), (4,2)).

% block 4,2
block((4,2), (4,3)).
block((4,2), (3,2)).
block((4,2), (4,1)).

% block 4,1
block((4,1), (3,1)).
block((4,1), (4,2)).
block((4,1), (5,1)).

% block 5,5
block((5,5), (4,5)).
block((5,5), (6,5)).

% block 5,1
block((5,1), (4,1)).
block((5,1), (6,1)).

% block 6,5
block((6,5), (5,5)).
block((6,5), (6,4)).

% block 6,4
block((6,4), (6,5)).
block((6,4), (6,3)).

% block 6,3
block((6,3), (6,4)).
block((6,3), (6,2)).

% block 6,2
block((6,2), (6,3)).
block((6,2), (6,1)).

% block 6,1
block((6,1), (6,2)).
block((6,1), (5,1)).

goal((2,4)).


%solve(N, []) :-  goal(N).
%solve(N, [N1 | S1]) :- edge(N, N1), solve(N1, S1).

%%
solve(Node, Solution) :- depthfirst([], Node, Solution).


%%
depthfirst(Path, Node, [Node | Path]) :- goal(Node).

depthfirst(Path, Node, Sol) :-
	block(Node, Node1),
	%write(Node), write(Node1), write(Path),
	not(member(Node1, Path)),
	depthfirst([Node | Path], Node1, Sol).
