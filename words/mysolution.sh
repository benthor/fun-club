#!/bin/sh
sed -e 's/.*/\L\0/g' | grep -oE "[a-z]*" | sort | uniq -c | sort -rn | head
