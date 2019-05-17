
# Documentation build script using AutoDoc

# Note that to add a one-pixel black border around a screenshot,
# as has already been done for all screenshots in this repository,
# use ImageMagic as follows.
# $ convert original.png -border 1x1 -bordercolor black new.png

LoadPackage( "AutoDoc" );
AutoDoc(
    rec(
        scaffold := rec(
            gapdoc_latex_options := rec(
                EarlyExtraPreamble := "\\usepackage[pdftex]{graphicx}"
            )
        ),
        autodoc := true
    )
);
QUIT;
