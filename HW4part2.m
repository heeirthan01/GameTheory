%Solving Two-Stage Feedback Game
%Populate Original Policy Combinations
P1Policies = zeros(5,2^5);
P2Policies = zeros(6,2^6);
%0 ->top, 1->bottom

for i=1:size(P1Policies,1)
    flip = 2^(i-1);
    action = 0;
    for j=1:size(P1Policies,2)
        if mod(j-1,flip) == 0 && j~=1
            action = 1-action;
        end
        P1Policies(i,j) = action;
    end
end

%0 ->left, 1->right
for i=1:size(P2Policies,1)
    flip = 2^(i-1);
    action = 0;
    for j=1:size(P2Policies,2)
        if mod(j-1,flip) == 0 && j~=1
            action = 1-action;
        end
        P2Policies(i,j) = action;
    end
end


%% Initialize Tree
treestructhw4;

%% Grab values from policies

Aext = zeros(size(P1Policies,2), size(P2Policies,2));

for i = 1:size(P1Policies,2)
    for j = 1:size(P2Policies,2)
        p1 = P1Policies(:,i);
        p2 = P2Policies(:,j);
        val = getValue(Tree, p1,p2);
        Aext(i,j) = val;
    end
end

%% Check row/col domination
indices = removeRows(Aext); % no dominance
Aext(indices,:) = [];
size(Aext)
indices = removeCols(Aext);
Aext(:,indices) = [];
size(Aext)

%% Pure Policy Computation

% Minimizer
maxes = [];
maxinds = [];
for i=1:size(Aext,1)
    maxcurr = Aext(i,1);
    maxind = 1;
    for j = 2:size(Aext,2)
        if Aext(i,j) > maxcurr
            maxcurr = Aext(i,j);
            maxind = j;
        end
    end
    maxes = [maxes,maxcurr];
    maxinds = [maxinds,maxind];
end
disp('Minimizer value is: ')
[val,ind] = min(maxes);
val
ind

%Maximizer
mins = [];
mininds = [];
for i=1:size(Aext,2)
    mincurr = Aext(1,i);
    minind = 1;
    for j = 2:size(Aext,1)
        if Aext(j,i) < mincurr
            mincurr = Aext(j,i);
            minind = j;
        end
    end
    mins = [mins,mincurr];
    mininds = [mininds,minind];
end
disp('Maximizer value is: ')
[val,ind] = max(mins);
val
ind

%% mixed policy computation
%minimzer
echo on

A = Aext;
cvx_begin
   variables v y(size(A,1))
   minimize v
   subject to
      y >= 0;
      sum(y) == 1;
      A'*y<=v;
cvx_end

echo off

%maximizer
echo on

A = Aext;
cvx_begin
   variables v z(size(A,2))
   maximize v
   subject to
      z >= 0;
      sum(z) == 1;
      A*z>=v;
cvx_end

echo off



%% Functions


function [value] = getValue(Tree,p1plc,p2plc)
    current = 1;
    treestat = false;
    while ~treestat
        if Tree(current).player == 1
            action = p1plc(Tree(current).infoset);
        else
            action = p2plc(Tree(current).infoset);
        end

        if action == 0
            current = Tree(current).L;
        else
            current = Tree(current).R;
        end
        treestat = Tree(current).terminal;
    end
    
    value = Tree(current).value;
end


function [indices] = removeRows(Aext)
    indices = [];
    for i = 1:size(Aext,1)
        query = Aext(i,:);
        for j=1:size(Aext,1)
            if i~=j
                A = Aext(j,:);
                if all(query<A)
                    indices = [indices,j];
                    fprintf('row %d dominated by row %d\n',j,i)
                end
            end
        end
    end
end

function [indices] = removeCols(Aext)
    indices = [];
    for i = 1:size(Aext,2)
        query = Aext(:,i);
        for j=1:size(Aext,2)
            if i~=j
                A = Aext(:,j);
                if all(query>A)
                    indices = [indices,j];
                    fprintf('Col %d dominated by col %d\n',j,i)
                end
            end
        end
    end
    indices = unique(indices);
end

