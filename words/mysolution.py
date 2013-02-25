from sys import stdin
from re import compile

def yieldwords():
    matcher = compile("[a-z]*")
    for line in stdin.readlines():
        for word in filter(lambda x: x != '', [m.group(0) for m in matcher.finditer(line.lower())]):
            yield word

def count(iterator):
    d = {}
    for word in iterator():
        d[word] = d.get(word, 0) + 1
    return d

def rank(d):
    return sorted([(x,d[x]) for x in d.keys()], key=lambda y: d[y[0]], reverse=True)

[print("%s: %i" % (tup[0],tup[1])) for tup in rank(count(yieldwords))[:10]]






