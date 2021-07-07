-module(information).
-export([get_data/0]).


get_data() -> 
    P1 = {mike, mitchel, 25, +79134567685},
    io:fwrite("~w~n", [P1]).