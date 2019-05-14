############################################################################
##
#A  mult-tables.tst      Group Explorer Package          Nathan Carter
##
gap> START_TEST("GroupExplorer package: mult-tables.tst");

# Ensure that multiplication tables for small groups come out correctly.
gap> GPEX_MakeMultTable( SmallGroup( 1, 1 ) );
[ [ 1 ] ]
gap> GPEX_MakeMultTable( SmallGroup( 2, 1 ) );
[ [ 1, 2 ], [ 2, 1 ] ]
gap> GPEX_MakeMultTable( SmallGroup( 3, 1 ) );
[ [ 1, 2, 3 ], [ 2, 3, 1 ], [ 3, 1, 2 ] ]
gap> GPEX_MakeMultTable( SmallGroup( 4, 1 ) );
[ [ 1, 2, 3, 4 ], [ 2, 3, 4, 1 ], [ 3, 4, 1, 2 ], [ 4, 1, 2, 3 ] ]
gap> GPEX_MakeMultTable( SmallGroup( 4, 2 ) );
[ [ 1, 2, 3, 4 ], [ 2, 1, 4, 3 ], [ 3, 4, 1, 2 ], [ 4, 3, 2, 1 ] ]

## Each test file should finish with the call of STOP_TEST.
## The first argument of STOP_TEST should be the name of the test file.
## The second argument is redundant and is used for backwards compatibility.
gap> STOP_TEST( "mult-tables.tst", 10000 );

############################################################################
##
#E
