############################################################################
##
#A  what-is-defined.tst      Group Explorer Package          Nathan Carter
##
gap> START_TEST("GroupExplorer package: what-is-defined.tst");

# Ensure that the functions that are supposed to be exposed are exposed
gap> IsBoundGlobal( "ExploreGroup" );
true
gap> IsBoundGlobal( "ExploreMultiplicationTable" );
true
gap> IsBoundGlobal( "ExploreCayleyDiagram" );
true
gap> IsBoundGlobal( "ExploreCayleyGraph" );
true
gap> IsBoundGlobal( "ExploreCycleDiagram" );
true
gap> IsBoundGlobal( "ExploreCycleGraph" );
true
gap> IsBoundGlobal( "GPEX_MakeMultTable" );
true

## Each test file should finish with the call of STOP_TEST.
## The first argument of STOP_TEST should be the name of the test file.
## The second argument is redundant and is used for backwards compatibility.
gap> STOP_TEST( "what-is-defined.tst", 10000 );

############################################################################
##
#E
