#!
#! @Chapter Introduction
#!
#! The desktop group theory visualization software Group Explorer
#! was ported to the web in 2019.  It is available online at
#! <URL Text="https://nathancarter.github.io/group-explorer">https://nathancarter.github.io/group-explorer</URL>.
#! It has some software-as-a-service features that let its pages be
#! opened by other applications, with parameters indicating which groups
#! to display and in which ways.  This package provides a &GAP; API for
#! doing exactly that.
#!
#! Group Explorer has many features that this package does not expose,
#! because its primary intended use case is (as the name suggests)
#! interactive exploration of visualizations (rather than generating
#! them programmatically).  The reader may wish to investigate
#! <URL Text="the Group Explorer manual">https://nathancarter.github.io/group-explorer/help/</URL>
#! for a full list of its features.
#!
#! The subset of those features exposed by this package include:
#! <List>
#!   <Item>displaying a multiplication table for a given group</Item>
#!   <Item>displaying a Cayley graph for a given group</Item>
#!   <Item>displaying a cycle graph for a given group</Item>
#!   <Item>letting the user interact with any of these visualizations
#!     after they have been displayed</Item>
#! </List>
#! These visualizations have natural limitations; it becomes impossible
#! to gain any benefit from, for example, a Cayley graph that is so huge
#! that its structure is unreadable to the human eye.  And the computer
#! would have difficulty constructing and rendering such an object as
#! well.  Thus this package's utility decreases with group size, roughly
#! as follows.
#! <List>
#!   <Item>groups of order 1-30: ideal</Item>
#!   <Item>groups of order 31-60: still useful</Item>
#!   <Item>groups of order 61-200: renderable but not very useful</Item>
#!   <Item>groups of order 201+: slow to render, not very useful</Item>
#! </List>
#!
#! Note that Group Explorer is a separate application from this
#! package, and if bugs are discovered within Group Explorer, they should
#! be reported on its issue tracker on GitHub, rather than within the
#! issue tracker for this &GAP; package.  Bugs for this package's
#! connection to Group Explorer can be reported to this package's issue
#! tracker.
#!
#! The remaining sections of this chapter cover some illustrative
#! examples to help get you started using the package.  Comprehensive
#! reference documentation for the few functions exposed by the package
#! appears in Chapter <Ref Chap="Chapter_funcref"/>.
#!
#! @Chapter Usage Examples
#!
#! @Section Example: Multiplication Tables
#! @SectionLabel mt
#!
#! To open a Group Explorer web page rendering a multiplication table of
#! a given group, follow the example below.  For additional details, see
#! the documentation for the function
#! <Ref Func="ExploreMultiplicationTable"/>.
#!
#! @Example
#! LoadPackage( "groupexplorer" );   # only needed once, of course
#! G := SymmetricGroup( 4 );         # or any group of reasonable size
#! ExploreMultiplicationTable( G );  # result appears in web browser
#! @EndExample
#!
#! The code above opens a page like this in the user's default web
#! browser:
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-1-mt-s4.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-1-mt-s4.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! (If the code were invoked in a Jupyter notebook, then that page would
#! instead be embedded in the corresponding output cell of the notebook.)
#!
#! The heading in the image above contains the phrase "Untitled group,"
#! because we did not provide a name for the group when invoking Group
#! Explorer.  Furthermore, group elements have a default naming scheme
#! of natural numbers starting at zero.  To see how to change these
#! defaults, refer to the examples in Section
#! <Ref Sect="Section_opts"/> and the documentation of
#! <Ref Func="ExploreGroup"/>.
#!
#! @Section Interacting with Multiplication Tables
#!
#! In Group Explorer, the user can interact with multiplication tables in
#! several ways, including these.
#! <List>
#!   <Item>Compute various subgroups, subsets, and partitions</Item>
#!   <Item>Color elements by subgroup, subset, and/or a partition</Item>
#!   <Item>Organize the table by a subgroup, or freely reorder rows
#!     and columns</Item>
#!   <Item>Divide the table along coset boundaries to inspect
#!     normality of the subgroup</Item>
#! </List>
#! For full details on how to use the Group Explorer interface for these
#! features, see
#! <URL Text="the relevant page in the Group Explorer manual">https://nathancarter.github.io/group-explorer/help/rf-um-mt-options/</URL>.
#!
#! @Section Example: Cayley diagrams
#! @SectionLabel cd
#!
#! To open a Group Explorer web page rendering a Cayley diagram (or a
#! Cayley graph) of a given group, follow the example below.  For
#! additional details, see the documentation for the function
#! <Ref Func="ExploreCayleyDiagram"/>.
#!
#! @Example
#! LoadPackage( "groupexplorer" );   # only needed once, of course
#! G := SymmetricGroup( 3 );         # or any group of reasonable size
#! ExploreCayleyGraph( G );          # result appears in web browser
#! @EndExample
#!
#! The code above opens a page like this in the user's default web
#! browser:
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-2-cd-s3.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-2-cd-s3.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! (If the code were invoked in a Jupyter notebook, then that page would
#! instead be embedded in the corresponding output cell of the notebook.)
#!
#! The heading in the image above contains the phrase "Untitled group,"
#! because we did not provide a name for the group when invoking Group
#! Explorer.  Furthermore, group elements have a default naming scheme
#! of natural numbers starting at zero.  To see how to change these
#! defaults, refer to the examples in Section
#! <Ref Sect="Section_opts"/> and the documentation of
#! <Ref Func="ExploreGroup"/>.
#!
#! @Section Interacting with Cayley Diagrams
#!
#! In Group Explorer, the user can interact with Cayley diagrams in
#! several ways, including these.
#! <List>
#!   <Item>Clicking and dragging to rotate the diagram in space
#!     (particularly useful if the diagram is three-dimensional,
#!     unlike the example above)</Item>
#!   <Item>Compute various subgroups, subsets, and partitions</Item>
#!   <Item>Color elements by subgroup, subset, and/or a partition</Item>
#!   <Item>Organize the diagram by a subgroup, request the digram change
#!     its layout, or freely move vertices and edges in space</Item>
#!   <Item>Draw boxes to show coset boundaries, for inspecting
#!     normality of a subgroup</Item>
#!   <Item>Change visual details such as size of vertices, thickness of
#!     lines, zoom level, etc.</Item>
#! </List>
#! For full details on how to use the Group Explorer interface for these
#! features, see
#! <URL Text="the relevant page in the Group Explorer manual">https://nathancarter.github.io/group-explorer/help/rf-um-cd-options/</URL>.
#!
#! @Section Example: Cycle diagrams
#! @SectionLabel cg
#!
#! To open a Group Explorer web page rendering a cycle graph of a given
#! group, follow the example below.  For additional details, see the
#! documentation for the function <Ref Func="ExploreCycleDiagram"/>.
#!
#! @Example
#! LoadPackage( "groupexplorer" );   # only needed once, of course
#! G := SmallGroup( 32, 3 );         # or any group of reasonable size
#! ExploreCycleGraph( G );           # result appears in web browser
#! @EndExample
#!
#! The code above opens a page like this in the user's default web
#! browser:
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-3-cg-32.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-3-cg-32.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! (If the code were invoked in a Jupyter notebook, then that page would
#! instead be embedded in the corresponding output cell of the notebook.)
#!
#! The heading in the image above contains the phrase "Untitled group,"
#! because we did not provide a name for the group when invoking Group
#! Explorer.  Furthermore, group elements have a default naming scheme
#! of natural numbers starting at zero.  To see how to change these
#! defaults, refer to the examples in Section
#! <Ref Sect="Section_opts"/> and the documentation of
#! <Ref Func="ExploreGroup"/>.
#!
#! @Section Interacting with Cycle Graphs
#!
#! In Group Explorer, the user can interact with cycle graphs in
#! several ways, including these.
#! <List>
#!   <Item>Pan and zoom, which is particularly useful for graphs that
#!     are larger and more complex than the example shown above</Item>
#!   <Item>Compute various subgroups, subsets, and partitions</Item>
#!   <Item>Color elements by subgroup, subset, and/or a partition</Item>
#! </List>
#! For full details on how to use the Group Explorer interface for these
#! features, see
#! <URL Text="the relevant page in the Group Explorer manual">https://nathancarter.github.io/group-explorer/help/rf-um-cg-options/</URL>.
#!
#! @Section The Options Record
#! @SectionLabel opts
#!
#! When invoking <Ref Func="ExploreGroup"/>,
#! <Ref Func="ExploreMultiplicationTable"/>,
#! <Ref Func="ExploreCayleyDiagram"/>, or
#! <Ref Func="ExploreCycleDiagram"/>, one can pass an optional final
#! parameter, a &GAP; record containing options.  Details appear in
#! the documentation for <Ref Func="ExploreGroup"/>, but this section
#! contains a few illustrative examples.
#!
#! @Subsection Specifying the name of a group
#!
#! This replaces "Untitled Group" in the header of the resulting page.
#!
#! @Example
#! # construct G as in earlier examples
#! ExploreMultiplicationTable( G, rec( name := "Group Name Here" ) );
#! @EndExample
#!
#! You can use plain text or MathML markup in group names.
#!
#! @Subsection Specifying element names
#!
#! You can provide an array of representations for the elements of the
#! group.  Only the first representation is used by default.
#!
#! @Example
#! ExploreCayleyGraph( Group( [ (1,2,3) ] ), rec(
#!   representations := [
#!     [ # MathML is not required, but is acceptable:
#!       "<mi>e</mi>",
#!       "<mi>a</mi>",
#!       "<msup><mi>a</mi><mn>2</mn></msup>"
#!     ]
#!   ]
#! ) );
#! @EndExample
#!
#! If the names are not valid XML, they will be treated as plain text
#! rather than MathML.
#!
#! You can also specify element names by providing a &GAP; function
#! that maps from the group to the string data type.
#!
#! @Example
#! ExploreCycleGraph( G, rec( representations := PrintString ) );
#! @EndExample
#!