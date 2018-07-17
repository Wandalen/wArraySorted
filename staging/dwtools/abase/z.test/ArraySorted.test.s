( function _ArraySorted_test_s_( ) {

'use strict';

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

  var _global = _global_; var _ = _global_.wTools;

  _.include( 'wTesting' );

  require( '../layer4/ArraySorted.s' );

}

//

var _global = _global_; var _ = _global_.wTools;
var Parent = _.Tester;

// --
// test
// --

function makeArray( length, density )
{
  var top = length / density;

  if( top < 1 ) top = 1;

  var array = [];
  for( var i = 0 ; i < length ; i += 1 )
  array[ i ] = Math.round( Math.random()*top );

  array.sort( function( a, b ){ return a-b } );

  return array;
}

//

function _arraySortedLookUpAct( test )
{

  test.case = 'first argument is empty, so it returns the index from which it ended search at';
  var got = _._arraySortedLookUpAct( [  ], 55, function( a, b ){ return a - b }, 0, 5 );
  var expected = 2;
  test.identical( got, expected );

  test.case = 'returns the last index of the first argument';
  var got = _._arraySortedLookUpAct( [ 1, 2, 3, 4, 5 ], 5, function( a, b ){ return a - b }, 0, 5 );
  var expected = 4;
  test.identical( got, expected );

  test.case = 'second argument was not found, so it returns the length of the first argument';
  var got = _._arraySortedLookUpAct( [ 1, 2, 3, 4, 5 ], 55, function( a, b ){ return a - b }, 0, 5 );
  var expected = 5;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _._arraySortedLookUpAct();
  });

};

//

function arraySortedLookUp( test )
{

  test.case = 'returns an object that containing the found value';
  var got = _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = { value : 5, index : 4 };
  test.identical( got, expected );

  test.case = 'returns undefined';
  var got = _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = { value : undefined, index : -1 };
  test.identical( got, expected );

  test.case = 'call without a callback function';
  var got = _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 3 );
  var expected = { value : 3, index : 2 };
  test.identical( got, expected );


  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp();
  });

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedLookUp( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });

};

//

function arraySortedLookUpIndex( test )
{

  test.case = 'simples';

  // [16, 17, 34, 34, 37, 42, 44, 44, 5, 9]
  // [ 1, 2, 3 ]
  // 0 -1
  // 1 0, 1
  // 2 0, 1

  var a = [ 1, 2, 3 ];

  var i = _.arraySortedLookUpIndex( a, 0 );
  test.identical( i, -1 );

  var i = _.arraySortedLookUpIndex( a, 1 );
  test.identical( i, 0 );

  var i = _.arraySortedLookUpIndex( a, 2 );
  test.identical( i, 1 );

  var i = _.arraySortedLookUpIndex( a, 3 );
  test.identical( i, 2 );

  var i = _.arraySortedLookUpIndex( a, 4 );
  test.identical( i, -1 );

  //

  var a = [ 1, 1, 3, 3, 5, 5 ];

  var i = _.arraySortedLookUpIndex( a, 1 );
  test.identical( i, 1 );

  var i = _.arraySortedLookUpIndex( a, 3 );
  test.identical( i, 3 );

  var i = _.arraySortedLookUpIndex( a, 5 );
  test.identical( i, 5 );

  //

  var a = [ 5, 4, 3, 2, 1 ];

  var i = _.arraySortedLookUpIndex( a, 5 );
  test.identical( i, -1 );

  //

  var i = _.arraySortedLookUpIndex( [], 1 );
  test.identical( i, -1 );

  //

  var arr = [ 1.5, 2.6, 5.7, 9.8 ];

  var transformer = function( value )
  {
    return Math.floor( value );
  }

  var i = _.arraySortedLookUpIndex( arr, 5, transformer );
  test.identical( i, 2 )

  //

  var arr = [{ value : 1 }, { value : 2 }, { value : 3 } ];

  var comparator = function( a, b )
  {
    return a.value - b.value;
  }

  var i = _.arraySortedLookUpIndex( arr, { value : 2 }, comparator );
  test.identical( i, 1 )

  //

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpIndex( a, 0, function() {} );
    })
  }

  //

  function testArray( array, top )
  {

    for( var ins = -1 ; ins < top+1 ; ins++ )
    {
      var index = _.arraySortedLookUpIndex( array, ins );

      if( 1 <= index && index <= array.length-1 )
      test.is( array[ index-1 ] <= array[ index ] );

      if( 0 <= index && index <= array.length-2 )
      test.is( array[ index ] <= array[ index+1 ] );

      if( ins !== array[ index ] )
      {

        if( 0 <= index && index <= array.length-1 )
        test.is( ins < array[ index ] );

        if( 1 <= index && index <= array.length-1 )
        test.is( array[ index-1 ] < ins );

      }

    }

  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 5 );
    testArray( array, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 0.2 );
    testArray( array, c/0.2 );
  }

  test.identical( true, true );
}

