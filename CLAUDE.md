# Dotfiles Repository

Personal dotfiles for shell configuration, git settings, and development tools.

## Setup

Clone to any machine and run:
```bash
git clone https://github.com/arthurnn/dotfiles.git && cd dotfiles && script/setup
```

The setup script symlinks all dotfiles to `$HOME` (e.g., `bashrc` -> `~/.bashrc`).

## Structure

- **Shell configs**: `bashrc`, `bash_profile.sh`, `zshrc.sh`, `zprofile.sh`, `shrc.sh` (shared)
- **Git**: `gitconfig`, `gitignore`, `gitattributes`, `git-completion.bash`
- **Ruby**: `gemrc`, `irbrc`, `ruby-version`, `rdebugrc`
- **Other**: `tmux.conf`, `bin/` (custom scripts)

## Platform Support

The setup script detects macOS, Linux, and Windows and adjusts paths accordingly (e.g., VSCode settings location).
