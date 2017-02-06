if( typeof module !== 'undefined' )
{
  require( '../staging/abase/component/ArraySorted.s' );
}

var _ = wTools;
var arr = [ 0,1,4,5 ];

var interval = [ 2, 5 ];

console.log( "Array", arr );
console.log( "Interval", interval );

var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval result: ', range );
// arraySortedLookUpInterval looks for elements from interval that exists in array and returns range where this elements are locaded.
// arraySortedLookUpInterval result:  [ 2,4 ]


var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace result: ', range );
/*
 arraySortedLookUpEmbrace  returns range where all elements from interval can be located even they not exists in the current array, can go out of interval
 boundaries for minimal possible value;
 arraySortedLookUpEmbrace result:  [ 1, 4 ]
*/
