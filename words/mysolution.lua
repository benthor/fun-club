-- io module required for reading from stdin
require 'io'


function get_frequencies(iterator) 
    -- hashtable where we keep the frequencies in
    local freqs = {}

    -- define metatable that returns 0 instead of nil when its associated table
    -- is accessed with a non-existing key
    mt = { __index = function(t,word) return 0 end }

    -- assign the metatable to our frequency table, the freqs table will now
    -- return 0 instead of nil if a non-existing element is accessed
    setmetatable(freqs, mt)

    -- get the freqencies
    for line in iterator() do
        -- lowercase the line, then return match iterator for only "lower case word
        -- characters" and iterate
        for word in string.gmatch(string.lower(line), "%l+") do
            -- thanks to our metatable, an access to non-existing freqs[word] entry
            -- just returns 0, so the following just works(TM)
            freqs[word] = freqs[word] + 1
        end
    end
    return freqs
end


function mk_tuple_sequence(frequencies)
    -- get a table to become a sequence of tuples
    -- table layout: integers as indicies/keys, {word,frequency}-tuples as values
    local result = {}

    -- iterate over key/value pairs in the freqs table
    for word,freq in pairs(frequencies) do
        -- will insert {word,frequency} as value for next available integer index/key
        -- i.e., inserting {"spam",5} into table {1={"foo",6}, 2={"bar",2}} will result in
        -- {1={"foo",6}, 2={"bar",2}, 3={"spam",5}}
        table.insert(result, {word,freq})
    end
    return result
end

-- is within the scope of an easy anonymous function but making this explicit anyway
function tuple_comparator(tuple_a, tuple_b)
    return tuple_a[2] > tuple_b[2]
end


function order_tuple_sequence(sequence, comparator)
    -- unfortunately table.sort sorts in-place
    table.sort(sequence, comparator)
    return sequence
end


function print_first_n(sequence, n)
    if n ~= 0 then
        -- doing head recursion here, works as expected
        print_first_n(sequence, n-1)
        print(string.format("%s: %i", sequence[n][1], sequence[n][2]))
    end
end

-- io.lines() without argument just reads from stdin, although we pass this as a function here
print_first_n(order_tuple_sequence(mk_tuple_sequence(get_frequencies(io.lines)), tuple_comparator), 10)
                

