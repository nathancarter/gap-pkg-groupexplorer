
LoadPackage( "JupyterViz" );

InstallVisualizationTool( "groupexplorer", ReadAll( InputTextFile(
    "/Users/nathan/.gap/pkg/groupexplorer/viz-tool-group-explorer.js"
) ) );

_MakeMultTable := function ( group )
    local elements;
    elements := Elements( group );
    return List( elements, a ->
        List( elements, b ->
            Position( elements, a * b ) ) );
end;

_DrawAnyGroupVisualization := function ( group, tool, more... )
    local vizparam, name;
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

DrawMultiplicationTable := function ( group, more... )
    return _DrawAnyGroupVisualization( group, "Multtable", more );
end;
DrawCayleyDiagram := function ( group, more... )
    return _DrawAnyGroupVisualization( group, "CayleyDiagram", more );
end;
DrawCayleyGraph := DrawCayleyDiagram;
DrawCycleGraph := function ( group, more... )
    return _DrawAnyGroupVisualization( group, "CycleDiagram", more );
end;
DrawCycleDiagram := DrawCycleGraph;
