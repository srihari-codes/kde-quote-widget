# Minute Quote KDE Widget

A transparent KDE Plasma 5 widget that displays one quote every minute by
default. The widget displays only the quote text.

Use **Configure Minute Quote** from the widget context menu to choose the font,
text color, quote-change interval, and quote list. Add one quote per line. Empty
lines and lines starting with `#` are ignored.

The initial quote list is loaded from `contents/data/quotes.txt`. Once edited in
the configuration dialog, the quote list is stored in this widget instance's
Plasma settings.

## Install

```bash
kpackagetool5 --type Plasma/Applet --install .
```

To reinstall after changing the widget:

```bash
kpackagetool5 --type Plasma/Applet --upgrade .
```
