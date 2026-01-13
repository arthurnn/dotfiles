# arthurnn’s dotfiles

## Installation

### Using Git and the setup script

You can clone the repository wherever you want. (I like to keep it in `~/src/dotfiles`) The bootstrapper script will pull in the latest version and link the files to your home folder.

```bash
git clone https://github.com/arthurnn/dotfiles.git && cd dotfiles && script/setup
```

## Troubleshooting

### Clipboard over mosh + tmux

OSC52 clipboard (`set-clipboard on` in tmux) works over SSH but **not through mosh** due to [known issues](https://github.com/tmux/tmux/issues/3423) with how mosh handles escape sequences.

**Workaround** - create a script that writes OSC52 directly to the tmux client tty:

```bash
cat > /tmp/osc52-copy << 'EOF'
#!/bin/bash
TTY=$(tmux display -p "#{client_tty}")
printf '\e]52;c;%s\a' "$(base64 | tr -d '\n')" > "$TTY"
EOF
chmod +x /tmp/osc52-copy
```

Then add tmux bindings (session-only, or add to `tmux.conf`):

```bash
tmux bind -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel '/tmp/osc52-copy'
tmux bind -T copy-mode M-w send-keys -X copy-pipe-and-cancel '/tmp/osc52-copy'
```

Usage: mouse-select text or use `M-w` in copy-mode to copy to local clipboard.
