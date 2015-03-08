test_dir = getFilenamePath (getSourceFileName())
fileIn (pathConfig.appendPath test_dir @"..\mxs_dict.ms")


fn test_fromkeys = (
    local d = mxs_dict.fromkeys #("foo", "bar") default:#()
    local keys = d.keys()
    local values = d.values()

    assert (keys.count == 2) options:#(#dialog)
    assert (values.count == 2) options:#(#dialog)

    assert (keys[1] == "foo") options:#(#dialog)
    assert (keys[2] == "bar") options:#(#dialog)

    assert (classof values[1] == Array) options:#(#dialog)
    assert (classof values[2] == Array) options:#(#dialog)
)


fn test_has_key = (
    local d = mxs_dict()
    d.add "foo" 123

    local key_exists = d.has_key "foo"
    assert key_exists options:#(#dialog)

    local key_exists = d.has_key "bar"
    assert (not key_exists) options:#(#dialog)
)


fn test_get = (
    local d = mxs_dict()
    assert (d.get "nope" == undefined) options:#(#dialog)
    assert (d.get "nope" default:123 == 123) options:#(#dialog)

    d.add "foo" 567
    assert (d.get "foo" == 567) options:#(#dialog)
)


fn test_keys = (
    local d = mxs_dict()
    local keys = d.keys()
    assert (keys.count == 0) options:#(#dialog)

    d.add "foo" 123
    d.add "bar" 567

    keys = d.keys()
    assert (keys.count == 2) options:#(#dialog)
    assert (keys[1] == "foo") options:#(#dialog)
    assert (keys[2] == "bar") options:#(#dialog)
)


fn test_values = (
    local d = mxs_dict()
    local values = d.values()
    assert (values.count == 0) options:#(#dialog)

    d.add "foo" 123
    d.add "bar" 567

    values = d.values()
    assert (values.count == 2) options:#(#dialog)
    assert (values[1] == 123) options:#(#dialog)
    assert (values[2] == 567) options:#(#dialog)
)


fn test_items = (
    local d = mxs_dict()
    local items = d.items()
    assert (items.count == 0) options:#(#dialog)

    d.add "foo" 123
    d.add "bar" 567

    items = d.items()
    assert (items.count == 2) options:#(#dialog)
    assert (items[1][1] == "foo") options:#(#dialog)
    assert (items[2][1] == "bar") options:#(#dialog)
    assert (items[1][2] == 123) options:#(#dialog)
    assert (items[2][2] == 567) options:#(#dialog)
)


fn test_add = (
    local d = mxs_dict()
    local no_val = d.get "nope"
    assert (no_val == undefined) options:#(#dialog)

    d.add "foo" "bar"
    local val = d.get "foo"
    assert (val == "bar") options:#(#dialog)

    d.add "foo" "dingbaz"
    local overwritten = d.get "foo"
    assert (overwritten == "dingbaz") options:#(#dialog)
)


fn test_clear = (
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 567
    d.clear()

    local items = d.items()
    assert (items.count == 0) options:#(#dialog)
)


fn test_copy = (
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 567
    local pot = Teapot()
    d.add "tea" pot

    local copied = d.copy()
    assert (copied != d) options:#(#dialog)

    local d_items = d.items()
    local copied_items = copied.items()

    for i = 1 to d_items.count do (
        local d_key = d_items[i][1]
        local d_val = d_items[i][2]
        local copied_key = copied_items[i][1]
        local copied_val = copied_items[i][2]
        assert (d_key == copied_key) options:#(#dialog)
        assert (d_val == copied_val) options:#(#dialog)
    )

    delete pot
)


fn test_pop = (
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 567

    local val = d.pop "bar"
    assert (val == 567) options:#(#dialog)

    local val = d.pop "foo" default:333
    assert (val == 333) options:#(#dialog)

    local val = d.pop "nope"
    assert (val == undefined) options:#(#dialog)
)


