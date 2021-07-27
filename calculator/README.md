$ erl -sname client1 -setcookie calc
Erlang/OTP 22 [erts-10.6.4] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Eshell V10.6.4  (abort with ^G)

(client1@linux)1> Cl = {client2, 'client2@linux'}.
{client2,client2@linux}
(client1@linux)2> Cl ! {self(), [sqrt, 1024]}.
{<0.85.0>,[sqrt,1024]}
(client1@linux)3> flush().
Shell got 32.0
ok
(client1@linux)4> Cl ! {self(), [sin, 0]}.    
{<0.85.0>,[sin,0]}
(client1@linux)5> flush().
Shell got 0.0
ok
(client1@linux)6> Cl ! {self(), [pow, 2, 8]}.
{<0.85.0>,[pow,2,8]}
(client1@linux)7> flush().
Shell got 256.0
ok



$ erl -sname client2 -setcookie calc
Erlang/OTP 22 [erts-10.6.4] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Eshell V10.6.4  (abort with ^G)

(client2@linux)1> register(client2, self()).
true
(client2@linux)2> c(node_calc).
Recompiling /home/diana/Desktop/Erlang/node_calc.erl
{ok,node_calc}
(client2@linux)3> node_calc:calculator().
sqrt
sin
pow