############################################################################
##
#A  explore-group-options.tst     Group Explorer Package     Nathan Carter
##
gap> START_TEST("GroupExplorer package: explore-group-options.tst");

# This file tests that ExploreGroup and related functions support all of
# the options described in the documentation.  In each case, we call one
# of the functions on a group plus an options record, and then verify that
# the resulting data structure contains the data that our options requested.

# See explore-group-defaults.tst for an explanation of these lines:
gap> EGP := ExploreGroup;;
gap> EMT := ExploreMultiplicationTable;;
gap> ECG := ExploreCycleGraph;;
gap> ECD := ExploreCayleyDiagram;;

# Does each function let us specify the name of the group?
gap> G := SymmetricGroup( 3 );;
gap> MT := GPEX_MakeMultTable( G );;
gap> EGP( G, rec( name := "TEST!", showResult := false ) ).data.name;
"TEST!"
gap> EMT( G, rec( name := "TEST!", showResult := false ) ).data.name;
"TEST!"
gap> ECG( G, rec( name := "TEST!", showResult := false ) ).data.name;
"TEST!"
gap> ECD( G, rec( name := "TEST!", showResult := false ) ).data.name;
"TEST!"

# Does each function let us specify the names of the group's elements,
# by providing a list of lists?
gap> REP := [ [ "e", "v", "w", "x", "y", "z" ] ];;
gap> EGP( G, rec( representations := REP, showResult := false ) ).data.representations;
[ [ "e", "v", "w", "x", "y", "z" ] ]
gap> EMT( G, rec( representations := REP, showResult := false ) ).data.representations;
[ [ "e", "v", "w", "x", "y", "z" ] ]
gap> ECG( G, rec( representations := REP, showResult := false ) ).data.representations;
[ [ "e", "v", "w", "x", "y", "z" ] ]
gap> ECD( G, rec( representations := REP, showResult := false ) ).data.representations;
[ [ "e", "v", "w", "x", "y", "z" ] ]

# Does each function let us specify the names of the group's elements,
# by providing a function that does so?
gap> RFN := a -> Position( Elements( G ), a );;
gap> EGP( G, rec( representations := RFN, showResult := false ) ).data.representations;
[ [ 1, 2, 3, 4, 5, 6 ] ]
gap> EMT( G, rec( representations := RFN, showResult := false ) ).data.representations;
[ [ 1, 2, 3, 4, 5, 6 ] ]
gap> ECG( G, rec( representations := RFN, showResult := false ) ).data.representations;
[ [ 1, 2, 3, 4, 5, 6 ] ]
gap> ECD( G, rec( representations := RFN, showResult := false ) ).data.representations;
[ [ 1, 2, 3, 4, 5, 6 ] ]

# Does each function let us specify a subset to highlights, as a list?
# (Note that we start with indices 2,4 in GAP, then test for indices
# 1,3 in the data, because it is on its way to JavaScript, zero-based.)
gap> SUB := [ Elements( G )[2], Elements( G )[4] ];;
gap> EGP( G, rec( subset := SUB, showResult := false ) ).data.subset;
[ 1, 3 ]
gap> EMT( G, rec( subset := SUB, showResult := false ) ).data.subset;
[ 1, 3 ]
gap> ECG( G, rec( subset := SUB, showResult := false ) ).data.subset;
[ 1, 3 ]
gap> ECD( G, rec( subset := SUB, showResult := false ) ).data.subset;
[ 1, 3 ]

# Does each function let us specify a subset to highlights, as a subgroup?
# (Note that we start with indices 1,4,5 in GAP, then test for indices
# 0,3,4 in the data, because it is on its way to JavaScript, zero-based.)
gap> ELG := Elements( G );;
gap> SUB := Subgroup( G, [ ELG[4] ] );;
gap> Size( SUB );
3
gap> ELG[1] in SUB;
true
gap> ELG[4] in SUB;
true
gap> ELG[5] in SUB;
true
gap> Set( EGP( G, rec( subset := SUB, showResult := false ) ).data.subset );
[ 0, 3, 4 ]
gap> Set( EMT( G, rec( subset := SUB, showResult := false ) ).data.subset );
[ 0, 3, 4 ]
gap> Set( ECG( G, rec( subset := SUB, showResult := false ) ).data.subset );
[ 0, 3, 4 ]
gap> Set( ECD( G, rec( subset := SUB, showResult := false ) ).data.subset );
[ 0, 3, 4 ]

