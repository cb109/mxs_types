test_dir = getFilenamePath (getSourceFileName())
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\mxs_dict.ms")
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\cmp.ms")


struct ComparableStruct (
    name,

    fn __cmp__ other = (
        case of (
            (this.name > other.name) : 1
            (this.name < other.name) : -1
            default : 0
        )
    ),

    fn __eq__ other = (
        this.name == other.name
    )
)


fn test_cmp_cmp_generic = (
    local x = 789
    local y = "test"

    assert ((cmp._cmp_generic x x) == 0) options:#(#listener, #dialog) showstack:true
    assert ((cmp._cmp_generic x 788) == 1) options:#(#listener, #dialog) showstack:true
    assert ((cmp._cmp_generic x 790) == -1) options:#(#listener, #dialog) showstack:true

    assert ((cmp._cmp_generic y y) == 0) options:#(#listener, #dialog) showstack:true
    assert ((cmp._cmp_generic y "atest") == 1) options:#(#listener, #dialog) showstack:true
    assert ((cmp._cmp_generic y "ztest") == -1) options:#(#listener, #dialog) showstack:true
)


fn test_cmp_cmp_arrays= (

)


fn test_cmp_cmp_dicts = (

)


fn test_cmp_struct_instances = (

)


fn test_cmp_looks_like_dict = (
    local x = 789
    local y = "test"
    local z = true
    local a = [1, 2, 3]
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 456
    local cs = ComparableStruct "Bob"

    assert (not (cmp._looks_like_dict x)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._looks_like_dict y)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._looks_like_dict z)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._looks_like_dict a)) options:#(#listener, #dialog) showstack:true
    assert ((cmp._looks_like_dict d)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._looks_like_dict cs)) options:#(#listener, #dialog) showstack:true
)


fn test_cmp_is_comparable_struct = (
    local x = 789
    local y = "test"
    local z = true
    local a = [1, 2, 3]
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 456
    local cs = ComparableStruct "Bob"

    assert (not (cmp._is_comparable_struct x)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._is_comparable_struct y)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._is_comparable_struct z)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._is_comparable_struct a)) options:#(#listener, #dialog) showstack:true
    assert (not (cmp._is_comparable_struct d)) options:#(#listener, #dialog) showstack:true
    assert ((cmp._is_comparable_struct cs)) options:#(#listener, #dialog) showstack:true
)


fn test_cmp_cmp = (

)


fn test_cmp_eq = (

)


test_cmp_cmp_generic()
test_cmp_looks_like_dict()
test_cmp_is_comparable_struct()

print "done"