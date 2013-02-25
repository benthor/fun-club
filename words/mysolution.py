from sys import stdin
from re import compile

def yieldwords():
    matcher = compile("[a-z]*")
    for line in stdin.readlines():
        for word in filter(lambda x: x != '', [m.group(0) for m in matcher.finditer(line.lower())]):
            # yield is completely sufficient, we don't need to create something like an explicit result list
            yield word

def count(iterator):
    d = {}
    for word in iterator():
        d[word] = d.get(word, 0) + 1
    return d

def rank(d):
    # get tuples from dictionary and sort by second element in each tuple
    return sorted(d.items(), key=lambda y: y[1], reverse=True)

[print("%s: %i" % (tup[0],tup[1])) for tup in rank(count(yieldwords))[:10]]






