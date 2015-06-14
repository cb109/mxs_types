ALPHABET = "abcdefghijklmnopqrstuvwxyz"


fn get_random_string length:20 = (
    local random_str = StringStream ""
    for i = 1 to length do
        format "%" (ALPHABET[random 1 length]) to:random_str
    random_str as String
)


fn get_random_strings amount = (
    for i = 1 to amount collect get_random_string()
)


fn benchmark_dict d_class d_name n = (
    local keys = get_random_strings n
    local values = for i = 1 to n collect random 1 n
    local d = d_class()

    local tstart = timestamp()
    for i = 1 to n do
        d.add keys[i] values[i]
    local tend = timestamp()
    format "%: added % in: %\n" d_name (n as String) ((tend - tstart) / 1000.0)

    local tstart = timestamp()
    for i = 1 to n do
        local val = d.get keys[i]
    local tend = timestamp()
    format "%: gotten % in: %\n" d_name (n as String) ((tend - tstart) / 1000.0)

    format "\n"
)


fn avg_time_to_add d_class d_name d_size repitions = (
    local d = d_class.fromkeys (get_random_strings d_size)

    local random_keys = get_random_strings repitions
    local times = #()

    for i = 1 to repitions do (
        local copied_d = d.copy()

        local tstart = timestamp()
        copied_d.add random_keys[i] undefined
        -- copied_d.get random_keys[i]
        local tend = timestamp()

        local t = (tend - tstart) / 1000.0
        append times t
    )

    local avg = 0
    for t in times do
        avg += t

    avg = avg / times.count as float
    avgstr = formattedPrint avg format:".6f"

    format "Average of % add() for % with % items: % seconds\n\n" repitions d_name d_size avgstr
)


-- Execute benchmark.
clearListener()
format "\n"

avg_time_to_add mxs_dict "mxs_dict" 10 1000
avg_time_to_add mxs_dict "mxs_dict" 100 1000
avg_time_to_add mxs_dict "mxs_dict" 1000 1000
avg_time_to_add mxs_dict "mxs_dict" 10000 1000
avg_time_to_add mxs_dict "mxs_dict" 100000 1000

avg_time_to_add mxs_hashdict "mxs_hashdict" 10 1000
avg_time_to_add mxs_hashdict "mxs_hashdict" 100 1000
avg_time_to_add mxs_hashdict "mxs_hashdict" 1000 1000
avg_time_to_add mxs_hashdict "mxs_hashdict" 10000 1000
avg_time_to_add mxs_hashdict "mxs_hashdict" 100000 1000

OK