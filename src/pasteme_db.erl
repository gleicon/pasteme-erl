%% @author gleicon <gleicon@gmail.com>
%% @copyright 2010 gleicon.

-module (pasteme_db).
-export ([save/1, load/1]).

-define (UNIQUE_ID_REF, "PASTEME:UNIQ").
-define (OBJECT_ID_REF, "PASTEME:OBJID:").

save(Code) ->
	Uid = create_unique_id(),
	Euid = base62:encode(Uid),
	Date = calendar:now_to_datetime(now()), 
	emongo:insert(pasteme_pool, "pasteme", [{id, Uid}, {euid, Euid}, 
						{"code", Code}, {"date", Date}]),
 
	{Euid, Date}.
	
load(Euid) ->
	Id = base62:decode(Euid),
	case lists:flatten(emongo:find(pasteme_pool, "pasteme", [{id, Id}])) of
		[] ->
			not_found;
		Doc ->
			{Euid, proplists:get_value(<<"code">>, Doc), proplists:get_value(<<"date">>, Doc)}
		end.

create_unique_id() ->
    {ok, Client} = erldis:connect("localhost", 6379),
    case erldis:incr(Client, list_to_bitstring(?UNIQUE_ID_REF)) of
            true ->
            	Id2 = 1;
            Id ->
            	Id2 = Id
    end,
    erldis_client:stop(Client),
    Id2.

