if( typeof module !== 'undefined' )
{
  require( '../staging/abase/component/ArraySorted.s' );
}

var _ = wTools;
var arr = [ 1,3,5,8,9,12,16 ];

var interval = [ 7, 12 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpEmbrace Interval:  [ 7, 12 ] Result range:  [ 2, 6 ]

var interval = [ -1, 16 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpEmbrace Interval:  [ -1, 16 ] Result range:  [ 0, 7 ]

var interval = [ 3, 10 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpEmbrace Interval:  [ 3, 10 ] Result range:  [ 1, 5 ]

var interval = [ 12, 17 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpEmbrace Interval:  [ 12, 17 ] Result range:  [ 5, 7 ]

var interval = [ 6, 7 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpEmbrace Interval:  [ 6, 7 ] Result range:  [ 2, 4 ]

var arr = [ 0,0,0,0,1,1,1,1 ];

var interval = [ 0, 1 ];
var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpEmbrace Interval:  [ 0, 1 ] Result range:  [ 3, 5 ]
