%% @author gleicon <gleicon@gmail.com>
%% @copyright 2010 gleicon.

%% @doc Web server for pasteme.

-module(pasteme_web).
-author('gleicon <gleicon@gmail.com>').

-export([start/1, stop/0, loop/2]).
-define(SERVERNAME, "http://localhost:8000").

%% External API

start(Options) ->
    {DocRoot, Options1} = get_option(docroot, Options),
    Loop = fun (Req) ->
                   ?MODULE:loop(Req, DocRoot)
           end,
    pasteme_tpl:start(DocRoot),
    mochiweb_http:start([{name, ?MODULE}, {loop, Loop} | Options1]).

stop() ->
    mochiweb_http:stop(?MODULE).

loop(Req, DocRoot) ->
    "/" ++ Path = Req:get(path),
    case Req:get(method) of
        Method when Method =:= 'GET'; Method =:= 'HEAD' ->
            case pasteme_rest:get_resource(Path) of
				{p, Id} ->
					case pasteme_db:load(lists:flatten(Id)) of 
						{Euid, Code, Date} -> 
							pasteme_db:load(lists:flatten(Id)),
							Req:ok({"text/html", [], pasteme_tpl:ok(Euid, Code, Date)});
						_ ->
							Req:not_found()
						end;
				home ->
					Req:serve_file("index.html", DocRoot);
				{static, File} ->
					Req:serve_file(string:join(File, "/"), DocRoot);
				_ ->
                    Req:not_found()
            end;

        'POST' ->
            case pasteme_rest:get_resource(Path) of
            	paste ->
					Params = Req:parse_post(),
					Code = proplists:get_value("code", Params),
					{Euid, _} = pasteme_db:save(Code),
					Req:respond({302, [{"Location", ?SERVERNAME++"/p/"++Euid}, {"Content-Type", "text/html; charset=UTF-8"}],""});
		    	_ ->
                    Req:not_found()
            end;
        _ ->
            Req:respond({501, [], []})
    end.

%% Internal API

get_option(Option, Options) ->
    {proplists:get_value(Option, Options), proplists:delete(Option, Options)}.


%%
%% Tests
%%
-include_lib("eunit/include/eunit.hrl").
-ifdef(TEST).
-endif.
