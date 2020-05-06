#!/usr/bin/env python3

import sys
import json

workspaces = [ws['name'] for ws in json.load(sys.stdin)]

num = "壹貳參肆伍陸柒捌玖零"

for n in num:
	if n not in workspaces:
		print(n)
		break
