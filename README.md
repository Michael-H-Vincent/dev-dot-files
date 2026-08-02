# Dev dotfiles

Config for shell/dev tools:

- bash
- tmux
- Neovim
- Starship

## Install

```bash
git clone <repo-url>
cd dev-dot-files
./install.sh
```

The installer symlinks files into `~/` and `~/.config/`. Existing targets are backed up to `~/.dotfiles_backup_<timestamp>/`.

To also install common packages with the detected Linux package manager:

```bash
./install.sh --install-packages
```

After install, open tmux and press prefix + `I` to install tmux plugins.
