#!/usr/bin/python3 
from __future__ import absolute_import, division, print_function
__metaclass__ = type

import os
import platform

print(os.getlogin())
print(platform.machine())
print(platform.system())
print(platform.version())