############################################################################
##
#A  explore-group-defaults.tst     Group Explorer Package     Nathan Carter
##
gap> START_TEST("GroupExplorer package: explore-group-defaults.tst");

# This test file tests that each of the following functions gives the
# correct default values for several attributes of its result, when called
# on a group.
#  - ExploreGroup
#  - ExploreMultiplicationTable
#  - ExploreCayleyGraph
#  - ExploreCayleyDiagram (tested indirectly because we've already
#    verified in what-is-defined.tst that it's equal to the previous)
#  - ExploreCycleGraph
#  - ExploreCycleDiagram (tested indirectly because we've already
#    verified in what-is-defined.tst that it's equal to the previous)
# To make the code below easier to write and easier to vertically align,
# we define now aliases for each of these four functions.
gap> EGP := ExploreGroup;;
gap> EMT := ExploreMultiplicationTable;;
gap> ECG := ExploreCycleGraph;;
gap> ECD := ExploreCayleyDiagram;;

# Does each function give a result with the correct multiplication table?
# (Note that we must subtract 1 from the table as GPEX_MakeMultTable
# produces it, because this data is ready to go to JavaScript, which
# uses zero-based indexing.)
gap> G := SmallGroup( 6, 1 );;
gap> MT := GPEX_MakeMultTable( G );;
gap> EGP( G, rec( showResult := false ) ).data.multtable = MT - 1;
true
gap> EMT( G, rec( showResult := false ) ).data.multtable = MT - 1;
true
gap> ECG( G, rec( showResult := false ) ).data.multtable = MT - 1;
true
gap> ECD( G, rec( showResult := false ) ).data.multtable = MT - 1;
true

# Does each function give a result with the correct visualization tool
# for the JupyterViz package?
# (In every case, the tool should be "groupexlorer".)
gap> EGP( G, rec( showResult := false ) ).tool;
"groupexplorer"
gap> EMT( G, rec( showResult := false ) ).tool;
"groupexplorer"
gap> ECG( G, rec( showResult := false ) ).tool;
"groupexplorer"
gap> ECD( G, rec( showResult := false ) ).tool;
"groupexplorer"

# Does each function give a result with the correct visualization tool
# for the viz-tool-group-explorer.js file to use?
# (Note that these names are taken precisely from the names of the
# pages on the Group Explorer website, because that's what they're
# used for in this package -- navigating to those pages.)
gap> EGP( G, rec( showResult := false ) ).data.visualization;
"CayleyDiagram"
gap> EMT( G, rec( showResult := false ) ).data.visualization;
"Multtable"
gap> ECG( G, rec( showResult := false ) ).data.visualization;
"CycleDiagram"
gap> ECD( G, rec( showResult := false ) ).data.visualization;
"CayleyDiagram"

# Does each function include a default name for the group generated
# from ViewString (with tab/spacing characters removed)?
gap> EGP( G, rec( showResult := false ) ).data.name;
"<group of size 6 with 2 generators>"
gap> EMT( G, rec( showResult := false ) ).data.name;
"<group of size 6 with 2 generators>"
gap> ECG( G, rec( showResult := false ) ).data.name;
"<group of size 6 with 2 generators>"
gap> ECD( G, rec( showResult := false ) ).data.name;
"<group of size 6 with 2 generators>"

## Each test file should finish with the call of STOP_TEST.
## The first argument of STOP_TEST should be the name of the test file.
## The second argument is redundant and is used for backwards compatibility.
gap> STOP_TEST( "explore-group-defaults.tst", 10000 );

############################################################################
##
#E
