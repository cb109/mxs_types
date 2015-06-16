================
mxs_hashdict API
================

The mxs_hashdict internally works with .NET strings only, and therefore
only accepts key-value pairs that can be converted to string. For the
same reason values retrieved from it will always be strings. It shares
its API with the mxs_dict, but lacks its sorting methods
(**sort_by_key** and **sort_by_value**).