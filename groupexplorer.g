
#
# This package depends upon the JupyterViz package,
# which it uses to create visualizsations, inside or
# outside of Jupyter notebooks.
#
LoadPackage( "JupyterViz" );

#
# This package adds a new visualization tool to JupyterViz,
# one capable of displaying groups using Group Explorer 3.0.
# The following line installs it.
#
# Right now this points to a local file on the developer's
# machine.  It will later be updated to work everywhere.
#
InstallVisualizationTool( "groupexplorer", ReadAll( InputTextFile(
    "/Users/nathan/.gap/pkg/groupexplorer/viz-tool-group-explorer.js"
) ) );

#
# Internal function for converting any reasonably small group
# into a list of lists representing the group as a multiplication
# table.
#
_MakeMultTable := function ( group )
    local elements;
    elements := Elements( group );
    return List( elements, a ->
        List( elements, b ->
            Position( elements, a * b ) ) );
end;

#
# A generic function for opening a Group Explorer page that shows
# the group in question using the tool in question.
# This routine works by delegating to CreateVisualization in the
# JupyterViz package, asking it to invoke the visualization scripts
# in viz-tool-group-explorer.js, installed above.
#
# First parameter should be a GAP group object.
# Second parameter should be a string from this list:
#   "Multtable", "CayleyDiagram", "CycleDiagram"
# But we accept any initial segment of any of those strings,
# optionally with spaces, ignoring case.  So "mult" is fine, f.ex.
# Third parameter is optional and its use will evolve with time.
#
ExploreGroup := function ( group, tool, more... )
    local vizparam, name;
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
            multtable := _MakeMultTable( group ) - 1
        )
    );
    if Length( more ) > 0 and IsRecord( more[1] ) then
        for name in RecNames( more[1] ) do
            vizparam.( name ) := more[1].( name );
        od;
    fi;
    return CreateVisualization( vizparam );
end;

#
# Convenience function that invokes ExploreGroup,
# passing the magic string for multiplication tables.
#
DrawMultiplicationTable := function ( group, more... )
    return ExploreGroup( group, "mult", more );
end;
#
# Convenience function that invokes ExploreGroup,
# passing the magic string for Cayley diagrams.
#
DrawCayleyDiagram := function ( group, more... )
    return ExploreGroup( group, "cayley", more );
end;
#
# Alternate name for the above function, because there are two
# common terms for the same thing.
#
DrawCayleyGraph := DrawCayleyDiagram;
#
# Convenience function that invokes ExploreGroup,
# passing the magic string for multiplication tables.
#
DrawCycleGraph := function ( group, more... )
    return ExploreGroup( group, "cycle", more );
end;
#
# Alternate name for the above function, because there are two
# common terms for the same thing.
#
DrawCycleDiagram := DrawCycleGraph;
