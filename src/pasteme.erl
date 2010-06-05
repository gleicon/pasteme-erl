%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc TEMPLATE.

-module(pasteme).
-author('gleicon <gleicon@gmail.com>').
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @spec start() -> ok
%% @doc Start the pasteme server.
start() ->
    pasteme_deps:ensure(),
    ensure_started(crypto),
	ensure_started(emongo),
	emongo:add_pool(pasteme_pool, "localhost", 27017, "pasteme", 1),
    application:start(pasteme).

%% @spec stop() -> ok
%% @doc Stop the pasteme server.
stop() ->
    Res = application:stop(pasteme),
	aplication:stop(emongo),
    application:stop(crypto),
    Res.
