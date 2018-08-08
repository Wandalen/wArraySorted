( function _ArraySorted_s_() {

'use strict';

/**
  @module Tools/base/ArraySorted - Collection of routines to operate effectively sorted arrays. For that ArraySorted provides customizable quicksort algorithm and a dozen functions to optimally find/add/remove single/multiple elements into a sorted array, add/remove sorted array to/from another sorted array. Use it to increase the performance of your algorithms.
*/

/**
 * @file ArraySorted.s.
 */

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

}

//

var Self = _global_.wTools;
var _global = _global_;
var _ = _global_.wTools;

// --
// array sorted
// --

/**
 * Bin search of element ( ins ) in array ( arr ). Find element with closest value.
 * If array does not have such element then return index of smallest possible greater element.
 * If array does not have such element then element previous to returned is smaller.
 * Could return index of the next ( non-existent ) after the last one element.
 * Zero is the least possible returned index.
 * Could return index of any element if there are several elements with such value.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { Function } comparator - A callback function.
 * @param { Number } left - The index to start the search at.
 * @param { Number } right - The index to end the search at.
 *
 * @example
 * // returns 4
 * _arraySortedLookUpAct( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 0, 5 );
 *
 * @example
 * // returns 5
 * _arraySortedLookUpAct( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b }, 0, 5 );
 *
 * @returns { Number } Returns the first index at which a given element (ins)
 * can be found in the array (arr).
 * Otherwise, if (ins) was not found, it returns the length of the array (arr) or the index from which it ended search at.
 * @method _arraySortedLookUpAct
 * @memberof wTools
 */

function _arraySortedLookUpAct( arr,ins,comparator,left,right )
{

  _.assert( right >= 0 );
  _.assert( left <= arr.length );

  var oleft = left;
  var oright = right;

  var d = 0;
  var current = ( left + right ) >> 1;

  /* */

  while( left < right )
  {

    var d = comparator( arr[ current ],ins );

    if( d < 0 )
    {
      left = current + 1;
      current = ( left + right ) >> 1;
    }
    else if( d > 0 )
    {
      right = current;
      current = ( left + right ) >> 1;
    }
    else return current;

  }

  /* */

  if( current < arr.length )
  {
    var d = comparator( arr[ current ],ins );
    if( d === 0 )
    return current;
    if( d < 0 )
    current += 1;
  }

  /*  */

  if( Config.debug )
  {

    /* current element is greater */
    if( _.numberIs( ins ) && current > oleft )
    if( current < oright )
    _.assert( comparator( arr[ current ],ins ) > 0 );

    /* next element is greater */
    if( _.numberIs( ins ) )
    if( current+1 < oright )
    _.assert( comparator( arr[ current+1 ],ins ) > 0 );

    /* prev element is smaller */
    if( _.numberIs( ins ) )
    if( current-1 >= oleft )
    _.assert( comparator( arr[ current-1 ],ins ) < 0 );

  }

  return current;
}

//

function arraySortedLookUpIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var index = this._arraySortedLookUpAct( arr,ins,comparator,0,arr.length );

  if( index === arr.length )
  return -1;

  if( comparator( ins,arr[ index ] ) !== 0 )
  return -1;

  return index;
}

//

function arraySortedLookUpValue( arr,ins,comparator )
{
  var index = arraySortedLookUpIndex.apply( this, arguments );
  return arr[ index ];
}

//