arraySortedLookUpIndex.timeOut = 60000;

//

function arraySortedLookUpClosestIndex( test )
{

  test.case = 'simples';

  // [16, 17, 34, 34, 37, 42, 44, 44, 5, 9]
  // [ 1, 2, 3 ]
  // 0 -1
  // 1 0, 1
  // 2 0, 1

  var a = [ 1, 2, 3 ];

  var i = _.arraySortedLookUpClosestIndex( a, 0 );
  test.identical( i, 0 );

  var i = _.arraySortedLookUpClosestIndex( a, 1 );
  test.identical( i, 0 );

  var i = _.arraySortedLookUpClosestIndex( a, 2 );
  test.identical( i, 1 );

  var i = _.arraySortedLookUpClosestIndex( a, 3 );
  test.identical( i, 2 );

  var i = _.arraySortedLookUpClosestIndex( a, 4 );
  test.identical( i, 3 );

  //

  var a = [ 1, 3, 5, 7 ];

  var i = _.arraySortedLookUpClosestIndex( a, 2 );
  test.identical( i, 1 );

  var i = _.arraySortedLookUpClosestIndex( a, 6 );
  test.identical( i, 3 );

  var i = _.arraySortedLookUpClosestIndex( a, -1 );
  test.identical( i, 0 );

  //

  var a = [ 1, 1, 3, 3, 5, 5 ];

  var i = _.arraySortedLookUpClosestIndex( a, 1 );
  test.identical( i, 1 );

  var i = _.arraySortedLookUpClosestIndex( a, 3 );
  test.identical( i, 3 );

  var i = _.arraySortedLookUpClosestIndex( a, 5 );
  test.identical( i, 5 );

  var i = _.arraySortedLookUpClosestIndex( a, -1 );
  test.identical( i, 0 );

  //

  var i = _.arraySortedLookUpClosestIndex( [], 1 );
  test.identical( i, 0 );

  //

  var a = [ 5, 4, 3, 2, 1 ];

  var i = _.arraySortedLookUpClosestIndex( a, 2 );
  test.identical( i, 0 );

  var i = _.arraySortedLookUpClosestIndex( a, 1 );
  test.identical( i, 0 );

  var i = _.arraySortedLookUpClosestIndex( a, 3 );
  test.identical( i, 2 );

  //

  var arr = [ 1.5, 2.6, 6.2, 9.8 ];

  var transformer = function( value )
  {
    return Math.floor( value );
  }

  var i = _.arraySortedLookUpClosestIndex( arr, 5, transformer );
  test.identical( i, 2 )

  //

  var arr = [{ value : 1 }, { value : 3 }, { value : 4 } ];

  var comparator = function( a, b )
  {
    return a.value - b.value;
  }

  var i = _.arraySortedLookUpClosestIndex( arr, { value : 2 }, comparator );
  test.identical( i, 1 )

  //

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpClosestIndex( a, 0, function() {} );
    })
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpClosestIndex( a, 0, 0 );
    })
  }

  //

  function testArray( array, top )
  {

    for( var ins = -1 ; ins < top+1 ; ins++ )
    {
      var index = _.arraySortedLookUpClosestIndex( array, ins );

      if( 1 <= index && index <= array.length-1 )
      test.is( array[ index-1 ] <= array[ index ] );

      if( 0 <= index && index <= array.length-2 )
      test.is( array[ index ] <= array[ index+1 ] );

      if( ins !== array[ index ] )
      {

        if( 0 <= index && index <= array.length-1 )
        test.is( ins < array[ index ] );

        if( 1 <= index && index <= array.length-1 )
        test.is( array[ index-1 ] < ins );

      }

    }

  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 5 );
    testArray( array, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var array = makeArray( c, 0.2 );
    testArray( array, c/0.2 );
  }

  test.identical( true, true );
}

arraySortedLookUpClosestIndex.timeOut = 60000;

//

