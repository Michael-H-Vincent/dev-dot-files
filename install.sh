#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$REPO_ROOT/config"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
INSTALL_PACKAGES=0

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--install-packages]

Creates symlinks for dev dotfiles. Existing targets are backed up first.

Options:
  --install-packages  Best-effort install of common dependencies using the
                      system package manager.
USAGE
}

log() { printf '[+] %s\n' "$*"; }
warn() { printf '[!] %s\n' "$*" >&2; }
die() { printf '[x] %s\n' "$*" >&2; exit 1; }
have() { command -v "$1" >/dev/null 2>&1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-packages) INSTALL_PACKAGES=1 ;;
    -h|--help) usage; exit 0 ;;
    *) die "Unknown option: $1" ;;
  esac
  shift
done

backup_target() {
  local target="$1"
  [[ -e "$target" || -L "$target" ]] || return 0

  local rel="${target#"$HOME"/}"
  mkdir -p "$BACKUP_DIR/$(dirname -- "$rel")"
  cp -a "$target" "$BACKUP_DIR/$rel"
  log "Backed up $target -> $BACKUP_DIR/$rel"
}

link_path() {
  local src="$1"
  local dst="$2"

  [[ -e "$src" || -L "$src" ]] || die "Missing source: $src"
  mkdir -p "$(dirname -- "$dst")"

  if [[ -L "$dst" && "$(readlink -- "$dst")" == "$src" ]]; then
    log "Already linked: $dst"
    return 0
  fi

  backup_target "$dst"
  rm -rf -- "$dst"
  ln -s -- "$src" "$dst"
  log "Linked $dst -> $src"
}

install_packages() {
  local packages=(git curl ripgrep fd fzf neovim tmux starship)

  if have pacman; then
    sudo pacman -S --needed "${packages[@]}"
  elif have apt-get; then
    sudo apt-get update
    sudo apt-get install -y git curl ripgrep fd-find fzf neovim tmux starship
  elif have dnf; then
    sudo dnf install -y "${packages[@]}"
  elif have zypper; then
    sudo zypper install -y "${packages[@]}"
  elif have apk; then
    sudo apk add git curl ripgrep fd fzf neovim tmux starship
  else
    warn "No supported package manager found; skipping package install."
  fi
}

install_tpm() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"

  if [[ -d "$tpm_dir/.git" ]]; then
    log "TPM already installed: $tpm_dir"
    return 0
  fi

  if ! have git; then
    warn "git not found; skipping TPM install."
    return 0
  fi

  mkdir -p "$(dirname -- "$tpm_dir")"
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

[[ -d "$CONFIG_SRC" ]] || die "Missing config directory: $CONFIG_SRC"

if [[ "$INSTALL_PACKAGES" -eq 1 ]]; then
  install_packages
fi

mkdir -p "$HOME/.config"
link_path "$CONFIG_SRC/.bash_profile" "$HOME/.bash_profile"
link_path "$CONFIG_SRC/.bashrc" "$HOME/.bashrc"
link_path "$CONFIG_SRC/.tmux.conf" "$HOME/.tmux.conf"
link_path "$CONFIG_SRC/nvim" "$HOME/.config/nvim"
link_path "$CONFIG_SRC/starship" "$HOME/.config/starship"

install_tpm

log "Done."
