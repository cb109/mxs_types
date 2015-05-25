fileIn "mxs_dict.ms"


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

    -- Override the get() method while delegating all others.
    public
    fromkeys = this._dict.fromkeys,
    has_key = this._dict.has_key,
    has_value = this._dict.has_value,

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
    ),

    public
    keys = this._dict.keys,
    values = this._dict.values,
    items = this._dict.items,
    size = this._dict.size,
    clear = this._dict.clear,
    add = this._dict.add,
    set_ = this._dict.set_,
    copy = this._dict.copy,
    pop = this._dict.pop,
    popitem = this._dict.popitem,
    update = this._dict.update,
    sort_by_key = this._dict.sort_by_key,
    sort_by_value = this._dict.sort_by_value
)
