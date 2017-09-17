if( typeof module !== 'undefined' )
{
  require( '../staging/dwtools/abase/component/ArraySorted.s' );
}

var _ = wTools;
var arr = [ 1,3,5,8,9,12,16 ];

var interval = [ 7, 12 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace(',interval,') :',range );
// arraySortedLookUpEmbrace( [ 7, 12 ] ) : [ 2, 6 ]

var interval = [ -1, 16 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace(',interval,') :',range );
// arraySortedLookUpEmbrace( [ -1, 16 ] ) : [ 0, 7 ]

var interval = [ 3, 10 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace(',interval,') :',range );
// arraySortedLookUpEmbrace( [ 3, 10 ] ) : [ 1, 6 ]

var interval = [ 12, 17 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace(',interval,') :',range );
// arraySortedLookUpEmbrace( [ 12, 17 ] ) : [ 5, 7 ]

var interval = [ 6, 7 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace(',interval,') :',range );
// arraySortedLookUpEmbrace( [ 6, 7 ] ) : [ 2, 4 ]

var arr = [ 0,0,0,0,1,1,1,1 ];

var interval = [ 0, 1 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace(',interval,') :',range );
// arraySortedLookUpEmbrace( [ 0, 1 ] ) : [ 3, 5 ]
