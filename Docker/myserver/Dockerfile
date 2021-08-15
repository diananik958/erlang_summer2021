FROM elixir:latest

COPY ./ .


RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get 
RUN mix compile


CMD iex -S mix Myserver
