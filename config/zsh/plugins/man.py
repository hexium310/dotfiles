import os
import pynvim
import sys

address = os.environ.get('NVIM_LISTEN_ADDRESS')
if not address:
    sys.exit(0)

nvim = pynvim.attach("socket", path=address);
name = list(filter(lambda item: item != '\n', sys.stdin))[0].split()[0].lower()
nvim.command(f'Man {name}')
