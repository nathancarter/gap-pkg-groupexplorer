############################################################################
##
#A  explore-hom-defaults.tst     Group Explorer Package     Nathan Carter
##
gap> START_TEST("GroupExplorer package: explore-hom-defaults.tst");

# This test file tests that the ExploreGroupHomomorphism function gives the
# correct default values for several attributes of its result, when called
# on a group homomorphism.
# To make the code below easier to write,
# we define an alias for the function ExploreGroupHomomorphism.
gap> EGH := ExploreGroupHomomorphism;;

# Does the function give a result with the correct multiplication tables?
# (Note that we must subtract 1 from each table that GPEX_MakeMultTable
# produces, because this data is ready to go to JavaScript, which
# uses zero-based indexing.)
gap> G := SmallGroup( 6, 1 );;
gap> H := SmallGroup( 7, 1 );;
gap> f := GroupHomomorphismByFunction( G, H, a -> Identity( H ) );;
gap> MT1 := GPEX_MakeMultTable( G );;
gap> MT2 := GPEX_MakeMultTable( H );;
gap> EGH( f, rec( showResult := false ) ).data.multtable = MT1 - 1;
true
gap> EGH( f, rec( showResult := false ) ).data.multtable2 = MT2 - 1;
true

# Does the function give a result with the correct visualization tool
# for the JupyterViz package (the tool "groupexplorer")?
gap> EGH( f, rec( showResult := false ) ).tool;
"groupexplorer"

# Does the function give a result with the correct visualization tool
# for the viz-tool-group-explorer.js file to use (the tool "Sheet",
# which is the only Group Explorer page capable of showing a
# homomorphism)?
gap> EGH( f, rec( showResult := false ) ).data.visualization;
"Sheet"

# Does the function also embed the correct visualization tool for
# Group Explorer to apply to each group involved?
# (The default is a Cayley graph in each case, which we call by the
# name used in the page on the Group Explorer website, because that's
# what this datum is used for in this package -- navigating to that page.)
gap> EGH( f, rec( showResult := false ) ).data.tool1;
"CayleyDiagram"
gap> EGH( f, rec( showResult := false ) ).data.tool2;
"CayleyDiagram"

# Does each function include a default name for each group, generated
# from ViewString (with tab/spacing characters removed)?
gap> EGH( f, rec( showResult := false ) ).data.name;
"<group of size 6 with 2 generators>"
gap> EGH( f, rec( showResult := false ) ).data.name2;
"<group of size 7 with 1 generators>"

## Each test file should finish with the call of STOP_TEST.
## The first argument of STOP_TEST should be the name of the test file.
## The second argument is redundant and is used for backwards compatibility.
gap> STOP_TEST( "explore-hom-defaults.tst", 10000 );

############################################################################
##
#E
