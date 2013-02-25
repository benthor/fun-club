#!/bin/sh

# 1. reads something from stdin, converts to lower case
# 2. returns as many consecutive lowercase alphabetic characters at a time as possible ("greedy")
# 3. sorts the resulting strings alphabetically
# 4. displays only one instance of each redundant line, prefixed by the amount of lines originally seen
# 5. sorts again, this time numerically (i.e., according to prefixed count) and reversed
# 6. head gives only the first 10 resulting lines
# 7. (optional) awk de-pretty-fies the output in favour of emulating the example solution output

sed -e 's/.*/\L\0/g' | grep -oE "[a-z]*" | sort | uniq -c | sort -rn | head | awk '{ print $2 ": " $1 }'
