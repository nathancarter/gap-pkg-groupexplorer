
# To-do list

## Tasks that will enable me to declare version 1.0.0

 * Ask others to check over this package and give bug feedback.
 * When testing complete, run ReleaseTools to generate the first release.

## Miscellaneous tasks

 * Add a feature to Group Explorer so that if it is displaying a group
   that was loaded from `waitForMessage` with an explicit multiplication
   table, it will let the user search for that group in the built-in GE
   library, and will let the user switch to that representation.

## Extending this package's power

Here are some features that it would be nice to support.  In each case,
assume that one has the GAP data for the objects in question, and wants
a convenience function to call that will illustrate the data in the
nicest way.

Easy extensions of existing features:

 * If the specified subgroup is in the codomain, highlight it there,
   and its pre-image in the domain
 * Add to a CD arrows for chosen elements
 * Support highlighting a single element and its orbit
 * Showing normalizers: highlight $H$ and all of its cosets that sit
   within $N_G(H)$ as a partition (leaving everything outside the
   normalizer unhighlighted)

Somewhat easy extension of existing features:

 * Organizing by subgroups in MT/CD
 * Show quotient operation in MT/CD, with partitions and chunks

New convenience functions with some computation in them:

 * Show all groups of a given order (which refuses if the number is
   above a certain threshold, unless you pass `force:=true`)
 * Show non-abelian-ness in MT/CD
 * Illustrate automorphisms of a group.  This may be useful:
   https://www.gap-system.org/Manuals/doc/ref/chap40.html#X791D12B7845610CE
 * Galois group of a polynomial, with elements named for permutations
   of the polynomial's roots.  This may be useful:
   https://www.gap-system.org/Manuals/doc/ref/chap66.html#X7AB9A6257ED694EC
 * Show Cayley's Theorem by an embedding of $G$ into $Perm(|G|)$
   or an isomorphism between $G$ and $H<Perm(|G|)$ if $|G|>5$.
 * Show a direct product with names that are ordered pairs and where,
   if the visualizer is an MT/CD, it is organized by one of the factors
 * Same as previous, but for semidirect products
 * Show the embedding of either factor into either kind of product

Larger pieces of work:

 * Roots of a polynomial plotted in the complex plane, with generators
   of the Galois group drawn as permutations of them, using the same
   colors that will appear in a full Cayley diagram, for comparison
 * Group of symmetries of a set of points in $R^3$
   (For each pair of distinct points, compute the rotation that moves
   one to the other and ask if it permutes the set.  From those that do,
   create a group.)
