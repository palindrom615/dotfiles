#!/usr/bin/env python3 
import glob
from os import path
import random
import sys
args = sys.argv[1:]
if len(args) == 0:
    args = [""]
walls = list()
walls += glob.glob(path.realpath(path.dirname(__file__))+"/wallpapers/*.*")
print(random.choice(walls))

