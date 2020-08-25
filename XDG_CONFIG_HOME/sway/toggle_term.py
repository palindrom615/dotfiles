#!/usr/bin/env python3

from i3ipc.aio import Connection
import asyncio
from time import sleep

def find(lst, lmd):
    return next(x for x in lst if lmd(x))

def find_workspace(window):
    ptr = window
    while ptr.type != 'workspace':
        ptr = ptr.parent
    return ptr

async def main():
    i3 = await Connection().connect()

    tree = await i3.get_tree()
    term_windows = tree.find_marked('quake-like')
    focused_window = tree.find_focused()
    current_workspace = find_workspace(focused_window)

    if len(term_windows) == 0:
        await i3.command('workspace tmp')
        await i3.command('exec $term -e byobu')
        sleep(0.2)  # sway exec command works async!

        tree = await i3.get_tree()
        tmp_workspace = find(tree.workspaces(), lambda x: x.name == 'tmp')
        term_window = tmp_workspace.nodes[0]

        await i3.command(f'mark --add "quake-like" {term_window.id}')
    elif term_windows[0].id == focused_window.id:
        await i3.command('move to scratchpad')
        return
    await i3.command(f'[con_mark="quake-like"] focus')
    await i3.command('floating enable')
    await i3.command(f'resize set width {current_workspace.rect.width} height {current_workspace.rect.height}')
    await i3.command(f'move window to workspace {current_workspace.name}')
    await i3.command(f'[con_mark="quake-like"] focus')

if __name__ == '__main__':
    asyncio.run(main())
