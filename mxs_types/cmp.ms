-- Order must match for arrays, but not for dicts.

struct cmp (
    /***This struct offers functions to compare composite structures
    which are not covered by the builtin MAXScript comparison.

    That includes arrays and custom dictionaries (flat and nested).
    It can also compare any struct instances that implement a __cmp__
    method (returning 0 for ==, 1 for > and -1 for <) or __eq__ method
    (returning true or false) if you just want to test for equality.

    Example:
        a = #(1, 2, 3)
        b = #(1, 2, 3)

        a == b
        >>> false

        cmp.eq a b
        >>> true

        cmp.cmp a b
        >>> 0

    ***/
    fn _cmp_generic gen_1 gen_2 = (
        case of (
            (gen_1 > gen_2) : 1
            (gen_1 < gen_2) : -1
            default : 0
        )
    ),

    fn _cmp_arrays arr_1 arr_2 = (

    ),

    fn _cmp_dicts dict_1 dict_2 = (

    ),

    fn _cmp_struct_instances struct_1 struct_2 = (

    ),

    fn _looks_like_dict thing = (
        (thing != undefined and \
         isProperty thing "items" and \
         isProperty thing "keys" and \
         isProperty thing "values" and \
         findString ((classof thing) as String) "dict" != undefined )
    ),

    fn _is_comparable_struct thing = (
        (superclassof thing == StructDef and \
         isProperty thing "__cmp__")
    ),

    fn cmp a b = (
        if (classof a == Array and \
            classof b == Array) then
                this._cmp_arrays a b

        else if (this._looks_like_dict a and \
                 this._looks_like_dict b) then
            this._cmp_dicts a b

        else if (this._is_comparable_struct a and \
                 this._is_comparable_struct b) then
            this._cmp_struct_instances a b

        else
            this._cmp_generic a b
    ),

    fn eq a b  = (

    )
)

global cmp = cmp()