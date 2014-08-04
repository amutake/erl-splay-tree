

# Module splay_tree #
* [Description](#description)
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)


SplayTree.
Copyright (c) 2013 Takeru Ohta <phjgt308@gmail.com>


<a name="types"></a>

## Data Types ##




### <a name="type-fold_fn">fold_fn()</a> ###



<pre><code>
fold_fn() = fun((<a href="#type-key">key()</a>, <a href="#type-value">value()</a>, term()) -&gt; term())
</code></pre>





### <a name="type-fold_while_fn">fold_while_fn()</a> ###



<pre><code>
fold_while_fn() = fun((<a href="#type-key">key()</a>, <a href="#type-value">value()</a>, term()) -&gt; {boolean(), term()})
</code></pre>





### <a name="type-key">key()</a> ###



<pre><code>
key() = any()
</code></pre>





### <a name="type-map_fn">map_fn()</a> ###



<pre><code>
map_fn() = fun((<a href="#type-key">key()</a>, <a href="#type-value">value()</a>) -&gt; <a href="#type-value">value()</a>)
</code></pre>





### <a name="type-pred_fn">pred_fn()</a> ###



<pre><code>
pred_fn() = fun((<a href="#type-key">key()</a>, <a href="#type-value">value()</a>) -&gt; boolean())
</code></pre>





### <a name="type-tree">tree()</a> ###


__abstract datatype__: `tree(_Key, _Vlaue)`




### <a name="type-tree">tree()</a> ###


__abstract datatype__: `tree()`




### <a name="type-update_fn">update_fn()</a> ###



<pre><code>
update_fn() = fun((<a href="#type-value">value()</a>) -&gt; <a href="#type-value">value()</a>)
</code></pre>





### <a name="type-value">value()</a> ###



<pre><code>
value() = any()
</code></pre>


<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#erase-2">erase/2</a></td><td></td></tr><tr><td valign="top"><a href="#filter-2">filter/2</a></td><td></td></tr><tr><td valign="top"><a href="#find-2">find/2</a></td><td></td></tr><tr><td valign="top"><a href="#find_largest-1">find_largest/1</a></td><td></td></tr><tr><td valign="top"><a href="#find_smallest-1">find_smallest/1</a></td><td></td></tr><tr><td valign="top"><a href="#foldl-3">foldl/3</a></td><td></td></tr><tr><td valign="top"><a href="#foldl_while-3">foldl_while/3</a></td><td></td></tr><tr><td valign="top"><a href="#foldr-3">foldr/3</a></td><td></td></tr><tr><td valign="top"><a href="#foldr_while-3">foldr_while/3</a></td><td></td></tr><tr><td valign="top"><a href="#from_list-1">from_list/1</a></td><td></td></tr><tr><td valign="top"><a href="#get_value-3">get_value/3</a></td><td></td></tr><tr><td valign="top"><a href="#is_empty-1">is_empty/1</a></td><td></td></tr><tr><td valign="top"><a href="#lookup-2">lookup/2</a></td><td></td></tr><tr><td valign="top"><a href="#map-2">map/2</a></td><td></td></tr><tr><td valign="top"><a href="#new-0">new/0</a></td><td></td></tr><tr><td valign="top"><a href="#size-1">size/1</a></td><td></td></tr><tr><td valign="top"><a href="#split-2">split/2</a></td><td></td></tr><tr><td valign="top"><a href="#store-3">store/3</a></td><td></td></tr><tr><td valign="top"><a href="#take_largest-1">take_largest/1</a></td><td></td></tr><tr><td valign="top"><a href="#take_smallest-1">take_smallest/1</a></td><td></td></tr><tr><td valign="top"><a href="#to_list-1">to_list/1</a></td><td></td></tr><tr><td valign="top"><a href="#update-3">update/3</a></td><td></td></tr><tr><td valign="top"><a href="#update-4">update/4</a></td><td></td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="erase-2"></a>

### erase/2 ###


<pre><code>
erase(Key::<a href="#type-key">key()</a>, Root::<a href="#type-tree">tree()</a>) -&gt; <a href="#type-tree">tree()</a>
</code></pre>

<br></br>



<a name="filter-2"></a>

### filter/2 ###


<pre><code>
filter(Pred::<a href="#type-pred_fn">pred_fn()</a>, Tree::<a href="#type-tree">tree()</a>) -&gt; <a href="#type-tree">tree()</a>
</code></pre>

<br></br>



<a name="find-2"></a>

### find/2 ###


<pre><code>
find(Key::<a href="#type-key">key()</a>, Root::<a href="#type-tree">tree()</a>) -&gt; {error, <a href="#type-tree">tree()</a>} | {{ok, <a href="#type-value">value()</a>}, <a href="#type-tree">tree()</a>}
</code></pre>

<br></br>



<a name="find_largest-1"></a>

### find_largest/1 ###


<pre><code>
find_largest(Tree::<a href="#type-tree">tree()</a>) -&gt; {error, <a href="#type-tree">tree()</a>} | {{ok, <a href="#type-key">key()</a>, <a href="#type-value">value()</a>}, <a href="#type-tree">tree()</a>}
</code></pre>

<br></br>



<a name="find_smallest-1"></a>

### find_smallest/1 ###


<pre><code>
find_smallest(Tree::<a href="#type-tree">tree()</a>) -&gt; {error, <a href="#type-tree">tree()</a>} | {{ok, <a href="#type-key">key()</a>, <a href="#type-value">value()</a>}, <a href="#type-tree">tree()</a>}
</code></pre>

