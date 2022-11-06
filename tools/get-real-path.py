#!/usr/bin/python

# Get the cononical path of the specified filename by eliminating
# any symbolic links encountered in the path.
# Example: python get-real-path.py <file>

import os,sys
print(os.path.realpath(sys.argv[1]))
