
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;
var arr = [ 1,2,5,9 ];

var e = 0
var i = _.sorted.add( arr,e );
console.log( 'sorted.add(',e,') inserted to index :',i, "array: ", arr );
// sorted.add( 0 ) inserted to index : 0 array:  [ 0, 1, 2, 5, 9 ]


var e = 4
var i = _.sorted.add( arr,e );
console.log( 'sorted.add(',e,') inserted to index :', i, "array: ", arr );
// sorted.add( 4 ) inserted to index : 3 array:  [ 0, 1, 2, 4, 5, 9 ]


var e = 10
var i = _.sorted.add( arr,e );
console.log( 'sorted.add(',e,') inserted to index :', i, "array: ", arr );
// sorted.add( 10 ) inserted to index : 6 array:  [ 0, 1, 2, 4, 5, 9, 10 ]

var src = [ 3,6,8 ];
var i = _.sorted.addArray( arr,src );
console.log( 'sorted.addArray(',src,') sum of indexes:', i, "array: ", arr );
// sorted.add( 10 ) inserted to index : 6 array:  [ 0, 1, 2, 4, 5, 9, 10 ]
