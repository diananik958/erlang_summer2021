-module(node_calc).
-export([calculator/0]).


handle3(Operation, Value, To) ->
    case Operation of 
        pow -> math:pow(Value, To);
        _ -> io:format("Wrong operation or digits~n")
    end.


handle2(Operation, Value) ->
    case Operation of 
        sqrt -> math:sqrt(Value);
        log2 -> math:log2(Value);
        sin -> math:sin(Value);
        _ -> io:format("Wrong operation or digits~n")
    end.


calculator() ->
    receive
        {From, [Message, Value]} ->
            io:format("~p~n", [Message]),
            From ! handle2(Message, Value),
            calculator();
        {From, [Message, Value1, Value2]} ->
            io:format("~p~n", [Message]),
            From ! handle3(Message, Value1, Value2),
            calculator();
        _ -> io:format("Error~n")
    end.
