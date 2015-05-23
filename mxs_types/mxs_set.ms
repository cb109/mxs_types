struct mxs_set (
    /***Represents a collection of unique elements.

    Offers operations like union, difference, intersection etc.

    A set can be constructed simply like:
        mxs_set()
    Or with an array as its first argument to start with:
        mxs_set #(...)

    Note: Elements can have any type, but be aware that due
    to MAXScript limitations some values can not be tested
    for uniqueness, e.g. when comparing arrays.

    The interface is loosely based on Python's set API.

    ***/

    public
    _elements,  -- Initialized in event handler.

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
    fn add element = (
        /***Add an element to a set.
        This has no effect if the element is already present.***/
        appendIfUnique this._elements element
    ),

    public
    fn set_elements elements_ = (
        /***Set elements from given list.
        Elements will only contain unique items afterwards.***/
        this._elements = #()
        for element in elements_ do
            this.add element
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
        /***Return the difference of this set and another as a new set.
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
        mxs_set differing
    ),

    public
    fn difference_update set_ = (
        /***Remove all elements of another set from this set.***/
        local diff_set = this.difference set_
        this._elements = diff_set.elements()
    ),

    public
    fn intersection set_ = (
        /***Return the intersection of this set and another as a new set.
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
        mxs_set intersecting
    ),

    public
    fn intersection_update set_ = (
        /***Update a set with the intersection of itself and another.***/
        local intersect_set = this.intersection set_
        this._elements = intersect_set.elements()
    ),

    public
    fn isdisjoint set_ = (
        /***Return true if two sets have a null intersection.***/
        local intersect_set = this.intersection set_
        (intersect_set.elements()).count == 0
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

    private
    fn _is_in set_ item_ = (
        local elements_ = set_.elements()
        local idx = findItem elements_ item_
        idx != 0
    ),

    public
    fn symmetric_difference set_ = (
        /***Return the symmetric difference of two sets as a new set.
        (i.e. all elements that are in exactly one of the sets.)***/
        local only_in_this = #()
        for element_1 in this.elements() do (
            if not this._is_in set_ element_1 do
                append only_in_this element_1
        )

        local only_in_that = #()
        for element_2 in set_.elements() do (
            if not this._is_in this element_2 do
                append only_in_that element_2
        )
        local symmetric = only_in_this + only_in_that
        mxs_set symmetric
    ),

    public
    fn symmetric_difference_update set_ = (
        /***Update a set with the symmetric
        difference of itself and another.***/
        local symmetric_set = this.symmetric_difference set_
        this._elements = symmetric_set.elements()
    ),

    public
    fn union set_ = (
        /***Return the union of sets as a new set.
        (i.e. all elements that are in either set.)***/
        local united = this.elements() + set_.elements()
        mxs_set united
    ),

    public
    fn update set_ = (
        /***Update a set with the union of itself and another.***/
        local union_set = this.union set_
        this._elements = union_set.elements()
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
        if this._elements != undefined then
            this._elements = makeUniqueArray this._elements
        else
            this._elements = #()
    )
)