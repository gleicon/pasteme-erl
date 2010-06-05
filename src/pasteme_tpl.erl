%% @author gleicon <gleicon@gmail.com>
%% @copyright 2010 gleicon.

-module (pasteme_tpl).
-export ([start/1, ok/3, pasted/3, pt/3]).

start(TplRoot) ->
	erltl:compile(TplRoot ++ "/ok.tpl", [{outdir, TplRoot},
			       report_errors, report_warnings, nowarn_unused_vars]),
	erltl:compile(TplRoot ++ "/pasted.tpl", [{outdir, TplRoot},
			       report_errors, report_warnings, nowarn_unused_vars]),
	erltl:compile(TplRoot ++ "/pt.tpl", [{outdir, TplRoot},
				       report_errors, report_warnings, nowarn_unused_vars]).

ok(Id, Code, Date) -> ok:render({Id, Code, Date}).
pasted(Id, Code, Date) -> pasted:render({Id, Code, datetime_helper(Date)}).
pt(Id, Code, Date) -> pt:render({Id, Code, datetime_helper(Date)}).

datetime_helper(Local_time) when Local_time == [] -> "nan";
datetime_helper(Local_time) ->       
    {{Year, Month, Day}, {Hour, Min, Sec}} = Local_time,
    lists:flatten(io_lib:fwrite("~2B/~2B/~4..0B ~2B:~2.10.0B:~2.10.0B",
    				[Day, Month, Year, Hour, Min, Sec])).
          


	