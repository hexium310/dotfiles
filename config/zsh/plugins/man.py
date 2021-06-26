import os
import pynvim
import sys

address = os.environ.get('NVIM_LISTEN_ADDRESS')
if not address:
    sys.exit(0)

nvim = pynvim.attach("socket", path=address);
name = next(filter(lambda item: item != '\n', sys.stdin)).split(maxsplit = 1)[0].lower()
nvim.command(f'Man {name}')
