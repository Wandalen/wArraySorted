
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;
var arr = [ 1,2,5,9 ];

var e = 0
var i = _.sorted.lookUpIndex( arr,e );
console.log( 'sorted.lookUpIndex(',e,') :',i );
// sorted.lookUpIndex( 0 ) : -1

var e = 1
var i = _.sorted.lookUpIndex( arr,e );
console.log( 'sorted.lookUpIndex(',e,') :',i );
// sorted.lookUpIndex( 1 ) : 0

var e = 4
var i = _.sorted.lookUpIndex( arr,e );
console.log( 'sorted.lookUpIndex(',e,') :',i );
// sorted.lookUpIndex( 4 ) : -1

var e = 5
var i = _.sorted.lookUpIndex( arr,e );
console.log( 'sorted.lookUpIndex(',e,') :',i );
// sorted.lookUpIndex( 5 ) : 2

var e = 10
var i = _.sorted.lookUpIndex( arr,e );
console.log( 'sorted.lookUpIndex(',e,') :',i );
// sorted.lookUpIndex( 10 ) : -1
