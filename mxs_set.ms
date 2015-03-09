-- TODO maybe allow both arrays and sets as input?
-- make array a set before actual use?

struct mxs_set (
    /***

    ***/

    public
    _elements = #(),


    -- Static methods.

    public
    fn from_array array_ = (

    ),


    -- Instance methods.

    public
    fn add element = (
        /***Add an element to a set.

        This has no effect if the element is already present.

        ***/

    ),

    public
    fn clear = (
        /***Remove all elements from this set.***/

    ),

    public
    fn copy = (
        /***Return a shallow copy of a set.***/

    ),

    public
    fn difference set_ = (
        /***Return the difference of two or more sets as a new set.
        (i.e. all elements that are in this set but not the others.)***/

    ),

    public
    fn difference_update set_ = (
        /***Remove all elements of another set from this set.***/

    ),

    public
    fn discard element = (
        /***Remove an element from a set if it is a member.
        If the element is not a member, do nothing.***/

    ),

    public
    fn intersection set_ = (
        /***Return the intersection of two or more sets as a new set.
        (i.e. elements that are common to all of the sets.)***/

    ),

    public
    fn intersection_update set_ = (
        /***Update a set with the intersection of itself and another.***/

    ),

    public
    fn isdisjoint set_ = (
        /***Return True if two sets have a null intersection.***/

    ),

    public
    fn issubset set_ = (
        /***Report whether another set contains this set.***/

    ),

    public
    fn issuperset set_ = (
        /***Report whether this set contains another set.***/

    ),

    public
    fn pop = (
        /***Remove and return an arbitrary set element.
        Raises KeyError if the set is empty.***/

    ),

    public
    fn remove element = (
        /***Remove an element from a set; it must be a member.
        If the element is not a member, raise a KeyError.***/

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

    public
    fn union set_ = (
        /***Return the union of sets as a new set.
        (i.e. all elements that are in either set.)***/

    ),

    public
    fn update set_ = (
        /***Update a set with the union of itself and others.***/

    ),

    public
    fn to_array = (

    )
)