function arraySortedLookUpInterval( test )
{
  var self = this;

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var range = _.arraySortedLookUpInterval( arr, [ 1, 1 ] );
  test.identical( range, [ 4, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ 1, 2 ] );
  test.identical( range, [ 4, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ 0, 0 ] );
  test.identical( range, [ 0, 4 ] );

  var range = _.arraySortedLookUpInterval( arr, [ -1, 0 ] );
  test.identical( range, [ 0, 4 ] );

  var range = _.arraySortedLookUpInterval( arr, [ 0, 1 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ -1, 3 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ -2, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.arraySortedLookUpInterval( arr, [ 2, 3 ] );
  test.identical( range, [ 8, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ -1, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.arraySortedLookUpInterval( arr, [ -1, 1 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ '0', 0 ] );
  test.identical( range, [ 0, 4 ] );

  var range = _.arraySortedLookUpInterval( arr, [ '0', '1' ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ '-1', '1' ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.arraySortedLookUpInterval( arr, [ 1, 0 ] );
  test.identical( range, [ 4, 4 ] );

  //

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 2, 3 ];

  var range = _.arraySortedLookUpInterval( arr, [ '1', '2' ] );
  test.identical( range, [ 4, 8 ] );

  /* arr[ range[ 1 ] ] < interval[ 1 ], increase by 1 */
  var arr = [ 0, 1, 0 ];
  var range = _.arraySortedLookUpInterval( arr, [ 0, 3 ] );

  //

  var arr = [ 5, 4, 3, 2, 1 ];

  var range = _.arraySortedLookUpInterval( arr, [ 5, 1 ] );
  test.identical( range, [ 5, 5 ] );

  var range = _.arraySortedLookUpInterval( arr, [ 1, 5 ] );
  test.identical( range, [ 0, 5 ] );

  var range = _.arraySortedLookUpInterval( arr, [ 5, 5 ] );
  test.identical( range, [ 5, 5 ] );

  //

  var range = _.arraySortedLookUpInterval( [], [ 1, 1 ] );
  test.identical( range, [ 0, 0 ] );

  //

  if( Config.debug )
  {
    var arr = [ 1, 1, 1, 0, 0, 0 ];
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpInterval( arr, [ 0, 1 ] );
    })

    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpInterval( a, [ 0, 1], function() {} );
    })
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpInterval( a, [ 0, 1], 1 );
    })
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpInterval( a, [ 0 ] );
    })
  }

  /* */

  var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];
  var range = _.arraySortedLookUpInterval( arr, [ 7, 28 ] );
  test.identical( range, [ 3, 8 ] );

  /* */

  function testArray( arr, top )
  {

    for( var val = 0 ; val < top ; val++ )
    {
      var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
      interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );

      // debugger;
      var range = _.arraySortedLookUpInterval( arr, interval );

      if( range[ 0 ] < arr.length )
      test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );

      test.is( range[ 0 ] >= 0 );
      test.is( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );
        test.is( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.is( arr[ range[ 0 ]-1 ] < interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.is( arr[ range[ 1 ] ] > interval[ 1 ] );

      }

    }

  }

  /* */

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 5 );
    testArray( arr, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 0.2 );
    testArray( arr, c/0.2 );
  }

  /* */

  test.identical( true, true );
}

arraySortedLookUpInterval.timeOut = 60000;

//

function arraySortedLookUpIntervalNarrowest( test )
{
  var self = this;
  debugger;

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 1, 1 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 1, 2 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 0, 0 ] );
  test.identical( range, [ 3, 4 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ -1, 0 ] );
  test.identical( range, [ 0, 1 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 0, 1 ] );
  test.identical( range, [ 3, 5 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ -1, 3 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ -2, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 2, 3 ] );
  test.identical( range, [ 8, 8 ] );

  var arr = [ 0, 1, 2 ];
  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 3, 3 ] );
  test.identical( range, [ 3, 3 ] );

  /* */

  var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 7, 28 ] );
  test.identical( range, [ 3, 8 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 1, 0 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 25, 25 ] );
  test.identical( range, [ 6, 7 ] );

  var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 36, 37 ] );
  test.identical( range, [ 9, 10 ] );

  test.shouldThrowErrorSync( function()
  {
    _.arraySortedLookUpIntervalNarrowest( arr, [ 2, 0 ] );
  })

  /* */

  function testArray( arr, top )
  {

    for( var val = 0 ; val < top ; val++ )
    {
      var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
      interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );

      // debugger;
      var range = _.arraySortedLookUpIntervalNarrowest( arr, interval );

      if( range[ 0 ] < arr.length )
      test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );

      test.is( range[ 0 ] >= 0 );
      test.is( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );
        test.is( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.is( arr[ range[ 1 ] ] >= interval[ 1 ] );

      }

    }

  }

  /* */

  debugger;

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 5 );
    testArray( arr, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 0.2 );
    testArray( arr, c/0.2 );
  }

  /* */

  test.identical( true, true );
  debugger;
}

