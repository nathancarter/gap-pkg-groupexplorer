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

InstallGlobalFunction( GPEX_SubgroupIndices,
function ( subgroup )
    return GPEX_SubsetIndices( subgroup, Parent( subgroup ) );
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
            if key = "representations" then
                if IsFunction( value ) then
                    vizparam.data.representations :=
                        [ List( Elements( group ), value ) ];
                else
                    vizparam.data.( key ) := value;
                fi;
            elif key = "name" then
                vizparam.data.( key ) := value;
            elif key = "subgroup" then
                vizparam.data.( key ) :=
                    GPEX_SubgroupIndices( value ) - 1;
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
            elif key = "tool" then
                value := LowercaseString(
                    ReplacedString( value, " ", "" ) );
                if StartsWith( "multiplicationtables", value ) or
                   StartsWith( "multtables", value ) then
                    vizparam.data.visualization := "Multtable";
                elif StartsWith( "cayleydiagrams", value ) or
                   StartsWith( "cayleygraphs", value ) then
                    vizparam.data.visualization := "CayleyDiagram";
                elif StartsWith( "cyclediagrams", value ) or
                   StartsWith( "cyclegraphs", value ) then
                    vizparam.data.visualization := "CycleDiagram";
                else
                    vizparam.data.visualization := "CayleyDiagram";
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

#E  main.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
