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
    local a_set = mxs_set #(1, 1, 2, 2, 3, 3)
    local b_set = mxs_set #(2, 2, 3, 3, 4, 4)

    local diff_set = a_set.difference a_set
    local elements = diff_set.elements()
    assert (elements.count == 0) options:#(#listener, #dialog) showstack:true

    local diff_set = b_set.difference b_set
    local elements = diff_set.elements()
    assert (elements.count == 0) options:#(#listener, #dialog) showstack:true

    local diff_set = a_set.difference b_set
    local elements = diff_set.elements()
    assert (elements.count == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true

    local diff_set = b_set.difference a_set
    local elements = diff_set.elements()
    assert (elements.count == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 4) options:#(#listener, #dialog) showstack:true
)


fn test_difference_update = (
    local a_set = mxs_set #(1, 1, 2, 2, 3, 3)
    local b_set = mxs_set #(2, 2, 3, 3, 4, 4)

    local a_copy = a_set.copy()
    a_copy.difference_update a_set
    local elements = a_copy.elements()
    assert (elements.count == 0) options:#(#listener, #dialog) showstack:true

    local b_copy = b_set.copy()
    b_copy.difference_update b_set
    local elements = b_copy.elements()
    assert (elements.count == 0) options:#(#listener, #dialog) showstack:true

    local a_copy = a_set.copy()
    a_copy.difference_update b_set
    local elements = a_copy.elements()
    assert (elements.count == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true

    local b_copy = b_set.copy()
    b_copy.difference_update a_set
    local elements = b_copy.elements()
    assert (elements.count == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 4) options:#(#listener, #dialog) showstack:true
)


fn test_intersection = (
    local a_set = mxs_set #(1, 1, 2, 2, 3, 3)
    local b_set = mxs_set #(2, 2, 3, 3, 4, 4)

    local intersect_set = a_set.intersection a_set
    local elements = intersect_set.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 3) options:#(#listener, #dialog) showstack:true

    local intersect_set = b_set.intersection b_set
    local elements = intersect_set.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 4) options:#(#listener, #dialog) showstack:true

    local intersect_set = a_set.intersection b_set
    local elements = intersect_set.elements()
    assert (elements.count == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true

    local intersect_set = b_set.intersection a_set
    local elements = intersect_set.elements()
    assert (elements.count == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true
)


fn test_intersection_update = (
    local a_set = mxs_set #(1, 1, 2, 2, 3, 3)
    local b_set = mxs_set #(2, 2, 3, 3, 4, 4)

    local a_copy = a_set.copy()
    a_copy.intersection_update a_set
    local elements = a_copy.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 1) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 3) options:#(#listener, #dialog) showstack:true

    local b_copy = b_set.copy()
    b_copy.intersection_update b_set
    local elements = b_copy.elements()
    assert (elements.count == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true
    assert (elements[3] == 4) options:#(#listener, #dialog) showstack:true

    local a_copy = a_set.copy()
    a_copy.intersection_update b_set
    local elements = a_copy.elements()
    assert (elements.count == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true

    local b_copy = b_set.copy()
    b_copy.intersection_update a_set
    local elements = b_copy.elements()
    assert (elements.count == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[1] == 2) options:#(#listener, #dialog) showstack:true
    assert (elements[2] == 3) options:#(#listener, #dialog) showstack:true
)


fn test_isdisjoint = (
    local a_set = mxs_set #(1, 1, 2, 2)
    local b_set = mxs_set #(3, 3, 4, 4)

    local is_disjoint = a_set.isdisjoint a_set
    assert (not is_disjoint) options:#(#listener, #dialog) showstack:true

    local is_disjoint = b_set.isdisjoint b_set
    assert (not is_disjoint) options:#(#listener, #dialog) showstack:true

    local is_disjoint = a_set.isdisjoint b_set
    assert (is_disjoint) options:#(#listener, #dialog) showstack:true

    local is_disjoint = b_set.isdisjoint a_set
    assert (is_disjoint) options:#(#listener, #dialog) showstack:true
)


fn test_issubset = (
    local a_set = mxs_set #(1, 1, 2, 2, 3, 3)
    local b_set = mxs_set #(2, 2, 3, 3)

    local is_subset = a_set.issubset a_set
    assert (is_subset) options:#(#listener, #dialog) showstack:true

    local is_subset = b_set.issubset b_set
    assert (is_subset) options:#(#listener, #dialog) showstack:true

    local is_subset = a_set.issubset b_set
    assert (not is_subset) options:#(#listener, #dialog) showstack:true

    local is_subset = b_set.issubset a_set
    assert (is_subset) options:#(#listener, #dialog) showstack:true
)


fn test_issuperset = (
    local a_set = mxs_set #(1, 1, 2, 2, 3, 3)
    local b_set = mxs_set #(2, 2, 3, 3)

    local is_superset = a_set.issuperset a_set
    assert (is_superset) options:#(#listener, #dialog) showstack:true

    local is_superset = b_set.issuperset b_set
    assert (is_superset) options:#(#listener, #dialog) showstack:true

    local is_superset = a_set.issuperset b_set
    assert (is_superset) options:#(#listener, #dialog) showstack:true

    local is_superset = b_set.issuperset a_set
    assert (not is_superset) options:#(#listener, #dialog) showstack:true
)


fn test_pop = (
    local new_set = mxs_set #(1, 1, 2, 2, 3, 3)
    assert (classof (new_set.pop()) == Integer) options:#(#listener, #dialog) showstack:true
    assert (classof (new_set.pop()) == Integer) options:#(#listener, #dialog) showstack:true
    assert (classof (new_set.pop()) == Integer) options:#(#listener, #dialog) showstack:true
    assert (new_set.pop() == undefined) options:#(#listener, #dialog) showstack:true

    local elements = new_set.elements()
    assert (elements.count == 0) options:#(#listener, #dialog) showstack:true
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

fn test_different_objecttypes = (

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
test_different_objecttypes()


print "test_mxs_set finished."