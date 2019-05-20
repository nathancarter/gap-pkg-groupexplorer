############################################################################
##
#A  explore-hom-options.tst     Group Explorer Package     Nathan Carter
##
gap> START_TEST("GroupExplorer package: explore-hom-options.tst");

# This file tests that ExploreGroupHomomorphism supports all of
# the options described in the documentation.  We call it on a group
# plus an options record, and then verify that the resulting data
# structure contains the data that our options requested.

# To make the code below easier to write,
# we define an alias for the function ExploreGroupHomomorphism.
gap> EGH := ExploreGroupHomomorphism;;

# Does it let us specify the name of the domain group?
gap> G := SymmetricGroup( 3 );;
gap> H := SmallGroup( 7, 1 );;
gap> f := GroupHomomorphismByFunction( G, H, a -> Identity( H ) );;
gap> MT1 := GPEX_MakeMultTable( G );;
gap> MT2 := GPEX_MakeMultTable( H );;
gap> tmp := EGH( f, rec( name := "TEST!", showResult := false ) );;
gap> tmp.data.name;
"TEST!"
gap> tmp.data.name2;
"<group of size 7 with 1 generators>"
gap> tmp := EGH( f, rec( name2 := "TEST!", showResult := false ) );;
gap> tmp.data.name;
"Sym( [ 1 .. 3 ] )"
gap> tmp.data.name2;
"TEST!"
gap> tmp := EGH( f, rec( name := "a b c", name2 := "d e f", showResult := false ) );;
gap> tmp.data.name;
"a b c"
gap> tmp.data.name2;
"d e f"

# Does it let us specify the names of either group's elements,
# by providing a list of lists?
gap> REP1 := [ [ "e", "v", "w", "x", "y", "z" ] ];;
gap> REP2 := [ [ "e", "u", "v", "w", "x", "y", "z" ] ];;
gap> tmp := EGH( f, rec( representations := REP1, showResult := false ) );;
gap> tmp.data.representations;
[ [ "e", "v", "w", "x", "y", "z" ] ]
gap> IsBound( tmp.data.representations2 );
false
gap> tmp := EGH( f, rec( representations2 := REP2, showResult := false ) );;
gap> IsBound( tmp.data.representations );
false
gap> tmp.data.representations2;
[ [ "e", "u", "v", "w", "x", "y", "z" ] ]
gap> tmp := EGH( f, rec( representations := REP1, representations2 := REP2, showResult := false ) );;
gap> tmp.data.representations;
[ [ "e", "v", "w", "x", "y", "z" ] ]
gap> tmp.data.representations2;
[ [ "e", "u", "v", "w", "x", "y", "z" ] ]

# Does it let us specify the names of either group's elements,
# by providing a function that does so?
gap> RFN1 := a -> Position( Elements( G ), a );;
gap> RFN2 := a -> Position( Elements( H ), a );;
gap> tmp := EGH( f, rec( representations := RFN1, showResult := false ) );;
gap> tmp.data.representations;
[ [ 1, 2, 3, 4, 5, 6 ] ]
gap> IsBound( tmp.data.representations2 );
false
gap> tmp := EGH( f, rec( representations2 := RFN2, showResult := false ) );;
gap> IsBound( tmp.data.representations );
false
gap> tmp.data.representations2;
[ [ 1, 2, 3, 4, 5, 6, 7 ] ]
gap> tmp := EGH( f, rec( representations := RFN1, representations2 := RFN2, showResult := false ) );;
gap> tmp.data.representations;
[ [ 1, 2, 3, 4, 5, 6 ] ]
gap> tmp.data.representations2;
[ [ 1, 2, 3, 4, 5, 6, 7 ] ]

# Does it let us specify a subset to highlight in the domain, as a list?
# And if so, does it convert that correctly into its image in the codomain?
# (Note that we start with indices 2,4 in GAP, then test for indices
# 1,3 in the data, because it is on its way to JavaScript, zero-based.)
gap> SUB := [ Elements( G )[2], Elements( G )[4] ];;
gap> tmp := EGH( f, rec( subset := SUB, showResult := false ) );;
gap> tmp.data.subset;
[ 1, 3 ]
gap> tmp.data.subset2;
[ 0 ]

