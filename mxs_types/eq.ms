-- Order must match for arrays, but not for dicts.

struct eq (
    /***This struct offers functions to check composite structures
    for equality which MAXScript does not offer natively..

    That includes arrays and custom dictionaries (flat and nested).
    It can also compare any struct instances that implement __eq__().

    ***/

    public
    fn _eq_generic gen_1 gen_2 = (
        gen_1 == gen_2
    ),

    public
    fn _eq_arrays arr_1 arr_2 = (

    ),

    public
    fn _eq_dicts dict_1 dict_2 = (

    ),

    public
    fn _eq_struct_instances struct_1 struct_2 = (

    ),

    public
    fn _looks_like_dict thing = (
        (thing != undefined and \
         isProperty thing "items" and \
         isProperty thing "keys" and \
         isProperty thing "values" and \
         findString ((classOf thing) as String) "dict" != undefined )
    ),

    public
    fn _is_eq_struct thing = (
        (superClassOf thing == StructDef and \
         isProperty thing "__eq__")
    ),

    public
    fn eq a b = (
        if (classof a == Array and \
            classof b == Array) then
                this._eq_arrays a b

        else if (this._looks_like_dict a and \
                 this._looks_like_dict b) then
            this._eq_dicts a b

        else if (this._is_eq_struct a and \
                 this._is_eq_struct b) then
            this._eq_struct_instances a b

        else
            this._eq_generic a b
    )
)

global eq = eq()