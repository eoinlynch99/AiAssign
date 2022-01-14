% question 3 maze 2

% block 1,5
block((1,5), (2,5),1).
block((1,5), (1,4),1).

% block 1,4
block((1,4), (1,5),1).
block((1,4), (2,4),1).
block((1,4), (1,3),1).

% block 1,3
block((1,3), (1,4),1).
block((1,3), (1,2),1).

% block 1,2
block((1,2), (1,3),1).
block((1,2), (2,2),1).
block((1,2), (1,1),1).

% block 1,1
block((1,1), (1,2),1).
block((1,1), (2,1),1).

% block 2,5
block((2,5), (1,5),1).
block((2,5), (2,4),1).
block((2,5), (3,5),1).

% block 2,4
block((2,4), (2,5),1).
block((2,4), (1,4),1).

% block 2,2 
block((2,2), (1,2),1).
block((2,2), (2,1),1).
block((2,2), (3,2),1).

% block 2,1 
block((2,1), (1,1),1).
block((2,1), (2,2),1).
block((2,1), (3,1),1).

% block 3,5
block((3,5), (2,5),1).
block((3,5), (4,5),1).

% block 3,2
block((3,2), (2,2),1).
block((3,2), (3,1),1).
block((3,2), (4,2),1).

% block 3,1
block((3,1), (2,1),1).
block((3,1), (3,2),1).
block((3,1), (4,1),1).

% block 4,5
block((4,5), (3,5),1).
block((4,5), (5,5),1).

% block 4,3
block((4,3), (4,2),1).

% block 4,2
block((4,2), (4,3),1).
block((4,2), (3,2),1).
block((4,2), (4,1),1).

% block 4,1
block((4,1), (3,1),1).
block((4,1), (4,2),1).
block((4,1), (5,1),1).

% block 5,5
block((5,5), (4,5),1).
block((5,5), (6,5),1).

% block 5,1
block((5,1), (4,1),1).
block((5,1), (6,1),1).

% block 6,5
block((6,5), (5,5),1).
block((6,5), (6,4),1).

% block 6,4
block((6,4), (6,5),1).
block((6,4), (6,3),1).

% block 6,3
block((6,3), (6,4),1).
block((6,3), (6,2),1).

% block 6,2
block((6,2), (6,3),1).
block((6,2), (6,1),1).

% block 6,1
block((6,1), (6,2),1).
block((6,1), (5,1),1).

h((1,5), 1).
h((1,4), 1).
h((1,3), 1).
h((1,2), 1).
h((1,1), 1).
h((2,5), 1).
h((2,4), 1).
h((2,2), 1).
h((2,1), 1).
h((3,5), 1).
h((3,2), 1).
h((3,1), 1).
h((4,5), 1).
h((4,3), 1).
h((4,2), 1).
h((4,1), 1).
h((5,5), 1).
h((5,1), 1).
h((6,5), 1).
h((6,4), 1).
h((6,3), 1).
h((6,2), 1).
h((6,1), 1).

goal((2,4)).


move_astar([Node|Path]/G_val/_, [NextNode,Node|Path]/NewG_val/NewH_val) :-
 	block(Node, NextNode, StepCost),
    not(member(NextNode, Path)),
    NewG_val is G_val + StepCost,
    h(NextNode, NewH_val).

expand_astar(Path, ExpPaths) :-
    findall(NewPath, move_astar(Path,NewPath), ExpPaths).

%%
get_best([Path], Path) :- !.

get_best([Path1/Cost1/Est1,_/Cost2/Est2|Paths], BestPath) :-
  	Cost1 + Est1 =< Cost2 + Est2, !,
  	get_best([Path1/Cost1/Est1|Paths], BestPath).

get_best([_|Paths], BestPath) :-
  	get_best(Paths, BestPath).


%%
solve_astar(Node, Path/Cost) :-
     h(Node, Estimate),
     astar([[Node]/0/Estimate], RevPath/Cost/_),
     reverse(RevPath, Path).

% If best path reaches goal node - terminate.
%
astar(Paths, Path) :-
     get_best(Paths, Path),
     Path = [Node|_]/_/_,
     goal(Node).

% Otherwise expand best path
%
astar(Paths, SolutionPath) :-
     get_best(Paths, BestPath),
     select(BestPath, Paths, OtherPaths), %OtherPaths is the remainder of the list when BestPath is removed
     expand_astar(BestPath, ExpPaths),
     append(OtherPaths, ExpPaths, NewPaths),
     astar(NewPaths, SolutionPath).
