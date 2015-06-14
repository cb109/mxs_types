struct mxs_hashdict (
    /***A string-only dictionary datatype.

    On adding keys and values they are implicitly converted to strings.
    Therefore all items retrieved from the table will be string only.

    In comparison to mxs_dict, this structure features a real hashtable
    in the background, making lookups very fast even for a large number
    of items. On the downside, it does not offer sorting by key/value.

    The interface is loosely based on Python's dict API.

    ***/

    public
    -- Do not modify directly.
    _table = dotNetObject "System.Collections.HashTable",

    private
    fn _dns thing = (
        /***Converts thing to a dotNet compatible string.***/
        dotNetObject "System.String" (thing as String)
    ),

    -- Static methods.

    public
    fn fromkeys keys default:"" = (
        /***Returns a dict instance build from the
        given keys and the supplied default value.***/
        local new_hdict = mxs_hashdict()
        for key in keys do
            new_hdict.add key default
        new_hdict
    ),

    -- Instance methods.

    public
    fn has_key key = (
        /***Returns True if the key is part
        of the dict, False otherwise.***/
        this._table.ContainsKey (this._dns key)
    ),

    public
    fn has_value val = (
        /***Returns True if the value is part
        of the dict, False otherwise.***/
        this._table.ContainsValue (this._dns val)
    ),

    public
    fn get key default:undefined = (
        /***Returns the value that belongs to the given key
        or the supplied default, if the key does not exist.***/
        local val = this._table.Item (this._dns key)
        if val != undefined then
            val
        else
            default
    ),

    public
    fn keys = (
        /***Returns a list of keys.***/
        local keys = #()
        local enum = this._table.Keys.GetEnumerator()
        while enum.MoveNext() do
            append keys enum.Key
        keys
    ),

    public
    fn values = (
        /***Returns a list of values.***/
        local values = #()
        local enum = this._table.Keys.GetEnumerator()
        while enum.MoveNext() do
            append values enum.Value
        values
    ),

    public
    fn items = (
        /***Returns a list of key-value tuples.***/
        local items = #()
        local enum = this._table.Keys.GetEnumerator()
        while enum.MoveNext() do
            append items #(enum.Key, enum.Value)
        items
    ),

    public
    fn size = (
        /***Returns the number of items in the dict.***/
        this._table.Count
    ),

    public
    fn clear = (
        /***Resets the internal key and value
        arrays, thus emptying the dict.***/
        this._table.Clear()
    ),

    public
    fn add key val = (
        /***Adds a new key-value pair if the key is new.
        Updates the value for the existing key otherwise.

		Key and value are both converted to strings.

        ***/
        local needs_update = this.has_key key
        if needs_update do
            this._table.Remove (this._dns key)
        this._table.Add (this._dns key) (this._dns val)
    ),

    public
    fn copy = (
        /***Returns a shallow copy of this dict.***/
        local new_hdict = mxs_hashdict()
        new_hdict._table  = ::copy this._table
        new_hdict
    ),

    public
    fn pop key default: = (
        /***Returns the value for the given key,
        effectively removing this item from the dict.

        If a default value is supplied, this is
        returned instead of the actual value.

        Returns undefined if the key does not exist.

        ***/
        if this.has_key key do (
            local val = this.get key
            this._table.Remove (this._dns key)
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
        local count_ = this.size()
        if count_ > 0 do (
            local idx = random 1 count_
            local items = this.items()
            local item = items[idx]
            local key = item[1]
            this._table.Remove (this._dns key)
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
    )
)