
Read( "groupexplorer.g" );
G := Group( [ (1,2,3), (3,4) ] );
# ExploreMultiplicationTable( G );
ExploreCayleyDiagram( G, rec(
    representations := function ( elt )
        local i;
        i := Position( Elements( G ), elt );
        return Concatenation(
            "<mi>", "abcdefghijklmnopqrstuvwxyz"{[i..i]}, "</mi>" );
    end
) );
# ExploreCycleGraph( G );
