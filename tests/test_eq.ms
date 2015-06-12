test_dir = getFilenamePath (getSourceFileName())
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\mxs_dict.ms")
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\eq.ms")


struct EqualityTestableStruct (
    /***Dummy struct for testing.***/
    name,

    fn __eq__ other = (
        /***We implement some custom behaviour for testing here:

        If 'other' is actually the same instance than this struct
        instance, we want it to be not equal. In any other case, we
        define both being equal if their names match, while ignoring its
        case.

        ***/
        if other == this do
            return false
        toLower this.name == toLower other.name
    )
)


fn test_eq_is_dict = (
    local x = 789
    local y = "test"
    local z = true
    local a = [1, 2, 3]
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 456
    local ets = EqualityTestableStruct "Bob"

    assert (not (eq._is_dict x)) options:#(#listener) showstack:true
    assert (not (eq._is_dict y)) options:#(#listener) showstack:true
    assert (not (eq._is_dict z)) options:#(#listener) showstack:true
    assert (not (eq._is_dict a)) options:#(#listener) showstack:true
    assert ((eq._is_dict d)) options:#(#listener) showstack:true
    assert (not (eq._is_dict ets)) options:#(#listener) showstack:true
)


fn test_eq_is_eq_struct = (
    local x = 789
    local y = "test"
    local z = true
    local a = [1, 2, 3]
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 456
    local ets = EqualityTestableStruct "Bob"

    assert (not (eq._is_eq_struct x)) options:#(#listener) showstack:true
    assert (not (eq._is_eq_struct y)) options:#(#listener) showstack:true
    assert (not (eq._is_eq_struct z)) options:#(#listener) showstack:true
    assert (not (eq._is_eq_struct a)) options:#(#listener) showstack:true
    assert (not (eq._is_eq_struct d)) options:#(#listener) showstack:true
    assert ((eq._is_eq_struct ets)) options:#(#listener) showstack:true
)


fn test_eq_eq_generic = (
    local x = 789
    local y = "test"
    local z = 1.0

    assert (eq._eq_generic x x) options:#(#listener) showstack:true
    assert (not (eq._eq_generic x 788)) options:#(#listener) showstack:true

    assert (eq._eq_generic y y) options:#(#listener) showstack:true
    assert (not (eq._eq_generic y "TEST")) options:#(#listener) showstack:true

    assert (eq._eq_generic z z) options:#(#listener) showstack:true
    assert (eq._eq_generic z 1) options:#(#listener) showstack:true
    assert (not (eq._eq_generic z 1.33)) options:#(#listener) showstack:true
)


fn test_eq_eq_arrays= (
    local a = #(1, 2, 3)
    local b = #(1, 2, 3)
    local c = #(3, 1, 2)
    local g = #(4, 5)
    local h = #()

    local expr_1 = #(1 == 1)
    local expr_2 = #(false or true)

    local nested_1 = #(false, "foobar", #(3, 4.33), #(5, #(true, 7)))
    local nested_2 = #(false, "foobar", #(3, 4.33), #(5, #(true, 7)))

    assert (eq._eq_arrays a a) options:#(#listener) showstack:true
    assert (eq._eq_arrays a b) options:#(#listener) showstack:true
    assert (eq._eq_arrays b a) options:#(#listener) showstack:true
    assert (not (eq._eq_arrays b c)) options:#(#listener) showstack:true

    assert (not (eq._eq_arrays a g)) options:#(#listener) showstack:true
    assert (eq._eq_arrays h h) options:#(#listener) showstack:true

    assert (eq._eq_arrays expr_1 expr_2) options:#(#listener) showstack:true

    assert (eq._eq_arrays nested_1 nested_1) options:#(#listener) showstack:true
    assert (eq._eq_arrays nested_1 nested_2) options:#(#listener) showstack:true
    assert (eq._eq_arrays nested_2 nested_1) options:#(#listener) showstack:true
    assert (not (eq._eq_arrays nested_1 h)) options:#(#listener) showstack:true
)


fn test_eq_eq_dicts = (
    local d_1 = mxs_dict()
    d_1.add "foo" 123

    local copied_d_1 = d_1.copy()

    local d_2 = mxs_dict()
    d_2.add "foo" 123

    assert (eq._eq_dicts d_1 d_1) options:#(#listener) showstack:true
    assert (eq._eq_dicts d_1 copied_d_1) options:#(#listener) showstack:true
    assert (eq._eq_dicts d_1 d_2) options:#(#listener) showstack:true
    assert (eq._eq_dicts d_2 d_1) options:#(#listener) showstack:true
    assert (eq._eq_dicts d_2 copied_d_1) options:#(#listener) showstack:true

    local d_3 = mxs_dict()
    d_3.add "bar" #(1, 2, 3)
    d_3.add true d_1
    d_3.add #some_key #(true, "test", #(4, 5), undefined)

    local d_4 = mxs_dict()
    d_4.add "bar" #(1, 2, 3)
    d_4.add true d_1
    d_4.add #some_key #(true, "test", #(4, 5), undefined)

    assert (eq._eq_dicts d_3 d_3) options:#(#listener) showstack:true
    assert (eq._eq_dicts d_3 d_4) options:#(#listener) showstack:true

    local d_5 = mxs_dict()
    d_5.add "foo" "nope"

    assert (not (eq._eq_dicts d_1 d_5)) options:#(#listener) showstack:true

    local d_6 = mxs_dict()
    d_6.add "bar" #(1, 2, 3)
    d_6.add true d_1
    d_6.add #some_key #(true, "test", #(5, 4), undefined)

    assert (not (eq._eq_dicts d_3 d_6)) options:#(#listener) showstack:true

    local deep_1 = mxs_dict()
    deep_1.add "dicts" #(d_1, d_2, d_3, d_4, d_5, d_6)

    local deep_2 = mxs_dict()
    deep_2.add "dicts" #(d_1, d_2, d_3, d_4, d_5, d_6)

    local deep_3 = mxs_dict()
    deep_3.add "dicts" #(d_1, d_2, undefined, d_4, d_5, d_6)

    assert (eq._eq_dicts deep_1 deep_2) options:#(#listener) showstack:true
    assert (eq._eq_dicts deep_2 deep_1) options:#(#listener) showstack:true
    assert (not (eq._eq_dicts deep_1 deep_3)) options:#(#listener) showstack:true
)


fn test_eq_structs = (
    local ets_1 = EqualityTestableStruct "Guido"
    local ets_2 = EqualityTestableStruct "Guido"
    local ets_3 = EqualityTestableStruct "Tim"
    local ets_4 = EqualityTestableStruct "GUIDO"

    assert (not (eq._eq_structs ets_1 ets_1)) options:#(#listener) showstack:true
    assert (eq._eq_structs ets_1 ets_2) options:#(#listener) showstack:true
    assert (not (eq._eq_structs ets_1 ets_3)) options:#(#listener) showstack:true
    assert (eq._eq_structs ets_1 ets_4) options:#(#listener) showstack:true
)


fn test_eq_eq = (

)


test_eq_is_dict()
test_eq_is_eq_struct()
test_eq_eq_generic()
test_eq_eq_arrays()
test_eq_eq_dicts()
test_eq_structs()

print "done"