-module(task3-parser).
-export([open_file/1]).
-export([parse_data/1]).

%"Desktop/Erlang/data.csv"

open_file(File) ->
    {ok, Data}=file:read_file(File),
    io:format(Data).
    parse_data(Data).

parse_data(Data) ->
    

    file:close(Data).
