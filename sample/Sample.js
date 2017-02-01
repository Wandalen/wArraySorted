
if( typeof module !== 'undefined' )
{
  require( 'wArraySorted' );
}

var _ = wTools;
var arr = [ 1,2,5,9 ];

var e = 0
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex',e,i );
// arraySortedLookUpIndex 0 0

var e = 1
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex',e,i );
// arraySortedLookUpIndex 1 0

var e = 4
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex',e,i );
// arraySortedLookUpIndex 4 2

var e = 5
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex',e,i );
// arraySortedLookUpIndex 5 2

var e = 10
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex',e,i );
// arraySortedLookUpIndex 10 4
