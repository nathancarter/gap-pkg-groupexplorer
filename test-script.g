
Read( "groupexplorer.g" );
G := Group( [ (1,2,3), (3,4) ] );
# ExploreMultiplicationTable( G );
ExploreCayleyDiagram( G, rec(
    representations := [ List( [1..24], i ->
        Concatenation( "<mi>", "abcdefghijklmnopqrstuvwxyz"{[i..i]}, "</mi>" ) ) ]
) );
# ExploreCycleGraph( G );
