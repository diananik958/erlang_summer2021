-module(testserver).
-export([main/0, client/1, get_file/1]).
-compile({no_auto_import,[error/1]}).


formatstring(Elem) ->
    IOList = io_lib:format("~w", [Elem]),
    FlatList = lists:flatten(IOList) -- "[",
    FlatList -- "]".


mysql(Tuple) ->
    {ok, Pid} = mysql:start_link([{host, "localhost"}, {user, "test"},
                                {password, "Test123!"}, {database, "testserver1"}]),
    {{ok, {IPshort, Port}}, {{Year,Month,Day},{Hour,Min,Sec}}, {abs_path, Path}, Method} = Tuple,
    io:fwrite("Path for mysql: ~p~n", [Path]),
    D = formatstring(Year) ++ "-" ++ formatstring(Month) ++ "-" ++ formatstring(Day),
    io:fwrite("Date ~p~n", [D]),
    T = formatstring(Hour) ++ ":" ++ formatstring(Min) ++ ":" ++ formatstring(Sec),
    io:fwrite("Time ~p~n", [T]),
    %% Manipulate data
    ok = mysql:query(Pid, "INSERT INTO server VALUES (?, ?, ?, ?, ?, ?)", [formatstring(IPshort), Port, D, T, Path, formatstring(Method)]),
    io:fwrite("OKKK"),
    mysql:stop(Pid).


read_file(Fname) ->
    {ok, File} = file:read_file(Fname),
    File.


get_file(Fname) ->
    File = read_file(Fname),
    %Content = unicode:characters_to_list(File, unicode),
    %string:len(Content),
    Html = list_to_binary("HTTP/1.1 200 OK\r\nContent-Length: " ++ integer_to_list(byte_size(File)) ++ "\r\n\r\n" ++ File),
    Html.


error(Type) ->
    case Type of
        404 -> get_file("html/404.html");
        500 -> get_file("html/500.html");
        _ -> get_file("html/unknown.html")
    end.


handle_get(ReqPath) ->
    {abs_path, RelPath} = ReqPath,
    Parameters = string:substr(RelPath, string:str(RelPath, "?") + 1),
    ParsedParms = uri_string:dissect_query(Parameters),
    io:fwrite("Full Path: ~p~nParameters: ~p~n", [RelPath, ParsedParms]).


send_file(ReqPath) ->
    {abs_path, RelPath} = ReqPath,
    case (RelPath) of
        "/" -> get_file("html/index.html");
        _ -> error(404)
    end.


client(Socket) ->
    {ok, {http_request, Method, Path, _Version}} = gen_tcp:recv(Socket, 0),
    io:fwrite("Method: ~p~nPath: ~p~nVersion: ~p~n", [Method, Path, _Version]),
    Html = send_file(Path),
    IP = inet:peername(Socket),
    gen_tcp:send(Socket, Html),
    gen_tcp:close(Socket),
    case (Method) of
        'GET' ->
            DateTime = erlang:localtime_to_universaltime(erlang:localtime()), %forman: {1996,11,6},{14,45,17}
            io:fwrite("IP: ~p~n", [IP]),
            Tuple = {IP, DateTime, Path, Method},
            mysql(Tuple),
            handle_get(Path);
        _ -> 
            error(500)
    end.


server(ServerSocket) ->
    {ok, Socket} = gen_tcp:accept(ServerSocket),
    try erlang:is_pid(spawn(testserver, client, [Socket])) of
        true -> server(ServerSocket);
        false -> erlang:throw("Not PID")
    catch
        TypeError:Reason -> io:format("~p~n~p~n", [TypeError, Reason])
    end.


main() ->
    {ok, ServerSocket} = gen_tcp:listen(8080, [list, {active, false}, {packet, http}, {reuseaddr, true}]),
    server(ServerSocket).
