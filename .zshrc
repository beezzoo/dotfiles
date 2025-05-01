# Suppress Powerlevel10k instant prompt warnings
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Ensure Oh My Zsh is installed
export ZSH="$HOME/.oh-my-zsh"
if [ ! -d "$ZSH" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Enable Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Plugins to load (these are for Oh My Zsh itself, not zinit)
plugins=(git pacman colorize command-not-found compleat ufw history-substring-search mosh docker docker-compose eza)

# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Load additional zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load Oh My Zsh plugin snippets (optional, since OMZ is loaded above)
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Enable completions
autoload -Uz compinit && compinit

# Replay any deferred zinit loading
zinit cdreplay -q

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zoxide for smarter `cd`
eval "$(zoxide init zsh)"

# Aliases
alias ls='eza'
alias cat='bat'
alias df='duf'
alias cd='z'