arraySortedLookUpIntervalNarrowest.timeOut = 60000;

//

function arraySortedLookUpEmbrace( test )
{
  var self = this;

  /* */

  var arr = [ 0, 0, 5, 5, 9, 9 ];

  debugger;
  var range = _.arraySortedLookUpEmbrace( arr, [ 5, 9 ] );
  test.identical( range, [ 3, 5 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 0, 5 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 0, 3 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 2, 5 ] );
  test.identical( range, [ 1, 3 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 2, 3 ] );
  test.identical( range, [ 1, 3 ] );

  // debugger;
  // return;

  /* */

  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var range = _.arraySortedLookUpEmbrace( arr, [ 1, 1 ] );
  test.identical( range, [ 7, 8 ] );

  debugger;
  var range = _.arraySortedLookUpEmbrace( arr, [ 1, 2 ] );
  test.identical( range, [ 7, 8 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 0, 0 ] );
  test.identical( range, [ 3, 4 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ -1, 0 ] );
  test.identical( range, [ 0, 1 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 0, 1 ] );
  test.identical( range, [ 3, 5 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ -1, 3 ] );
  test.identical( range, [ 0, 8 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ -2, -1 ] );
  test.identical( range, [ 0, 0 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 2, 3 ] );
  test.identical( range, [ 8, 8 ] );

  var range = _.arraySortedLookUpEmbrace( arr, [ 1, 0 ] );
  test.identical( range, [ 7, 7 ] );

  var range = _.arraySortedLookUpEmbrace( arr,[ '0','1' ] );
  test.identical( range, [ 3, 5 ] );


  /* empty */

  var range = _.arraySortedLookUpEmbrace( [], [ 1, 0 ] );
  test.identical( range, [ 0, 0 ] );

  /* */

  var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];

  var range = _.arraySortedLookUpEmbrace( arr, [ 7, 28 ] );
  test.identical( range, [ 2, 9 ] );

  /* */

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpEmbrace( [], [ 0, 1 ], function() {} );
    })

    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpEmbrace( [], [ 0, 1 ], 0 );
    })

    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLookUpEmbrace( [ 3, 1, 2 ], [ 1, 2] );
    })
  }

  /* */

  function testArray( arr, top )
  {

    for( var val = 0 ; val < top ; val++ )
    {
      var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
      interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );

      // debugger;
      var range = _.arraySortedLookUpEmbrace( arr, interval );

      if( range[ 0 ] > 0 )
      test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

      test.is( range[ 0 ] >= 0 );
      test.is( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        // test.is( arr[ range[ 0 ] ] >= interval[ 0 ] );
        // test.is( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.is( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.is( arr[ range[ 1 ] ] >= interval[ 1 ] );
      }

    }

  }

  /* */

  debugger;

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 5 );
    testArray( arr, c/5 );
  }

  for( var c = 10 ; c <= 100 ; c *= 10 )
  {
    var arr = makeArray( c, 0.2 );
    testArray( arr, c/0.2 );
  }

  /* */

  test.identical( true, true );
  debugger;
}

arraySortedLookUpEmbrace.timeOut = 60000;
//

function arraySortedAdd( test )
{
  var self = this;

  // 13.00 13.00 10.00 10.00 10.00 2.000 10.00 15.00 2.000 14.00 10.00 6.000 6.000 15.00 4.000 8.000

  var samples =
  [

    [],
    [ 0 ],

    [ 0,1 ],
    [ 1,0 ],

    [ 1,0,2 ],
    [ 2,0,1 ],
    [ 0,1,2 ],
    [ 0,2,1 ],
    [ 2,1,0 ],
    [ 1,2,0 ],

    [ 0,1,1 ],
    [ 1,0,1 ],
    [ 1,1,0 ],

    [ 0,0,1,1 ],
    [ 0,1,1,0 ],
    [ 1,1,0,0 ],
    [ 1,0,1,0 ],
    [ 0,1,0,1 ],

    //_.arrayFill({ times : 16 }).map( function(){ return Math.floor( Math.random() * 16 ) } ),

  ];

  for( var s = 0 ; s < samples.length ; s++ )
  {
    var expected = samples[ s ].slice();
    var got = [];
    for( var i = 0 ; i < expected.length ; i++ )
    _.arraySortedAdd( got, expected[ i ] );
    expected.sort( function( a, b ){ return a-b } );
    test.identical( got, expected );
  }

}

