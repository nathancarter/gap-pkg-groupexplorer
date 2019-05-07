
Read( "groupexplorer.g" );
# G := Group( [ (1,2,3), (3,4) ] );
# ExploreMultiplicationTable( G );
ExploreCayleyDiagram( G, rec(
    representations := function ( elt )
        local i;
        i := Position( Elements( G ), elt );
        return Concatenation(
            "<mi>", "abcdefghijklmnopqrstuvwxyz"{[i..i]}, "</mi>" );
    end
) );
ExploreCycleGraph( G );
# ExploreCayleyGraph( SmallGroup( 16, 3 ) );
# ExploreMultiplicationTable( Group( [ (1,2,3,4,5) ] ), rec(
#     representations := [
#         [ "e", "a", "aa", "aaa", "aaaa" ]
#     ]
# ) );
# ExploreCycleGraph( Group( [ (1,2,3,4), (1,2) ] ), rec(
#     representations := PrintString
# ) );
