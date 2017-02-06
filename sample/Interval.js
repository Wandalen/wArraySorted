
if( typeof module !== 'undefined' )
{
  require( '../staging/abase/component/ArraySorted.s' );
}

var _ = wTools;
var arr = [ 1,3,5,7,9,12,16 ];

var interval = [ 0, 1 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpInterval Interval:  [ 0, 1 ] Result range:  [ 0, 1 ]

var interval = [ -1, 5 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpInterval Interval:  [ -1, 5 ] Result range:  [ 0, 3 ]

var interval = [ 1, 9 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpInterval Interval:  [ 1, 9 ] Result range:  [ 0, 5 ]

var interval = [ 9, 18 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpInterval Interval:  [ 9, 18 ] Result range:  [ 4, 7 ]

var interval = [ 17, 20 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpInterval Interval:  [ 17, 20 ] Result range:  [ 7, 7 ]

var interval = [ 10, 11 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpInterval Interval:  [ 10, 11 ] Result range:  [ 5, 5 ]

var arr = [ 0,0,0,0,1,1,1,1 ];
var interval = [ 0, 1 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval',"Interval: ",interval,"Result range: ", range );
// arraySortedLookUpInterval Interval:  [ 0, 1 ] Result range:  [ 0, 8 ]
