############################################################################
##
##
#W  main.gd          Group Explorer Package                  Nathan Carter
##
##  Declaration file for functions of the Group Explorer package.
##
#Y  Copyright (C) 2019 University of St. Andrews, North Haugh,
#Y                     St. Andrews, Fife KY16 9SS, Scotland
##

#! @Chapter Function reference
#! @ChapterLabel funcref

#! @Section Public API

#! @Arguments group, [options]
#! @Returns one of two things, documented below
#! @Description
#!  If evaluated in a Jupyter Notebook, the result of this function, when
#!  rendered by that notebook, will run JavaScript code that imports into
#!  the output cell an instance of a page from the Group Explorer 3 web
#!  app for visualizing groups (using an <Code>iframe</Code>).  How the
#!  group is displayed depends on the value of the second and third
#!  parameters, as documented below.
#!  <P/>
#!  If evaluated in the &GAP; REPL, this function will open a new tab or
#!  window in the user's default browser, showing the page from the Group
#!  Explorer 3 web app described above.
#!  <P/>
#!  Note that there are convenience functions defined below that call
#!  this one; the user can choose which style is their preference.
#!
#!  <List>
#!    <Item>The <Code>group</Code> parameter should be a &GAP; group
#!      object.</Item>
#!    <Item>The <Code>options</Code> parameter is optional.  If present,
#!      it should be a &GAP; record with the following attributes, each
#!      of which is optional.
#!      <List>
#!        <Item><Code>tool</Code> - a tool from among the three supported
#!          by Group Explorer: multiplication tables, Cayley graphs, and
#!          cycle graphs.  This parameter is a string, and it can be any
#!          string equal to one of those three tool names, with case and
#!          spacing ignored.  For example, "mult" or "cayley" or "cycle"
#!          are acceptable values.  If this option is not provided, it
#!          defaults to Cayley graph.</Item>
#!        <Item><Code>representations</Code> - a list of lists of strings.
#!          If we call the value of this parameter <Code>V</Code> then
#!          each entry <Code>V[i]</Code> is a representation for the
#!          group, by which we mean that for every <Code>j</Code> in
#!          <Code>[1..Size(group)]</Code>, <Code>V[i][j]</Code> is a
#!          string representation of the group element
#!          <Code>Elements(group)[j]</Code>.
#!          <P/>
#!          Alternately, if one would like to use a function to compute
#!          these representations, simply replace the list of lists with
#!          a &GAP; function, and this routine will create a single
#!          representation by evaluating that function on each element
#!          of the group.  For example, you can use
#!          <Code>rec(representations:=PrintString)</Code>.
#!          The default representation, if this is not provided, is that
#!          <Code>Elements(group)[j]</Code> is represented as <Code>j</Code>.
#!          <P/>
#!          Each element name can be MathML code, and it will be rendered
#!          as such.  If it is not valid XML, it will be treated instead
#!          as plain text and rendered as such.
#!        </Item>
#!        <Item><Code>name</Code> - a string to be used as the name of the
#!          group, in the header of the page to be displayed.  If not
#!          provided, it defaults to <Code>ViewString(group)</Code>.
#!          <P/>
#!          This, too, can be MathML code, and it will be rendered as such.
#!          If it is not valid XML, it will be treated instead as plain
#!          text and rendered as such.</Item>
#!        <Item><Code>subgroup</Code> - a subgroup of <Code>group</Code>
#!          (as a &GAP; <Code>Subgroup</Code> object) to be highlighted in
#!          the resulting visualization</Item>
#!        <Item><Code>partition</Code> - this can have several types of
#!          values, but in each case it makes the visualization highlight
#!          each part of the partition with a different color.  The types
#!          of values this can have, each with its associated meaning,
#!          follow.
#!          <List>
#!            <Item>If <Code>partition</Code> is a list of lists of
#!              elements of <Code>group</Code>, then it is already a
#!              partition of <Code>group</Code> and will be
#!              respected.</Item>
#!            <Item>If <Code>partition</Code> is a subgroup of
#!              <Code>group</Code>, then it will be converted into a
#!              partition by invoking &GAP;'s
#!              <Code>CosetDecomposition</Code> function.</Item>
#!            <Item>If <Code>partition</Code> is an equivalence relation
#!              (that is, it passes &GAP;'s
#!              <Code>IsEquivalenceRelation</Code> test) then it will be
#!              converted into a partition by applying &GAP;'s
#!              <Code>EquivalenceRelationPartition</Code> function.
#!              No check is done to ensure the domain of the relation is
#!              <Code>group</Code>; the caller should ensure this.</Item>
#!          </List>
#!          </Item>
#!        <Item>Other options may be added here later.</Item>
#!      </List>
#!    </Item>
#!  </List>
#!
#!  This routine works by delegating to the <Code>CreateVisualization</Code>
#!  function in the <Package>JupyterViz</Package> package, asking it to
#!  invoke the visualization scripts in
#!  <File>viz-tool-group-explorer.js</File>, installed by this package.
DeclareGlobalFunction( "ExploreGroup" );

