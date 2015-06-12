-- Order must match for arrays, but not for dicts.

struct eq (
    /***This struct offers functions to check composite structures
    for equality which MAXScript does not offer natively..

    That includes arrays and custom dictionaries (flat and nested).
    It can also compare any struct instances that implement __eq__().

    ***/

    public
    fn _eq_generics gen_1 gen_2 = (
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
        local same_instance = this._eq_generics arr_1 arr_2
        if same_instance do
            return true

        local same_length = this._eq_generics arr_1.count arr_2.count
        if not same_length do
            return false

        for i = 1 to arr_1.count do (
            local item_1 = arr_1[i]
            local item_2 = arr_2[i]

            local items_equal = this.isequal item_1 item_2
            if not items_equal do
                return false
        )
        true
    ),

    public
    fn _eq_dicts dict_1 dict_2 = (
        /***Checks if dict_1 is equal to dict_2.

        Dictionaries can include nested arrays and other dictionaries.

        The order of their keys/values/items must match, which is
        different to e.g. Python handles this.

        ***/
        local items_1 = dict_1.items()
        local items_2 = dict_2.items()
        this._eq_arrays items_1 items_2
    ),

    public
    fn _eq_structs struct_1 struct_2 = (
        /***Checks if struct_1 is equal to struct_2 by calling its
        custom __eq__() implementation.***/
        struct_1.__eq__ struct_2
    ),

    public
    fn _is_dict thing = (
        /***Checks if thing is a dictionary instance, as defined by the
        API of e.g. mxs_dict and its derivative / sibling structs.***/
        (thing != undefined and \
         isProperty thing "items" and \
         isProperty thing "keys" and \
         isProperty thing "values" and \
         findString ((classOf thing) as String) "dict" != undefined )
    ),

    public
    fn _is_eq_struct thing = (
        /***Checks if thing is a struct that implements the __eq__()
        method and therefore needs to be handled accordingly.***/
        (thing != undefined and \
         superClassOf thing == StructDef and \
         isProperty thing "__eq__")
    ),

    public
    fn isequal a b = (
        /***Checks if a is equal to b.

        a and b can be anything, the proper comparison method is
        identified automatically here. This method can be used as a
        replacement for the generic 'a == b'.

        ***/
        if (classof a == Array and \
            classof b == Array) then
                this._eq_arrays a b

        else if (this._is_dict a and \
                 this._is_dict b) then
            this._eq_dicts a b

        else if (this._is_eq_struct a and \
                 this._is_eq_struct b) then
            this._eq_struct_instances a b

        else
            this._eq_generics a b
    )
)

global eq = eq()
