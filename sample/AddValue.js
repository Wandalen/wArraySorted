if( typeof module !== 'undefined' )
{
  require( '../staging/dwtools/abase/component/ArraySorted.s' );
}

var _ = wTools;
var arr = [ 1,2,5,9 ];

var e = 0
var i = _.arraySortedAdd( arr,e );
console.log( 'arraySortedAdd(',e,') inserted to index :',i, "array: ", arr );
// arraySortedAdd( 0 ) inserted to index : 0 array:  [ 0, 1, 2, 5, 9 ]


var e = 4
var i = _.arraySortedAdd( arr,e );
console.log( 'arraySortedAdd(',e,') inserted to index :', i, "array: ", arr );
// arraySortedAdd( 4 ) inserted to index : 3 array:  [ 0, 1, 2, 4, 5, 9 ]


var e = 10
var i = _.arraySortedAdd( arr,e );
console.log( 'arraySortedAdd(',e,') inserted to index :', i, "array: ", arr );
// arraySortedAdd( 10 ) inserted to index : 6 array:  [ 0, 1, 2, 4, 5, 9, 10 ]

var src = [ 3,6,8 ];
var i = _.arraySortedAddArray( arr,src );
console.log( 'arraySortedAddArray(',src,') sum of indexes:', i, "array: ", arr );
// arraySortedAdd( 10 ) inserted to index : 6 array:  [ 0, 1, 2, 4, 5, 9, 10 ]
