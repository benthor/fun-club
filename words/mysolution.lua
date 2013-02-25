-- io module required for reading from stdin
require 'io'

-- hashtable where we keep the frequencies in
freqs = {}

-- define metatable that returns 0 instead of nil when its associated table
-- is accessed with a non-existing key
mt = { __index = function(t,word) return 0 end }

-- assign the metatable to our frequency table, the freqs table will now
-- return 0 instead of nil if a non-existing element is accessed
setmetatable(freqs, mt)

-- get the freqencies
-- io.lines() without argument just reads from stdin
for line in io.lines() do
    -- lowercase the line, then return match iterator for only "lower case word
    -- characters" and iterate
    for word in string.gmatch(string.lower(line), "%l+") do
        -- thanks to our metatable, an access to non-existing freqs[word] entry
        -- just returns 0, so the following just works(TM)
        freqs[word] = freqs[word] + 1
    end
end

-- get a table to become a sorted list of frequent words
-- table layout: integers as indicies/keys, words as values
sorted = {}

-- iterate over key/value pairs in the freqs table, only the keys (words) are
-- of interest so we use "dummy" variable "_" for the values
for word,_ in pairs(freqs) do
    -- will insert word as value for next available integer index/key
    -- i.e., inserting "spam" into table {1="foo", 2="bar"} will result in
    -- {1="foo", 2="bar", 3="spam"}
    table.insert(sorted, word)
end

-- reorder the elements in the table using an anonymous compare function that
-- looks up the word frequencies in the freqs table. reorder from highest
-- associated freq to lowest associated freq. NOTE: this happens in-place
table.sort(sorted, (function(a,b) return freqs[a] > freqs[b] end))

-- finally print the top 10 words, look up their freqencies in the freqs table
for i=1,10 do
    word = sorted[i]
    print(string.format("%s: %i", word, freqs[word]))
end

