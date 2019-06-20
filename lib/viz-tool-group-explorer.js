
// Group Explorer 3.0 website URL
const GEorigin = 'https://nathancarter.github.io/'
// folder within that domain that contains the GE app itself
const GEpath = GEorigin + 'group-explorer/';
// the three pages within that folder that show visualizations,
// and their corresponding VisualizerElement names
const vizEltName = {
    CayleyDiagram : 'CDElement',
    Multtable : 'MTElement',
    CycleDiagram : 'CGElement'
}
const methods = Object.keys( vizEltName );

// Utility function for escaping XML characters
const escapeXML = ( text ) =>
    text.replace( /&/g, '&amp;' )
        .replace( /</g, '&lt;' )
        .replace( />/g, '&gt;' )
        .replace( /"/g, '&quot;' )
        .replace( /'/g, '&apos;' );

// Group Explorer (https://github.com/nathancarter/group-explorer/)
//
// This web app draws Cayley Digrams, Multiplication Tables, and Cycle
// Graphs for groups.  It is, however, still under development, so this
// should be considered alpha quality for now (as of Oct 2018).
//
// The JSON data should have the following attributes:
//   visualization : a string, one of the following options
//     "CayleyDiagram" - to display a Cayley diagram of one group
//     "Multtable" - to display a multiplication table of one group
//     "CycleDiagram" - to display a multiplication table of one group
//     "Sheet" - to display a pair of visualizations, one for each of two
//       groups, connected by a homomorphism
//   multtable : a multiplication table for the group, stored as nested
//     arrays, in which we assume that group elements are numbered 0 through
//     |G|-1, and for all i,j in that range, the product i*j is
//     multtable[i][j], which is also an integer from 0 to |G|-1.
//   multtable2 : if the visualization type is "Sheet" then the "multtable"
//     will be for the domain group and "multtable2" must be provided for
//     the codomain group.  if the visualization type is not "Sheet" then
//     this will be ignored.
//   name : a string, the name of the group, as valid MathML
//     (optional, defaults to "Untitled Group")
//   name2 : if the visualization type is "Sheet" then the "name" will be
//     for the domain group and "name2" may be provided for the codomain
//     group.  if the visualization type is not "Sheet" then this will be
//     ignored.
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
//   representations2 : if the visualization type is "Sheet" then the
//     "representations" will be for the domain group and "representation2"
//     must be provided for the codomain group.  if the visualization type
//     is not "Sheet" then this will be ignored.
//   morphism : if the visualization type is "Sheet" then this must be
//     an array of arrays, each inner array being of length two, containing
//     two natural numbers, call them a and b, such that the homomorphism
//     contains f(a)=b, with a an index into the domain group's multtable,
//     and b an index into the codomain group's multtable2.  The entire
//     morphism need not be provided; a set that generates it is sufficient.
//     If the visualization type is not "Sheet" then this has no meaning
//     and will be ignored.
//   subset : a list of natural numbers, indices into the group, of a
//     set of elements that should be highlighted in the resulting
//     visualization (if just one group is being shown).
//   partition : a list of lists of natural numbers, forming a partition of
//     the group's elements.  if just one group is being shown, this
//     partition will be used to highlight the elements by colors that show
//     the partition visually.
//   partition2 : if the visualization type is "Sheet" then the
//     "partition" will be of the domain group and "partition2"
//     may be provided for the codomain group.  if the visualization type
//     is not "Sheet" then this will be ignored.
// Because this kind of JSON is tiresome to produce, this library provides
// some GAP functions to help create it.  See the GroupVisualization()
// function in the GAP code for this package.
window.VisualizationTools['groupexplorer'] =
function ( element, json, callback ) {
    // If they did not pass the name of a visualization tool that exists in
    // Group Explorer, just tell them so and stop now.
    if ( json.data.visualization != "Sheet"
      && methods.indexOf( json.data.visualization ) == -1 ) {
        var paragraph = document.createElement( 'p' );
        paragraph.textContent =
            'Not a valid Group Explorer visualization method: '
          + json.data.visualization + '.  Must be one of: '
          + methods.join( ', ' ) + ', Sheet.';
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
    var url = GEpath + json.data.visualization + '.html';
    if ( json.data.visualization != "Sheet" ) url += '?waitForMessage=true';
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
    // Element representations are supposed to be valid MathML.
    // If GAP passed representations that are not valid XML,
    // just wrap them in <mtext>...</mtext> to solve this problem.
    if ( copy.hasOwnProperty( 'representations' ) )
        copy.representations = copy.representations.map( array =>
            array.map( eltRepr => {
                try {
                    $.parseXML( eltRepr );
                    return eltRepr;
                } catch ( err ) {
                    return `<mtext>${escapeXML( eltRepr )}</mtext>`;
                }
            } ) );
    if ( copy.hasOwnProperty( 'representations2' ) )
        copy.representations2 = copy.representations2.map( array =>
            array.map( eltRepr => {
                try {
                    $.parseXML( eltRepr );
                    return eltRepr;
                } catch ( err ) {
                    return `<mtext>${escapeXML( eltRepr )}</mtext>`;
                }
            } ) );
    // Similar processing for group name:
    if ( copy.hasOwnProperty( 'name' ) )
        try {
            $.parseXML( copy.name );
        } catch ( err ) {
            copy.name = `<mrow><mtext>${escapeXML( copy.name )}</mtext></mrow>`;
        }
    if ( copy.hasOwnProperty( 'name2' ) )
        try {
            $.parseXML( copy.name2 );
        } catch ( err ) {
            copy.name2 = `<mrow><mtext>${escapeXML( copy.name2 )}</mtext></mrow>`;
        }
    // Prepare data for highlighting a subset or a partition.
    const groupOrder = copy.multtable.length;
    const groupElts = Array( groupOrder ).fill( 0 ).map( ( _, i ) => i );
    var groupOrder2, groupElts2;
    if ( copy.multtable2 ) {
        groupOrder2 = copy.multtable2.length;
        groupElts2 = Array( groupOrder2 ).fill( 0 ).map( ( _, i ) => i );
    }
    const hue2color = ( hue, vizType ) => {
        const angle = Math.round( 360 * hue );
        if ( !vizType ) vizType = copy.tool1 || json.data.visualization;
        return vizType == 'CayleyDiagram' ? `hsl(${angle},53%,30%)`
                                          : `hsl(${angle},100%,80%)`;
    }
    const whichPart = partition => g => partition.indexOf(
        partition.find( part => part.indexOf( g ) > -1 ) );
    const whichColor = partition => g => {
        const index = whichPart( partition )( g );
        return index === -1 ? undefined :
            hue2color( index / partition.length );
    }
    var highlights = undefined, highlights2 = undefined,
        elements = undefined;
    // If our options include a particular subset, then include in our
    // JSON a request to highlight that subset red.
    if ( copy.subset ) {
        highlights = {
            background : groupElts.map( g =>
                copy.subset.indexOf( g ) > -1 ?
                hue2color( 0 ) : undefined )
        };
    }
    if ( copy.subset2 && copy.multtable2 ) {
        highlights2 = {
            background : groupElts2.map( g =>
                copy.subset2.indexOf( g ) > -1 ?
                hue2color( 0, copy.tool2 ) : undefined )
        };
    }
    // If our options include a partition of the group, then
    // for now just print it out so we can debug what's up.
    if ( copy.partition ) {
        highlights = {
            background : groupElts.map( whichColor( copy.partition ) )
        };
    }
    if ( copy.partition2 ) {
        highlights2 = {
            background : groupElts2.map( whichColor( copy.partition2 ) )
        }
    }
    // If our options include a list of arrows to show in a Cayley diagram,
    // then include in our JSON a request to draw those specific arrows.
    var arrows = undefined, arrows2 = undefined;
    if ( json.data.visualization == "Sheet" ) {
        if ( copy.arrows && copy.tool1 == 'CayleyDiagram' )
            arrows = copy.arrows;
        if ( copy.arrows2 && copy.tool2 == 'CayleyDiagram' )
            arrows2 = copy.arrows2;
        if ( copy.elements && copy.tool1 == 'Multtable' )
            elements = copy.elements;
        if ( copy.elements2 && copy.tool2 == 'Multtable' )
            elements2 = copy.elements2;
    } else {
        if ( copy.arrows && json.data.visualization == 'CayleyDiagram' )
            arrows = copy.arrows;
        if ( copy.elements && json.data.visualization == 'Multtable' )
            elements = copy.elements;
    }
    // Send a message to the iframe, once it's loaded, about the group or
    // homomorphism that should be displayed.  Call the callback.
    const iwin = iframe.contentWindow;
    iframe.addEventListener( 'load', function ( event ) {
        if ( json.data.visualization == "Sheet" ) {
            var domainGroupJSON = {
                className : vizEltName[copy.tool1],
                group : {
                    name : copy.name,
                    representations : copy.representations,
                    multtable : copy.multtable
                },
                x : 100, y : 100, w : 300, h : 300
            };
            if ( highlights ) domainGroupJSON.highlights = highlights;
            if ( arrows ) domainGroupJSON.arrows = arrows;
            if ( elements ) domainGroupJSON.elements = elements;
            var codomainGroupJSON = {
                className : vizEltName[copy.tool2],
                group : {
                    name : copy.name2,
                    representations : copy.representations2,
                    multtable : copy.multtable2
                },
                x : 500, y : 100, w : 300, h : 300
            };
            if ( highlights2 ) codomainGroupJSON.highlights = highlights2;
            if ( arrows2 ) codomainGroupJSON.arrows = arrows2;
            if ( elements2 ) codomainGroupJSON.elements = elements2;
            setTimeout( function () {
                iwin.postMessage( {
                    type : 'load from json',
                    json : [
                        domainGroupJSON,
                        codomainGroupJSON,
                        {
                            className : 'MorphismElement',
                            name : copy.homname || 'f',
                            fromIndex : 0, toIndex : 1,
                            showManyArrows : true, showInjSurj : true,
                            definingPairs : copy.morphism
                        },
                        {
                            className : 'TextElement', text : copy.name,
                            x : 100, y : 50, w : 300, h : 50,
                            alignment : 'center'
                        },
                        {
                            className : 'TextElement', text : copy.name2,
                            x : 500, y : 50, w : 300, h : 50,
                            alignment : 'center'
                        }
                    ]
                }, GEorigin );
            }, 100 );
        } else {
            iwin.postMessage( {
                type : 'load group',
                group : copy
            }, GEorigin );
        }
        callback( element, iframe );
    } );
    // When the group has been displayed for the first time, we may wish to
    // transmit additional options, asking that visualization to highlight
    // certain elements, for example.  See comments below.
    window.addEventListener( 'message', function ( event ) {
        if ( event.data == 'listener ready' ) {
            var jsonToPost = { };
            if ( highlights ) jsonToPost.highlights = highlights;
            if ( arrows ) jsonToPost.arrows = arrows;
            if ( elements ) jsonToPost.elements = elements;
            if ( highlights || arrows ) {
                iwin.postMessage( {
                    json : jsonToPost,
                    source : 'external'
                }, GEorigin );
            }
        }
    }, false );
};
