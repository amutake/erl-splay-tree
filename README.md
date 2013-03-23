# README
## 概要
* スプレー木のErlang実装
* スプレー木
　* http://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%97%E3%83%AC%E3%83%BC%E6%9C%A8

## バージョン
* 0.0.3

## API
#### splay_tree:new() -> Tree

    空のスプレー木を作成する


#### splay_tree:size(Tree) -> Size

    木に格納されている要素数を返す


#### splay_tree:store(Key, Value, Tree) -> NewTree

    木に要素を挿入する。既にKeyに対応する要素が存在する場合は、その値が更新される。


#### splay_tree:update(Key, Fun, Initial, Tree) -> NewTree

    木の要素を以下のルールに従い、更新する。
     a] Keyに対応する要素がない場合: Initialを値とする要素を追加する
     b] Keyに対応する要素がある場合: Fun(既存の値)を適用し、その返り値で要素の値を更新する


#### splay_tree:find(Key, Tree) -> {{ok,Value}, NewTree} | {error, NewTree}

    Keyに対応する要素の値を検索する。
    ※ スプレー木では、要素検索時にも木のリバランシングが行われるため、新しい木が返り値に含まれる

#### splay_tree:lookup(Key, Tree) -> {ok,Value} | error

    Keyに対応する要素の値を検索する。

#### splay_tree:get_value(Key, Tree, DefaultValue) -> Value

    Keyに対応する要素の値を返す。要素が存在しない場合は DefaultValue が返される。

#### splay_tree:erase(Key, Tree) -> NewTree

    Keyに対応する要素を木から削除する。

##### splay_tree:from_list(KeyValueList) -> Tree

    {Key,Value}を要素とするリストから、スプレー木を生成する。
    ※ Keyが重複する要素がある場合は、後に出現するものの値が使用される


#### splay_tree:to_list(Tree) -> KeyValueList

    木を{Key,Value}形式のリストに変換する。
    リスト内の要素はKeyの昇順にソートされている。


#### splay_tree:map(Fun, Tree) -> NewTree

    木の全ての要素にFun(Key,Value)を適用し、その結果で各要素の値を更新する。

#### splay_tree:filter(Pred, Tree) -> NewTree

    木の全ての要素に述語関数Pred(Key,Value)を適用し、結果がfalseとなった要素を木から除去する

#### splay_tree:fold(Fun, Acc0, Tree) -> Acc

    木の要素の畳み込みを行う。
    畳み込み:
     1] 木の始めの要素に対してFun(Key, Value, Acc0)を適用する
     2] 二番目以降の要素に対してFun(Key, Value, 一つ前の適用結果)を実行する
     3] 一番最後に要素に対する適用結果がAccとなり、fold関数呼び出し元に返される
     ※ 要素の走査順はキーの値の昇順