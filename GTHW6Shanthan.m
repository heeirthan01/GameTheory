%% Sudoku Game with improvement paths
clear;
clc;
close;

N = 81; % no of players
no_sims = 10000;

board = [5,3,0,0,7,0,0,0,0;
         6,0,0,1,9,5,0,0,0;
         0,9,8,0,0,0,0,6,0;
         8,0,9,0,6,0,0,0,3;
         4,0,0,8,5,3,0,0,1;
         7,0,0,9,2,0,0,5,6;
         0,6,0,0,0,0,2,8,0
         0,0,0,4,1,9,0,3,5;
         0,0,0,0,8,0,0,7,9];

actionspace = getactionSpace(board); %Initialize action space
best_As = zeros(9,9,no_sims);
best_Js = zeros(9,9,no_sims);
potentials = zeros(no_sims,1);

for i = 1:no_sims
    A = zeros(size(board));
    for k=1:N
        A(k) = actionspace{k}(randi(length(actionspace{k}))); %initial acitons
    end
    
    [best_A, Jbest, steps] = improvementPath(A, actionspace);
    best_As(:,:,i) = best_A;
    best_Js(:,:,i) = Jbest;
    potential = getPotential(Jbest);
    potentials(i) = potential;
    if potential == 0
        fprintf('Minimum potential found at sim %d!', i)
    end
end

histogram(potentials)
title(['Histogram for ', num2str(no_sims),' runs'])


function [actionSpace] = getactionSpace(board)
    actionSpace = cell(size(board));
    for row = 1:size(board,1)
        for col = 1:size(board,2)
            if board(row,col) ~= 0
                actionSpace{row,col} = board(row,col); %no action needed
            else
                rowact = setdiff((1:9),board(row,:));
                colact = setdiff((1:9),board(:,col));
                
                rowindB = 3*floor((row-1)/3) + (1:3);
                colindB = 3*floor((col-1)/3) + (1:3);
                block = board(rowindB,colindB);
                blockact = setdiff((1:9), block);

                intersectrb = intersect(rowact, colact);
                intersectall = intersect(intersectrb,blockact);

                actionSpace{row,col} = intersectall;
            end
        end
    end
end

function [Jcost] = getCost(board)
    %board populated with nominal actions per player
    Jcost = zeros(size(board));
    for row = 1:size(board,1)
        for col= 1:size(board,2)
            rowset = board(row,:);
            [~,~,idx] = unique(rowset);
            counts = accumarray(idx,1);
            rowcost = sum(counts-1);

            colset = board(:,col);
            [~,~,idx] = unique(colset);
            counts = accumarray(idx,1);
            colcost = sum(counts-1);

            rowindB = 3*floor((row-1)/3) + (1:3);
            colindB = 3*floor((col-1)/3) + (1:3);
            block = board(rowindB,colindB);
            [~,~,idx] = unique(block);
            counts = accumarray(idx,1);
            blockcost = sum(counts-1);

            Jcost(row,col) = rowcost + colcost + blockcost;
        end
    end
end

function [potential] = getPotential(Jcost)
    potential = sum(Jcost(:))/9;
end

function [best_A,Jbest, steps] = improvementPath(A,actionspace)
    N = size(A,1)*size(A,2);
    Jbest = getCost(A);
    total_players = linspace(1,N,N);
    best_A = A;
    no_improvement = 0; %False
    steps = 0;


    while (no_improvement == 0)
        %stages in improvemtn
        steps = steps + 1;
        advanced = 0;

        tested_players = [];
        %checking every player
        for i = 1:N
            query_player = randi(N);
            avl_players = setdiff(total_players,tested_players);
            while (~ismember(query_player, avl_players))
                query_player = randi(N);
            end
            tested_players = [tested_players,query_player];

            %Generat action of random guy
            A_check = best_A;
            query_action = actionspace{query_player}(randi(length(actionspace{query_player})));

            A_check(query_player) = query_action; %check only that action
            Jquery = getCost(A_check);
            

            if Jquery(query_player) < Jbest(query_player)
                %fprintf('Success, %d better than %d\n', Jquery(query_player),Jbest(query_player))
                Jbest = Jquery;
                best_A = A_check;
                advanced = 1;
                break;
            end
        end
        if advanced == 0
            %if we get here, no further improvement and done.
            no_improvement = 1;
            %disp('No further improvement')
        end

    end

end