fn test_popitem = (
    local d = mxs_dict()
    d.add "foo" 123
    d.add "bar" 567

    local item = d.popitem()
    assert ((d.items()).count == 1) options:#(#dialog)
    assert ((item[1] == "foo") or (item[1] == "bar")) options:#(#dialog)
    assert ((item[2] == 123) or (item[2] == 567)) options:#(#dialog)

    local item = d.popitem()
    assert ((d.items()).count == 0) options:#(#dialog)
    assert ((item[1] == "foo") or (item[1] == "bar")) options:#(#dialog)
    assert ((item[2] == 123) or (item[2] == 567)) options:#(#dialog)

    local item = d.popitem()
    assert (item == undefined) options:#(#dialog)
)


fn test_update = (
    local d1 = mxs_dict()
    d1.add "foo" 123
    d1.add "bar" 567

    local d2 = mxs_dict()
    d2.add "foo" 999
    d2.add "test" 890

    d1.update d2

    local d1_items = d1.items()
    assert (d1_items[1][1] == "foo") options:#(#dialog)
    assert (d1_items[1][2] == 999) options:#(#dialog)

    assert (d1_items[2][1] == "bar") options:#(#dialog)
    assert (d1_items[2][2] == 567) options:#(#dialog)

    assert (d1_items[3][1] == "test") options:#(#dialog)
    assert (d1_items[3][2] == 890) options:#(#dialog)
)


fn test_sort_by_key = (
    local d = mxs_dict()
    d.add "bernhard" 3
    d.add "zacharias" 6
    d.add "thomas" 2
    d.add "andreas" 1

    d.sort_by_key reversed:false
    local items = d.items()
    assert (items[1][1] == "andreas") options:#(#dialog)
    assert (items[2][1] == "bernhard") options:#(#dialog)
    assert (items[3][1] == "thomas") options:#(#dialog)
    assert (items[4][1] == "zacharias") options:#(#dialog)
    assert (items[1][2] == 1) options:#(#dialog)
    assert (items[2][2] == 3) options:#(#dialog)
    assert (items[3][2] == 2) options:#(#dialog)
    assert (items[4][2] == 6) options:#(#dialog)

    d.sort_by_key reversed:true
    local items = d.items()
    assert (items[1][1] == "zacharias") options:#(#dialog)
    assert (items[2][1] == "thomas") options:#(#dialog)
    assert (items[3][1] == "bernhard") options:#(#dialog)
    assert (items[4][1] == "andreas") options:#(#dialog)
    assert (items[1][2] == 6) options:#(#dialog)
    assert (items[2][2] == 2) options:#(#dialog)
    assert (items[3][2] == 3) options:#(#dialog)
    assert (items[4][2] == 1) options:#(#dialog)
)


fn test_sort_by_value = (
    local d = mxs_dict()
    d.add "bernhard" 3
    d.add "zacharias" 6
    d.add "thomas" 2
    d.add "andreas" 1

    d.sort_by_value reversed:false
    local items = d.items()
    assert (items[1][1] == "andreas") options:#(#dialog)
    assert (items[2][1] == "thomas") options:#(#dialog)
    assert (items[3][1] == "bernhard") options:#(#dialog)
    assert (items[4][1] == "zacharias") options:#(#dialog)
    assert (items[1][2] == 1) options:#(#dialog)
    assert (items[2][2] == 2) options:#(#dialog)
    assert (items[3][2] == 3) options:#(#dialog)
    assert (items[4][2] == 6) options:#(#dialog)

    d.sort_by_value reversed:true
    local items = d.items()
    assert (items[1][1] == "zacharias") options:#(#dialog)
    assert (items[2][1] == "bernhard") options:#(#dialog)
    assert (items[3][1] == "thomas") options:#(#dialog)
    assert (items[4][1] == "andreas") options:#(#dialog)
    assert (items[1][2] == 6) options:#(#dialog)
    assert (items[2][2] == 3) options:#(#dialog)
    assert (items[3][2] == 2) options:#(#dialog)
    assert (items[4][2] == 1) options:#(#dialog)
)


test_fromkeys()
test_has_key()
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
test_sort_by_key()
test_sort_by_value()


print "test_mxs_dict finished."