//

function arraySortedAddOnce( test )
{
  test.case = 'arraySortedAddOnce test';

  var arr = [];
  _.arraySortedAddOnce( arr, 1 );
  test.identical( arr, [ 1 ] );

  var arr = [ 1 ];
  _.arraySortedAddOnce( arr, 1 );
  test.identical( arr, [ 1 ] );

  var arr = [ 1, 3 ];
  _.arraySortedAddOnce( arr, 2 );
  test.identical( arr, [ 1, 2, 3 ] );

  var arr = [ 1, 3 ];
  _.arraySortedAddOnce( arr, 0 );
  test.identical( arr, [ 0, 1, 3 ] );

  var arr = [ 1, 3 ];
  _.arraySortedAddOnce( arr, 4 );
  test.identical( arr, [ 1, 3, 4 ] );

  var arr = [ 1 ];
  function comparator( a, b ){ return ( a - b ) + 1  }
  _.arraySortedAddOnce( arr, 2, comparator );
  test.identical( arr, [ 2, 1 ] );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.arraySortedAddOnce();
  })

  test.shouldThrowErrorSync( function()
  {
    _.arraySortedAddOnce( 0, 0 );
  })

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedAddOnce( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedAddOnce( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });
}

//

function arraySortedAddArray( test )
{
  test.case = 'arraySortedAddOnce test';

  var arr = [];
  _.arraySortedAddArray( arr, [ 1 ] );
  test.identical( arr, [ 1 ] );

  var arr = [ 1 ];
  _.arraySortedAddArray( arr, [ 1 ] );
  test.identical( arr, [ 1, 1 ] );

  var arr = [ 1, 3 ];
  _.arraySortedAddArray( arr, [ 2, 2, 2 ] );
  test.identical( arr, [ 1, 2, 2, 2, 3 ] );

  var arr = [ 1, 3 ];
  _.arraySortedAddArray( arr, [ 0, 1 ] );
  test.identical( arr, [ 0, 1, 1, 3 ] );

  var arr = [ 1, 3 ];
  _.arraySortedAddArray( arr, [ 1, 4 ]  );
  test.identical( arr, [ 1, 1, 3, 4 ] );

  var arr = [ 1 ];
  function comparator( a, b ){ return ( a - b ) + 1  }
  _.arraySortedAddArray( arr, [ 1, 2 ], comparator );
  test.identical( arr, [ 1, 2, 1 ] );

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedAddArray();
    })

    test.shouldThrowErrorSync( function()
    {
      _.arraySortedAddArray( 0, 0 );
    })
  }
}

//

function arraySortedRemove( test )
{
  test.case = 'arraySortedAddOnce test';

  var arr = [];
  _.arraySortedRemove( arr, [ 1 ] );
  test.identical( arr, [ ] );

  var arr = [ 1 ];
  _.arraySortedRemove( arr, [ 1 ] );
  test.identical( arr, [ ] );

  var arr = [ 1, 3 ];
  _.arraySortedRemove( arr, 2 );
  test.identical( arr, [ 1, 3 ] );

  var arr = [ 1, 3 ];
  _.arraySortedRemove( arr, 3 );
  test.identical( arr, [ 1 ] );

  var arr = [ 1, 1, 1 ];
  _.arraySortedRemove( arr, 1 );
  test.identical( arr, [ 1, 1 ] );

  var arr = [ 1, 3 ];
  _.arraySortedRemove( arr, -1  );
  test.identical( arr, [ 1, 3 ] );

  test.case = 'nothing to remove';
  var got = _.arraySortedRemove( [ 1, 2, 3, 4, 5 ], 55, function( a, b ) { return a - b } );
  var expected = false;
  test.identical( got, expected );

  test.case = 'remove last index from first argument';
  var got = _.arraySortedRemove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b } );
  var expected = true;
  test.identical( got, expected );

  if( !Config.debug )
  return;

  test.shouldThrowErrorSync( function()
  {
    _.arraySortedRemove();
  })

  test.shouldThrowErrorSync( function()
  {
    _.arraySortedRemove( 0, 0 );
  })

  test.case = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.arraySortedRemove( 'wrong argument', 5, function( a, b ) { return a - b } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowError( function()
  {
    _.arraySortedRemove( [ 1, 2, 3, 4, 5 ] );
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.arraySortedRemove( [ 1, 2, 3, 4, 5 ], 5, function( a, b ) { return a - b }, 'extra argument' );
  });
}

