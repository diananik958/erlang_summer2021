 -module(person).
-export([info/0]).


info() ->
    Map = #{first=>{mike, hemings, 24, +76547893456}, second=>{nina, black, 20, +78767658945}},
    io:fwrite("The person is "),
    maps:get(first, Map).