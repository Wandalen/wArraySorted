if( typeof module !== 'undefined' )
{
  require( '../staging/abase/component/ArraySorted.s' );
}

var _ = wTools;

/*transformer*/

var arr = [ 1.5, 2.6, 5.7, 9.8 ];

//transformer - function that makes some calculations on passed values before they will be compared
//default comparison in that case looks like : transformer( a ) - transformer( b )
var transformer = function( value )
{
  var result =  Math.floor( value );
  console.log( "Math.floor: ", value, "->", result);
  return result;
}

var e = 5;
var i = _.arraySortedLookUp( arr,e, transformer );
console.log( 'arraySortedLookUp(',e,') :',i );
// arraySortedLookUp( 5 ) : { value: 5.7, index: 2 }


/*comparator*/

var arr = [ 1, 2, 5, 9 ];

//comparator - function that makes comparison between two values
var comparator = function( a, b )
{
  return a - b;
}

var e = 5;
var i = _.arraySortedLookUp( arr,e, comparator );
console.log( 'arraySortedLookUp(',e,') :',i );
// arraySortedLookUp( 5 ) : { value: 5, index: 2 }


/*Combination of custom transformer and comparator*/

var arr = [ -1, -2, -5, -9 ];

var transformer = function( value )
{
  return Math.abs( value );
}

var comparator = function( a, b )
{
  console.log( "Comparing: ", a, "with", b );
  return transformer( a ) - transformer( b );
}

var e = 5;
var i = _.arraySortedLookUp( arr,e, comparator );
console.log( 'arraySortedLookUp(',e,') :',i );
// arraySortedLookUp( 5 ) : { value: -5, index: 2 }
