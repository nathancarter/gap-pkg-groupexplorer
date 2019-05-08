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

InstallGlobalFunction( ExploreGroup,
function ( group, tool, more... )
    local vizparam, key, value;
    tool := LowercaseString( ReplacedString( tool, " ", "" ) );
    if StartsWith( "multiplicationtable", tool ) or
       StartsWith( "multtable", tool ) then
        tool := "Multtable";
    elif StartsWith( "cayleydiagram", tool ) or
       StartsWith( "cayleygraph", tool ) then
        tool := "CayleyDiagram";
    elif StartsWith( "cyclediagram", tool ) or
       StartsWith( "cyclegraph", tool ) then
        tool := "CycleDiagram";
    else
        tool := "Multtable";
    fi;
    vizparam := rec(
        tool := "groupexplorer",
        width := 800,
        height := 600,
        data := rec(
            visualization := tool,
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
            else
                vizparam.( key ) := value;
            fi;
        od;
    fi;
    return CreateVisualization( vizparam );
end );

InstallGlobalFunction( ExploreMultiplicationTable,
function ( group, more... )
    return CallFuncList( ExploreGroup,
        Concatenation( [ group, "mult" ], more ) );
end );

InstallGlobalFunction( ExploreCayleyDiagram,
function ( group, more... )
    return CallFuncList( ExploreGroup,
        Concatenation( [ group, "cayley" ], more ) );
end );

InstallGlobalFunction( ExploreCycleDiagram,
function ( group, more... )
    return CallFuncList( ExploreGroup,
        Concatenation( [ group, "cycle" ], more ) );
end );

#E  main.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
