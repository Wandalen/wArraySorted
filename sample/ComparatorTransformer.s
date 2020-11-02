
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;

/*transformer*/

var arr = [ 1.5, 2.6, 5.7, 9.8 ];

//transformer - function that makes some calculations on passed values before they will be compared
//default comparison in that case looks like : transformer( a ) - transformer( b )
var transformer = ( value ) =>
{
  var result =  Math.floor( value );
  console.log( 'Math.floor: ', value, '->', result);
  return result;
}

var e = 5;
var i = _.sorted.lookUp( arr, e, transformer );
console.log( 'sorted.lookUp(', e, ') :', i );
// sorted.lookUp( 5 ) : { value: 5.7, index: 2 }


/*comparator*/

var arr = [ 1, 2, 5, 9 ];

//comparator - function that makes comparison between two values
var comparator = ( a, b ) =>
{
  return a - b;
}

var e = 5;
var i = _.sorted.lookUp( arr, e, comparator );
console.log( 'sorted.lookUp(', e, ') :', i );
// sorted.lookUp( 5 ) : { value: 5, index: 2 }


/*Combination of custom transformer and comparator*/

var arr = [ -1, -2, -5, -9 ];

var transformer = ( value ) =>
{
  return Math.abs( value );
}

var comparator = ( a, b ) =>
{
  console.log( 'Comparing: ', a, 'with', b );
  return transformer( a ) - transformer( b );
}

var e = 5;
var i = _.sorted.lookUp( arr, e, comparator );
console.log( 'sorted.lookUp(', e, ') :', i );
// sorted.lookUp( 5 ) : { value: -5, index: 2 }
