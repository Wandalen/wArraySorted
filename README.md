
# wArraySorted

Collection of routines for sorted arrays handling
#### Binary search
Binary search algorithm is used for finding an item from an ordered list of elements. Its based on dividing in half the part of list that can contain the element, until the count of the possible locations is decreased to just one. [More about binary search.]( https://en.wikipedia.org/wiki/Binary_search_algorithm )


## Methods

* arraySortedLookUp - binary search of element in array, returns object containing properties: value, index. If nothing founded returns undefined.

* arraySortedLookUpIndex - binary search of element in array, returns index of the element: equal to or element with smallest possible difference if it exists. Otherwise returns zero or length of array, it depends on if element value is bigger/lower then last/first element of the array.

* arraySortedLookUpInterval - looks for elements from passed interval that exists in array and returns range where this elements are locaded.

* arraySortedLookUpEmbrace - returns range where all elements from interval can be located even they not exists in the current array.

* arraySortedLeftMostIndex - returns index of first element that is equal or bigger with smallest difference to passed value.

* arraySortedRightMostIndex - returns index of last element that is equal or bigger with smallest difference to passed value.

#### Example #1
```javascript
var _ = wTools;

var arr = [ 3,5,6,7,9 ];
var e = 5
var i = _.arraySortedLookUp( arr,e );
console.log( 'arraySortedLookUp',e,i );
// arraySortedLookUp 5 { value: 5, index: 1 }
```

#### Example #2
```javascript
var _ = wTools;

var arr = [ 3,5,6,7,9 ];
var e = 4
var i = _.arraySortedLookUpIndex( arr,e );
console.log( 'arraySortedLookUpIndex',e,i );
// arraySortedLookUpIndex 4 2
```

#### Example #3
```javascript
var _ = wTools;

var arr = [ 0,1,4,5 ];

var interval = [ 2, 5 ];

var range = _.arraySortedLookUpInterval( arr,interval );
console.log( 'arraySortedLookUpInterval: ',interval, range );
// arraySortedLookUpInterval : [ 2, 5 ] [ 2, 4 ]

var range = _.arraySortedLookUpEmbrace( arr,interval );
console.log( 'arraySortedLookUpEmbrace: ',interval, range );
// arraySortedLookUpEmbrace :  [ 2, 5 ] [ 1, 4 ]
```
For more examples see: [samples/Interval.js](https://github.com/Wandalen/wArraySorted/blob/master/sample/Interval.js), [samples/Embrace.js](https://github.com/Wandalen/wArraySorted/blob/master/sample/Embrace.js), [sample/LookUpDifference.js](https://github.com/Wandalen/wArraySorted/blob/master/sample/LookUpDifference.js)

#### Example #4
```javascript
var _ = wTools;

var arr = [ 0,0,0,0,1,1,1,1 ];

var leftMost = _.arraySortedLeftMostIndex( arr, 1 );
var rightMost = _.arraySortedRightMostIndex( arr, 0 );
console.log( 'leftMostIndex: ',leftMost,' rightMostIndex: ',rightMost );
// leftMostIndex:  4  rightMostIndex:  3
```
