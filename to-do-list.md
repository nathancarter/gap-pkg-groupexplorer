
# To-do list

## Tasks that will enable me to declare version 0.7.0

 * Add an `ExploreGroupHomomorphism` function as follows:
    * Extend `viz-tool-group-explorer.js`, both is code and its
      documentation, to support opening `Sheet.html`.  In such a case,
      do not send immediately a message of the form
      `{type:'load group',group:...}`, but instead, after a delay of 100ms,
      send the a message of the form `{type:'load from json',json:...}`.
    * Create the GAP function `ExploreGroupHomomorphism` that calls
      `CreateVisualization` with parameters very similar to how
      `ExploreGroup` calls it, but using the "Sheet.html" URL instead.
      This will not yet do anything other than show a blank sheet; see
      below to fix this.
    * Extend GE's `Sheet.html` with an event listener that hears messages
      from the parent context, and if they are of the form
      `{type:'load from json',json:...}`, then it calls its global
      `loadSheetFromJSON` function on the `json` member of that message.
      Test this by having `viz-tool-group-explorer.js` pass this message:
      `[{className:'TextElement',text:`test`,x:100,y:100,w:100,h:100}]`.
    * In GE, extend `VisualizerElement`'s `fromJSON` routine so that it
      can support JSON without a `groupURL` field, but a `multtable` field
      instead.
    * Also extend `VisualizerElement`'s `edit` routine so that, if it does
      not have a `groupURL`, but rather a `multtable`, then rather than
      load the large visualizer page with a `groupURL` entry in its query
      string, it loads it without a group and then posts the 'load group'
      message once loading is complete, just like
      `viz-tool-group-explorer.js` does.  Ensure that the large
      visualizer does not post the 'listener ready' message until the group
      has been loaded.
    * Test all the above by having `viz-tool-group-explorer.js` no longer
      pass a message about a text element, but now one of this form:
      `[{className:'CDElement',multtable:...,x:100,y:100,w:200,h:200}]`.
    * Once that works, update `ExploreGroupHomomorphism` to accept an
      actual GAP group homomorphism, convert the domain and codomain into
      JSON using `GPEX_MakeMultTable`, and pass that to
      `viz-tool-group-explorer.js`, which then does the correct thing with
      it, that is, produces two visualizers side-by-side in the sheet, with
      enough space between them for morphism arrows later.
    * Extend `ExploreGroupHomomorphism` with an option in its third
      parameter to choose the visualizer type (CD, CG, MT), and respect
      that in the data passed to `viz-tool-group-explorer.js`, and thus in
      the JSON that creates the sheet.
    * Create a GAP function for converting a group homomorphism into a
      list of pairs of indices into `Elements( domain )` and
      `Elements( codomain )`, respectively.  The result should be of the
      form `[[#,#],[#,#],...]` where each `#` is a non-negative integer,
      altered to be zero-based, for JavaScript's benefit.
    * Complete `ExploreGroupHomomorphism` by having it pass this JSON form
      to `viz-tool-group-explorer.js`.
    * Complete `viz-tool-group-explorer.js` by having it do the correct
      thing with that data (creating a morphism JSON object of the following
      form):
```json
{
    "className" : "MorphismElement",
    "name" : "...",
    "fromIndex" : 0,
    "toIndex" : 1,
    "showManyArrows" : true,
    "showInjSurj" : true,
    "definingPairs" : [ [ 0, 0 ], ... ]
}
```

## Tasks that will enable me to declare version 0.9.0

 * Add an option to the "more" parameter of `ExploreGroup` that tells it
   to just return the record it creates rather than calling
   `CreateVisualization` on it, so that we can add much more thorough
   testing of the package.  Then add that testing.

## Tasks that will enable me to declare version 1.0.0

 * Ask others to check over this package and give bug feedback.
 * When testing complete, run ReleaseTools to generate the first release.

## Miscellaneous tasks

 * Add a feature to Group Explorer so that if it is displaying a group
   that was loaded from `waitForMessage` with an explicit multiplication
   table, it will let the user search for that group in the built-in GE
   library, and will let the user switch to that representation.
