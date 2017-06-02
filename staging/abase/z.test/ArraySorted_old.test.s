( function _ArraySorted_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  //if( typeof wBase === 'undefined' )
  try
  {
    require( '../../abase/wTools.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  var _ = wTools;

  _.include( 'wTesting' );

  require( '../component/ArraySorted.s' );

}

//

var _ = wTools;
var Parent = wTools.Testing;

//

function _arraySortedLookUpAct( test )
{

  test.description = 'first argument is empty, so it returns the index from which it ended search at';
  var got = _._arraySortedLookUpAct( [  ], 55, function( a, b ){ return a - b }, 0, 5 );
  var expected = 3;
  test.identical( got, expected );

  test.description = 'returns the last index of the first argument';
  var got = _._arraySortedLookUpAct( [ 1, 2, 3, 4, 5 ], 5, function( a, b ){ return a - b }, 0, 5 );
  var expected = 4;
  test.identical( got, expected );

  test.description = 'second argument was not found, so it returns the length of the first argument';
  var got = _._arraySortedLookUpAct( [ 1, 2, 3, 4, 5 ], 55, function( a, b ){ return a - b }, 0, 5 );
  var expected = 5;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _._arraySortedLookUpAct();
  });

};

//

function arraySortedLookUp( test )
{

  test.description = 'returns an object that containing the found value';
  var got = _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = { value : 5, index : 4 };
  test.identical( got, expected );

  test.description = 'returns undefined';
  var got = _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = undefined;
  test.identical( got, expected );

  test.description = 'call without a callback function';
  var got = _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 3 );
  var expected = { value : 3, index : 2 };
  test.identical( got, expected );


  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp();
  });

  test.description = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ] );
  });

  test.description = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });

};

//

function arraySortedRemove( test )
{

  test.description = 'nothing to remove';
  var got = _.arraySortedRemove( [  ], 55 );
  var expected = false;
  test.identical( got, expected );

  test.description = 'nothing to remove';
  var got = _.arraySortedRemove( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = false;
  test.identical( got, expected );

  test.description = 'remove last index from first argument';
  var got = _.arraySortedRemove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = true;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedRemove();
  });

  test.description = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedRemove( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedRemove( [ 1, 2, 3, 4, 5 ] );
  });

  test.description = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedRemove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });

};

//

function arraySortedAddOnce( test )
{

  test.description = 'add an element';
  var got = _.arraySortedAddOnce( [  ], 55 );
  var expected = true;
  test.identical( got, expected );

  test.description = 'add a new element';
  var got = _.arraySortedAddOnce( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = true;
  test.identical( got, expected );

  test.description = 'do not add, because the second element already has in the first argument';
  var got = _.arraySortedAddOnce( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedAddOnce();
  });

  test.description = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedAddOnce( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedAddOnce( [ 1, 2, 3, 4, 5 ] );
  });

  test.description = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedAddOnce( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });

};

//

function arraySortedAdd( test )
{

  test.description = 'add an element';
  var got = _.arraySortedAdd( [  ], 55 );
  var expected = 0;
  test.identical( got, expected );

  test.description = 'add a new element';
  var got = _.arraySortedAdd( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = 5;
  test.identical( got, expected );

  test.description = 'offsets arguments[0][1]';
  var got = _.arraySortedAdd( [ 1, 2, 3, 4 ], 2, function( a, b ) { return a - b } );
  var expected = 1;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedAdd();
  });

  test.description = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedAdd( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedAdd( [ 1, 2, 3, 4, 5 ] );
  });

  test.description = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedAdd( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });

};

//

function arraySortedAddArray( test )
{

  test.description = 'returns sum equal to the 3';
  var got = _.arraySortedAddArray( [  ], [ 1, 2, 3 ], function( a, b ) { return a - b } );
  var expected = 3;
  test.identical( got, expected );

  test.description = 'returns sum equal to the 19';
  var got = _.arraySortedAddArray( [ 1, 2, 3, 4, 5 ], [ 6, 7, 8, 2 ], function( a, b ) { return a - b } );
  var expected = 19;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedAddArray();
  });

  test.description = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedAddArray( 'wrong argument', [ 6, 7, 8, 2 ], function( a, b ) { return a - b } );
  });

  test.description = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedAddArray( [ 1, 2, 3, 4, 5 ], 'wrong argument', function( a, b ) { return a - b } );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedAddArray( [ 1, 2, 3, 4, 5 ] );
  });

  test.description = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedAddArray( [ 1, 2, 3, 4, 5 ], [ 6, 7, 8, 2 ], function( a, b ) { return a - b }, 'extra argument' );
  });

};

// --
// proto
// --

var Self =
{

  name : 'ArraySorted_old',

  tests :
  {
    // _arraySortedLookUpAct : _arraySortedLookUpAct,
    // arraySortedLookUp : arraySortedLookUp,
    // arraySortedRemove : arraySortedRemove,
    // arraySortedAddOnce : arraySortedAddOnce,
    // arraySortedAdd : arraySortedAdd,
    //
    // arraySortedAddArray : arraySortedAddArray,
  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Testing.test( Self.name );

} )( );
