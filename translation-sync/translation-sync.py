#!/usr/bin/python

# Should be run as translation-sync path/to/package
# Example: translation-sync cafe-terminal/

# This utility assumes that the user has already run "tx init",
# "tx set", and the .tx directory exists in the path specified

# TODO: Add the ability to run it from the cafe/ so that all
#       all the repos can be synced at once.

import os
import sys
import subprocess
import optparse

PO = "po/"

parser = optparse.OptionParser()
parser.add_option("-c", "--commit", dest="commit", help="commit changes to git")
(options, args) = parser.parse_args()

# Some package names in the cafe git repo don't match
# the names on transifex. Example: cafe-file-manager (git) 
# and caja (transifex). This dictionary allows us to
# seamlessly use the git package name.
mismatching_pkgs = {"cafe-file-manager" : "caja",
                    "cafe-document-viewer" : "atril",
                    "cafe-file-manager-gksu" : "caja-gksu",
                    "cafe-file-manager-image-converter" : "caja-image-converter",
                    "cafe-file-manager-open-terminal" : "caja-open-terminal",
                    "cafe-file-manager-sendto" : "caja-sendto",
                    "cafe-file-archiver" : "engrampa",
                    "cafe-image-viewer" : "eom",
                    "cafe-window-manager" : "marco",
                    "cafe-menu-editor" : "mozo",
                    "cafe-text-editor" : "pluma"}

# Check to make sure the path to the package was provided.
if len(sys.argv) < 2:
    print "ERROR: Please enter the path of the package."
    sys.exit(1)

# Get package from some/path/package/
pkg = sys.argv[1].rstrip("/")
pkg = pkg.split("/")[-1]

os.chdir(pkg)

# Switch to the transifex naming for this package if applicable.
if pkg in mismatching_pkgs:
    pkg = mismatching_pkgs[pkg]

TRANSLATIONS = "translations/CAFE." + pkg + "/"

# Check to make sure that .tx is in the package.
if not ".tx" in os.listdir(os.curdir):
    print "ERROR: No .tx directory found. Please run 'tx init'"
    sys.exit(1)

try:    
    print "Beginning to sync translations."

    output = subprocess.check_output(["tx", "pull", "-a", "-r", "CAFE." + pkg])
    
    # There's nothing to sync, so exit.
    if output == "Done.":
        print "All translations up-to-date. Nothing to sync."
        sys.exit(1)
    else:
        print "Translations synced."
        
except subprocess.CalledProcessError:
    print "ERROR: Unable to pull translations."
    sys.exit(1)

if not "translations" in os.listdir(os.curdir):
    print "ERROR: No translations directory found. Could not patch files."
    sys.exit(1)
 
trans_files = [f for f in os.listdir(TRANSLATIONS) if f[-4:] == "..po"]

print "Moving new translations to po/."

# Move the new translations to the po folder.
for trans in trans_files:
    subprocess.call(["mv", TRANSLATIONS + trans, PO + trans[:-4] + trans[-3:]])

if options.commit is not None:    
    # Commit and push the sync to git.
    subprocess.call(["git", "add", PO])
    subprocess.call(["git", "commit", "-m", "Synced translations for " + sys.argv[1].rstrip("/")])
    subprocess.call(["git", "push"])

# Cleanup.
if len(os.listdir(TRANSLATIONS)) != 0:
    subprocess.call(["rm", TRANSLATIONS + "*"])

os.rmdir(TRANSLATIONS)
os.rmdir("translations/")