//

function arraySortedLeftMost( test )
{
  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var got = _.arraySortedLeftMost( arr, 0 );
  var expected = { index : 0, value : 0 }
  test.identical( got, expected );

  var got = _.arraySortedLeftMost( arr, 1 );
  var expected = { index : 4, value : 1 }
  test.identical( got, expected );

  var got = _.arraySortedLeftMost( arr, -1 );
  var expected = { index : 0, value : 0 }
  test.identical( got, expected );

  var got = _.arraySortedLeftMost( arr, 2 );
  var expected = { index : 8, value : undefined }
  test.identical( got, expected );

  var got = _.arraySortedLeftMost( [], 2 );
  var expected = { index : 0, value : undefined }
  test.identical( got, expected );

  function comparator( a, b )
  {
    return ( a + 1 ) - b;
  }
  var got = _.arraySortedLeftMost( arr, 2, comparator  );
  var expected = { index : 4, value : 1 }
  test.identical( got, expected );

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLeftMost();
    })

    test.shouldThrowErrorSync( function()
    {
      _.arraySortedLeftMost( 0, 0 );
    })
  }


}

//

function arraySortedRightMost( test )
{
  var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];

  var got = _.arraySortedRightMost( arr, 0 );
  var expected = { index : 3, value : 0 }
  test.identical( got, expected );

  var got = _.arraySortedRightMost( arr, 1 );
  var expected = { index : 7, value : 1 }
  test.identical( got, expected );

  var got = _.arraySortedRightMost( arr, -1 );
  var expected = { index : 0, value : 0 }
  test.identical( got, expected );

  var got = _.arraySortedRightMost( arr, 2 );
  var expected = { index : 8, value : undefined }
  test.identical( got, expected );

  var got = _.arraySortedRightMost( [], 2 );
  var expected = { index : 0, value : undefined }
  test.identical( got, expected );

  function comparator( a, b )
  {
    return ( a + 1 ) - b;
  }
  var got = _.arraySortedRightMost( arr, 2, comparator  );
  var expected = { index : 7, value : 1 }
  test.identical( got, expected );

  if( Config.debug )
  {
    test.shouldThrowErrorSync( function()
    {
      _.arraySortedRightMost();
    })

    test.shouldThrowErrorSync( function()
    {
      _.arraySortedRightMost( 0, 0 );
    })
  }
}

//

function arraySortedLookUpIntervalNarrowestExperiment( test )
{
  var arr = [ 3, 8, 16, 17, 30, 35, 35, 36, 37, 47 ];

  //

  var got = _.arraySortedLookUpIntervalNarrowest( arr, [ 42, 44 ] );
  test.identical( got, [ 9, 9 ] );

  //

  var got = _.arraySortedLookUpIntervalNarrowest( arr, [ 48, 49 ] );
  test.identical( got, [ 10, 10 ] );

}

// --
// define class
// --

var Self =
{

  name : 'Tools/base/layer4/ArraySorted',
  silencing : 1,

  tests :
  {
    _arraySortedLookUpAct : _arraySortedLookUpAct,
    arraySortedLookUp : arraySortedLookUp,

    arraySortedLookUpIndex : arraySortedLookUpIndex,
    arraySortedLookUpClosestIndex : arraySortedLookUpClosestIndex,

    arraySortedLookUpInterval : arraySortedLookUpInterval,
    arraySortedLookUpIntervalNarrowest : arraySortedLookUpIntervalNarrowest,
    arraySortedLookUpEmbrace : arraySortedLookUpEmbrace,

    arraySortedAdd : arraySortedAdd,
    arraySortedRemove : arraySortedRemove,
    arraySortedAddOnce : arraySortedAddOnce,
    arraySortedAddArray : arraySortedAddArray,

    arraySortedLeftMost : arraySortedLeftMost,
    arraySortedRightMost : arraySortedRightMost,

    arraySortedLookUpIntervalNarrowestExperiment : arraySortedLookUpIntervalNarrowestExperiment

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