/**
 * The arraySortedLookUp() method returns a new object containing the properties, (value, index),
 * corresponding to the found value (ins) from array (arr).
 *
 * @see {@link wTools._arraySortedLookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [comparator=function( a, b ) { return a - b }] comparator - A callback function.
 *
 * @example
 * // returns { value : 5, index : 4 }
 * arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
 *
 * @example
 * // returns undefined
 * arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
 *
 * @returns { Object } Returns a new object containing the properties, (value, index),
 * corresponding to the found value (ins) from the array (arr).
 * Otherwise, it returns 'undefined'.
 * @method arraySortedLookUp
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function arraySortedLookUp( arr,ins,comparator )
{
  var index = arraySortedLookUpIndex.apply( this, arguments );
  return { value : arr[ index ], index : index };
}

//

function arraySortedLookUpClosestIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var index = this._arraySortedLookUpAct( arr,ins,comparator,0,arr.length );

  return index;
}

//

function arraySortedLookUpClosestValue( arr,ins,comparator )
{
  var index = arraySortedLookUpClosestIndex.apply( this, arguments );
  return arr[ index ];
}

//

function arraySortedLookUpClosest( arr,ins,comparator )
{
  var index = arraySortedLookUpClosestIndex.apply( this, arguments );
  return { value : arr[ index ], index : index };
}

//

function arraySortedLookUpInterval( arr,interval,comparator )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var length = arr.length;
  var b = _._arraySortedLeftMostIndex( arr,interval[ 0 ],comparator,0,length );

  if( b === length || comparator( arr[ b ],interval[ 1 ] ) > 0 )
  return [ b,b ];

  var e = _._arraySortedRightMostIndex( arr,interval[ 1 ],comparator,b+1,length );

  if( comparator( arr[ e ],interval[ 1 ] ) <= 0 )
  e += 1;

  if( Config.debug )
  {

    if( b < length )
    _.assert( arr[ b ] >= interval[ 0 ] );

    if( b > 0 )
    _.assert( arr[ b-1 ] < interval[ 0 ] );

    if( e < length )
    _.assert( arr[ e ] > interval[ 1 ] );

    if( e > 0 )
    _.assert( arr[ e-1 ] <= interval[ 1 ] );

  }

  return [ b,e ]
}

//

function arraySortedLookUpIntervalNarrowest( arr,interval,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var length = arr.length;
  var b = _._arraySortedRightMostIndex( arr,interval[ 0 ],comparator,0,length );

  // if( comparator( arr[ b ],interval[ 1 ] ) > 0 )
  // debugger;

  // if( b === length || comparator( arr[ b ],interval[ 1 ] ) > 0 )

  if( b === length )
  if( comparator( arr[ b - 1 ],interval[ 0 ] ) < 0 )
  return [ b,b ];

  if( b === 0 )
  if( comparator( arr[ b ],interval[ 1 ] ) > 0 )
  return [ b,b ];

  var e = _._arraySortedLeftMostIndex( arr,interval[ 1 ],comparator,b+1,length );

  if( comparator( arr[ e - 1 ],interval[ 1 ] ) > 0)
  e -= 1;

  if( comparator( arr[ e ],interval[ 1 ] ) <= 0 )
  e += 1;

  if( Config.debug )
  {

    if( b < length )
    _.assert( arr[ b ] >= interval[ 0 ] );

    if( b > 0 )
    _.assert( arr[ b-1 ] <= interval[ 0 ] );

    if( e < length )
    _.assert( arr[ e ] >= interval[ 1 ] );

    if( e > 0 )
    _.assert( arr[ e-1 ] <= interval[ 1 ] );

  }

  return [ b,e ]
}

//

function arraySortedLookUpEmbrace( arr,interval,comparator )
{
  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var length = arr.length;
  var b = _._arraySortedRightMostIndex( arr,interval[ 0 ],comparator,0,length );

  if( length === 0 )
  debugger;

  if( 0 < b && b < length )
  if( comparator( arr[ b ],interval[ 0 ] ) > 0 )
  b -= 1;

  if( b === length || comparator( arr[ b ],interval[ 1 ] ) > 0 )
  return [ b,b ];

  var e = _._arraySortedLeftMostIndex( arr,interval[ 1 ],comparator,b+1,length );

  // if( comparator( arr[ e ],interval[ 1 ] ) <= 0 )
  if( e > 0 )
  {
    if( e < length )
    if( comparator( arr[ e-1 ],interval[ 1 ] ) < 0 )
    e += 1;
  }
  else
  {
    _.assert( length > 0 );
    if( comparator( arr[ e ],interval[ 1 ] ) <= 0 )
    e += 1;
  }

  if( Config.debug )
  {

    // if( b < length )
    // _.assert( arr[ b ] >= interval[ 0 ] );

    if( b > 0 )
    _.assert( arr[ b-1 ] <= interval[ 0 ] );

    if( e < length )
    _.assert( arr[ e ] >= interval[ 1 ] );

    // if( e > 0 )
    // _.assert( arr[ e-1 ] <= interval[ 1 ] );

  }

  return [ b,e ]
}

//

function _arraySortedLeftMostIndex( arr,ins,comparator,left,right )
{

  _.assert( arguments.length === 5 );

  var comparator = _._comparatorFromEvaluator( comparator );
  var index = _._arraySortedLookUpAct( arr,ins,comparator,left,right );

  if( index === right )
  return right;

  var val = arr[ index ];
  var c = comparator( val,ins );

  if( c !== 0 )
  return index;

  var i = index-1;
  while( i > -1 )
  {
    if( arr[ i ] !== val )
    break;
    i -= 1;
  }

  index = i + 1;

  return index;
}

//

function arraySortedLeftMostIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  if( !arr.length )
  return 0;

  var l = arr.length;
  var comparator = _._comparatorFromEvaluator( comparator );
  var index = _._arraySortedLeftMostIndex( arr,ins,comparator,0,l );

  return index;
}

//

function arraySortedLeftMostValue( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  var index = _.arraySortedLeftMostIndex( arr,ins,comparator );
  var result = arr[ index ];

  return result;
}

//

function arraySortedLeftMost( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  var index = _.arraySortedLeftMostIndex( arr,ins,comparator );
  var result = { index : index, value : arr[ index ] };

  return result;
}

//

function _arraySortedRightMostIndex( arr,ins,comparator,left,right )
{

  _.assert( arguments.length === 5 );

  var comparator = _._comparatorFromEvaluator( comparator );
  var index = _._arraySortedLookUpAct( arr,ins,comparator,left,right );

  if( index === right )
  return right;

  var val = arr[ index ];
  var c = comparator( val,ins );

  if( c !== 0 )
  return index;

  var i = index+1;
  while( i < right )
  {
    if( arr[ i ] !== val )
    break;
    i += 1;
  }

  index = i - 1;

  return index;
}

//

function arraySortedRightMostIndex( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  if( !arr.length )
  return 0;

  var l = arr.length;
  var comparator = _._comparatorFromEvaluator( comparator );
  var index = _._arraySortedRightMostIndex( arr,ins,comparator,0,l );

  return index;
}

//

function arraySortedRightMostValue( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  var index = _.arraySortedRightMostIndex( arr,ins,comparator );
  var result = arr[ index ];

  return result;
}

//

function arraySortedRightMost( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );

  var index = _.arraySortedRightMostIndex( arr,ins,comparator );
  var result = { index : index, value : arr[ index ] };

  return result;
}

// //
//
// function arraySortedClosestIndex( arr,ins,comparator )
// {
//
//   _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
//   _.assert( _.longIs( arr ) );
//
//   if( !arr.length )
//   return 0;
//
//   var l = arr.length;
//   var comparator = _._comparatorFromEvaluator( comparator );
//   var index = _._arraySortedLookUpAct( arr,ins,comparator,0,l );
//
//   if( index === l )
//   return l-1;
//
//   var c = comparator( arr[ index ],ins );
//
//   if( c  === 0 )
//   return index;
//
//   if( c < 0 )
//   {
//     throw _.err( 'redundant branch?' );
//     if( ( arr.length-1 ) === index )
//     return index;
//     else if( Math.abs( comparator( arr[ index + 1 ],ins ) ) < Math.abs( c ) )
//     return index+1;
//     else
//     return index;
//   }
//
//   if( c > 0 )
//   {
//     if( 0 === index )
//     return index;
//     else if( Math.abs( comparator( arr[ index - 1 ],ins ) ) < Math.abs( c ) )
//     return index-1;
//     else
//     return index;
//   }
//
// }
//
// //
//
// function arraySortedClosestValue( arr,ins,comparator )
// {
//
//   _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
//
//   var index = _.arraySortedClosestIndex( arr,ins,comparator );
//   var result = arr[ index ];
//
//   return result;
// }
//
// //
//
// function arraySortedClosest( arr,ins,comparator )
// {
//
//   _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
//
//   var index = _.arraySortedClosestIndex( arr,ins,comparator );
//   var result = { index : index, value : arr[ index ] };
//
//   return result;
// }

//

/**
 * The arraySortedRemove() method returns true, if a value (ins) was removed from an array (arr).
 * Otherwise, it returns false.
 *
 * @see {@link wTools._arraySortedLookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns true
 * arraySortedRemove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4 ]
 *
 * @example
 * // returns false
 * arraySortedRemove( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5 ]
 *
 * @returns { Boolean } Returns true, if a value (ins) was removed from an array (arr).
 * Otherwise, it returns false.
 * @method arraySortedRemove
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function arraySortedRemove( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var l = arr.length;
  var index = _._arraySortedLookUpAct( arr,ins,comparator,0,l );

  var remove = index !== l && comparator( ins,arr[ index ] ) === 0;

  if( remove ) arr.splice( index,1 );

  return remove;
}

//

/**
 * The arraySortedAddOnce() method returns true, if a value (ins) was added to an array (arr).
 * Otherwise, it returns false.
 *
 * It calls the method (_._arraySortedLookUpAct( arr, ins, comparator, 0, arr.length - 1 )),
 * that returns the index of the value (ins) in the array (arr).
 * [wTools._arraySortedLookUpAct() ]{@link wTools._arraySortedLookUpAct}.
 * If (index) is equal to the one, and call callback function(comparator( ins, arr[ index ])
 * returns a value that is not equal to the zero (i.e the array (arr) doesn't contain the value (ins)), it adds the value (ins) to the array (arr), and returns true.
 * Otherwise, it returns false.
 *
 * @see {@link wTools._arraySortedLookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns false
 * arraySortedAddOnce( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5 ]
 *
 * @example
 * // returns true
 * arraySortedAddOnce( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5, 55 ]
 *
 * @returns { Boolean } Returns true, if a value (ins) was added to an array (arr).
 * Otherwise, it returns false.
 * @method arraySortedAddOnce
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function arraySortedAddOnce( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var l = arr.length;
  var index = _._arraySortedLookUpAct( arr,ins,comparator,0,l );

  var add = index === l || comparator( ins,arr[ index ] ) !== 0;

  if( add )
  arr.splice( index,0,ins );

  return add;
}

//

/**
 * The arraySortedAdd() method adds the value (ins) to the array (arr), no matter whether it has there or hasn't,
 * and returns the new added or the updated index.
 *
 * It calls the method (_._arraySortedLookUpAct( arr, ins, comparator, 0, arr.length - 1 )),
 * that returns the index of the value (ins) in the array (arr).
 * [wTools._arraySortedLookUpAct() ]{@link wTools._arraySortedLookUpAct}.
 * If value (ins) has in the array (arr), it adds (ins) to that found index and offsets the old values in the (arr).
 * Otherwise, it adds the new index.
 *
 * @see {@link wTools._arraySortedLookUpAct} - See for more information.
 *
 * @param { longIs } arr - Entity to check.
 * @param { Number } ins - Element to locate in the array.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns 5
 * arraySortedAdd( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } ); // => [ 1, 2, 3, 4, 5, 5 ]
 *
 * @example
 * // returns 4
 * arraySortedAdd( [ 1, 2, 3, 4 ], 2, function( a, b ) { return a - b } ); // => [ 1, 2, 2, 3, 4 ]
 *
 * @returns { Number } Returns the new added or the updated index.
 * @method arraySortedAdd
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (arr) is not an array-like.
 * @memberof wTools
 */

