
LoadPackage( "groupexplorer" );
G := Group( [ (1,2,3), (3,4) ] );
H := Subgroup( G, [ (1,2,3) ] );
# ExploreCayleyDiagram( G, rec( subgroup := H ) );
# ExploreCycleDiagram( G, rec( subgroup := H ) );
ExploreMultiplicationTable( G, rec( subgroup := H ) );
# ExploreMultiplicationTable( G );
# ExploreCayleyDiagram( G, rec(
#     representations := function ( elt )
#         local i;
#         i := Position( Elements( G ), elt );
#         return Concatenation(
#             "<mi>", "abcdefghijklmnopqrstuvwxyz"{[i..i]}, "</mi>" );
#     end,
#     name := "My 24-Element Group"
# ) );
# ExploreCycleGraph( G );
# ExploreCayleyGraph( SmallGroup( 16, 3 ) );
# ExploreMultiplicationTable( Group( [ (1,2,3,4,5) ] ), rec(
#     representations := [
#         [ "e", "a", "aa", "aaa", "aaaa" ]
#     ]
# ) );
# ExploreCycleGraph( Group( [ (1,2,3,4), (1,2) ] ), rec(
#     representations := PrintString,
#     name := "<msub><mi>S</mi><mn>4</mn></msub>"
# ) );
