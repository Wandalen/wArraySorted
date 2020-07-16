
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;
var arr = [ 1,2,5,9 ];

var e = 0
var i = _.arraySortedLookUpClosest( arr,e );
console.log( 'arraySortedLookUpClosest(',e,') :',i );
// arraySortedLookUpClosest( 0 ) : { value: 1, index: 0 }


var e = 1
var i = _.arraySortedLookUpClosest( arr,e );
console.log( 'arraySortedLookUpClosest(',e,') :',i );
// arraySortedLookUpClosest( 1 ) : { value: 1, index: 0 }


var e = 4
var i = _.arraySortedLookUpClosest( arr,e );
console.log( 'arraySortedLookUpClosest(',e,') :',i );
// arraySortedLookUpClosest( 4 ) : { value: 5, index: 2 }


var e = 5
var i = _.arraySortedLookUpClosest( arr,e );
console.log( 'arraySortedLookUpClosest(',e,') :',i );
// arraySortedLookUpClosest( 5 ) : { value: 5, index: 2 }


var e = 10
var i = _.arraySortedLookUpClosest( arr,e );
console.log( 'arraySortedLookUpClosest(',e,') :',i );
// arraySortedLookUpClosest( 10 ) : { value: undefined, index: 4 }
