test_dir = getFilenamePath (getSourceFileName())
fileIn (pathConfig.appendPath test_dir @"..\mxs_types\mxs_hashdict.ms")


fn test_fromkeys = (
    local d = mxs_hashdict.fromkeys #("foo", "bar") default:"default"
    local keys = d.keys()
    local values = d.values()

    assert (keys.count == 2) options:#(#listener) showstack:true
    assert (values.count == 2) options:#(#listener) showstack:true

    assert (keys[1] == "foo") options:#(#listener) showstack:true
    assert (keys[2] == "bar") options:#(#listener) showstack:true

    assert (values[1] == "default") options:#(#listener) showstack:true
    assert (values[2] == "default") options:#(#listener) showstack:true
)


fn test_has_key = (
    local d = mxs_hashdict()
    d.add "foo" 123

    local key_exists = d.has_key "foo"
    assert key_exists options:#(#listener) showstack:true

    local key_exists = d.has_key "bar"
    assert (not key_exists) options:#(#listener) showstack:true
)


fn test_has_value = (
    local d = mxs_hashdict()
    d.add "foo" 123

    local value_exists = d.has_value 123
    assert value_exists options:#(#listener) showstack:true

    local value_exists = d.has_value 456
    assert (not value_exists) options:#(#listener) showstack:true
)


fn test_get = (
    local d = mxs_hashdict()
    assert (d.get "nope" == undefined) options:#(#listener) showstack:true
    assert (d.get "nope" default:"123" == "123") options:#(#listener) showstack:true

    d.add "foo" 567
    assert (d.get "foo" == "567") options:#(#listener) showstack:true
)


fn test_keys = (
    local d = mxs_hashdict()
    local keys = d.keys()
    assert (keys.count == 0) options:#(#listener) showstack:true

    d.add "foo" 123
    d.add "bar" 567

    keys = d.keys()
    assert (keys.count == 2) options:#(#listener) showstack:true
    assert (keys[1] == "foo") options:#(#listener) showstack:true
    assert (keys[2] == "bar") options:#(#listener) showstack:true
)


fn test_values = (
    local d = mxs_hashdict()
    local values = d.values()
    assert (values.count == 0) options:#(#listener) showstack:true

    d.add "foo" 123
    d.add "bar" 567

    values = d.values()
    assert (values.count == 2) options:#(#listener) showstack:true
    assert (values[1] == "123") options:#(#listener) showstack:true
    assert (values[2] == "567") options:#(#listener) showstack:true
)


fn test_items = (
    local d = mxs_hashdict()
    local items = d.items()
    assert (items.count == 0) options:#(#listener) showstack:true

    d.add "foo" 123
    d.add "bar" 567

    items = d.items()
    assert (items.count == 2) options:#(#listener) showstack:true
    assert (items[1][1] == "foo") options:#(#listener) showstack:true
    assert (items[2][1] == "bar") options:#(#listener) showstack:true
    assert (items[1][2] == "123") options:#(#listener) showstack:true
    assert (items[2][2] == "567") options:#(#listener) showstack:true
)


fn test_size = (
    local d = mxs_hashdict()
    assert (d.size() == 0) options:#(#listener) showstack:true

    d.add "foo" 1234
    d.add "bar" 567
    assert (d.size() == 2) options:#(#listener) showstack:true
)


fn test_add = (
    local d = mxs_hashdict()
    local no_val = d.get "nope"
    assert (no_val == undefined) options:#(#listener) showstack:true

    d.add "foo" "bar"
    local val = d.get "foo"
    assert (val == "bar") options:#(#listener) showstack:true

    d.add "foo" "dingbaz"
    local overwritten = d.get "foo"
    assert (overwritten == "dingbaz") options:#(#listener) showstack:true
)


fn test_clear = (
    local d = mxs_hashdict()
    d.add "foo" 123
    d.add "bar" 567
    d.clear()

    local items = d.items()
    assert (items.count == 0) options:#(#listener) showstack:true
)


fn test_copy = (
    local d = mxs_hashdict()
    d.add "foo" 123
    d.add "bar" 567

    local copied = d.copy()
    assert (copied != d) options:#(#listener) showstack:true

    local d_items = d.items()
    local copied_items = copied.items()
    assert (d_items.count == 2) options:#(#listener) showstack:true
    assert (copied_items.count == 2) options:#(#listener) showstack:true

    for i = 1 to d_items.count do (
        local d_key = d_items[i][1]
        local d_val = d_items[i][2]
        local copied_key = copied_items[i][1]
        local copied_val = copied_items[i][2]
        assert (d_key == copied_key) options:#(#listener) showstack:true
        assert (d_val == copied_val) options:#(#listener) showstack:true
    )
)


