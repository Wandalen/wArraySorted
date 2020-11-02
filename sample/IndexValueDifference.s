
if( typeof module !== 'undefined' )
require( 'warraysorted' );

let _ = wTools;

var arr = [ 1, 2, 5, 9 ];

/*Index  methods returns index( depends on method ) of some element as result or -1 if nothing founded*/

var e = 5;
var i = _.sorted.lookUpIndex( arr,e );
console.log( 'sorted.lookUpIndex(',e,') :',i );
// sorted.lookUpIndex( 5 ) : 2

var e = 55;
var i = _.sorted.lookUpIndex( arr,e );
console.log( 'sorted.lookUpIndex(',e,') :',i );
// sorted.lookUpIndex( 55 ) : -1


/*Value methods returns element value if it exists or undefined if nothing founded*/

var e = 5;
var i = _.sorted.lookUpValue( arr,e );
console.log( 'sorted.lookUpValue(',e,') :',i );
// sorted.lookUpValue( 5 ) : 5

var e = 55;
var i = _.sorted.lookUpValue( arr,e );
console.log( 'sorted.lookUpValue(',e,') :',i );
// sorted.lookUpValue( 55 ) : undefined


/*Non sufix methods returns object with properties: value, index  if element exists
 otherwise object with undefined as value and -1 as index*/

var e = 5;
var i = _.sorted.lookUp( arr,e );
console.log( 'sorted.lookUp(',e,') :',i );
// sorted.lookUp( 5 ) : { value: 5, index: 2 }

var e = 55;
var i = _.sorted.lookUp( arr,e );
console.log( 'sorted.lookUp(',e,') :',i );
// sorted.lookUp( 55 ) : { value: undefined, index: -1 }
