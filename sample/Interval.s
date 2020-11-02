
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;
var arr = [ 1, 3, 5, 8, 9, 12, 16 ];

var interval = [ 7, 12 ];
var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
// sorted.lookUpInterval( [ 7, 12 ] ) : [ 3, 6 ]

var interval = [ -1, 16 ];
var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
// sorted.lookUpInterval( [ -1, 16 ] ) : [ 0, 7 ]

var interval = [ 3, 10 ];
var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
// sorted.lookUpInterval( [ 3, 10 ] ) : [ 1, 5 ]

var interval = [ 12, 17 ];
var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
// sorted.lookUpInterval( [ 12, 17 ] ) : [ 5, 7 ]

var interval = [ 6, 7 ];
var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
// sorted.lookUpInterval( [ 6, 7 ] ) : [ 3, 3 ]

var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

var interval = [ 0, 1 ];
var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
// sorted.lookUpInterval( [ 0, 1 ] ) : [ 0, 8 ]