fn test_pop = (
    local d = mxs_hashdict()
    d.add "foo" 123
    d.add "bar" 567

    local val = d.pop "bar"
    assert (val == "567") options:#(#listener) showstack:true

    local val = d.pop "foo" default:333
    assert (val == 333) options:#(#listener) showstack:true

    local val = d.pop "nope"
    assert (val == undefined) options:#(#listener) showstack:true
)


fn test_popitem = (
    local d = mxs_hashdict()
    d.add "foo" 123
    d.add "bar" 567

    local item = d.popitem()
    assert ((d.items()).count == 1) options:#(#listener) showstack:true
    assert ((item[1] == "foo") or (item[1] == "bar")) options:#(#listener) showstack:true
    assert ((item[2] == "123") or (item[2] == "567")) options:#(#listener) showstack:true

    local item = d.popitem()
    assert ((d.items()).count == 0) options:#(#listener) showstack:true
    assert ((item[1] == "foo") or (item[1] == "bar")) options:#(#listener) showstack:true
    assert ((item[2] == "123") or (item[2] == "567")) options:#(#listener) showstack:true

    local item = d.popitem()
    assert (item == undefined) options:#(#listener) showstack:true
)


fn test_update = (
    local d1 = mxs_hashdict()
    d1.add "foo" 123
    d1.add "bar" 567

    local d2 = mxs_hashdict()
    d2.add "foo" 999
    d2.add "test" 890

    d1.update d2

    assert (d1.size() == 3) options:#(#listener) showstack:true
    assert ((d1.get "test") == "890") options:#(#listener) showstack:true
    assert ((d1.get "foo") == "999") options:#(#listener) showstack:true
    assert ((d1.get "bar") == "567") options:#(#listener) showstack:true
)


fn test_sort_by_key = (
    local d = mxs_hashdict()
    d.add "bernhard" 3
    d.add "zacharias" 6
    d.add "thomas" 2
    d.add "andreas" 1

    d.sort_by_key reversed:false
    local items = d.items()
    assert (items[1][1] == "andreas") options:#(#listener) showstack:true
    assert (items[2][1] == "bernhard") options:#(#listener) showstack:true
    assert (items[3][1] == "thomas") options:#(#listener) showstack:true
    assert (items[4][1] == "zacharias") options:#(#listener) showstack:true
    assert (items[1][2] == 1) options:#(#listener) showstack:true
    assert (items[2][2] == 3) options:#(#listener) showstack:true
    assert (items[3][2] == 2) options:#(#listener) showstack:true
    assert (items[4][2] == 6) options:#(#listener) showstack:true

    d.sort_by_key reversed:true
    local items = d.items()
    assert (items[1][1] == "zacharias") options:#(#listener) showstack:true
    assert (items[2][1] == "thomas") options:#(#listener) showstack:true
    assert (items[3][1] == "bernhard") options:#(#listener) showstack:true
    assert (items[4][1] == "andreas") options:#(#listener) showstack:true
    assert (items[1][2] == 6) options:#(#listener) showstack:true
    assert (items[2][2] == 2) options:#(#listener) showstack:true
    assert (items[3][2] == 3) options:#(#listener) showstack:true
    assert (items[4][2] == 1) options:#(#listener) showstack:true
)


fn test_sort_by_value = (
    local d = mxs_hashdict()
    d.add "bernhard" 3
    d.add "zacharias" 6
    d.add "thomas" 2
    d.add "andreas" 1

    d.sort_by_value reversed:false
    local items = d.items()
    assert (items[1][1] == "andreas") options:#(#listener) showstack:true
    assert (items[2][1] == "thomas") options:#(#listener) showstack:true
    assert (items[3][1] == "bernhard") options:#(#listener) showstack:true
    assert (items[4][1] == "zacharias") options:#(#listener) showstack:true
    assert (items[1][2] == 1) options:#(#listener) showstack:true
    assert (items[2][2] == 2) options:#(#listener) showstack:true
    assert (items[3][2] == 3) options:#(#listener) showstack:true
    assert (items[4][2] == 6) options:#(#listener) showstack:true

    d.sort_by_value reversed:true
    local items = d.items()
    assert (items[1][1] == "zacharias") options:#(#listener) showstack:true
    assert (items[2][1] == "bernhard") options:#(#listener) showstack:true
    assert (items[3][1] == "thomas") options:#(#listener) showstack:true
    assert (items[4][1] == "andreas") options:#(#listener) showstack:true
    assert (items[1][2] == 6) options:#(#listener) showstack:true
    assert (items[2][2] == 3) options:#(#listener) showstack:true
    assert (items[3][2] == 2) options:#(#listener) showstack:true
    assert (items[4][2] == 1) options:#(#listener) showstack:true
)


test_fromkeys()
test_has_key()
test_has_value()
test_get()
test_keys()
test_values()
test_items()
test_clear()
test_add()
test_copy()
test_pop()
test_popitem()
test_update()


print "test_mxs_hashdict finished."
