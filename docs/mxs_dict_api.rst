============
mxs_dict API
============

**fromkeys** ``keys`` ``default:undefined``
    Returns a dict instance build from the
    given keys and the supplied default value.

**has_key** ``key``
    Returns True if the key is part
    of the dict, False otherwise.

**has_value** ``value``
    Returns True if the value is part
    of the dict, False otherwise.

**get** ``key`` ``default:undefined``
    Returns the value that belongs to the given key
    or the supplied default, if the key does not exist.

**keys**
    Returns a list of keys.

**values**
    Returns a list of values.

**items**
    Returns a list of key-value tuples.

**size**
    Returns the number of items in the dict.

**clear**
    Resets the internal key and value
    arrays, thus emptying the dict.

**add** ``key`` ``val``
    Adds a new key-value pair if the key is new.
    Updates the value for the existing key otherwise.

**set_** ``key`` ``val``
    Can be used as an alias for add().
    set() unfortunately is a reserved MXS keyword.

**copy**
    Returns a shallow copy of this dict.
    If the keys or values are referenced datatypes,
    these references are kept intact, no copies are made.

**pop** ``key`` ``default:``
    Returns the value for the given key,
    effectively removing this item from the dict.
    If a default value is supplied, this is
    returned instead of the actual value.
    Returns undefined if the key does not exist.

**popitem**
    Updates this dict in-place with the supplied one.
    New key-value pairs are added, existing ones are updated.
    Can be used e.g. to merge two dicts into one.

**update** ``dict``
    Updates this dict in-place with the supplied one.
    New key-value pairs are added, existing ones are updated.
    Can be used e.g. to merge two dicts into one.

**sort_by_key** ``reversed:False``
    In-place sorting of the dict's items based
    on the alphabet-/numer-ical order of the keys.

**sort_by_value** ``reversed:False``
    In-place sorting of the dict's items based
    on the alphabet-/numer-ical order of the values.