#!/usr/bin/env python3

import argparse
import os
import pynvim
import sys

address = os.environ.get('NVIM')
if not address:
    sys.exit(0)

nvim = pynvim.attach("socket", path=address);

def init(args):
    buffers = nvim.eval("filter(getbufinfo(), { k, v -> has_key(v.variables, 'terminal_job_id') })")
    lastused_buffer = max(buffers, key=lambda value: value['lastused'])
    buffer_id = lastused_buffer['bufnr']
    print(buffer_id)

def cd(args):
    buffer_id = os.environ.get('_NVIM_TERMINAL_BUFFER_ID')
    if not buffer_id:
        sys.exit(1)

    nvim.buffers[int(buffer_id)].vars['terminal_current_directory'] = args.directory
    nvim.command('redrawstatus')

parser = argparse.ArgumentParser()
subparsers = parser.add_subparsers()

init_parser = subparsers.add_parser('init', help='Print current terminal buffer id')
init_parser.set_defaults(handler=init)

cd_parser = subparsers.add_parser('cd', help='Set current directory to b:terminal_current_directory in Neovim')
cd_parser.add_argument('directory', nargs='?', default=os.getcwd())
cd_parser.set_defaults(handler=cd)

args = parser.parse_args()

if hasattr(args, 'handler'):
    args.handler(args)
