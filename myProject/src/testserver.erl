-module(testserver).
-export([main/0, client/1, get_file/1]).
-compile({no_auto_import,[error/1]}).

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
    ParsedParms = httpd:parse_query(Parameters),
    io:fwrite("Full Path: ~p~nParameters: ~p~n", [RelPath, ParsedParms]).


send_file(ReqPath) ->
    {abs_path, RelPath} = ReqPath,
    case (RelPath) of
        "/" -> get_file("html/index.html");
        _ -> error(404)
    end.


client(Socket) ->
    {ok, {http_request, Method, Path, _Version}} = gen_tcp:recv(Socket, 0),
    Html = send_file(Path),
    gen_tcp:send(Socket, Html),
    gen_tcp:close(Socket),
    case (Method) of
        'GET' ->
            handle_get(Path);
        _ -> 
            error(500)
    end.


server(ServerSocket) ->
    {ok, Socket} = gen_tcp:accept(ServerSocket),
    spawn(testserver, client, [Socket]),
    server(ServerSocket).


main() ->
    {ok, ServerSocket} = gen_tcp:listen(8080, [binary, {active, false}, {packet, http}, {reuseaddr, true}]),
    server(ServerSocket).
