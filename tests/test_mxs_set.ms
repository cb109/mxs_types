test_dir = getFilenamePath (getSourceFileName())
fileIn (pathConfig.appendPath test_dir @"..\mxs_set.ms")


fn test_from_array = (
    local arr = #(1, 1, 2, 3, 5, 5)
    local new_set = mxs_set.from_array arr
    assert (classof new_set == mxs_set) options:#(#listener, #dialog) showstack:true

    local elements = new_set.elements()
    assert (elements.count == 4) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[4] == 5) options:#(#listener, #dialog) showstack:true
)


fn test_elements = (
    local new_set = mxs_set #(1, 2, 2, 3, 3)
    local elements = new_set.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 3) options:#(#listener, #dialog) showstack:true
)


fn test_set_elements = (
    local new_set = mxs_set()
    new_set.set_elements #(1, 2, 2, 3, 3)
    local elements = new_set.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 3) options:#(#listener, #dialog) showstack:true
)


fn test_discard = (
    local new_set = mxs_set #(1, 2, 2, 3, 3)

    new_set.discard 2
    local elements = new_set.elements()
    assert (elements.count == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true

    new_set.discard 5
    local elements = new_set.elements()
    assert (elements.count == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true
)


fn test_clear = (
    local new_set = mxs_set #(1, 2, 2, 3, 3)
    local elements = new_set.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true

    new_set.clear()
    local elements = new_set.elements()
    assert (elements.count == 0) options:#(#listener, #dialog) showstack:true
)


fn test_copy = (
    local new_set = mxs_set #(1, 2, 2, 3, 3)
    local elements = new_set.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true

    local copied_set = new_set.copy()
    local copied_elements = copied_set.elements()
    assert (copied_elements.count == 3) options:#(#listener, #dialog) showstack:true
    assert (copied_elements[1] == elements[1]) options:#(#listener, #dialog) showstack:true
    assert (copied_elements[2] == elements[2]) options:#(#listener, #dialog) showstack:true
    assert (copied_elements[3] == elements[3]) options:#(#listener, #dialog) showstack:true
)


fn test_difference = (

)


fn test_difference_update = (

)


fn test_intersection = (

)


fn test_intersection_update = (

)


fn test_isdisjoint = (

)


fn test_issubset = (

)


fn test_issuperset = (

)


fn test_pop = (

)


fn test_symmetric_difference = (

)


fn test_symmetric_difference_update = (

)


fn test_union = (

)


fn test_update = (

)


fn test_to_array = (

)


test_from_array()
test_elements()
test_set_elements()
test_discard()
test_clear()
test_copy()
test_difference()
test_difference_update()
test_intersection()
test_intersection_update()
test_isdisjoint()
test_issubset()
test_issuperset()
test_pop()
test_symmetric_difference()
test_symmetric_difference_update()
test_union()
test_update()


print "test_mxs_set finished."