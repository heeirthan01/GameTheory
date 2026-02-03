%% Create Tree 

Tree = struct( ...
    'terminal', {}, ...
    'player', {}, ...
    'infoset', {}, ...
    'L', {}, ...
    'R', {}, ...
    'value', {} ...
    );

Tree(1).terminal = false;
Tree(1).player = 1;
Tree(1).infoset = 1;
Tree(1).L = 2;
Tree(1).R = 3;
Tree(1).value = [];

Tree(2).terminal = false;
Tree(2).player = 2;
Tree(2).infoset = 1;
Tree(2).L = 4;
Tree(2).R = 5;
Tree(2).value = [];

Tree(3).terminal = false;
Tree(3).player = 2;
Tree(3).infoset = 1;
Tree(3).L = 6;
Tree(3).R = 7;
Tree(3).value = [];

Tree(4).terminal = false;
Tree(4).player = 1;
Tree(4).infoset = 2;
Tree(4).L = 8;
Tree(4).R = 9;
Tree(4).value = [];

Tree(5).terminal = false;
Tree(5).player = 1;
Tree(5).infoset = 3;
Tree(5).L = 10;
Tree(5).R = 11;
Tree(5).value = [];

Tree(6).terminal = false;
Tree(6).player = 1;
Tree(6).infoset = 4;
Tree(6).L = 12;
Tree(6).R = 13;
Tree(6).value = [];

Tree(7).terminal = false;
Tree(7).player = 1;
Tree(7).infoset = 5;
Tree(7).L = 14;
Tree(7).R = 15;
Tree(7).value = [];

Tree(8).terminal = false;
Tree(8).player = 2;
Tree(8).infoset = 2;
Tree(8).L = 16;
Tree(8).R = 17;
Tree(8).value = [];

Tree(9).terminal = false;
Tree(9).player = 2;
Tree(9).infoset = 2;
Tree(9).L = 18;
Tree(9).R = 19;
Tree(9).value = [];

Tree(10).terminal = false;
Tree(10).player = 2;
Tree(10).infoset = 3;
Tree(10).L = 20;
Tree(10).R = 21;
Tree(10).value = [];

Tree(11).terminal = false;
Tree(11).player = 2;
Tree(11).infoset = 4;
Tree(11).L = 22;
Tree(11).R = 23;
Tree(11).value = [];

Tree(12).terminal = false;
Tree(12).player = 2;
Tree(12).infoset = 5;
Tree(12).L = 24;
Tree(12).R = 25;
Tree(12).value = [];

Tree(13).terminal = false;
Tree(13).player = 2;
Tree(13).infoset = 5;
Tree(13).L = 26;
Tree(13).R = 27;
Tree(13).value = [];

Tree(14).terminal = false;
Tree(14).player = 2;
Tree(14).infoset = 6;
Tree(14).L = 28;
Tree(14).R = 29;
Tree(14).value = [];

Tree(15).terminal = false;
Tree(15).player = 2;
Tree(15).infoset = 6;
Tree(15).L = 30;
Tree(15).R = 31;
Tree(15).value = [];

Tree(16).terminal = true;
Tree(16).value = 1;

Tree(17).terminal = true;
Tree(17).value = -1;

Tree(18).terminal = true;
Tree(18).value = 1;

Tree(19).terminal = true;
Tree(19).value = -1;

Tree(20).terminal = true;
Tree(20).value = -2;

Tree(21).terminal = true;
Tree(21).value = -1;

Tree(22).terminal = true;
Tree(22).value = 1;

Tree(23).terminal = true;
Tree(23).value = -1;

Tree(24).terminal = true;
Tree(24).value = -1;

Tree(25).terminal = true;
Tree(25).value = -3;

Tree(26).terminal = true;
Tree(26).value = -3;

Tree(27).terminal = true;
Tree(27).value = -1;

Tree(28).terminal = true;
Tree(28).value = -1;

Tree(29).terminal = true;
Tree(29).value = 2;

Tree(30).terminal = true;
Tree(30).value = -1;

Tree(31).terminal = true;
Tree(31).value = 2;