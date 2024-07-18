# TermSplit Plugin For Micro

This plugin adds a keybinding `Alt-p` to open a smaller hsplit terminal pane.
This reflects how vscode has a terminal shortcut like `Ctrl+Shift+,`.

Install by cloning this into your plug directory:

```shell
git clone https://github.com/AspieSoft/micro-editor-plugin-termsplit ~/.config/micro/plug/termsplit
```

Use `Alt-i` to initialize an IDE like structure.
This will open a [filetree](https://github.com/NicolaiSoeborg/filemanager-plugin) and a terminal.
You can aslo edit `~/.config/micro/settings.json` and set `{"ide": true}` to auto open in IDE mode.