#! @Arguments group, [options]
#! @Returns one of two things, as in <Ref Func="ExploreGroup"/>
#! @Description
#!  This is a convenience function that invokes <Ref Func="ExploreGroup"/>,
#!  passing the appropriate tool option to ensure that the resulting
#!  visualization is a multiplication table.
DeclareGlobalFunction( "ExploreMultiplicationTable" );

#! @Arguments group, [options]
#! @Returns one of two things, as in <Ref Func="ExploreGroup"/>
#! @Description
#!  This is a convenience function that invokes <Ref Func="ExploreGroup"/>,
#!  passing the appropriate tool option to ensure that the resulting
#!  visualization is a Cayley graph.
#!  <P/>
#!  This package also defines the synonym <Code>ExploreCayleyGraph</Code>
#!  for this function, because there are two common terms for the same
#!  concept.
DeclareGlobalFunction( "ExploreCayleyDiagram" );

DeclareSynonym( "ExploreCayleyGraph", ExploreCayleyDiagram );

#! @Arguments group, [options]
#! @Returns one of two things, as in <Ref Func="ExploreGroup"/>
#! @Description
#!  This is a convenience function that invokes <Ref Func="ExploreGroup"/>,
#!  passing the appropriate tool option to ensure that the resulting
#!  visualization is a cycle graph.
#!  <P/>
#!  This package also defines the synonym <Code>ExploreCycleGraph</Code>
#!  for this function, because there are two common terms for the same
#!  concept.
DeclareGlobalFunction( "ExploreCycleDiagram" );

DeclareSynonym( "ExploreCycleGraph", ExploreCycleDiagram );

#! @Section Private functions

#! Clients of this package should not need to call functions in this
#! section; they are used internally by the package, and are documented
#! for the sake of completeness, and for anyone who maintains the package
#! in the future.

#! @Arguments group
#! @Returns a list of lists of natural numbers, representing the group
#!  as a multiplication table
#! @Description
#!  This function internally converts any group into the format just
#!  described, which is convertible into JSON for passing to Group
#!  Explorer.  This way, regardless of whether the group in question
#!  exists in Group Explorer's library, or what name it is stored under,
#!  the correct group structure is communicated.
#!  <P/>
#!  The user of this package should not need to call this function.
#!  It is used internally by <Ref Func="ExploreGroup"/> to create the
#!  JSON data it passes to Group Explorer for visualization.
DeclareGlobalFunction( "GPEX_MakeMultTable" );

#! @Arguments subset, group
#! @Returns a list of natural numbers
#! @Description
#!  This function internally converts any subset of a group into a
#!  list of indices into its parent group.  The indices will match
#!  those used by <Ref Func="GPEX_MakeMultTable"/>, so that if the
#!  list is passed to Group Explorer, it can be interpreted as the
#!  correct subset by Group Explorer.
#!  <P/>
#!  The user of this package should not need to call this function.
#!  It is used internally by <Ref Func="ExploreGroup"/> to create the
#!  JSON data it passes to Group Explorer for visualization, in the
#!  case when a subset is indicated as one of the options passed
#!  to that function.
DeclareGlobalFunction( "GPEX_SubsetIndices" );

#! @Arguments subgroup
#! @Returns a list of natural numbers
#! @Description
#!  This function internally converts any subgroup into a list of
#!  indices into its parent group.  The indices will match those used
#!  by <Ref Func="GPEX_MakeMultTable"/>, so that if the list is
#!  passed to Group Explorer, it can be interpreted as the correct
#!  subgroup by Group Explorer.
#!  <P/>
#!  The user of this package should not need to call this function.
#!  It is used internally by <Ref Func="ExploreGroup"/> to create the
#!  JSON data it passes to Group Explorer for visualization, in the
#!  case when a subgroup is indicated as one of the options passed
#!  to that function.
DeclareGlobalFunction( "GPEX_SubgroupIndices" );

#! @Arguments partition, group
#! @Returns a list of lists of natural numbers
#! @Description
#!  This function internally converts any partition of a group into a
#!  list of lists of indices into the group.  The indices will match
#!  those used by <Ref Func="GPEX_MakeMultTable"/>, so that if the
#!  return value is passed to Group Explorer, it can be interpreted
#!  as a partition of the group by Group Explorer.
#!  <P/>
#!  The user of this package should not need to call this function.
#!  It is used internally by <Ref Func="ExploreGroup"/> to create the
#!  JSON data it passes to Group Explorer for visualization, in the
#!  case when a partition is indicated as one of the options passed
#!  to that function.
DeclareGlobalFunction( "GPEX_PartitionIndexLists" );

#E  main.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
