/***The MIT License (MIT)

Copyright (c) 2015 Christoph Buelter (www.cbuelter.de)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.***/


struct mxs_dict (
    /***Represents a mapping of keys to values.

    Anything can be used as a key or value, e.g. scene objects,
    materials, color values or controllers, making it very versatile.

    Supports sorting by key/value if keys/values are all of the
    same comparable type (e.g. all strings or numbers).

    Note: This is not a 'real' hash table, just parallel arrays,
    resulting in low performance when used with many items.

    The interface is loosely based on Python's dict API.

    ***/

    -- Public for tests and convenience.
    -- Modification however may break the dict.
    public
    _keys = #(),
    _values = #(),

    -- Static methods.

    public
    fn fromkeys keys default:undefined = (
        /***Returns a dict instance build from the
        given keys and the supplied default value.***/
        local new_dict = mxs_dict()
        new_dict._keys = keys
        new_dict._values = for key in keys collect default
        new_dict
    ),


    -- Instance methods.

    public
    fn has_key key = (
        /***Returns True if the key is part
        of the dict, False otherwise.***/
        local idx = findItem this._keys key
        idx != 0
    ),

    public
    fn get key default:undefined = (
        /***Returns the value that belongs to the given key
        or the supplied default, if the key does not exist.***/
        for i = 1 to this._keys.count do
            if this._keys[i] == key do
                return this._values[i]
        default
    ),

    public
    fn keys = (
        /***Returns a list of keys.***/
        this._keys
    ),

    public
    fn values = (
        /***Returns a list of values.***/
        this._values
    ),

    public
    fn items = (
        /***Returns a list of key-value tuples.***/
        for i = 1 to this._keys.count collect
            #(this._keys[i], this._values[i])
    ),

    public
    fn clear = (
        /***Resets the internal key and value
        arrays, thus emptying the dict.***/
        this._keys = #()
        this._values = #()
    ),

    public
    fn add key val = (
        /***Adds a new key-value pair if the key is new.
        Updates the value for the existing key otherwise.***/
        local idx = findItem this._keys key
        if idx != 0 then
            this._values[idx] = val
        else (
            append this._keys key
            append this._values val
        )
    ),

    public
    fn set_ key val = (
        /***Can be used as an alias for add().

        set() unfortunately is a reserved MXS keyword.

        ***/
        this.add key val
    ),

    public
    fn copy = (
        /***Returns a shallow copy of this dict.

        If the keys or values are referenced datatypes,
        these references are kept intact, no copies are made.

        ***/
        local new_dict = mxs_dict()
        new_dict._keys = for key in this._keys collect key
        new_dict._values = for val in this._values collect val
        new_dict
    ),

    public
    fn pop key default: = (
        /***Returns the value for the given key,
        effectively removing this item from the dict.

        If a default value is supplied, this is
        returned instead of the actual value.

        Returns undefined if the key does not exist.

        ***/
        local idx = findItem this._keys key
        if idx != 0 do (
            deleteItem this._keys idx
            local val = this._values[idx]
            deleteItem this._values idx
            if default != unsupplied do
                return default
            return val
        )
        undefined
    ),

    public
    fn popitem = (
        /***Returns a random key-value tuple from the
        dict, effectively removing this item from it.***/
        if this._keys.count > 0 do (
            local idx = random 1 this._keys.count
            local item = #(this._keys[idx], this._values[idx])
            deleteItem this._keys idx
            deleteItem this._values idx
            return item
        )
        undefined
    ),

    public
    fn update dict_ = (
        /***Updates this dict in-place with the supplied one.

        New key-value pairs are added, existing ones are updated.
        Can be used e.g. to merge two dicts into one.

        ***/
        local input_keys = dict_.keys()
        local input_values = dict_.values()
        for i = 1 to input_keys.count do
            this.add input_keys[i] input_values[i]
    ),

    public
    fn _sort_by item1 item2 item_index:1 reversed:False = (
        /***Used to sort by key or value
        based on the given items.***/
        local smaller = if reversed then 1 else -1
        local bigger = if reversed then -1 else 1

        local v1 = item1[item_index]
        local v2 = item2[item_index]

        case of (
            (v1 < v2) : smaller
            (v1 > v2) : bigger
            default : 0
        )
    ),

    public
    fn _update_arrays items = (
        /***As sorting is based on items, this function
        empties and rebuilds the _keys and _values arrays.***/
        this.clear()
        for i = 1 to items.count do (
            this._keys[i] = items[i][1]
            this._values[i] = items[i][2]
        )
    ),

    public
    fn sort_by_key reversed:False = (
        /***In-place sorting of the dict's items based
        on the alphabet-/numer-ical order of the keys.***/
        local items = this.items()
        try (
            qsort items this._sort_by item_index:1 reversed:reversed
            this._update_arrays items
        )
        catch (
            format "[ERROR] %\n" ("Could not sort dict by key, " + \
                                  "keys are not of comparable type.")
            throw
        )
    ),

    public
    fn sort_by_value reversed:False = (
        /***In-place sorting of the dict's items based
        on the alphabet-/numer-ical order of the values.***/
        local items = this.items()
        try (
            qsort items this._sort_by item_index:2 reversed:reversed
            this._update_arrays items
        )
        catch (
            format "[ERROR] %\n" ("Could not sort dict by value, " + \
                                  "values are not of comparable type.")
            throw
        )
    )
)


struct mxs_defaultdict (
    /***Similar to the collections.defaultdict in Python,
    this dict gets a factory function as its first argument
    to create and add values for unknown keys on the fly.

    The rest of the API works as in mxs_dict.

    It is useful for manipulating values on the fly that
    can be modified in-place, like arrays or custom struct
    instances, for collecting or counting objects.

    Example:

    fn list = #()
    d = mxs_defaultdict list
    append (d.get "foo") 123
    append (d.get "foo") 456
    append (d.get "foo") 789
    d.get "foo"
    >>> #(123, 456, 789)

    ***/
    public
    default_factory,

    private
    _dict = mxs_dict(),

    public
    _keys = this._dict._keys,
    _values = this._dict._values,

    -- Delegates to mxs_dict methods.
    public
    fromkeys = this._dict.fromkeys,
    has_key = this._dict.has_key,
    add = this._dict.add,
    set_ = this._dict.set_,
    keys = this._dict.keys,
    values = this._dict.values,
    items = this._dict.items,
    clear = this._dict.clear,
    copy = this._dict.copy,
    pop = this._dict.pop,
    popitem = this._dict.popitem,
    update = this._dict.update,
    sort_by_key = this._dict.sort_by_key,
    sort_by_value = this._dict.sort_by_value,
    _sort_by = this._dict._sort_by,
    _update_arrays = this._dict._update_arrays,

    -- Overriden methods.
    public
    fn get key  = (
        /***Unknown keys will trigger insertion of
        the value returned by default_factory.***/
        if this.default_factory != undefined and \
                not (this._dict.has_key key) do (
            local val = this.default_factory()
            this.add key val
            return val
        )

        this._dict.get key
    )
)