# Does each function let us specify a partition to highlight, as a
# list of lists?
gap> LL := [ [ ELG[1] ], [ ELG[2], ELG[3] ], [ ELG[4], ELG[5], ELG[6] ] ];;
gap> IsList( LL );
true
gap> EGP( G, rec( partition := LL, showResult := false ) ).data.partition;
[ [ 0 ], [ 1, 2 ], [ 3, 4, 5 ] ]
gap> EMT( G, rec( partition := LL, showResult := false ) ).data.partition;
[ [ 0 ], [ 1, 2 ], [ 3, 4, 5 ] ]
gap> ECG( G, rec( partition := LL, showResult := false ) ).data.partition;
[ [ 0 ], [ 1, 2 ], [ 3, 4, 5 ] ]
gap> ECD( G, rec( partition := LL, showResult := false ) ).data.partition;
[ [ 0 ], [ 1, 2 ], [ 3, 4, 5 ] ]

# Does each function let us specify a partition to highlights, as a
# subgroup to be interpreted as a coset partition?
gap> Set( EGP( G, rec( partition := SUB, showResult := false ) ).data.partition[1] );
[ 0, 3, 4 ]
gap> Set( EMT( G, rec( partition := SUB, showResult := false ) ).data.partition[1] );
[ 0, 3, 4 ]
gap> Set( ECG( G, rec( partition := SUB, showResult := false ) ).data.partition[1] );
[ 0, 3, 4 ]
gap> Set( ECD( G, rec( partition := SUB, showResult := false ) ).data.partition[1] );
[ 0, 3, 4 ]
gap> Set( EGP( G, rec( partition := SUB, showResult := false ) ).data.partition[2] );
[ 1, 2, 5 ]
gap> Set( EMT( G, rec( partition := SUB, showResult := false ) ).data.partition[2] );
[ 1, 2, 5 ]
gap> Set( ECG( G, rec( partition := SUB, showResult := false ) ).data.partition[2] );
[ 1, 2, 5 ]
gap> Set( ECD( G, rec( partition := SUB, showResult := false ) ).data.partition[2] );
[ 1, 2, 5 ]

# Does each function let us specify a partition to highlight, as an
# equivalence relation?
# (As before, we test for indices one lower than we provide, because the
# data is ready for JavaScript, which is zero-based.)
gap> EQR := EquivalenceRelationByPairs( G, [ [ ELG[1], ELG[2] ], [ ELG[3], ELG[4] ], [ ELG[4], ELG[5] ] ] );;
gap> Set( EGP( G, rec( partition := EQR, showResult := false ) ).data.partition[1] );
[ 0, 1 ]
gap> Set( EMT( G, rec( partition := EQR, showResult := false ) ).data.partition[1] );
[ 0, 1 ]
gap> Set( ECG( G, rec( partition := EQR, showResult := false ) ).data.partition[1] );
[ 0, 1 ]
gap> Set( ECD( G, rec( partition := EQR, showResult := false ) ).data.partition[1] );
[ 0, 1 ]
gap> Set( EGP( G, rec( partition := EQR, showResult := false ) ).data.partition[2] );
[ 2, 3, 4 ]
gap> Set( EMT( G, rec( partition := EQR, showResult := false ) ).data.partition[2] );
[ 2, 3, 4 ]
gap> Set( ECG( G, rec( partition := EQR, showResult := false ) ).data.partition[2] );
[ 2, 3, 4 ]
gap> Set( ECD( G, rec( partition := EQR, showResult := false ) ).data.partition[2] );
[ 2, 3, 4 ]
gap> Set( EGP( G, rec( partition := EQR, showResult := false ) ).data.partition[3] );
[ 5 ]
gap> Set( EMT( G, rec( partition := EQR, showResult := false ) ).data.partition[3] );
[ 5 ]
gap> Set( ECG( G, rec( partition := EQR, showResult := false ) ).data.partition[3] );
[ 5 ]
gap> Set( ECD( G, rec( partition := EQR, showResult := false ) ).data.partition[3] );
[ 5 ]

# Does each function let us choose which arrows to display in a Cayley diagram?
# (Again there is a discrepancy between one-based and zero-based indices.)
gap> ELG[4];
(1,2,3)
gap> ExploreGroup( G, rec( arrows := [ (1,2,3) ], showResult := false ) ).data.arrows;
[ 3 ]
gap> ExploreCayleyDiagram( G, rec( arrows := [ (1,2,3) ], showResult := false ) ).data.arrows;
[ 3 ]
gap> IsBound( ExploreGroup( G, rec( showResult := false ) ).data.arrows );
false

## Each test file should finish with the call of STOP_TEST.
## The first argument of STOP_TEST should be the name of the test file.
## The second argument is redundant and is used for backwards compatibility.
gap> STOP_TEST( "explore-group-options.tst", 10000 );

############################################################################
##
#E
