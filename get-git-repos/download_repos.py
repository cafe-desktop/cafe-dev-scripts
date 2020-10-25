#!/usr/bin/env python3

import os

# from manual: https://docs.python.org/3.6/howto/argparse.html#introducing-optional-arguments
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--ssh", help="use ssh for the git clone commands", action="store_true")
args = parser.parse_args()

# CAFE repos
PKGS = ["atril",
        "caja",
        "caja-dropbox",
        "caja-extensions",
        "caja-xattrs",
        "debian-packages",
        "engrampa",
        "eom",
        "libcafekbd",
        "libcafemixer",
        "libcafeweather",
        "marco",
        "cafe-applets",
        "cafe-backgrounds",
        "cafe-calc",
        "cafe-common",
        "cafe-control-center",
        "cafe-desktop",
        "cafe-desktop.org",
        "cafe-dev-scripts",
        "cafe-icon-theme",
        "cafe-icon-theme-faenza",
        "cafe-indicator-applet",
        "cafe-media",
        "cafe-menus",
        "cafe-netbook",
        "cafe-notification-daemon",
        "cafe-panel",
        "cafe-polkit",
        "cafe-power-manager",
        "cafe-screensaver",
        "cafe-sensors-applet",
        "cafe-session-manager",
        "cafe-settings-daemon",
        "cafe-system-monitor",
        "cafe-terminal",
        "cafe-themes",
        "cafe-university",
        "cafe-user-guide",
        "cafe-user-share",
        "cafe-utils",
        "mozo",
        "pluma",
        "python-caja"]

# use ssh
if args.ssh:
    GIT_CLONE_CMD = "git clone git@github.com:cafe-desktop/"
# use https
else:
    GIT_CLONE_CMD = "git clone https://github.com/cafe-desktop/"

# clone all repositories one by one
for p in PKGS:
    os.system(GIT_CLONE_CMD + p + ".git")
