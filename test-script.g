
LoadPackage( "groupexplorer" );
G := Group( [ (1,2,3), (3,4) ] );
H := Subgroup( G, [ (1,2,3) ] );
# V4 := Group( [ (1,2),(3,4) ] );
# Z2 := Group( [ (1,2) ] );
# qm := GroupHomomorphismByImages( V4, Z2, [ (1,2), (3,4) ], [ (1,2), (1,2) ] );
# ExploreGroup( G );
# ExploreGroup( G, rec( arrows := [ (1,2,3), (3,4) ] ) );
# ExploreCayleyDiagram( G, rec( subset := H ) );
G2 := Group( [ (1,2,3,4,5), (1,2) ] );
ExploreMultiplicationTable( G2,
    rec( normalizer := Subgroup( G2, [ (1,2,3) ] ) ) );
# ExploreCycleDiagram( G, rec( subset := H ) );
# ExploreMultiplicationTable( G, rec( subset := H ) );
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
# ExploreCayleyDiagram( G, rec( partition := H ) );
# ExploreMultiplicationTable( G, rec( partition := H ) );
# ExploreCycleGraph( G, rec( partition := ConjugacyClasses( G ) ) );
# ExploreCayleyDiagram( G, rec(
#     partition := EquivalenceRelationByPartition( G,
#         CosetDecomposition( G, H ) )
# ) );
# embed := GroupHomomorphismByFunction( H, G, a -> a );
# ExploreGroupHomomorphism( embed, rec(
#     subset := H#, tool1 := "mult", tool2 := "cyc"
# ) );
# ExploreMultiplicationTable( SmallGroup( 150, 5 ) );
# ExploreGroupHomomorphism( qm, rec(
#     subset := Subgroup( Z2, [ () ] )
# ) );
