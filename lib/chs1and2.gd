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
#!   <Item>groups of order 61-200: renderable but not very useful
#!     (as in the example in Section <Ref Sect="Section_toobig"/>)</Item>
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
#! The heading in the image above contains &GAP;'s name for the group,
#! because we did not provide a name when invoking the
#! <Ref Func="ExploreMultiplicationTable"/> command.  Also, group
#! elements have a default naming scheme of natural numbers starting at
#! zero.  To see how to change these defaults, refer to the examples in
#! Section <Ref Sect="Section_opts"/> and the documentation of
#! <Ref Func="ExploreGroup"/>.
#!
#! @Section Interacting with Multiplication Tables
#! @SectionLabel mtint
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
#! In addition to the features listed in the manual, there is an additional
#! feature available when a group has been loaded from an external source,
#! such as &GAP;.  A search icon will appear in the top-right corner of the
#! visualization window, and clicking it will search for the group in
#! Group Explorer's library.  If it is found, then Group Explorer will open
#! its Group Info Page for that group, which shows all the visualization
#! options and group-related facts Group Explorer knows about the group,
#! <URL Text="as documented here">https://nathancarter.github.io/group-explorer/help/rf-um-groupwindow/</URL>.
#! If the group is not found (which happens only if it is too large to be
#! included in Group Explorer's library) then a message indicating so will
#! appear, and no Group Info Page will open.
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
#! ExploreCayleyDiagram( G );        # result appears in web browser
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
#! The heading in the image above contains &GAP;'s name for the group,
#! because we did not provide a name when invoking the
#! <Ref Func="ExploreCayleyDiagram"/> command.  Also, group
#! elements have a default naming scheme of natural numbers starting at
#! zero.  To see how to change these defaults, refer to the examples in
#! Section <Ref Sect="Section_opts"/> and the documentation of
#! <Ref Func="ExploreGroup"/>.
#!
#! @Section Interacting with Cayley Diagrams
#! @SectionLabel cdint
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
#! Regarding searching for &GAP; groups in Group Explorer's library,
#! see the comments at the end of Section <Ref Sect="Section_mtint"/>.
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
#! ExploreCycleDiagram( G );           # result appears in web browser
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
#! The heading in the image above contains &GAP;'s name for the group,
#! because we did not provide a name when invoking the
#! <Ref Func="ExploreCycleDiagram"/> command.  Also, group
#! elements have a default naming scheme of natural numbers starting at
#! zero.  To see how to change these defaults, refer to the examples in
#! Section <Ref Sect="Section_opts"/> and the documentation of
#! <Ref Func="ExploreGroup"/>.
#!
#! @Section Interacting with Cycle Graphs
#! @SectionLabel cgint
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
#! Regarding searching for &GAP; groups in Group Explorer's library,
#! see the comments at the end of Section <Ref Sect="Section_mtint"/>.
#!
#! @Section Example: Group Homomorphisms
#! @SectionLabel hom
#!
#! To open a Group Explorer web page rendering a homomorphism between
#! two groups, follow the example below.  For additional details, see
#! the documentation for the function
#! <Ref Func="ExploreGroupHomomorphism"/>.
#!
#! @Example
#! G := Group( [ (1,2,3), (3,4) ] );
#! H := Subgroup( G, [ (1,2,3) ] );
#! embed := GroupHomomorphismByFunction( H, G, a -> a );
#! ExploreGroupHomomorphism( embed,
#!     # second parameter is optional; see below
#!     rec( subset := H )
#! );
#! @EndExample
#!
#! The code above opens a page like this in the user's default web
#! browser:
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-6-homomorphism.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-6-homomorphism.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! (If the code were invoked in a Jupyter notebook, then that page would
#! instead be embedded in the corresponding output cell of the notebook.)
#!
#! The record passed as the second parameter in the example above is
#! optional, but caused the red highlighting shown in the figure.
#! The full list of options available to pass in that record appears in
#! the documentation for <Ref Func="ExploreGroupHomomorphism"/>.
#!
#! @Section Interacting with Homomorphisms
#!
#! In Group Explorer, the user can interact with sheets displaying
#! homomorphisms in several ways.
#! <List>
#!   <Item>Double-click either group to get a large view of that group,
#!     which enables all of the interactivity covered in Sections
#!     <Ref Sect="Section_mtint"/>, <Ref Sect="Section_cdint"/>,
#!     and <Ref Sect="Section_cgint"/>.</Item>
#!   <Item>Double-click the homomorphism to edit its display properties,
#!     including what data to report about it, how its arrows should be
#!     drawn, and the mapping itself.</Item>
#!   <Item>Add or delete elements to the sheet using the controls shown
#!     on the right side of the figure.</Item>
#! </List>
#! For full details on how to use the Group Explorer interface for these
#! features, see the relevant pages in the Group Explorer manual,
#! including both
#! <URL Text="sheets">https://nathancarter.github.io/group-explorer/help/rf-um-sheetwindow/</URL>
#! and
#! <URL Text="morphisms">https://nathancarter.github.io/group-explorer/help/rf-um-morphedit/</URL>.
#!
#! @Section The Options Record
#! @SectionLabel opts
#!
#! When invoking <Ref Func="ExploreGroup"/>,
#! <Ref Func="ExploreMultiplicationTable"/>,
#! <Ref Func="ExploreCayleyDiagram"/>,
#! <Ref Func="ExploreCycleDiagram"/>, or
#! <Ref Func="ExploreGroupHomomorphism"/>, one can pass an optional second
#! parameter, a &GAP; record containing options.  Details appear in
#! the documentation for <Ref Func="ExploreGroup"/> and
#! <Ref Func="ExploreGroupHomomorphism"/>, but this section
#! contains a few illustrative examples.
#!
#! @Subsection Specifying the name of a group
#!
#! This replaces the default group name in the header of the resulting page.
#!
#! @Example
#! # construct G as in earlier examples
#! ExploreMultiplicationTable( G, rec( name := "Group Name Here" ) );
#! @EndExample
#!
#! You can use plain text or MathML markup in group names.
#!
#! When visualizing a homomorphism, specifying the name as above applies to
#! the domain.  Use the key <Code>name2</Code> to name the codomain.
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
#! When visualizing a homomorphism, specifying the representations as
#! above applies to the domain group.  Use the key
#! <Code>representations2</Code> to name the codomain's elements.
#!
#! @Subsection Highlighting a subset or subgroup
#!
#! To highlight a particular subset or subgroup in the visualization,
#! simply pass a &GAP; list, set, or <Code>Subgroup</Code> object as
#! the <Code>subset</Code> member of the options record.
#!
#! @Example
#! G := Group( [ (1,2,3,4), (1,2) ] );
#! H := Subgroup( G, [ (1,2,3,4) ] );
#! ExploreCycleGraph( G, rec( subset := H ) );
#! @EndExample
#!
#! The following image is the result of running that example code.
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-4-highlight-subgroup.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-4-highlight-subgroup.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! When visualizing a homomorphism, specifying a subset as above
#! highlights it in the domain and its image in the codomain.
#!
#! @Subsection Highlighting a partition
#!
#! To highlight a partition of the group in the generated visualization,
#! use the <Code>partition</Code> member of the options record.  It can
#! accept a variety of things, including subgroups (to partition by
#! cosets), partitions (as lists of lists of elements), and equivalence
#! relations (which will be converted to partitions).
#!
#! @Example
#! G := Group( [ (1,2,3), (3,4) ] );
#! H := Subgroup( G, [ (1,2,3) ] );
#! ExploreCayleyGraph( G, rec( partition := H ) );
#! @EndExample
#!
#! The following image is the result of running that example code.
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-5-highlight-partition.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-5-highlight-partition.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! When visualizing a homomorphism, specifying a partition as above
#! highlights it in the domain group but not the codomain group,
#! because the image of a partition is not always a partition.
#!
#! @Section Size limitations
#! @SectionLabel toobig
#!
#! As mentioned in the introduction, there are limitations inherent in a
#! two- or three-dimensional visual representation readable by a human.
#! Groups above a certain size and level of complexity reveal less of
#! their structure in such representations, because there's only so much
#! space available before elements become very tiny, or occlude one
#! another.
#!
#! As an example, consider the group from &GAP;'s Small Groups library,
#! <Code>SmallGroup( 150, 5 )</Code>.  If we invoke each of the functions
#! <Ref Func="ExploreCayleyDiagram"/>, <Ref Func="ExploreCycleDiagram"/>,
#! and <Ref Func="ExploreMultiplicationTable"/> on that group, we see
#! the visualizations shown below.
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-7a-too-big.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-7a-too-big.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! Obviously, from this Cayley graph, we can see only that the group has
#! three generators and is not abelian.  Other than that, most of its
#! structure is too complex to read.
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-7b-too-big.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-7b-too-big.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! From this cycle graph, we can see roughly how many groups there are
#! with small orbits and with larger orbits, and how some of those
#! larger orbits overlap.  But without zooming to see the names of the
#! elements, we cannot tell much more.  (Viewing the graph in Group
#! Explorer permits zooming, panning, etc., as documented in Section
#! <Ref Sect="Section_cgint"/>.)
#!
#! <Alt Only="LaTeX">
#!     \begin{center}
#!         \includegraphics[width=\linewidth]{screenshot-7c-too-big.png}
#!     \end{center}
#! </Alt>
#! <Alt Only="HTML"><![CDATA[<img width="100%" src="screenshot-7c-too-big.png"/>]]></Alt>
#! <Alt Not="LaTeX HTML">Resulting image not shown here.</Alt>
#!
#! From this multipication table we can tell very little, other than
#! that there is a subgroup of order six that is not normal, and that
#! the element names are too small to read without zooming in.
#! (Viewing the table in Group Explorer permits zooming, panning, etc.,
#! as documented in Section <Ref Sect="Section_mtint"/>.)
#!
