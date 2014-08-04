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

