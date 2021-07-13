-module(task3).
-export([get_data/2]).

%"Desktop/Erlang/data.csv"

get_data(Count, List) ->
    if 
        (Count > 0) -> 
            {ok, [Name]} = io:fread("Enter name: ", "~s"),
            {ok, [LastName]} = io:fread("Enter last name: ", "~s"),
            {ok, [Age]} = io:fread("Enter age: ", "~s"),
            {ok, [Phone]} = io:fread("Enter phone number: ", "~s"),
            insert_data_into_file(Name++","++LastName++","++Age++","++Phone++"\r\n", "Desktop/Erlang/data.csv"),
            M1 = #{name=>Name,lastname=>LastName,age=>Age,phone=>Phone},
            Data = [M1],
            Full = List ++ Data,
            get_data(Count - 1, Full);
        true -> io:format("~nEnd~n")
    end.


print_data(List) ->
    io:fwrite("~w~n", [List]).
    
    
insert_data_into_file(Data, File) ->
    {ok, F} = file:open(File, [append]),
    io:format(F, "~s", [Data]),
    file:close(Data).