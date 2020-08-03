#!/bin/bash


##############################################################
# System Verification
#
# Keep it clean! That is the best approach when using Python and
# any tools that might use Python. There can easily be many installations
# of Python on your system already and you don't even know it. 
##############################################################

# python - find alternate installations
# echo "TASK: [Searching for alternate Python installations...] ******************"
# if [ -d /Library/Frameworks/Python.framework ]
# then
#     echo -e "WARNING: Python installations exist within /Library/Frameworks/Python.framework/"
#     echo -e "         It is recommended to remove this folder entirely.\n"
#     exit 1
# else
#     echo "OK"
# fi
# echo -e "\n"
#find /Applications/Python* -name "python"
#find /Users/`whoami`/Applications/Python* -name "python"

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

