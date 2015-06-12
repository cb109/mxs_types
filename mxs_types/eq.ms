-- Order must match for arrays, but not for dicts.

struct eq (
    /***This struct offers functions to check composite structures
    for equality which MAXScript does not offer natively..

    That includes arrays and custom dictionaries (flat and nested).
    It can also compare any struct instances that implement __eq__().

    ***/

    public
    fn _eq_generic gen_1 gen_2 = (
        /***Wraps the builtin equality check.***/
        gen_1 == gen_2
    ),

    public
    fn _eq_arrays arr_1 arr_2 = (
        /***Checks arrays for equality.

        To be considered equal their item count, content and order have
        to match. Calls the eq() method recursively on all items, so the
        given arrays can be nested.

        ***/
        local same_instance = this._eq_generic arr_1 arr_2
        if same_instance do
            return true

        local same_length = this._eq_generic arr_1.count arr_2.count
        if not same_length do
            return false

        for i = 1 to arr_1.count do (
            local item_1 = arr_1[i]
            local item_2 = arr_2[i]

            local items_equal = this.eq item_1 item_2
            if not items_equal do
                return false
        )
        true
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