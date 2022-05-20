#!/home/islamahmed1092/anaconda3/bin/python

import sys


prev_key = '0'
summation = 0
length = 0

for line in sys.stdin:
    key, val = line.strip().split('\t', 1)
    if key != prev_key:
        print(f'{prev_key},{summation/length}')
        summation = 0
        length = 0

    summation += float(val)
    length += 1   
    prev_key = key

print(f'{prev_key},{summation/length}')
