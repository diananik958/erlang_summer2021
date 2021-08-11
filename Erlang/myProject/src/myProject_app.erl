%%%-------------------------------------------------------------------
%% @doc myProject public API
%% @end
%%%-------------------------------------------------------------------

-module(myProject_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    myProject_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
