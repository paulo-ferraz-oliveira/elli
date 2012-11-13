
-type callback_mod() :: module().
-type callback_args() :: any().
-type callback() :: {callback_mod(), callback_args()}.

-type path() :: binary().
-type args() :: binary().
-type version() :: {0,9} | {1,0} | {1,1}.
-type header() :: {Key::binary(), Value::binary() | string()}.
-type headers() :: [header()].
-type body() :: binary() | iolist().
-type response() :: iolist().
-type http_method() :: 'OPTIONS' | 'GET' | 'HEAD' | 'POST' |
                       'PUT' | 'DELETE' | 'TRACE'.
-type response_code() :: 100..999.
-type connection_token_atom() :: keep_alive | close.

-type byte_range() :: {First::non_neg_integer(), Last::non_neg_integer()} |
                      {offset, Offset::non_neg_integer()} |
                      {suffix, Length::pos_integer()}.
-type byte_range_set() :: [byte_range()].

-type normalized_range() :: {Offset::non_neg_integer(), Length::non_neg_integer()}.

-type file_opt() :: {size, non_neg_integer()} | {range, normalized_range()}.
-type file_opts() :: [file_opt()].

-define(l2i(L), list_to_integer(L)).
-define(i2l(I), integer_to_list(I)).
-define(b2i(I), list_to_integer(binary_to_list(I))).

-type timestamp() :: {integer(), integer(), integer()}.


-record(state, {socket,
                acceptors,
                open_reqs,
                options,
                callback :: callback()
}).

-record(req, {
          method :: http_method(),
          path :: [binary()],
          args :: [{binary(), any()}],
          raw_path :: binary(),
          version :: version(),
          headers :: headers(),
          body :: body(),
          pid :: pid(),
          socket :: inet:socket()
}).

-define(EXAMPLE_CONF, [{callback, elli_example_callback},
                       {callback_args, []}]).