<br></br>



<a name="foldl-3"></a>

### foldl/3 ###


<pre><code>
foldl(Fun::<a href="#type-fold_fn">fold_fn()</a>, Acc0::term(), Tree::<a href="#type-tree">tree()</a>) -&gt; term()
</code></pre>

<br></br>



<a name="foldl_while-3"></a>

### foldl_while/3 ###


<pre><code>
foldl_while(Fun::<a href="#type-fold_while_fn">fold_while_fn()</a>, Acc0::term(), Tree::<a href="#type-tree">tree()</a>) -&gt; term()
</code></pre>

<br></br>



<a name="foldr-3"></a>

### foldr/3 ###


<pre><code>
foldr(Fun::<a href="#type-fold_fn">fold_fn()</a>, Acc0::term(), Tree::<a href="#type-tree">tree()</a>) -&gt; term()
</code></pre>

<br></br>



<a name="foldr_while-3"></a>

### foldr_while/3 ###


<pre><code>
foldr_while(Fun::<a href="#type-fold_while_fn">fold_while_fn()</a>, Acc0::term(), Tree::<a href="#type-tree">tree()</a>) -&gt; term()
</code></pre>

<br></br>



<a name="from_list-1"></a>

### from_list/1 ###


<pre><code>
from_list(List::[{<a href="#type-key">key()</a>, <a href="#type-value">value()</a>}]) -&gt; <a href="#type-tree">tree()</a>
</code></pre>

<br></br>



<a name="get_value-3"></a>

### get_value/3 ###


<pre><code>
get_value(Key::<a href="#type-key">key()</a>, Root::<a href="#type-tree">tree()</a>, DefaultValue::<a href="#type-value">value()</a>) -&gt; <a href="#type-value">value()</a>
</code></pre>

<br></br>



<a name="is_empty-1"></a>

### is_empty/1 ###


<pre><code>
is_empty(X1::<a href="#type-tree">tree()</a>) -&gt; boolean()
</code></pre>

<br></br>



<a name="lookup-2"></a>

### lookup/2 ###


<pre><code>
lookup(Key::<a href="#type-key">key()</a>, Root::<a href="#type-tree">tree()</a>) -&gt; error | {ok, <a href="#type-value">value()</a>}
</code></pre>

<br></br>



<a name="map-2"></a>

### map/2 ###


<pre><code>
map(Fun::<a href="#type-map_fn">map_fn()</a>, Tree::<a href="#type-tree">tree()</a>) -&gt; <a href="#type-tree">tree()</a>
</code></pre>

<br></br>



<a name="new-0"></a>

### new/0 ###


<pre><code>
new() -&gt; <a href="#type-tree">tree()</a>
</code></pre>

<br></br>



<a name="size-1"></a>

### size/1 ###


<pre><code>
size(Tree::<a href="#type-tree">tree()</a>) -&gt; non_neg_integer()
</code></pre>

<br></br>



<a name="split-2"></a>

### split/2 ###


<pre><code>
split(BorderKey::<a href="#type-key">key()</a>, Tree::<a href="#type-tree">tree()</a>) -&gt; {<a href="#type-tree">tree()</a>, <a href="#type-tree">tree()</a>}
</code></pre>

<br></br>



<a name="store-3"></a>

### store/3 ###


<pre><code>
store(Key::<a href="#type-key">key()</a>, Value::<a href="#type-value">value()</a>, Root::<a href="#type-tree">tree()</a>) -&gt; <a href="#type-tree">tree()</a>
</code></pre>

<br></br>



<a name="take_largest-1"></a>

### take_largest/1 ###


<pre><code>
take_largest(Tree::<a href="#type-tree">tree()</a>) -&gt; {error, <a href="#type-tree">tree()</a>} | {{ok, <a href="#type-key">key()</a>, <a href="#type-value">value()</a>}, <a href="#type-tree">tree()</a>}
</code></pre>

<br></br>



<a name="take_smallest-1"></a>

### take_smallest/1 ###


<pre><code>
take_smallest(Tree::<a href="#type-tree">tree()</a>) -&gt; {error, <a href="#type-tree">tree()</a>} | {{ok, <a href="#type-key">key()</a>, <a href="#type-value">value()</a>}, <a href="#type-tree">tree()</a>}
</code></pre>

<br></br>



<a name="to_list-1"></a>

### to_list/1 ###


<pre><code>
to_list(Tree::<a href="#type-tree">tree()</a>) -&gt; [{<a href="#type-key">key()</a>, <a href="#type-value">value()</a>}]
</code></pre>

<br></br>



<a name="update-3"></a>

### update/3 ###


<pre><code>
update(Key::<a href="#type-key">key()</a>, Fun::<a href="#type-update_fn">update_fn()</a>, Root::<a href="#type-tree">tree()</a>) -&gt; <a href="#type-tree">tree()</a> | error
</code></pre>

<br></br>



<a name="update-4"></a>

### update/4 ###


<pre><code>
update(Key::<a href="#type-key">key()</a>, Fun::<a href="#type-update_fn">update_fn()</a>, Initial::<a href="#type-value">value()</a>, Root::<a href="#type-tree">tree()</a>) -&gt; <a href="#type-tree">tree()</a>
</code></pre>

<br></br>



