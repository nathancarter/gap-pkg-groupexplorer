############################################################################
##
#W  main.gi          Group Explorer Package                  Nathan Carter
##
##  Installation file for functions of the Group Explorer package.
##
#Y  Copyright (C) 2019 University of St. Andrews, North Haugh,
#Y                     St. Andrews, Fife KY16 9SS, Scotland
##

#
# This package adds a new visualization tool to JupyterViz,
# one capable of displaying groups using Group Explorer 3.
# The following line installs it.
#
InstallVisualizationTool( "groupexplorer", ReadAll(
    InputTextFile( Filename(
        DirectoriesPackageLibrary( "groupexplorer", "lib" )[1],
        "viz-tool-group-explorer.js"
    ) )
) );

InstallGlobalFunction( GPEX_MakeMultTable,
function ( group )
    local elements;
    elements := Elements( group );
    return List( elements, a ->
        List( elements, b ->
            Position( elements, a * b ) ) );
end );

InstallGlobalFunction( GPEX_SubsetIndices,
function ( subset, group )
    local elements;
    elements := Elements( group );
    return List( subset, a -> Position( elements, a ) );
end );

InstallGlobalFunction( GPEX_PartitionIndexLists,
function ( partition, group )
    return List( partition, part ->
        GPEX_SubsetIndices( part, group ) );
end );

InstallGlobalFunction( ExploreGroup,
function ( group, more... )
    local vizparam, key, value;
    vizparam := rec(
        tool := "groupexplorer",
        width := 800,
        height := 600,
        data := rec(
            multtable := GPEX_MakeMultTable( group ) - 1
        )
    );
    if Length( more ) > 0 and IsRecord( more[1] ) then
        for key in RecNames( more[1] ) do
            value := more[1].( key );
            if key = "representations" or
               key = "representations2" then
                if IsFunction( value ) then
                    vizparam.data.( key ) :=
                        [ List( Elements( group ), value ) ];
                else
                    vizparam.data.( key ) := value;
                fi;
            elif key = "name" or key = "name2" or
                 key = "multtable2" or key = "morphism" or
                 key = "subset2" or key = "homname" then
                vizparam.data.( key ) := value;
            elif key = "subset" then
                vizparam.data.( key ) :=
                    GPEX_SubsetIndices( value, group ) - 1;
            elif key = "partition" then
                if IsSubgroup( group, value ) then
                    vizparam.data.( key ) :=
                        GPEX_PartitionIndexLists(
                            CosetDecomposition( group, value ),
                            group ) - 1;
                elif IsList( value ) then
                    vizparam.data.( key ) :=
                        GPEX_PartitionIndexLists(
                            value, group ) - 1;
                elif IsEquivalenceRelation( value ) then
                    vizparam.data.( key ) :=
                        GPEX_PartitionIndexLists(
                            EquivalenceRelationPartition( value ),
                            group ) - 1;
                fi;
            elif key = "tool" or key = "tool1" or key = "tool2" then
                value := LowercaseString(
                    ReplacedString( value, " ", "" ) );
                if key = "tool" then key := "visualization"; fi;
                if StartsWith( "sheets", value ) then
                    vizparam.data.( key ) := "Sheet";
                elif StartsWith( "multiplicationtables", value ) or
                   StartsWith( "multtables", value ) then
                    vizparam.data.( key ) := "Multtable";
                elif StartsWith( "cayleydiagrams", value ) or
                   StartsWith( "cayleygraphs", value ) then
                    vizparam.data.( key ) := "CayleyDiagram";
                elif StartsWith( "cyclediagrams", value ) or
                   StartsWith( "cyclegraphs", value ) then
                    vizparam.data.( key ) := "CycleDiagram";
                else
                    vizparam.data.( key ) := "CayleyDiagram";
                fi;
            else
                vizparam.( key ) := value;
            fi;
        od;
    fi;
    if not IsBound( vizparam.data.visualization ) then
        vizparam.data.visualization := "CayleyDiagram";
    fi;
    if not IsBound( vizparam.data.name ) then
        vizparam.data.name := ReplacedString(
            ReplacedString( ViewString( group ),
                "\>", "" ), "\<", "" );
    fi;
    return CreateVisualization( vizparam );
end );

InstallGlobalFunction( ExploreMultiplicationTable,
function ( group, more... )
    if Length( more ) > 0 and IsRecord( more[1] ) then
        more := more[1];
    else
        more := rec();
    fi;
    more.tool := "mult";
    return ExploreGroup( group, more );
end );

InstallGlobalFunction( ExploreCayleyDiagram,
function ( group, more... )
    if Length( more ) > 0 and IsRecord( more[1] ) then
        more := more[1];
    else
        more := rec();
    fi;
    more.tool := "cayley";
    return ExploreGroup( group, more );
end );

InstallGlobalFunction( ExploreCycleDiagram,
function ( group, more... )
    if Length( more ) > 0 and IsRecord( more[1] ) then
        more := more[1];
    else
        more := rec();
    fi;
    more.tool := "cycle";
    return ExploreGroup( group, more );
end );

InstallGlobalFunction( ExploreGroupHomomorphism,
function ( homomorphism, more... )
    local homGeneratingPairs, dom, cod, domelts, codelts, elt;
    dom := Source( homomorphism );
    cod := Range( homomorphism );
    if Length( more ) > 0 and IsRecord( more[1] ) then
        more := more[1];
    else
        more := rec();
    fi;
    more.multtable2 := GPEX_MakeMultTable( cod ) - 1;
    more.tool := "Sheet";
    if not IsBound( more.name2 ) then
        more.name2 := ReplacedString( ReplacedString(
            ViewString( cod ), "\>", "" ), "\<", "" );
    fi;
    homGeneratingPairs := [ ];
    domelts := Elements( dom );
    codelts := Elements( cod );
    for elt in MinimalGeneratingSet( dom ) do
        Add( homGeneratingPairs, [
            Position( domelts, elt ),
            Position( codelts, Image( homomorphism, elt ) )
        ] );
    od;
    more.morphism := homGeneratingPairs - 1;
    if IsBound( more.subset ) then
        more.subset2 := GPEX_SubsetIndices(
            Image( homomorphism, more.subset ), cod ) - 1;
    fi;
    if not IsBound( more.tool1 ) then
        more.tool1 := "CayleyDiagram";
    fi;
    if not IsBound( more.tool2 ) then
        more.tool2 := "CayleyDiagram";
    fi;
    return ExploreGroup( Source( homomorphism ), more );
end );

#E  main.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
