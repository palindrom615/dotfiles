#!/usr/bin/env python3

import time
import sys
import json
import subprocess
import socket

try:
    import psutil
except ImportError as e:
    print("'psutil' package not installed: do `pip install psutil`")
    sys.exit(1)

"""
see: `man swaybar-protocol`
"""

print('{"version": 1}')
print('[')


class Block():
    def __init__(self, txt, **props):
        self.full_text = txt
        self.border = "#FFFFFF"
        self.separator = False
        self.separator_block_width = 0
        for k in props:
            setattr(self, k, props[k])

    @staticmethod
    def charblock(name, **kargs):
        return Block(name, separator=False, **kargs)

    @staticmethod
    def numblock(num, **kargs):
        return Block(num, border_left=0, border_right=0, **kargs)


def blocks(name, *contents, props={}):
    name = Block.charblock(name, **props)
    content_blocks = [content if isinstance(
        content, Block) else Block.numblock(content, **props) for content in contents]
    content_blocks[-1].border_right = 1
    content_blocks[-1].separator_block_width = 4
    return [name, *content_blocks]


def brightness():
    process = subprocess.Popen(["brightnessctl", "-m"], stdout=subprocess.PIPE)
    _, _, current_brightness, current_percentage, max_brightness = str(
        process.communicate()[0])[0:-3].split(',')
    return blocks("明", f"{current_percentage:>4}")


def cpu():
    cpu_percent = psutil.cpu_percent(interval=1)
    return blocks("核", f"{cpu_percent:5}%")


def mem():
    vmem = psutil.virtual_memory()
    mem_percent = vmem.available / vmem.total
    return blocks("記", f"{mem_percent:6.1%}")


def today():
    w = "月火水木金土日"[time.localtime().tm_wday]
    return blocks(w, time.strftime("%m.%d").rjust(6))


def now():
    return blocks("時", time.strftime("%H%M").rjust(5))


def battery():
    battery_stats = psutil.sensors_battery()
    percentage = battery_stats.percent
    power_plugged = battery_stats.power_plugged
    background = "#BE132D" if power_plugged else None
    return blocks('電', f"{percentage:3.0f}%", props={"background": background})


def net_block(name, intfc):
    interface_addrs = psutil.net_if_addrs().get(intfc) or []
    is_working = socket.AF_INET in [
        snicaddr.family for snicaddr in interface_addrs]
    not_working = Block.numblock("不通", color="#ffffff55")

    def human_readable_size(size, decimal_places=0):
        for unit in ['B', 'K', 'M', 'G', 'T']:
            if size < 1024.0:
                break
            size /= 1024.0
        return f"{size:4.{decimal_places}f}{unit}"

    def color(x): return "ffffff55" if x == 0 else None

    def acc_sub(old, new):
        return ((new.bytes_sent-old[0], new.bytes_recv - old[1]), (new.bytes_sent, new.bytes_recv))
    acc = (0, 0)
    while True:
        new = psutil.net_io_counters(pernic=True)[intfc]
        up = new.bytes_sent - acc[0]
        down = new.bytes_recv - acc[1]

        up = Block.numblock(
            f"上{human_readable_size(up)}", color=color(up))
        down = Block.numblock(
            f"下{human_readable_size(down)}", color=color(down))
        acc = (new.bytes_sent, new.bytes_recv)
        yield blocks(name, up, down if is_working else not_working)


net_wired_gen = net_block("線", "enp12s0u1")
net_wireless_gen = net_block("波", "wlp2s0")


def sys_info():
    blocks = [*brightness(), *next(net_wired_gen), *next(net_wireless_gen),
              *cpu(), *mem(), *battery(), *today(), *now()]
    return [block.__dict__ for block in blocks]


starttime = time.time()
while True:
    print(json.dumps(sys_info()), end=",", flush=True)
    time.sleep(1. - ((time.time() - starttime) % 1.))
