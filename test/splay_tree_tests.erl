%% @copyright 2013-2014 Takeru Ohta <phjgt308@gmail.com>
%%
-module(splay_tree_tests).

-include_lib("eunit/include/eunit.hrl").

entries() ->
    [{forth, 100},
     {erlang, 10},
     {java, 123},
     {lisp, 3},
     {ruby, 3},
     {python, 30},
     {lisp, 20},
     {java, 0}].

sorted_unique_entires() ->
    [{erlang,10},
     {forth,100},
     {java,0},
     {lisp,20},
     {python,30},
     {ruby,3}].

store_test() ->
    Tree0 = splay_tree:new(),
    ?assertEqual(0, splay_tree:size(Tree0)),

    Tree1 = splay_tree:store(lisp, 3, Tree0),
    ?assertEqual(1, splay_tree:size(Tree1)),

    ?assertMatch({ok, 3}, splay_tree:lookup(lisp, Tree1)).

from_list_test() ->
    Input = entries(),
    Expected = sorted_unique_entires(),

    Tree = splay_tree:from_list(Input),
    ?assertEqual(Expected, splay_tree:to_list(Tree)).

find_test() ->
    ?assertMatch({error, _}, splay_tree:find(erlang, splay_tree:new())),

    Tree0 = splay_tree:from_list(entries()),
    
    ?assertMatch({{ok, 10}, _}, splay_tree:find(erlang, Tree0)),
    {{ok, _}, Tree1} = splay_tree:find(erlang, Tree0),
    
    ?assertMatch({error, _}, splay_tree:find(scala, Tree1)),
    {error, Tree2} = splay_tree:find(scala, Tree1),

    ?assertMatch({{ok, 30}, _}, splay_tree:find(python, Tree2)),
    {{ok, _}, Tree3} = splay_tree:find(python, Tree2),
    io:format("~w\n", [Tree2]),
    io:format("~w", [Tree3]),

    ?assertEqual(sorted_unique_entires(), splay_tree:to_list(Tree3)).

find_largest_test_() ->
    [
     {"finds largest element",
      fun () ->
              Tree = splay_tree:from_list([{5,5}, {1,1}, {3,3}]),
              ?assertMatch({{ok,5,5}, _}, splay_tree:find_largest(Tree))
      end},
     {"empty tree",
      fun () ->
              Empty = splay_tree:new(),
              ?assertEqual({error, Empty}, splay_tree:find_largest(Empty))
      end}
    ].

find_smallest_test_() ->
    [
     {"finds smallest element",
      fun () ->
              Tree = splay_tree:from_list([{5,5}, {1,1}, {3,3}]),
              ?assertMatch({{ok,1,1}, _}, splay_tree:find_smallest(Tree))
      end},
     {"empty tree",
      fun () ->
              Empty = splay_tree:new(),
              ?assertEqual({error, Empty}, splay_tree:find_smallest(Empty))
      end}
    ].

take_largest_test_() ->
    [
     {"takes elements in descending order",
      fun () ->
              Tree0 = splay_tree:from_list([{5,5}, {1,1}, {3,3}]),

              {{ok, Key1, Val1}, Tree1} = splay_tree:take_largest(Tree0),
              ?assertEqual({5,5}, {Key1, Val1}),

              {{ok, Key2, Val2}, Tree2} = splay_tree:take_largest(Tree1),
              ?assertEqual({3,3}, {Key2, Val2}),

              {{ok, Key3, Val3}, Tree3} = splay_tree:take_largest(Tree2),
              ?assertEqual({1,1}, {Key3, Val3}),

              ?assertMatch({error, _}, splay_tree:take_largest(Tree3))
      end}
    ].

take_smallest_test_() ->
    [
     {"takes elements in ascending order",
      fun () ->
              Tree0 = splay_tree:from_list([{5,5}, {1,1}, {3,3}]),

              {{ok, Key1, Val1}, Tree1} = splay_tree:take_smallest(Tree0),
              ?assertEqual({1,1}, {Key1, Val1}),

              {{ok, Key2, Val2}, Tree2} = splay_tree:take_smallest(Tree1),
              ?assertEqual({3,3}, {Key2, Val2}),

              {{ok, Key3, Val3}, Tree3} = splay_tree:take_smallest(Tree2),
              ?assertEqual({5,5}, {Key3, Val3}),

              ?assertMatch({error, _}, splay_tree:take_smallest(Tree3))
      end}
    ].

