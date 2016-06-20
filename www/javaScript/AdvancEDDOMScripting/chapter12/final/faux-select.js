// -- COLLECT & ENABLE THE FAUX-SELECTS -- //
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
    params = params || {};
    if( typeof( params.maxHeight ) != 'undefined' ) this.maxHeight = params.maxHeight;
    // set the BODY height
    this.bodyHeight = $( document.getElementsByTagName( 'body' )[0] ).getHeight() + 'px';

    // attach the standard CSS file
    var css = document.createElement('link');
        css.setAttribute('rel', 'stylesheet');
        css.setAttribute('type', 'text/css');
        css.setAttribute('href', this.cssFile);
    document.getElementsByTagName( 'head' )[0].appendChild( css );

    // collect the SELECTs
    var selects = $A( document.getElementsByTagName( 'select' ) );
        // loop through the collection
    selects.each( function( item, i ){
      // get the id
      var id = item.getAttribute( 'id' );
      // give the SELECT an ID if it doesn't have one
      if( id === false ){
        id = 'auto-ided-select-' + i;
        item.setAttribute( 'id', id );
      }
      // let us know when one is found
            // make it into a FauxSelect
      this.list[id] = new FauxSelect( id );
    }.bind( this ) );
      }
};
// if Prototype, selects & required DOM methods are available
if( typeof( Prototype ) != 'undefined' &&
    typeof( Fx ) != 'undefined' &&
    document.getElementById &&
    document.getElementsByTagName &&
    document.createElement &&
    document.getElementsByTagName( 'select' ) ){
  Event.observe( window, 'load', function(){
    FauxSelectConductor.initialize( { maxHeight: 300 } );
  }, false );
}

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
    // let us know FauxSelect initialized
        // store the ID
    this.id = id;

    // store the SELECT node
    this.select = $( id );

    // -- BUILD THE FAUX-SELECT -- //
    // create the faux-SELECT UL
    this.faux = $( FauxSelectConductor.elements.ul.cloneNode( true ) );
    this.faux.addClassName('faux-select');
        /* set the width, based on the existing SELECT
       (subtracting any border or padding) */
    this.faux.style.width = (
      parseInt( this.select.getWidth() )
      // Subtract borders
      - parseInt( this.select.getStyle( 'border-left-width' ) )
      - parseInt( this.select.getStyle( 'border-right-width' ) )
      // Subtract padding
      - parseInt( this.select.getStyle( 'padding-left' ) )
      - parseInt( this.select.getStyle( 'padding-right' ) )
    ) + 'px';

    // collect the children & make them enumerable
    var children = $A( this.select.childNodes );
    children.each( function( item, i ){
      if( item.nodeName.toUpperCase() == 'OPTION' ){
        // build the faux-OPTION
        var el = this.makeFake( item );
        // append it to the faux-SELECT
        this.faux.appendChild( el );
      }
    }.bind( this ) );

    /* append the faux-SELECT to the SELECT's parent, but keep it
       invisible because we don't want it to appear quite yet.
       We do need to append it though because we can't get it's
       height (which we'll need in a moment) without doing so */
    this.faux.style.visibility = 'hidden';
    this.select.parentNode.appendChild( this.faux );

    //--- Create a container DIV
    this.container = $( FauxSelectConductor.elements.div.cloneNode( true ) );
    this.container.addClassName( 'faux-container' );
    this.container.setAttribute( 'id', 'replaces_'+id );
    // slide it up the height of the SELECT we're replacing
    this.container.style.marginTop = '-'+ this.select.getHeight() +'px';

    //--- create the value P
    this.value = $( FauxSelectConductor.elements.p.cloneNode( true ) );
    this.value.addClassName( 'faux-value' );
    // set the default selected to be the value
    this.value.appendChild( document.createTextNode(
      this.select.getElementsByTagName(
        'option'
      )[this.select.selectedIndex].firstChild.nodeValue
    ) );
    /* this will be the trigger to open the faux-SELECT,
       so we'll need an event handler */
    Event.observe( this.value, 'click',
                   this.clickValue.bind( this ), false );
    this.container.appendChild( this.value );

    // add the "closed" CLASS to the faux-SELECT
    this.faux.addClassName( 'closed' );
    // set up the height FX for the faux-SELECT so it can open
    this.faux.heightFX = new fx.Style(
      this.faux, 'height',
      { duration: 350,
        onComplete: this.flip.bind( this ) }
    );

    // get the original height of the UL for when it's open
    this.faux.openHeight = this.faux.getHeight();
        /* if this faux-SELECT has a lot of OPTIONs, it could
       end up being overly tall, we need to trim it down
       to a reasonable height, based on whatever we set in
       the FauxSelectConductor */
    if( this.faux.openHeight > FauxSelectConductor.maxHeight ){
      // mark this as an overflowing faux-SELECT
      this.type = 'overflowing';
      // reset the height
      this.faux.openHeight = FauxSelectConductor.maxHeight;
    }
    this.faux.closedHeight = 0;
    // close the faux-SELECT
    this.faux.heightFX.custom( this.faux.openHeight, this.faux.closedHeight );

    // remove the faux-SELECT and re-append to our container
    this.faux.parentNode.removeChild( this.faux );
    this.container.appendChild( this.faux );
    this.select.parentNode.appendChild( this.container );

    // -- BUILD THE CLOSER -- //
    this.closer = $( FauxSelectConductor.elements.div.cloneNode( true ) );
    this.closer.addClassName( 'closer' );
    this.closer.style.height = FauxSelectConductor.bodyHeight;
    /* we will use this hidden div (which we will set to track
       the cursor) to close the faux-SELECT when you click outside of it */
    Event.observe( this.closer, 'click', this.close.bind( this ), false );

    // show the ul
    this.faux.style.visibility = '';

    // -- HANDLE EVENTS ON THE REAL SELECT -- //
    // focus
    Event.observe( this.select, 'focus', this.focus.bind( this ), false );
    // blur
    Event.observe( this.select, 'blur', this.blur.bind( this ), false );
    // typing
    this.select.onkeyup = this.updateFaux.bindAsEventListener( this );
    // clicking (for Safari)
    this.select.onclick = this.updateFaux.bindAsEventListener( this );

    /* Bind a mousedown event to the faux-select to indicate when
       we click the menu. The blur event in some browsers will trigger
       when we try to scroll so we need to prevent the menu from closing. */
    Event.observe( this.faux, 'mousedown', this.clickUL.bind(this), false );

    // -- HIDE THE REAL SELECT -- //
    this.select.addClassName( 'replaced' );
  },

  // --- DOM Building Methods
  makeFake:   function( node ){
        // clone the model LI
    var el = $( FauxSelectConductor.elements.li.cloneNode( true ) );
    // store the faux-OPTION's value
    el.val = node.getAttribute( 'value' );
    // set the faux-OPTION's text value
    el.appendChild( document.createTextNode( node.firstChild.nodeValue ) );
    // check for selected
    if( el.val == this.select.value ) el.addClassName( 'selected' );
    // set the event handlers
    Event.observe( el, 'click', this.clickLI.bind( this ), false ); // click
    Event.observe( el, 'mouseover', this.mouseoverLI, false ); // mouseover
    Event.observe( el, 'mouseout',  this.mouseoutLI,  false ); // mouseout
    return el;
  },

  // --- faux-SELECT Actions
  open:        function(){
        // Indicate the state of the faux-select by removing the
    //   closed class and adding opening
    this.faux.removeClassName( 'closed' );
    this.faux.addClassName( 'opening' );

    // Stop the effect if we're half way through.
    this.faux.heightFX.stop();

    // if this is an overflow scroll to the selected LI
    var heightLI = this.faux.firstChild.getHeight(); // get a sample height
    var top = heightLI * this.select.selectedIndex;
    if( this.type.indexOf( 'overflowing' ) != -1 &&
        ( this.faux.scrollTop > top ||
          this.faux.scrollTop + FauxSelectConductor.maxHeight < top + heightLI ) )
      this.faux.scrollTop = top;
    // Open the fauxSelect by invoking the effect
    this.faux.heightFX.custom(
      this.faux.getHeight(),
      this.faux.openHeight
    );

    // Set the z-index of the faux-SELECT container
    this.container.style.zIndex = FauxSelectConductor.zindex;
    // Set the z-index of the closer to one less than the faux-SELECT container
    this.closer.style.zIndex = FauxSelectConductor.zindex - 1;
    // Append the closer to the document
    document.getElementsByTagName( 'body' )[0].appendChild( this.closer );

    // Trigger the focus event on the select
    this.select.focus();
  },
  close:       function(){
        // Check if the menu is open and if it isn't return
    if( !this.faux.hasClassName( this.type + '-open' ) ) return;

    // Indicate the state of the faux-select by removing the
    // open class and adding closing
    this.faux.removeClassName( this.type + '-open' );
    this.faux.addClassName( 'closing' );

    // Stop the effect if we're half way through.
    this.faux.heightFX.stop();

    // Close the faux-SELECT with an effect
    this.faux.heightFX.custom(
        this.faux.getHeight(),
        this.faux.closedHeight
    );
    // Remove the closer
    this.closer.parentNode.removeChild( this.closer );

    // reset the z-indexes
    this.container.style.zIndex = this.closer.style.zIndex = false;


  },
  flip: function(){
        // If it's opening close it otherwise open it
    if( this.faux.hasClassName( 'opening' ) ){
      // Mark it open
      this.faux.removeClassName( 'opening' );
      this.faux.addClassName( this.type + '-open' );

      // If this is an overflow, scroll to the selected LI
      var heightLI = $( this.faux.firstChild ).getHeight();
      var top = heightLI * this.select.selectedIndex;
      if( this.type == 'overflowing' && (
          this.faux.scrollTop > top || this.faux.scrollTop
          + FauxSelectConductor.maxHeight < top + heightLI ) ) {
        this.faux.scrollTop = top;
      }
    } else {
      // Mark it closed
      this.faux.removeClassName(  'closing' );
      this.faux.addClassName( 'closed' );

      // Ensure all the li elements have their
      // hover class removed. It can stick around
      // because we manually closed the faux-select
      $A( this.faux.childNodes ).each( function( child ){
        if( child.hasClassName( 'hover' ) ) child.removeClassName( 'hover' );
      } );
    }
  },

  // --- Faux-SELECT Events
  clickValue: function(){
    // Open/close the faux-select
    if( this.faux.hasClassName( this.type + '-open' ) ){
      // The faux-SELECT is open
      this.close();
    } else {
      // The faux-SELECT is closed
      this.open();
    }
  },
  clickUL: function() {
        // Prevent closing after a click in the scroll bar.
    this.preventClose = true;
  },
  clickLI:     function( e ){
    var el = Event.element( e );
        // is it a multiple SELECT?
    // normal SELECT behavior
    var fOpts = $$( '#replaces_' + this.id + ' li' );
        this.deselectLI( fOpts[this.select.selectedIndex] );
    this.selectLI( el );
    this.close();
  },
  mouseoverLI: function( e ){
    Event.element(e).addClassName( 'hover' );
  },
  mouseoutLI:  function( e ){
    Event.element(e).removeClassName( 'hover' );
  },

  // --- Faux-SELECT Housekeeping
  selectLI:    function( el ){
        // "select" the faux-OPTION
    $( el ).addClassName( 'selected' );
        // set the faux-SELECT's "value"
    this.select.value = el.val;
    // set the faux-SELECT's "value"
    this.value.firstChild.nodeValue = el.firstChild.nodeValue;
  },
  deselectLI:  function( el ){
        el.removeClassName( 'selected' );
  },
  deselectAll: function( what ){
        if( what == 'real' ||
        typeof( what ) == 'undefined' ){
      // collect the children of the faux-SELECT
      var children = $A( this.select.getElementsByTagName( 'option' ) );
      // iterate through them
      children.each( function( item ){
        // deselect the OPTION
        item.selected = false;
      } );
    }
    if( what == 'faux' ||
        typeof( what ) == 'undefined' ){
      // collect the children of the faux-SELECT
      children = $A( this.faux.getElementsByTagName( 'li' ) );
      // iterate through them
      children.each( function( item ){
        // if the className exists, remove it
        this.deselectLI( item );
      }.bind( this ) );
    }
  },

  // --- Real SELECT Events
  focus:      function(){
        this.value.addClassName( 'focused' );
  },
  blur:       function(){
        this.value.removeClassName( 'focused' );
    if( this.faux.hasClassName( this.type + '-open' ) &&
        !this.preventClose ) this.close();
    /* If preventClose was true, the call to blur wasn't the
       one we wanted. The next one will be so set preventClose
       back to false */
    this.preventClose = false;
  },
  updateFaux: function( e ){
        var el = Event.element( e );
    var fOpts = $$( '#replaces_' + this.id + ' li' );
    /* special case for ALT+Up & ALT+Down allows opening of
       the faux-SELECT without updating the value with each
       keypress. To confirm a value change, ENTER must be
       pressed (see next conditional) */
    if( e.altKey &&
        ( e.keyCode == '38' ||
          e.keyCode == '40' ) ){
      this.clickValue();
      return;
    }
    /* special case for ENTER and ESC to close the faux-select */
    if( this.faux.hasClassName( this.type + '-open' ) &&
        ( e.keyCode == '13' ||
          e.keyCode == '27' ) ){
      this.close();
    }
    if( this.faux.hasClassName( this.type + '-open' ) ){
      var fOpt = false;
      // back
      if( e.keyCode == '37' ||
          e.keyCode == '38' ){
        if( this.select.selectedIndex > 0 )
          fOpt = fOpts[this.select.selectedIndex - 1];
      }
      // forward
      if( e.keyCode == '39' ||
          e.keyCode == '40' ){
        if( this.select.selectedIndex < fOpts.length )
          fOpt = fOpts[this.select.selectedIndex + 1];
      }
      // top
      if( e.keyCode == '33' ||
          e.keyCode == '36' ){
        fOpt = fOpts[0];
      }
      // bottom
      if( e.keyCode == '34' ||
          e.keyCode == '35' ){
        fOpt = fOpts[fOpts.length-1];
      }
      if( fOpt ){
        this.deselectLI( fOpts[this.select.selectedIndex] );
        this.selectLI( fOpt );
      }
    } else {
      this.deselectAll( 'faux' );
      this.selectLI( fOpts[el.selectedIndex] );
    }
    // adjust the scroll if there is one
    if( this.faux.className.indexOf( 'overflowing' ) != -1 &&
        this.faux.hasClassName( this.type + '-open' ) ){
            var ulHeight = this.faux.getHeight();
      var liHeight = $( this.faux.firstChild ).getHeight();
      if( // going down
          ( ( el.selectedIndex+1 ) * liHeight >
            this.faux.scrollTop + ulHeight ) ||
          // going up
          ( ( el.selectedIndex * liHeight ) < this.faux.scrollTop ) ){
        this.faux.scrollTop = el.selectedIndex * liHeight;
      }
    }
  }
};