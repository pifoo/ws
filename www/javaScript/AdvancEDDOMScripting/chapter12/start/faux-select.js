var FauxSelectConductor = {
  // A list of all the faux-SELECTs
  list:       [],
  // The faux-select specific CSS styles
  cssFile:    'faux-select.css',
  // The layer for the faux-SELECT
  zindex:      10000,
  // The maximum size of the dropdown
  maxHeight:   300,
  // BODY height
  bodyHeight:  0,
  // "model" elements
  elements:   { li:  document.createElement( 'li' ),
                div: document.createElement( 'div' ),
                p:   document.createElement( 'p' ),
                ul:  document.createElement( 'ul' ) },
  initialize: function( params ){
    // collect the params

    // set the BODY height

    // attach the standard CSS file

    // collect the SELECTs
      // loop through the collection
      // give the SELECT an ID if it doesn't have one
      // make it into a FauxSelect
  }
};

var FauxSelect = Class.create();
FauxSelect.prototype = {
  // the ID of the SELECT
  id:         false,
  // the original SELECT element
  select:     false,
  // the DIV containing the faux-SELECT
  container:  false,
  // the faux-SELECT UL
  faux:       false,
  // the faux-SELECT P (seen as the selected value)
  value:      false,
  // The closer DIV for this faux-SELECT
  closer:     false,
  // type of SELECT (standard, multiple, or optgrouped)
  type:       'standard',
  // keep the faux-SELECT from closing? fixes a blur bug
  preventClose: false,
  initialize: function( id ){
    // builds our faux-SELECT and sets up the event handlers
  },

  // --- DOM Building Methods
  makeFake:   function( node ){
    // we will use this to make OPTIONS, but eventually for more
  },

  // --- faux-SELECT Actions
  open:        function(){
    // opens the faux-SELECT
  },
  close:       function(){
    // closes the faux-SELECT
  },
  flip: function(){
    // flips CLASSes and performs other housekeeping
  },

  // --- Faux-SELECT Events
  clickValue: function(){
    // value click event handler
  },
  clickUL: function() {
    /* what happens when you click inside the UL;
       used for managing a browser bug */
  },
  clickLI:     function(){
    // faux-OPTION click event handler
  },
  mouseoverLI: function(){
    // faux-OPTION mouseover event handler
  },
  mouseoutLI:  function(){
    // faux-OPTION mouseout event handler
  },

  // --- Faux-SELECT Housekeeping
  selectLI:    function(){
    // updates the real SELECT & selects a faux-OPTION
  },
  deselectLI:  function(){
    // de-select a faux-OPTION
  },

  // --- Real SELECT Events
  focus:      function(){
    // SELECT focus event handler
  },
  blur:       function(){
    // SELECT blur event handler
  },
  updateFaux: function(){
    /* updates the faux-SELECT from the real one
       (used for keyboard events) */
  }
};