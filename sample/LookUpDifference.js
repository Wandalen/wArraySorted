if( typeof module !== 'undefined' )
{
  require( '../staging/dwtools/abase/component/ArraySorted.s' );
}

var _ = wTools;
var arr = [ 0,1,4,5 ];

var interval = [ 2, 5 ];

console.log( "Array", arr );
console.log( "Interval", interval );

var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval looks for elements from interval that exists in array and returns range where this elements are locaded.
// arraySortedLookUpInterval( [ 2, 5 ] ) : [ 2, 4 ]


var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace(',interval,') :',range );
/*
 arraySortedLookUpEmbrace  returns range where all elements from interval can be located even if they do not exist in the current array, range can go out of interval
 boundaries for minimal possible value;
 arraySortedLookUpEmbrace( [ 2, 5 ] ) : [ 1, 4 ]
*/
