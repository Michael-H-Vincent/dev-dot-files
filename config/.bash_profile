# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]] && [[ "$(tty)" == /dev/tty1 ]] && command -v start-hyprland >/dev/null 2>&1; then
  exec start-hyprland
fi
