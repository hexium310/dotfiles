import os
import pynvim
import sys

address = os.environ.get('NVIM_LISTEN_ADDRESS')
if not address:
    sys.exit(0)

nvim = pynvim.attach("socket", path=address);
name = list(sys.stdin)[1].split()[0].lower()
nvim.command(f'Man {name}')
