# -----------------------------------------------------------------------------
# Powerlevel10k instant prompt
# -----------------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
# Oh My Zsh (optional for OMZ plugins)
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
if [ ! -d "$ZSH" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# Zinit setup (Zinit → Zi)
# -----------------------------------------------------------------------------
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"

if [ ! -f "${ZINIT_HOME}/zinit.zsh" ]; then
  mkdir -p "$ZINIT_HOME"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
alias zinit=zi

# -----------------------------------------------------------------------------
# Screen artifacts fixing
# -----------------------------------------------------------------------------
export TERM=screen-256color


# -----------------------------------------------------------------------------
# Zinit plugins
# -----------------------------------------------------------------------------
#zinit self-update
#zinit compile

# Powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Plugins
zinit ice wait'1'
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait'1' atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait'1'
zinit light zsh-users/zsh-completions

zinit ice wait'1'
zinit light Aloxaf/fzf-tab

# Oh My Zsh snippets (optional)
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# -----------------------------------------------------------------------------
# Completions
# -----------------------------------------------------------------------------
autoload -Uz compinit
if [[ ! -f ~/.zcompdump.zwc || ~/.zcompdump -nt ~/.zcompdump.zwc ]]; then
  compinit -C
  zcompile ~/.zcompdump
else
  compinit -C
fi

# Apply delayed plugins
zinit cdreplay -q

# -----------------------------------------------------------------------------
# Powerlevel10k config
# -----------------------------------------------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -----------------------------------------------------------------------------
# Zoxide: smarter `cd`
# -----------------------------------------------------------------------------
eval "$(zoxide init zsh)"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias ls='eza'
alias cat='bat'
alias df='duf'
#alias cd='z'
#alias zinit='zi'
alias sudo='sudo-rs'

alias ida-dev='cd ~/projects/BILabs/IDA_DEV && source venv/bin/activate'

# -----------------------------------------------------------------------------
# Additional paths
# -----------------------------------------------------------------------------
export PATH="$HOME/.local/share/zigup/0.14.1/files:$PATH"

# -----------------------------------------------------------------------------
# Profile shell startup time
# -----------------------------------------------------------------------------
#zmodload zsh/zprof
#zprof

. "$HOME/.local/bin/env"
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
export TEXMFSYSVAR=/usr/local/texlive/2025/texmf-var
export PATH="$HOME/.local/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh

# -----------------------------------------------------------------------------
# Custom exports
# -----------------------------------------------------------------------------

export PATH="$PATH:$(npm config get prefix)/bin"

export EDITOR=vim
export VISUAL=vim

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# opencode
export PATH=/home/beezzoo/.opencode/bin:$PATH
export PATH="$HOME/.local/astracode/bin:$PATH"
[ -f ~/.config/openbao/env ] && source ~/.config/openbao/env
