
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;
var arr = [ 0, 1, 4, 5 ];

var interval = [ 2, 5 ];

console.log( 'Array', arr );
console.log( 'Interval', interval );

var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
// sorted.lookUpInterval looks for elements from interval that exists in array and returns range where this elements are locaded.
// sorted.lookUpInterval( [ 2, 5 ] ) : [ 2, 4 ]


var range = _.sorted.lookUpInterval( arr, interval );
console.log( 'sorted.lookUpInterval(', interval, ') :', range );
/*
 sorted.lookUpInterval  returns range where all elements from interval can be located even if they do not exist in the current array, range can go out of interval
 boundaries for minimal possible value;
 sorted.lookUpInterval( [ 2, 5 ] ) : [ 1, 4 ]
*/
