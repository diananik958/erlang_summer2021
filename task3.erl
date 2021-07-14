-module(task3).
-export([get_users/0, get_data/1, read_data/1, get_age_more_than/2]).
%"Desktop/Erlang/data.csv"

%Creates list for filter
get_users() ->
    [{user, 1, "Elena Ivanova", 35, "89134567896"},
    {user, 2, "Ivan Vasin", 25, "89134561234"},
    {user, 3, "Bob White", 15, "89134564321"},
    {user, 4, "Rain Smith", 45, "89134563456"},
    {user, 5, "Paul Mitchel", 30, "89134566543"}].


%Adds data that was entered on keybord to map
get_data(Count) -> get_data(Count, []).

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
    
%Inserts data to file    
insert_data_into_file(Data, File) ->
    {ok, F} = file:open(File, [append]),
    io:format(F, "~s", [Data]),
    file:close(Data).


%filteres users by age more than <Value>
get_age_more_than(Users, Value) -> get_age_more_than(Users, Value, []).

get_age_more_than([], Value, Storage) -> lists:reverse(Storage);

get_age_more_than([User|Tail], Value, Storage) ->
    {user, _, _, Age, _} = User,
    if 
        Age > Value -> get_age_more_than(Tail, Value, [User|Storage]);
        true -> get_age_more_than(Tail, Value, Storage)
    end.


    