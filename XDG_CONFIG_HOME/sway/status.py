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


class Interval():
    """
    This decorator class enables renewal interval configurable per block.
    The class memoizes one latest value of function until time-to-live runs out.
    """

    def __init__(self, ttl=1):
        self.ttl = ttl
        self.value = None
        self.key = None
        self.expires = 0

    def __call__(self, fn, *args, **kwargs):
        def wrapped_func(*args, **kwargs):
            key = tuple(args) + tuple(sorted(kwargs.items()))
            if key != self.key or time.time() > self.expires:
                self.key = key
                self.value = fn(*args, **kwargs)
                self.expires = time.time() + self.ttl
            return self.value
        return wrapped_func


class Block():
    """
    This class represents one body block element of swaybar-protocol.
    see: `man swaybar-protocol`
    or https://github.com/swaywm/sway/blob/master/swaybar/swaybar-protocol.7.scd
    """

    def __init__(self, txt, **props):
        self.full_text = txt
        self.border = "#FFFFFF"
        self.separator = False
        self.separator_block_width = 0
        for k in props:
            setattr(self, k, props[k])

    @staticmethod
    def head_block(name, **props):
        props = {"color": "000000", "background": "FFFFFF", **props}
        return Block(name, **props)

    @staticmethod
    def body_block(num, **props):
        props = {"border_left": 0, "border_right": 0, **props}
        return Block(num, **props)

    @staticmethod
    def blocks(name, *bodies, **props):
        head = Block.head_block(name, **props)
        body_blocks = [body if isinstance(body, Block) else
                       Block.body_block(body, **props) for body in bodies]
        body_blocks[-1].border_right = 1
        body_blocks[-1].separator_block_width = 4
        return [head, *body_blocks]


def brightness():
    process = subprocess.Popen(["brightnessctl", "-m"], stdout=subprocess.PIPE)
    _, _, current_brightness, current_percentage, max_brightness = str(
        process.communicate()[0])[0:-3].split(',')
    return Block.blocks("明", f"{current_percentage:>4}")


@Interval(4)
def cpu():
    cpu_percent = psutil.cpu_percent(interval=1)
    return Block.blocks("核", f"{cpu_percent:5}%")


@Interval(4)
def mem():
    vmem = psutil.virtual_memory()
    mem_percent = vmem.percent
    return Block.blocks("記", f"{mem_percent:5}%")


@Interval(60)
def today():
    w = "月火水木金土日"[time.localtime().tm_wday]
    return Block.blocks(w, time.strftime("%m.%d").rjust(5))


@Interval(4)
def now():
    return Block.blocks("時", time.strftime("%H:%M").rjust(5))


@Interval(4)
def battery():
    battery_stats = psutil.sensors_battery()
    percentage = battery_stats.percent
    power_plugged = battery_stats.power_plugged
    props = {}
    if power_plugged:
        props['background'] = "BE132D"
        props["color"] = "FFFFFF"
    return Block.blocks('電', f"{percentage:3.0f}%", **props)


def net_block(name, intfc):
    def human_readable_size(size):
        for unit in ['B', 'K', 'M', 'G', 'T']:
            if size < 1024.0:
                break
            size /= 1024.0
        decimal_places = 1 if size < 100 else 0
        return f"{size:4.{decimal_places}f}{unit}"

    def color(x): return "ffffff55" if x == 0 else None

    acc = (0, 0)
    while True:
        interface_addrs = psutil.net_if_addrs().get(intfc) or []
        is_working = socket.AF_INET in [
            snicaddr.family for snicaddr in interface_addrs]
        not_working = Block.body_block("不通", color="#ffffff55")

        if not is_working:
            yield Block.blocks(name, not_working)
            continue
        new = psutil.net_io_counters(pernic=True).get(intfc)
        up = new.bytes_sent - acc[0]
        down = new.bytes_recv - acc[1]

        up = Block.body_block(
            f"上{human_readable_size(up)}", color=color(up))
        down = Block.body_block(
            f"下{human_readable_size(down)}", color=color(down))
        acc = (new.bytes_sent, new.bytes_recv)
        yield Block.blocks(name, up, down)


def main():
    net_wired = net_block("線", "enp12s0u1")
    net_wireless = net_block("波", "wlp2s0")

    def sys_info():
        blocks = [*brightness(), *next(net_wired), *next(net_wireless),
                  *cpu(), *mem(), *battery(), *today(), *now()]
        return [block.__dict__ for block in blocks]
    print('{"version": 1}')
    print('[')

    starttime = time.time()
    while True:
        print(json.dumps(sys_info()), end=",", flush=True)
        time.sleep(1. - ((time.time() - starttime) % 1.))


if __name__ == "__main__":
    main()
