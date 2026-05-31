# Minute Quote KDE Widget

A transparent KDE Plasma widget that displays one quote at a configurable
interval. The widget shows only the quote text.

Use **Configure Minute Quote** from the widget context menu to choose the font,
text color, quote-change interval, and quote list. Add one quote per line. Empty
lines and lines starting with `#` are ignored.

The initial quote list is loaded from `contents/data/quotes.txt`. Once edited in
the configuration dialog, the quote list is stored in this widget instance's
Plasma settings.

## Requirements

- KDE Plasma 5 or 6
- `kpackagetool5` (Plasma 5) or `kpackagetool6` (Plasma 6)

## Install

Run the installer script:

```bash
./installer.sh
```

## Manual install

Plasma 5:

```bash
kpackagetool5 --type Plasma/Applet --install .
```

Plasma 6:

```bash
kpackagetool6 --type Plasma/Applet --install .
```

To upgrade after changing the widget:

```bash
kpackagetool5 --type Plasma/Applet --upgrade .
```

```bash
kpackagetool6 --type Plasma/Applet --upgrade .
```

## Uninstall

Plasma 5:

```bash
kpackagetool5 --type Plasma/Applet --remove com.hari.minutequote
```

Plasma 6:

```bash
kpackagetool6 --type Plasma/Applet --remove com.hari.minutequote
```

## License

MIT. See [LICENSE](LICENSE).
