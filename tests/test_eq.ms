test_dir = getFilenamePath (getSourceFileName())
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\mxs_dict.ms")
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\eq.ms")


struct EqualityTestableStruct (
    name,

    fn __eq__ other = (
        toLower this.name == tLower other.name
    )
)


fn test_eq_eq_generic = (
    local x = 789
    local y = "test"
    local z = 1.0

    assert (eq._eq_generic x x) options:#(#listener, #dialog) showstack:true
    assert (not (eq._eq_generic x 788)) options:#(#listener, #dialog) showstack:true

    assert (eq._eq_generic y y) options:#(#listener, #dialog) showstack:true
    assert (not (eq._eq_generic y "TEST")) options:#(#listener, #dialog) showstack:true

    assert (eq._eq_generic z z) options:#(#listener, #dialog) showstack:true
    assert (eq._eq_generic z 1) options:#(#listener, #dialog) showstack:true
    assert (not (eq._eq_generic z 1.33)) options:#(#listener, #dialog) showstack:true
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

)


fn test_eq_struct_instances = (

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

    assert (not (eq._is_dict x)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_dict y)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_dict z)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_dict a)) options:#(#listener, #dialog) showstack:true
    assert ((eq._is_dict d)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_dict ets)) options:#(#listener, #dialog) showstack:true
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

    assert (not (eq._is_eq_struct x)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct y)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct z)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct a)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct d)) options:#(#listener, #dialog) showstack:true
    assert ((eq._is_eq_struct ets)) options:#(#listener, #dialog) showstack:true
)


fn test_eq_eq = (

)


test_eq_eq_generic()
test_eq_is_dict()
test_eq_is_eq_struct()
test_eq_eq_arrays()

print "done"