%% @author gleicon <gleicon@gmail.com>
%% @copyright 2010 gleicon.

-module(pasteme_rest).
-export([get_resource/1]).

parse_uri(URI) ->
    case string:tokens(URI, "/") of
        [H|T] -> {H, T};
        [] -> {"home", URI};
        _ -> {"error", URI}
    end.

get_resource(URI) ->
    {Resource, T} = parse_uri(URI),
    case list_to_atom(Resource) of 
            p -> {p, T};
			static -> {static, T};
			css -> {css, T};
            paste -> paste;
            error -> error;
            _ -> home
    end.    
