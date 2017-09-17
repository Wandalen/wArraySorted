
if( typeof module !== 'undefined' )
require( 'warraysorted' );

var _ = wTools;
var arr = [ 1,3,5,7,9,12,16 ];

var interval = [ 0, 1 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval( [ 0, 1 ] ) : [ 0, 1 ]

var interval = [ -1, 5 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval( [ -1, 5 ] ) : [ 0, 3 ]

var interval = [ 1, 9 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval( [ 1, 9 ] ) : [ 0, 5 ]

var interval = [ 9, 18 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval( [ 9, 18 ] ) : [ 4, 7 ]

var interval = [ 17, 20 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval( [ 17, 20 ] ) : [ 7, 7 ]

var interval = [ 10, 11 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval( [ 10, 11 ] ) : [ 5, 5 ]

var arr = [ 0,0,0,0,1,1,1,1 ];
var interval = [ 0, 1 ];
var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval(',interval,') :',range );
// arraySortedLookUpInterval( [ 0, 1 ] ) : [ 0, 8 ]
