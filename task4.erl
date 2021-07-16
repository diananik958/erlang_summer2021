-module(task4).
-export([readLines/1, read_data/1]).


read_data(File) ->
    Table = ets:new(tab, []),
    {ok, Device} = file:open(File, [read]),
    try get_lines(Device, Table)
        after file:close(Device)
    end.
        
   
get_lines(Device, Table) ->
    case io:get_line(Device, "") of
        eof -> ok;    
        Line -> 
            Elem = string:split(Line,",",all),
            Tuple = list_to_tuple(Elem),
            ets:insert(Table, [Tuple]),
            get_lines(Device, Table),
            ets:lookup(Table, "20")
    end.

%"Desktop/Erlang/data.csv"