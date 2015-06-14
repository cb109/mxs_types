===================
mxs_defaultdict API
===================

The mxs_defaultdict shares its API with the mxs_dict with the following
exceptions:

**default_factory**
    This attribute holds a function (or class/struct) name that
    is called to create a default value for an unknown key.

**get** ``key``
    Returns the value that belongs to the given key.
    If the key is unknown, it is added to the dictionary
    using the value returned by the default_factory method
    and then returned.