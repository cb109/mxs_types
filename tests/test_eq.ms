test_dir = getFilenamePath (getSourceFileName())
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\mxs_dict.ms")
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\eq.ms")


struct ComparableStruct (
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

)


fn test_eq_eq_dicts = (

)


fn test_eq_struct_instances = (

)


fn test_eq_looks_like_dict = (
    local x = 789
    local y = "test"
    local z = true
    local a = [1, 2, 3]
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 456
    local cs = ComparableStruct "Bob"

    assert (not (eq._looks_like_dict x)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._looks_like_dict y)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._looks_like_dict z)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._looks_like_dict a)) options:#(#listener, #dialog) showstack:true
    assert ((eq._looks_like_dict d)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._looks_like_dict cs)) options:#(#listener, #dialog) showstack:true
)


fn test_eq_is_eq_struct = (
    local x = 789
    local y = "test"
    local z = true
    local a = [1, 2, 3]
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 456
    local cs = ComparableStruct "Bob"

    assert (not (eq._is_eq_struct x)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct y)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct z)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct a)) options:#(#listener, #dialog) showstack:true
    assert (not (eq._is_eq_struct d)) options:#(#listener, #dialog) showstack:true
    assert ((eq._is_eq_struct cs)) options:#(#listener, #dialog) showstack:true
)


fn test_eq_eq = (

)


test_eq_eq_generic()
test_eq_looks_like_dict()
test_eq_is_eq_struct()

print "done"