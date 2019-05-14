
# Group Explorer GAP Package

This package allows [GAP](http://www.gap-system.org) users to create
visualizations of groups using [Group Explorer
3.0](https://nathancarter.github.io/group-explorer/index.html).

## Status

This project is approaching a first release.  More testing remains to be
done before that release is declared, but the package is already functional.

## Examples

Assuming you've cloned this repo into your GAP packages folder, load the
package the usual way:

```gap
LoadPackage( "groupexplorer" );
```

Visualize a group of order 16 using a Cayley graph.

```gap
ExploreCayleyGraph( SmallGroup( 16, 3 ) );
```

![Web page generated by the code above](./doc/example-1.png)

Visualize the group of order 5 using a multiplication table,
specifying the names of the elements.

```gap
ExploreMultiplicationTable( Group( [ (1,2,3,4,5) ] ), rec(
    representations := [
        [ "e", "a", "aa", "aaa", "aaaa" ]
    ]
) );
```

![Web page generated by the code above](./doc/example-2.png)

Visualize a symmetric group using a cycle graph and its
standard permutation notation as its representation.
In this example, we give the group a name, which is used in
the page heading.  We can use MathML formatting, but doing
so is optional; plain text is also accepted.

```gap
ExploreCycleGraph( Group( [ (1,2,3,4), (1,2) ] ), rec(
    representations := PrintString,
    name := "<msub><mi>S</mi><mn>4</mn></msub>"
) );
```

![Web page generated by the code above](./doc/example-3.png)
