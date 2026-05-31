#!/usr/bin/env bash
set -euo pipefail

widget_id="com.hari.minutequote"

if command -v kpackagetool6 >/dev/null 2>&1; then
    kpackagetool6 --type Plasma/Applet --install . || \
        kpackagetool6 --type Plasma/Applet --upgrade .
    echo "Installed ${widget_id} with kpackagetool6."
    exit 0
fi

if command -v kpackagetool5 >/dev/null 2>&1; then
    kpackagetool5 --type Plasma/Applet --install . || \
        kpackagetool5 --type Plasma/Applet --upgrade .
    echo "Installed ${widget_id} with kpackagetool5."
    exit 0
fi

echo "Error: kpackagetool5 or kpackagetool6 not found."
echo "Install Plasma package tools and try again."
exit 1
