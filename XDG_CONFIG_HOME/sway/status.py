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

print('{"version": 1}')
print('[')


def charblock(chr, **kargs):
    return {"full_text": chr, "separator": False, "separator_block_width": 0, **kargs}


def numblock(num, rjust=0, **kargs):
    return {"full_text": num.rjust(rjust), "align": "right", **kargs}


def brightness():
    process = subprocess.Popen(["brightnessctl", "-m"], stdout=subprocess.PIPE)
    _, _, current_brightness, current_percentage, max_brightness = str(
        process.communicate()[0])[0:-3].split(',')
    return [charblock("明"), numblock(f"{current_percentage}", rjust=4)]


def cpu():
    cpu_percent = psutil.cpu_percent()
    return [charblock("核"), numblock(f"{cpu_percent}%", rjust=6)]


def mem():
    vmem = psutil.virtual_memory()
    mem_percent = vmem.available / vmem.total
    return [charblock("記"), numblock(f"{mem_percent:.1%}", rjust=6)]


def today():
    w = "月火水木金土日"[time.localtime().tm_wday]
    return [charblock(w), numblock(time.strftime(f"%m.%d"), rjust=6)]


def now():
    return [charblock("時"), numblock(time.strftime("%H%M"), rjust=5)]


def battery():
    battery_percent = int(psutil.sensors_battery().percent)
    return [charblock('電'), numblock(f"{battery_percent}%", rjust=5)]


def net():

    def check_interface(interface):
        interface_addrs = psutil.net_if_addrs().get(interface) or []
        return socket.AF_INET in [snicaddr.family for snicaddr in interface_addrs]

    def human_readable_size(size, decimal_places=0):
        for unit in ['B', 'K', 'M', 'G', 'T']:
            if size < 1024.0:
                break
            size /= 1024.0
        return f"{size:.{decimal_places}f}{unit}".rjust(5)

    def working(io):
        up = charblock(
            f"上{human_readable_size(io[0])}", color="#ffffff55" if io[0] == 0 else None)
        down = numblock(
            f"下{human_readable_size(io[1])}", color="#ffffff55" if io[1] == 0 else None)
        return [up, down]

    def acc_sub(old, new):
        return ((new.bytes_sent-old[0], new.bytes_recv - old[1]), (new.bytes_sent, new.bytes_recv))

    wired = "enp0s31f6"
    wireless = "wlp2s0"
    not_working = numblock("不通", rjust=3, color="#ffffff55")
    wired_acc = (0, 0)
    wireless_acc = (0, 0)
    while True:
        wired_bytes, wired_acc = acc_sub(
            wired_acc, psutil.net_io_counters(pernic=True)[wired])
        wireless_bytes, wireless_acc = acc_sub(
            wireless_acc, psutil.net_io_counters(pernic=True)[wireless])
        wired_status = working(wired_bytes) if check_interface(
            wired) else [not_working]
        wireless_status = working(wireless_bytes) if check_interface(
            wireless) else [not_working]
        yield [charblock("波 "), *wireless_status, charblock("線 "), *wired_status]


net_gen = net()


def sys_info():
    return json.dumps([*brightness(), *next(net_gen), *cpu(), *mem(), *battery(), *today(), *now()])


starttime = time.time()
while True:
    print(sys_info(), end=",", flush=True)
    time.sleep(1. - ((time.time() - starttime) % 1.))