function arraySortedAdd( arr,ins,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( arr ) );

  var comparator = _._comparatorFromEvaluator( comparator );
  var l = arr.length;
  var index = _._arraySortedLookUpAct( arr,ins,comparator,0,l );

  arr.splice( index,0,ins );

  return index;
}

//

/**
 * The arraySortedAddArray() method returns the sum of the added indexes from an array (src) to an array (dst).
 *
 * It creates variable (result = 0), iterates over an array (src),
 * adds to the (result +=) each call the function(arraySortedAdd( dst, src[ s ], comparator ))
 * that returns the new added or the updated index.
 *
 * @see {@link wTools_.arraySortedAdd} - See for more information.
 *
 * @param { longIs } dst - Entity to check.
 * @param { longIs } src - Entity to check.
 * @param { wTools~compareCallback } [ comparator = function( a, b ) { return a - b } ] comparator - A callback function.
 *
 * @example
 * // returns 19
 * arraySortedAddArray( [ 1, 2, 3, 4, 5 ], [ 6, 7, 8, 2 ], function( a, b ) { return a - b } ); // => [ 1, 2, 2, 3, 4, 5, 6, 7, 8 ]
 *
 * @example
 * // returns 3
 * arraySortedAddArray( [  ], [ 1, 2, 3 ], function( a, b ) { return a - b } ); // => [ 1, 2, 3 ]
 *
 * @returns { Number } Returns the sum of the added indexes from an array (src) to an array (dst).
 * @method arraySortedAddArray
 * @throws { Error } Will throw an Error if (arguments.length) is less than two or more than three.
 * @throws { Error } Will throw an Error if (dst and src) are not an array-like.
 * @memberof wTools
 */

