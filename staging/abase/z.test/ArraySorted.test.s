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

function arraySortedLookUpIndex( test )
{

  test.description = 'simples';

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
      test.shouldBe( array[ index-1 ] <= array[ index ] );

      if( 0 <= index && index <= array.length-2 )
      test.shouldBe( array[ index ] <= array[ index+1 ] );

      if( ins !== array[ index ] )
      {

        if( 0 <= index && index <= array.length-1 )
        test.shouldBe( ins < array[ index ] );

        if( 1 <= index && index <= array.length-1 )
        test.shouldBe( array[ index-1 ] < ins );

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

//

function arraySortedLookUpClosestIndex( test )
{

  test.description = 'simples';

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
      test.shouldBe( array[ index-1 ] <= array[ index ] );

      if( 0 <= index && index <= array.length-2 )
      test.shouldBe( array[ index ] <= array[ index+1 ] );

      if( ins !== array[ index ] )
      {

        if( 0 <= index && index <= array.length-1 )
        test.shouldBe( ins < array[ index ] );

        if( 1 <= index && index <= array.length-1 )
        test.shouldBe( array[ index-1 ] < ins );

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
      test.shouldBe( arr[ range[ 0 ] ] >= interval[ 0 ] );

      test.shouldBe( range[ 0 ] >= 0 );
      test.shouldBe( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        test.shouldBe( arr[ range[ 0 ] ] >= interval[ 0 ] );
        test.shouldBe( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.shouldBe( arr[ range[ 0 ]-1 ] < interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.shouldBe( arr[ range[ 1 ] ] > interval[ 1 ] );

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

//

// function arraySortedLookUpIntervalNarrowest( test )
// {
//   var self = this;
//   debugger;
//
//   /* */
//
//   var arr = [ 0, 0, 0, 0, 1, 1, 1, 1 ];
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 1, 1 ] );
//   test.identical( range, [ 7, 8 ] );
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 1, 2 ] );
//   test.identical( range, [ 7, 8 ] );
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 0, 0 ] );
//   test.identical( range, [ 3, 4 ] );
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ -1, 0 ] );
//   test.identical( range, [ 0, 1 ] );
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 0, 1 ] );
//   test.identical( range, [ 3, 5 ] );
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ -1, 3 ] );
//   test.identical( range, [ 0, 8 ] );
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ -2, -1 ] );
//   test.identical( range, [ 0, 0 ] );
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 2, 3 ] );
//   test.identical( range, [ 8, 8 ] );
//
//   /* */
//
//   var arr = [ 2, 2, 4, 18, 25, 25, 25, 26, 33, 36 ];
//
//   var range = _.arraySortedLookUpIntervalNarrowest( arr, [ 7, 28 ] );
//   test.identical( range, [ 3, 8 ] );
//
//   /* */
//
//   function testArray( arr, top )
//   {
//
//     for( var val = 0 ; val < top ; val++ )
//     {
//       var interval = [ Math.round( Math.random()*( top+2 )-1 ) ];
//       interval[ 1 ] = interval[ 0 ] + Math.round( Math.random()*( top+2 - interval[ 0 ] ) );
//
//       // debugger;
//       var range = _.arraySortedLookUpIntervalNarrowest( arr, interval );
//
//       if( range[ 0 ] < arr.length )
//       test.shouldBe( arr[ range[ 0 ] ] >= interval[ 0 ] );
//
//       test.shouldBe( range[ 0 ] >= 0 );
//       test.shouldBe( range[ 1 ] <= arr.length );
//
//       if( range[ 0 ] < range[ 1 ] )
//       {
//         test.shouldBe( arr[ range[ 0 ] ] >= interval[ 0 ] );
//         test.shouldBe( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );
//
//         if( range[ 0 ] > 0 )
//         test.shouldBe( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );
//
//         if( range[ 1 ] < arr.length )
//         test.shouldBe( arr[ range[ 1 ] ] >= interval[ 1 ] );
//
//       }
//
//     }
//
//   }
//
//   /* */
//
//   debugger;
//
//   for( var c = 10 ; c <= 100 ; c *= 10 )
//   {
//     var arr = makeArray( c, 5 );
//     testArray( arr, c/5 );
//   }
//
//   for( var c = 10 ; c <= 100 ; c *= 10 )
//   {
//     var arr = makeArray( c, 0.2 );
//     testArray( arr, c/0.2 );
//   }
//
//   /* */
//
//   test.identical( true, true );
//   debugger;
// }

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
      test.shouldBe( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

      test.shouldBe( range[ 0 ] >= 0 );
      test.shouldBe( range[ 1 ] <= arr.length );

      if( range[ 0 ] < range[ 1 ] )
      {
        // test.shouldBe( arr[ range[ 0 ] ] >= interval[ 0 ] );
        // test.shouldBe( arr[ range[ 1 ]-1 ] <= interval[ 1 ] );

        if( range[ 0 ] > 0 )
        test.shouldBe( arr[ range[ 0 ]-1 ] <= interval[ 0 ] );

        if( range[ 1 ] < arr.length )
        test.shouldBe( arr[ range[ 1 ] ] >= interval[ 1 ] );
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

// --
// proto
// --

var Self =
{

  name : 'ArraySorted',

  tests :
  {

    arraySortedLookUpIndex : arraySortedLookUpIndex,
    arraySortedLookUpClosestIndex : arraySortedLookUpClosestIndex,

    arraySortedLookUpInterval : arraySortedLookUpInterval,
    arraySortedLookUpEmbrace : arraySortedLookUpEmbrace,

    arraySortedAdd : arraySortedAdd,

  },

};

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Testing.test( Self.name );

} )( );
