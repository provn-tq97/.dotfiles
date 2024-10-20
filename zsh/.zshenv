. "$HOME/.cargo/env"
export PATH="$PATH:${$(find ~/.bin -maxdepth 1 -type d -printf %p:)%%:}"
