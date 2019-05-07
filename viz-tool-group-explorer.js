
const GEorigin = 'https://nathancarter.github.io/'
const GEpath = GEorigin + 'group-explorer/';
const methods = [ 'CayleyDiagram', 'Multtable', 'CycleDiagram' ];

// Group Explorer (https://github.com/nathancarter/group-explorer/)
//
// This web app draws Cayley Digrams, Multiplication Tables, and Cycle
// Graphs for groups.  It is, however, still under development, so this
// should be considered alpha quality for now (as of Oct 2018).
//
// The JSON data should have the following attributes:
//   visualization : a string, one of "CayleyDiagram", "Multtable", or
//     "CycleDiagram", to choose which kind of visualization to produce
//   multtable : a multiplication table for the group, stored as nested
//     arrays, in which we assume that group elements are numbered 0 through
//     |G|-1, and for all i,j in that range, the product i*j is
//     multtable[i][j], which is also an integer from 0 to |G|-1.
//   name : a string, the name of the group, as valid MathML
//     (optional, defaults to "Untitled Group")
//   shortName : a string, the name of the group, as plain text, kept short
//     (optional, similar default)
//   author : a string, the name of the person defining the group, optional
//   definition : a string containing a mathematical expression, in MathML
//     form, defining the group, optional
//   phrase : a human-readable description of the group, optional
//   representations : an array of arrays, formatted as follows:
//     (Here we use "representation" in the computer science sense, that is,
//     a text representation of an object, not in the group theoretic sense,
//     that is, embedding groups into groups of matrices.)
//     A representation for a group is an array of length |G| in which
//     element i is the string representation (in MathML) of element i.
//     The representations element of the JSON structure is an array of
//     such arrays, with the first entry in that larger array being the
//     representation that should be used by default.  This is optionl,
//     and if absent, defaults to representing each element i with the
//     number i (in the range 0 to |G|-1, as above).
// Because this kind of JSON is tiresome to produce, this library provides
// some GAP functions to help create it.  See the GroupVisualization()
// function in the GAP code for this package.
window.VisualizationTools['groupexplorer'] =
function ( element, json, callback ) {
    // If they did not pass the name of a visualization tool that exists in
    // Group Explorer, just tell them so and stop now.
    if ( methods.indexOf( json.data.visualization ) == -1 ) {
        var paragraph = document.createElement( 'p' );
        paragraph.textContent =
            'Not a valid Group Explorer visualization method: '
          + json.data.visualization + '.  Must be one of: '
          + methods.join( ', ' ) + '.';
        element.appendChild( paragraph );
        return callback( element, paragraph );
    }
    //
    // For dev purposes, we may sometimes run against a local copy of GE.
    // To do so, use the following line.
    //
    // var GEpath = 'http://localhost:8000/', GEorigin = '*';
    // Compute the URL to the Group Explorer web app, including
    // the specific page for the tool they chose.
    // web app, the specific page for the tool they chose.
    const url = GEpath + json.data.visualization + '.html?waitForMessage=true';
    // Create an iframe into which to load that URL.
    var iframe = document.createElement( 'iframe' );
    iframe.setAttribute( 'src', url );
    iframe.style.border = '0px';
    iframe.style.padding = '0px';
    iframe.style.margin = '0px';
    // If we're in a Jupyter notebook, assign a sensible default size.
    // Otherwise, make the iframe and its container fill the window.
    if ( window.Jupyter ) {
        iframe.setAttribute( 'width', json.width || 600 );
        iframe.setAttribute( 'height', json.height || 400 );
    } else {
        element.style.border = '0px';
        element.style.padding = '0px';
        element.style.margin = '0px';
        document.body.style.border = '0px';
        document.body.style.padding = '0px';
        document.body.style.margin = '0px';
        document.body.style.width = '100%';
        document.body.style.height = '100%';
        element.style.width = '100%';
        element.style.height = '100%';
        iframe.style.width = '100%';
        iframe.style.height = '100%';
    }
    // Then place the iframe in the element we're supposed to.
    element.appendChild( iframe );
    // Also create a link by which they can open the same visualization
    // in a new window, to see it larger.
    /*
    var div = document.createElement( 'div' );
    div.style.textAlign = 'center';
    var content = '<a href="' + iframe.getAttribute( 'src' )
                + '" target="_blank">Open this visualization in a new tab</a>';
    div.innerHTML = content;
    element.appendChild( div );
    */
    // Make a copy of the data they passed, but without the name of the
    // visualization tool, so as not to confuse Group Explorer.
    var copy = JSON.parse( JSON.stringify( json.data ) );
    delete copy.visualization;
    // Send a message to the iframe, once it's loaded, about the group that
    // should be displayed.  Call the callback.
    iframe.addEventListener( 'load', function ( event ) {
        console.log( 'iframe loaded' );
        iframe.contentWindow.postMessage( {
            type : 'load group',
            group : copy
        }, GEorigin );
        callback( element, iframe );
    } );
};
