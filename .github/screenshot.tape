# Renders .github/screenshot.png for the README with vhs.
# Run from the repository root: vhs .github/screenshot.tape
# Neovim starts with --clean and only this plugin on the runtimepath. It uses
# the bundled retrobox colorscheme, since the default one leaves Type and Number
# uncolored. The terminal theme matches retrobox so the padding blends in.

Set FontSize 15
Set Width 1100
Set Height 940
Set Padding 16
Set Theme { "name": "retrobox", "background": "#1c1c1c", "foreground": "#ebdbb2", "cursor": "#ebdbb2", "selection": "#504945", "black": "#1c1c1c", "red": "#fb4934", "green": "#b8bb26", "yellow": "#fabd2f", "blue": "#83a598", "magenta": "#d3869b", "cyan": "#8ec07c", "white": "#ebdbb2", "brightBlack": "#928374", "brightRed": "#fb4934", "brightGreen": "#b8bb26", "brightYellow": "#fabd2f", "brightBlue": "#83a598", "brightMagenta": "#d3869b", "brightCyan": "#8ec07c", "brightWhite": "#fbf1c7" }

Hide
Type `nvim --clean --cmd "set rtp^=$PWD" --cmd "set termguicolors background=dark number foldlevel=99 completeopt=menuone,noinsert" -c "colorscheme retrobox" .github/screenshot.ios`
Enter
Sleep 1.5s

# Open a new line in the LAN interface and show the completion menu.
Type ":20"
Enter
Type "o"
Type "switchport m"
Ctrl+X
Ctrl+O
Sleep 1s
Show

Screenshot .github/screenshot.png
Sleep 200ms

Hide
Escape
Type ":qa!"
Enter
