splay_tree (0.2.4)
==================

An implementation of [SplayTree](http://en.wikipedia.org/wiki/Splay_tree) in Erlang.


QuickStart
----------

```sh
# clone
$ git clone git://github.com/sile/erl-splay-tree.git splay_tree
$ cd splay_tree

# If you want to use HiPE enabled version, please execute following command.
# $ git checkout hipe

# compile
$ make compile

# run tests
$ make eunit

# dialyze
$ make dialyze

# Erlang shell
$ make start
1> Tree0 = splay_tree:new().
nil

2> Tree1 = splay_tree:store(key, value, Tree0).
{key, value}.

3> splay_tree:to_list(Tree1).
[{key,value}]
```


API
---

See [EDoc Document](doc/splay_tree.md)


Usage Example
-------------

```erlang
%% create
> Tree0 = splay_tree:new().
nil

%% store
> Tree1 = splay_tree:store(1, one, Tree0).
{1,one}.

> Tree2 = splay_tree:store(2, two, Tree1).
{2,two,{1,one},nil}

%% loopup
> splay_tree:lookup(1, Tree2).
{ok,one}

> splay_tree:lookup(3, Tree2).
error

%% find: find/2 adjusts tree structure
> splay_tree:find(1, Tree2).
{{ok,one}, {1,one,nil,{2,two}}}

> splay_tree:find(3, Tree2).
{error, {2,two,{1,one},nil}}

%% largest/smallest
> splay_tree:find_largest(Tree2).
{{ok,2,two}, {2,two,{1,one},nil}}

> splay_tree:take_largest(Tree2).
{{ok,2,two}, {1,one}}

%% to list
> splay_tree:to_list(Tree2).
[{1,one},{2,two}]

%% from list
> Tree3 = splay_tree:from_list([{1, one}, {2, two}, {3, trhee}]).
{3,trhee,{2,two,{1,one},nil},nil}

%% split
> splay_tree:split(2, Tree3).
{{1,one},               % less than
 {2,two,nil,{3,trhee}}} % greater than or equal to

> splay_tree:split(2.5, Tree3).
{{2,two,{1,one},nil}, % less than
 {3,trhee}}           % greater than or equal to

%% fold
> splay_tree:foldl(fun (Key, _, Sum) -> Key + Sum end, 0, Tree3).
6
```
