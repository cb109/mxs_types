-- TODO maybe allow both arrays and sets as input?
-- make array a set before actual use?

struct mxs_set (
    /***

    ***/

    public
    _elements,


    -- Static methods.

    public
    fn from_array array_ = (
        /***Returns a new set based on the given array.***/
        mxs_set array_
    ),


    -- Instance methods.

    public
    fn elements = (
        this._elements
    ),

    public
    fn set_elements elements_ = (
        this._elements = elements_
    ),

    public
    fn add element = (
        /***Add an element to a set.
        This has no effect if the element is already present.***/
        appendIfUnique this._elements element
    ),

    private
    fn _discard_by_index idx = (
        if idx != 0 do
            deleteItem this._elements idx
    ),

    public
    fn discard element = (
        /***Remove an element from a set if it is a member.
        If the element is not a member, do nothing.***/
        local idx = findItem this._elements element
        this._discard_by_index idx
    ),

    public
    fn clear = (
        /***Remove all elements from this set.***/
        this._elements = #()
    ),

    public
    fn copy = (
        /***Return a shallow copy of a set.***/
        mxs_set this._elements
    ),

    public
    fn difference set_ = (
        /***Return the difference of this set and a new set.
        (i.e. all elements that are in this set but not the other.)***/
        local differing = #()
        for element_1 in this.elements() do (
            local found = false
            for element_2 in set_.elements() while not found do (
                if element_1 == element_2 do
                    found = true
            )
            if not found do
                append differing element_1
        )
        differing
    ),

    public
    fn difference_update set_ = (
        /***Remove all elements of another set from this set.***/
        this._elements = this.difference set_
    ),

    public
    fn intersection set_ = (
        /***Return the intersection of this set and a new set.
        (i.e. elements that are common to both sets.)***/
        local intersecting = #()
        for element_1 in this.elements() do (
            local found = false
            for element_2 in set_.elements() while not found do (
                if element_1 == element_2 do
                    found = true
            )
            if found do
                append intersecting element_1
        )
        intersecting
    ),

    public
    fn intersection_update set_ = (
        /***Update a set with the intersection of itself and another.***/
        this._elements = this.intersection set_
    ),

    public
    fn isdisjoint set_ = (
        /***Return true if two sets have a null intersection.***/
        local intersecting = this.intersection set_
        intersecting.count == 0
    ),

    public
    fn issubset set_ = (
        /***Report whether another set contains this set.***/
        for element_1 in this.elements() do (
            local found = false
            for element_2 in set_.elements() do (
                if element_1 == element_2 do
                    found = true
            )
            if not found do
                return false
        )
        true
    ),

    public
    fn issuperset set_ = (
        /***Report whether this set contains another set.***/
        for element_2 in set_.elements() do (
            local found = false
            for element_1 in this.elements() do (
                if element_2 == element_1 do
                    found = true
            )
            if not found do
                return false
        )
        true
    ),

    public
    fn pop = (
        /***Remove and return an arbitrary set element.
        Return undefined if the set is empty.***/
        local count_ = this._elements.count
        if count_ > 0 do (
            local idx = random 1 count_
            local element = this._elements[idx]
            this._discard_by_index idx
            return element
        )
        undefined
    ),

    public
    fn symmetric_difference set_ = (
        /***Return the symmetric difference of two sets as a new set.
        (i.e. all elements that are in exactly one of the sets.)***/

    ),

    public
    fn symmetric_difference_update set_ = (
        /***Update a set with the symmetric
        difference of itself and another.***/

    ),

    private
    fn _get_union_elements set_ = (
        makeUniqueArray (this.elements() + set_.elements())
    ),

    public
    fn union set_ = (
        /***Return the union of sets as a new set.
        (i.e. all elements that are in either set.)***/
        local united = this._get_union_elements set_
        mxs_set united
    ),

    public
    fn update set_ = (
        /***Update a set with the union of itself and another.***/
        this._elements = this._get_union_elements set_
    ),

    public
    fn update_from_array array_ = (
        /***Update a set with the union of itself and a new set
        (which is created based on the given array).***/
        local set_ = mxs_set array_
        this.update set_
    ),

    public
    fn to_array = (
        /***Return the set content as an array.***/
        this._elements
    ),

    on create do (
        -- Handle array as optional first argument of constructor.
        if this._elements != undefined do
            this._elements = makeUniqueArray this._elements
    )
)