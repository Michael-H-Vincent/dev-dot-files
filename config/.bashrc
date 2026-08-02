
# Only run interactive stuff in interactive shells
[[ $- != *i* ]] && return

# ~/.bashrc

if command -v myfetch >/dev/null 2>&1; then
  clear && myfetch -c 8 -C " █"
fi

# --- Starship (full by default, toggle to simple) ---
export STARSHIP_FULL_CONFIG="$HOME/.config/starship/starship.toml"
export STARSHIP_SIMPLE_CONFIG="$HOME/.config/starship/starship-simple.toml"

# Default to full prompt unless STARSHIP_CONFIG is already set externally
: "${STARSHIP_CONFIG:=$STARSHIP_FULL_CONFIG}"
export STARSHIP_CONFIG

eval "$(starship init bash)"

# Toggle prompt between full and simple (bash version)
p() {
  if [[ "${STARSHIP_CONFIG:-}" == "$STARSHIP_SIMPLE_CONFIG" ]]; then
    export STARSHIP_CONFIG="$STARSHIP_FULL_CONFIG"
  else
    export STARSHIP_CONFIG="$STARSHIP_SIMPLE_CONFIG"
  fi
  echo
}

# --- Aliases ---
alias pacup='sudo pacman -Rns $(pacman -Qdtq)'
alias grep='grep --color=auto'
alias f='clear && myfetch -i e -f -c 16 -C "  "'
alias h='start-hyprland'
alias n='nvim'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa --icons'
fi

# --- NVM ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