lookup_test() ->
    Tree0 = splay_tree:from_list(entries()),
    
    ?assertMatch({ok, 10}, splay_tree:lookup(erlang, Tree0)),
    ?assertMatch(error,    splay_tree:lookup(scala, Tree0)),
    ?assertMatch({ok, 30}, splay_tree:lookup(python, Tree0)),
    
    ?assertEqual(sorted_unique_entires(), splay_tree:to_list(Tree0)).

get_value_test() ->
    Tree0 = splay_tree:from_list(entries()),
    
    ?assertMatch(10,   splay_tree:get_value(erlang, Tree0, none)),
    ?assertMatch(none, splay_tree:get_value(scala, Tree0, none)),
    ?assertMatch(30,   splay_tree:get_value(python, Tree0, none)),
    
    ?assertEqual(sorted_unique_entires(), splay_tree:to_list(Tree0)).

erase_test() ->
    Tree0 = splay_tree:from_list(entries()),
    InitialSize = length(sorted_unique_entires()),
    ?assertEqual(InitialSize, splay_tree:size(Tree0)),

    Tree1 = splay_tree:erase(erlang, Tree0),
    ?assertEqual(InitialSize-1, splay_tree:size(Tree1)),
    ?assertEqual(error, splay_tree:lookup(erlang, Tree1)),
    
    Tree2 = splay_tree:erase(scala, Tree1),
    ?assertEqual(InitialSize-1, splay_tree:size(Tree2)),

    Tree3 = splay_tree:erase(python, Tree2),
    ?assertEqual(InitialSize-2, splay_tree:size(Tree3)),
    ?assertEqual(error, splay_tree:lookup(python, Tree3)),

    Tree4 = 
        lists:foldl(fun ({Key, _}, AccTree0) ->
                            AccTree1 = splay_tree:erase(Key, AccTree0),
                            ?assertEqual(error, splay_tree:lookup(Key, AccTree1)),
                            AccTree1
                    end,
                    Tree0,
                    sorted_unique_entires()),
    ?assertEqual(0, splay_tree:size(Tree4)).

update4_test() ->
    Tree0 = splay_tree:from_list(entries()),
    Tree1 = 
        lists:foldl(fun ({Key, Value}, AccTree0) ->
                            UpdateFn = fun (V) -> {V, V} end,
                            AccTree1 = splay_tree:update(Key, UpdateFn, undefined, AccTree0),
                            ?assertEqual({ok, {Value, Value}}, splay_tree:lookup(Key, AccTree1)),
                            AccTree1
                    end,
                    Tree0,
                    sorted_unique_entires()),
    
    Expected = [{K,{V,V}} || {K,V} <- sorted_unique_entires()],
    ?assertEqual(Expected, splay_tree:to_list(Tree1)),
    
    Tree2 = splay_tree:update(scala, fun (V) -> V end, undefined, Tree1),
    ?assertEqual({ok, undefined}, splay_tree:lookup(scala, Tree2)).

update3_test() ->
    Tree0 = splay_tree:from_list(entries()),
    ?assertEqual(error, splay_tree:update(scala, fun (_) -> 300 end, Tree0)),

    Tree1 = splay_tree:update(lisp, fun (_) -> 300 end, Tree0),
    ?assert(Tree1 =/= error),
    ?assertEqual({ok, 300}, splay_tree:lookup(lisp, Tree1)).

filter_test() ->
    Tree0 = splay_tree:from_list(entries()),

    OddTree = splay_tree:filter(fun (_, V) -> V rem 2 =:= 1 end,
                                 Tree0),
    Expected = [{K,V} || {K,V} <- sorted_unique_entires(), V rem 2 =:= 1],

    ?assertEqual(Expected, splay_tree:to_list(OddTree)).