function arraySortedAddArray( dst,src,comparator )
{

  _.assert( arguments.length === 2 || arguments.length === 3, 'expects two or three arguments' );
  _.assert( _.longIs( dst ) && _.longIs( src ) );

  debugger;

  var result = 0;
  var comparator = _._comparatorFromEvaluator( comparator );

  for( var s = 0 ; s < src.length ; s++ )
  result += _.arraySortedAdd( dst,src[ s ],comparator );

  return result;
}

// --
// define class
// --

var Proto =
{

  // array sorted

  // _comparatorFromEvaluator : _comparatorFromEvaluator,

  _arraySortedLookUpAct : _arraySortedLookUpAct,

  arraySortedLookUpIndex : arraySortedLookUpIndex,
  arraySortedLookUpValue : arraySortedLookUpValue,
  arraySortedLookUp : arraySortedLookUp,

  arraySortedLookUpClosestIndex : arraySortedLookUpClosestIndex,
  arraySortedLookUpClosestValue : arraySortedLookUpClosestValue,
  arraySortedLookUpClosest : arraySortedLookUpClosest,

  arraySortedLookUpInterval : arraySortedLookUpInterval,
  arraySortedLookUpIntervalNarrowest : arraySortedLookUpIntervalNarrowest, /* experimental */
  arraySortedLookUpEmbrace : arraySortedLookUpEmbrace,

  _arraySortedLeftMostIndex : _arraySortedLeftMostIndex,
  arraySortedLeftMostIndex : arraySortedLeftMostIndex,
  arraySortedLeftMostValue : arraySortedLeftMostValue,
  arraySortedLeftMost : arraySortedLeftMost,

  _arraySortedRightMostIndex : _arraySortedRightMostIndex,
  arraySortedRightMostIndex : arraySortedRightMostIndex,
  arraySortedRightMostValue : arraySortedRightMostValue,
  arraySortedRightMost : arraySortedRightMost,

  // arraySortedClosestIndex : arraySortedClosestIndex,
  // arraySortedClosestValue : arraySortedClosestValue,
  // arraySortedClosest : arraySortedClosest,

  arraySortedRemove : arraySortedRemove,
  arraySortedAdd : arraySortedAdd,
  arraySortedAddOnce : arraySortedAddOnce,
  arraySortedAddArray : arraySortedAddArray,

}

_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