# Does it let us specify a subset to highlight in the domain, as a subgroup?
# And if so, does it convert that correctly into its image in the codomain?
# (Note that we start with indices 2,4 in GAP, then test for indices
# 1,3 in the data, because it is on its way to JavaScript, zero-based.)
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
gap> tmp := EGH( f, rec( subset := SUB, showResult := false ) );;
gap> Set( tmp.data.subset );
[ 0, 3, 4 ]
gap> tmp.data.subset2;
[ 0 ]

# Does it let us specify a subset to highlight in the codomain, as a subgroup?
# And if so, does it convert that convert that correctly into its preimage
# in the domain?
# (The one-based vs. zero-based indexing discrepency pops up here as well.)
gap> V4 := Group( [ (1,2),(3,4) ] );;
gap> Z2 := Group( [ (1,2) ] );;
gap> qm := GroupHomomorphismByImages( V4, Z2, [ (1,2), (3,4) ], [ (1,2), () ] );;
gap> sgp := Subgroup( Z2, [ () ] );;
gap> tmp := EGH( qm, rec( subset := sgp, showResult := false ) );;
gap> Elements( PreImage( qm, sgp ) );
[ (), (3,4) ]
gap> Elements( V4 )[1];
()
gap> Elements( V4 )[2];
(3,4)
gap> Set( tmp.data.subset );
[ 0, 1 ]
gap> Set( tmp.data.subset2 );
[ 0 ]

# Does it let us specify a subset to highlight in the codomain, as a list?
# And if so, does it convert that convert that correctly into its preimage
# in the domain?
# (The one-based vs. zero-based indexing discrepency pops up here as well.)
gap> Gp := SmallGroup( 15, 1 );;
gap> Z3 := Group( [ (1,2,3) ] );;
gap> qm := GroupHomomorphismByFunction( Gp, Z3, a -> Identity( Z3 ) );;
gap> Identity( Z3 ) in Gp;
false
gap> tmp := EGH( qm, rec( subset := [ Identity( Z3 ) ], showResult := false ) );;
gap> Size( PreImage( qm, sgp ) );
15
gap> Set( tmp.data.subset );
[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ]
gap> Set( tmp.data.subset2 );
[ 0 ]

# Does it let us specify a partition to highlight, as a list of lists?
gap> LL := [ [ ELG[1] ], [ ELG[2], ELG[3] ], [ ELG[4], ELG[5], ELG[6] ] ];;
gap> IsList( LL );
true
gap> tmp := EGH( f, rec( partition := LL, showResult := false ) );;
gap> tmp.data.partition;
[ [ 0 ], [ 1, 2 ], [ 3, 4, 5 ] ]

# Does it let us specify a partition to highlight, as a subgroup, to be
# interpreted as a coset partition?
gap> tmp := EGH( f, rec( partition := SUB, showResult := false ) );;
gap> Set( tmp.data.partition[1] );
[ 0, 3, 4 ]
gap> Set( tmp.data.partition[2] );
[ 1, 2, 5 ]

# Does it let us specify a partition to highlight, as an equivalence
# relation?
gap> EQR := EquivalenceRelationByPairs( G, [ [ ELG[1], ELG[2] ], [ ELG[3], ELG[4] ], [ ELG[4], ELG[5] ] ] );;
gap> tmp := EGH( f, rec( partition := EQR, showResult := false ) );;
gap> Set( tmp.data.partition[1] );
[ 0, 1 ]
gap> Set( tmp.data.partition[2] );
[ 2, 3, 4 ]
gap> Set( tmp.data.partition[3] );
[ 5 ]

# Does it let us specify a name for the homomorphism itself?
gap> tmp := EGH( f, rec( homname := "my hom", showResult := false ) );;
gap> tmp.data.homname;
"my hom"

## Each test file should finish with the call of STOP_TEST.
## The first argument of STOP_TEST should be the name of the test file.
## The second argument is redundant and is used for backwards compatibility.
gap> STOP_TEST( "explore-hom-options.tst", 10000 );

############################################################################
##
#E
