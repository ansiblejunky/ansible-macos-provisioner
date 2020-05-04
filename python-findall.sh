#!/bin/bash

echo ""
echo Find all python instances installed on Mac OSX
echo ---------------------------------------------------------------
echo ""
echo "NOTE: Apple's python located at: /System/Library/Frameworks/Python.framework/Versions/"
echo ""
echo Existing binaries:
echo ""

find -E /System/Volumes/Data -regex '.*python(@?)(([0-9]+)(\.?)([0-9]?)?)' -perm +111 -type f -print 2>/dev/null

echo ""
echo Existing symbolic links:
echo ""

find -E /System/Volumes/Data -regex '.*python(@?)(([0-9]+)(\.?)([0-9]?)?)' -perm +111 -type l -print 2>/dev/null

echo ""