foldl_test() ->
    TreeSum = splay_tree:foldl(fun (_, V, Sum) -> V + Sum end,
                              0,
                               splay_tree:from_list(entries())),
    
    ListSum = lists:foldl(fun ({_, V}, Sum) -> V + Sum end,
                          0,
                          sorted_unique_entires()),
    ?assertEqual(ListSum, TreeSum).

foldr_test() ->
    TreeSum = splay_tree:foldr(fun (_, V, Sum) -> V + Sum end,
                              0,
                               splay_tree:from_list(entries())),
    
    ListSum = lists:foldr(fun ({_, V}, Sum) -> V + Sum end,
                          0,
                          sorted_unique_entires()),
    ?assertEqual(ListSum, TreeSum).

foldl_while_test() ->
    TreeSum = splay_tree:foldl_while(fun (_, V, Sum) -> {Sum < 5, V + Sum} end,
                                     0,
                                     splay_tree:from_list(entries())),

    {_, ListSum} = lists:foldl(fun (_, {Prev, Sum}) when Prev > 5 -> {Prev, Sum};
                                   ({_, V}, {_Prev, Sum}) -> {Sum, V + Sum} end,
                               {0, 0},
                               sorted_unique_entires()),
    ?assertEqual(ListSum, TreeSum).

foldr_while_test() ->
    TreeSum = splay_tree:foldr_while(fun (_, V, Sum) -> {Sum < 5, V + Sum} end,
                                     0,
                                     splay_tree:from_list(entries())),
    
    {_, ListSum} = lists:foldr(fun (_, {Prev, Sum}) when Prev > 5 -> {Prev, Sum};
                                   ({_, V}, {_Prev, Sum}) -> {Sum, V + Sum} end,
                               {0, 0},
                               sorted_unique_entires()),
    ?assertEqual(ListSum, TreeSum).

map_test() ->
    Tree = splay_tree:map(fun (K, V) -> {K, V} end,
                          splay_tree:from_list(entries())),

    Expected = [{K, {K, V}} || {K,V} <- sorted_unique_entires()],

    ?assertEqual(Expected, splay_tree:to_list(Tree)).

large_entries_test() ->
    random:seed(0, 0, 0),

    Entries = dict:to_list(
                dict:from_list(
                  [{random:uniform(), N} || N <- lists:seq(1, 10000)])),
    
    Tree = splay_tree:from_list(Entries),
    
    lists:foreach(fun ({Key, Value}) ->
                          ?assertEqual({ok,Value}, splay_tree:lookup(Key, Tree))
                  end,
                  Entries),
    
    EmptyTree = lists:foldl(fun ({Key, _}, AccTree) ->
                                    splay_tree:erase(Key, AccTree)
                            end,
                            Tree,
                            Entries),
    ?assertEqual(0, splay_tree:size(EmptyTree)).

equal_test() ->
    Tree = splay_tree:from_list([{1.0, one}]),
    ?assertMatch({ok, one}, splay_tree:lookup(1, Tree)).

split_test_() ->
    [
     {"splits by exitings key",
      fun () ->
              List0 = [{1, a}, {2, b}, {3, c}, {4, d}, {5, e}],
              Tree0 = splay_tree:from_list(List0),

              lists:foreach(
                fun (N) ->
                        {ListLeft, ListRight} = lists:split(N-1, List0),
                        {TreeLeft, TreeRight} = splay_tree:split(N, Tree0),
                        ?assertEqual(ListLeft, splay_tree:to_list(TreeLeft)),
                        ?assertEqual(ListRight, splay_tree:to_list(TreeRight))
                end,
                lists:seq(1, length(List0)))
      end},
     {"splits empty tree",
      fun () ->
              Empty = splay_tree:new(),
              ?assertEqual({Empty, Empty}, splay_tree:split(key, Empty))
      end},
     {"splits by non-existing key",
      fun () ->
              List0 = [{1, a}, {2, b}, {3, c}],
              Tree0 = splay_tree:from_list(List0),

              {TreeLeft, TreeRight} = splay_tree:split(2.5, Tree0),
              ?assertEqual([{1, a}, {2, b}], splay_tree:to_list(TreeLeft)),
              ?assertEqual([{3, c}], splay_tree:to_list(TreeRight))
      end}
    ].
