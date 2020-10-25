#! /usr/bin/python

# Author: Steve Zesch

# This script assumes that the repos are locally organized
# as some_parent_folder/cafe_repo. For instance, my cloned repos
# are stored as cafe-desktop/cafe-common, cafe-desktop/cafe-doc-utils, etc.

# Obviously, you want the cwd when the script runs to be the folder that
# contains all the cafe repos. You can achieve this by copying this 
# script from cafe-dev-scripts/update-repos to the parent directory,
# running the script via it's path (cafe-dev-scripts/update-repos/update.py),
# or by creating a symbolic link. I prefer the symbolic link method.
# It doesn't matter, so long as the cwd for this script is the parent
# directory of all the cafe repos.

import os

# update all the directories
for d in os.listdir('.'):
    if os.path.isdir(d):
        os.chdir(d)
        if '.git' in os.listdir('.'):
            os.system('git pull')
        os.chdir('..')
