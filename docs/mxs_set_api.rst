===========
mxs_set API
===========

The mxs_set can be created with an array as its first argument.
(similar to using **from_array**.)

**from_array** ``array``
    Static function to return a new set based on the given array.

**elements**
    Return an array of unique elements.

**size**
    Returns the number of elements in the set.

**add** ``element``
    Add an element to a set.
    This has no effect if the element is already present.

**set_elements** ``elements``
    Set elements from given list.
    Elements will only contain unique items afterwards.

**discard** ``element``
    Remove an element from a set if it is a member.
    If the element is not a member, do nothing.

**clear**
    Remove all elements from this set.

**copy**
    Return a shallo wcopy of a set.

**difference** ``set``
    Return the difference of this set and another as a new set.
    (i.e. all elements that are in this set but not the other.)

**difference_update** ``set``
    Remove all elements of another set from this set.

**intersection** ``set``
    Return the intersection of this set and another as a new set.
    (i.e. elements that are common to both sets.)

**intersection_update** ``set``
    Update a set with the intersection of itself and another.

**isdisjoint** ``set``
    Return true if two sets have a null intersection.

**issubset** ``set``
    Report whether another set contains this set.

**issuperset** ``set``
    Report whether this set contains another set.

**pop**
    Remove and return an arbitrary set element.
    Return undefined if the set is empty.

**symmetric_difference** ``set``
    Return the symmetric difference of two sets as a new set.
    (i.e. all elements that are in exactly one of the sets.)

**symmetric_difference_update** ``set``
    Update a set with the symmetric
    difference of itself and another.

**union** ``set``
    Return the union of sets as a new set.
    (i.e. all elements that are in either set.)

**update** ``set``
    Update a set with the union of itself and another.

**update_from_array** ``array``
    Update a set with the union of itself and a new set
    (which is created based on the given array).

**to_array**
    Return the set content as an array.
