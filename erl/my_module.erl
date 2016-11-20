%% This is a simple Erlang module

-module(my_module).

-export([pie/0]).
-export([print/1]).
-export([either_or_both/2]).

pie() ->
    3.14.


print(Term) ->
  io:format("The value of Term is ~p.~n", [Term]).


either_or_both(true, _) ->
  true;
either_or_both(_, true) ->
  true;
either_or_both(false, false) ->
  false.


