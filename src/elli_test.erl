%%% @author Andreas Hasselberg <andreas.hasselberg@gmail.com>
%%%
%%% @doc Helper for calling your Elli callback in unit tests.
%%% Only the callback specified is actually run. Elli's response handling is not
%%% used, so the headers will for example not include a content length and the
%%% return format is not standardized.
%%% The unit tests below test `elli_example_callback'.

-module(elli_test).

-include("elli.hrl").

-export([call/5]).

-spec call(Method, Path, Headers, Body, Opts) -> elli_handler:result() when
      Method  :: elli:http_method(),
      Path    :: binary(),
      Headers :: elli:headers(),
      Body    :: elli:body(),
      Opts    :: proplists:proplist().
call(Method, Path, Headers, Body, Opts) ->
    Callback     = proplists:get_value(callback, Opts),
    CallbackArgs = proplists:get_value(callback_args, Opts),
    Req = elli_http:mk_req(Method, {abs_path, Path}, Headers, Headers,
                           Body, {1, 1}, undefined, {Callback, CallbackArgs}),
    ok  = Callback:handle_event(elli_startup, [], CallbackArgs),
    Callback:handle(Req, CallbackArgs).
