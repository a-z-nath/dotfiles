# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load private secrets if the file exists
if [ -f "$HOME/.zsh_secrets" ]; then
    source "$HOME/.zsh_secrets"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

ZSH_HIGHLIGHT_STYLES[string]='fg=yellow'

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Modify prompt to show only the last directory name
PROMPT_DIRTRIM=1
PROMPT='%1d%# '

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '\t' autosuggest-accept

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias v='nvim'
alias clr='clear'
alias bat='batcat'
alias pfzf='fzf --preview="batcat --color=always {}"'
alias inv='nvim $(fzf -m --preview="batcat --color=always {}")'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias cd="z" 
alias python="python3"
alias ag="antigravity"
alias qt-designer="/usr/lib/qt6/bin/designer"
alias update-blogs="cd ~/stow-packages && stow -R -d ~/Desktop/daily-update/ -t ~/stow-packages/content/ content && cd"


export datagrip='/home/az/Downloads/application/DataGrip-2025.2.4/bin'
runcpp() {
    if [[ -z "$1" ]]; then
        echo "Error: No file provided."
        return 1
    elif [[ ! -f "$1" ]]; then
        echo "Error: File '$1' not found."
        return 1
    fi

    base_name=$(basename "$1")
    base_name="${base_name%.*}"

    g++ "$1" -o "$base_name" && ./"$base_name"
}

runiocpp() {
    if [[ -z "$1" ]]; then
        echo "Error: No file provided."
        return 1
    elif [[ ! -f "$1" ]]; then
        echo "Error: File '$1' not found."
        return 1
    fi

    # Extract the directory and base name of the file
    dir_name=$(dirname "$1")
    base_name=$(basename "$1")
    base_name="${base_name%.*}"

    # Check if inputf.in exists in the same directory as the program file
    if [[ ! -f "$dir_name/inputf.in" ]]; then
        echo "Error: Input file 'inputf.in' not found in the directory '$dir_name'."
        return 1
    fi

    # Compile the program
    g++ "$1" -o "$dir_name/$base_name"
    if [[ $? -ne 0 ]]; then
        echo "Compilation failed."
        return 1
    fi

    # Run the program with input redirection and output redirection
    "$dir_name/$base_name" < "$dir_name/inputf.in" > "$dir_name/outputf.out"

    # Check if the execution was successful
    if [[ $? -eq 0 ]]; then
        echo "Program executed successfully. Output written to '$dir_name/outputf.out'."
    else
        echo "Execution failed."
    fi
}


# alias runcpp='g++ "$1" -o "${1%.*}" && ./"${1%.*}"'
# Add Node.js binaries
export PATH=$PATH:$HOME/NodeJS/bin

# Java JDK configuration
export JAVA_HOME="/usr/lib/jvm/jdk-21.0.7-oracle-x64"
export PATH=$JAVA_HOME/bin:$PATH

# Android SDK configuration
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME

export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/platform:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH

# Flutter SDK path
export PATH=$HOME/AndroidDev/flutter/bin:$PATH

# Android Studio
export androidkoala=$HOME/AndroidDev/android-studio-koala/bin/studio.sh
export androidmeerkat=$HOME/AndroidDev/android-studio-meerkat/bin/studio.sh

# Neovim binary path
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# fzf (fuzzy finder)
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
export PATH="$HOME/.fzf/bin:$PATH"

# Enable fzf key bindings and completion
eval "$(fzf --zsh)"

# pnpm configuration
export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"


# [[ -f ~/.zshrc ]] && source ~/.zshrc
export PATH="$PATH:$HOME/.fzf/bin"
export DOCKER_CONTENT_TRUST=0
export PATH="$PATH:/usr/local/bin/abctl"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
export PATH=$PATH:$HOME/.local/opt/go/bin
export PATH=$PATH:$HOME/.local/opt/go/bin
export PATH=$PATH:$HOME/go/bin



# bun completions
[ -s "/home/az/.bun/_bun" ] && source "/home/az/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PROMPT='%1~%# '
