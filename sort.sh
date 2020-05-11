#!/usr/bin/python3

import os

os.chdir("po-export")

os.system("mkdir -p FOREIGN/cinnamon-translations")

# remove forbidden locales: pt_PT, fr_FR.
FORBIDDEN_LOCALES = ["fr_FR", "pt_PT", "de_DE"]
for locale in FORBIDDEN_LOCALES:
    for root, dirs, files in os.walk("."):
        for file in files:
            if file.endswith('%s.po' % locale):
                fullpath = os.path.join(root, file)
                print ("%s deleted! (forbidden locale)." % fullpath)
                os.unlink(fullpath)

# special case, xedit -> xed
if os.path.exists("xedit") and os.path.exists("xed"):
    os.system("mv xedit/* xed/")
    os.system("rm -rf xedit")

# cinnamon-translations
for project in ["cinnamon", "cinnamon-control-center", "cinnamon-session", "cinnamon-settings-daemon", "cinnamon-screensaver", "nemo", "nemo-extensions"]:
    if os.path.exists(project):
        os.system("mv %s FOREIGN/cinnamon-translations/" % project)

# individual projects
for project in ["blueberry", "lightdm-settings", "live-installer", "nemo-emblems", "folder-color-switcher", "pix", "xed", "xplayer", "xreader", "xviewer", "xapp", "slick-greeter", "slideshow-mint", "slideshow-mint-kde", "mintupdate", "mintreport", "xfce4-xapp-status-plugin", "linuxmint-installation-guide", "warpinator", "mintubiquity", "nvidia-prime-applet"]:
    if os.path.exists(project):
        os.system("mv %s FOREIGN/" % project)

# projects which require locale.po, as opposed to project-locale.po filenames
for project in ["folder-color-switcher", "pix", "xed", "xplayer", "xreader", "xviewer", "xapp", "slick-greeter", "slideshow-mint", "slideshow-mint-kde", "xfce4-xapp-status-plugin", "mintubiquity", "nvidia-prime-applet"]:
    if os.path.exists("FOREIGN/%s" % project):
        os.system("rename 's/%s-//' FOREIGN/%s/*.po" % (project, project))

