FROM elixir:1.6.1
MAINTAINER Matthew Caldwell <caldwellysr@gmail.com>

WORKDIR /code/tennis

RUN mix local.rebar --force
RUN mix local.hex --force
RUN apt-get update && apt-get install -y inotify-tools

EXPOSE 4001

CMD mix deps.get && elixir --sname tennis --cookie somecookie --erl "-config sys.config" -S mix phx.server
