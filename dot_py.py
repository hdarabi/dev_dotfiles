# This script will be loaded into python before coding.

from importlib import reload, import_module, __import__


def my_reload(module, functions=None):
    new_module = import_module(module)
    reload(new_module)
    if functions:
        __import__(module, fromlist=functions)
