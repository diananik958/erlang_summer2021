-module(task2).
-export([fibonacci/1, factorial/1, is_prime_numb/1, dig_sum/1, flip_num/2]).


fibonacci(Numb) when Numb < 0; is_number(Numb) =/= true -> 
    io:format("Invalid input~n");
fibonacci(0) -> 0;
fibonacci(1) -> 1;
fibonacci(Numb) -> fibonacci(Numb-1)+fibonacci(Numb-2).


factorial(Num) when Num < 0; is_number(Num) =/= true ->
    io:format("Invalid input~n");
factorial(0) -> 1;
factorial(Num) -> Num * factorial(Num - 1).


is_prime_numb(N) -> is_prime_numb(N, 2).

is_prime_numb(N, I) when N < 2; is_number(N) =/= true; is_number(I) =/= true->
    io:format("NO~n");
is_prime_numb(2, 2) -> io:format("YES~n");
is_prime_numb(N, I) -> 
    if 
        N rem I == 0 -> io:format("NO~n");
        I  < N / 2 -> is_prime_numb(N, I + 1);
        true -> io:format("YES~n")
    end.


dig_sum(N) when N < 0; is_number(N) =/= true ->
    io:format("Invalid input~n");
dig_sum(N) -> 
    if 
        N < 10 -> N;
        N >= 10 -> N rem 10 + dig_sum(N div 10);
        true -> io:format("Error")
    end.


flip_num(N, I) when N < 0; is_number(N) =/= true; is_number(I) =/= true ->
    io:format("Invalid input~n");
flip_num(N, I) ->
    if 
        N < 10 -> N;
        N >= 10 -> (N rem 10)*I + flip_num(N div 10, I div 10);
        true -> io:format("Error")
    end.