
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;
var arr = [ 1,2,5,9 ];

var e = 0
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex(',e,') :',i );
// arraySortedLookUpIndex( 0 ) : -1

var e = 1
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex(',e,') :',i );
// arraySortedLookUpIndex( 1 ) : 0

var e = 4
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex(',e,') :',i );
// arraySortedLookUpIndex( 4 ) : -1

var e = 5
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex(',e,') :',i );
// arraySortedLookUpIndex( 5 ) : 2

var e = 10
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex(',e,') :',i );
// arraySortedLookUpIndex( 10 ) : -1
