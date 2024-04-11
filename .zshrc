
# Profiling Code
zmodload zsh/zprof
 
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin
 
# Path to your oh-my-zsh installation.
export ZSH="/home/joshua/.oh-my-zsh"

# Set terminal to xterm for VSCode Vim compatibility
export TERM=xterm
 
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"
#
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "spaceship" )
 
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
 
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
 
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
 
# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"
 
# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13
 
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true
 
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
 
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
 
# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"
 
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
 
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
 
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"
 
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
 
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting poetry)
 
source $ZSH/oh-my-zsh.sh
 
# User configuration
 
## Spaceship Prompt Settings
 
SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  dotnet        # .NET section
  # kubecontext   # Kubectl context section
  terraform     # Terraform workspace section
  line_sep      # Line break
  char          # Prompt character
)
 
SPACESHIP_RPROMPT_ORDER=(
  time
  exec_time
  exit_code
  jobs
)
 
SPACESHIP_CHAR_SYMBOL="➜ "
SPACESHIP_CHAR_COLOR_SUCCESS="#6272a4"
SPACESHIP_TIME_SHOW=true
SPACESHIP_DIR_TRUNC_PREFIX="../"
SPACESHIP_DIR_TRUNC_REPO=false
 
# load custom env vars
source ~/.zshenv
 
# export MANPATH="/usr/local/man:$MANPATH"
 
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
 
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
 
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
 
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
# 
 
 
# The following lines were added by compinstall
 
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/joshua/.zshrc'
 
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile~
HISTSIZE=10000
SAVEHIST=10000
setopt autocd notify
bindkey -v
# End of lines configured by zsh-newuser-install
 
autoload -Uz promptinit
promptinit
 
###########
# Aliases #
###########
alias zshconfig="sudo vim ~/.zshrc && source ~/.zshrc"
alias vim="nvim"
alias zshenv="sudo vim ~/.zshenv"
alias tmka="tmux killw -a"
alias tmas="tmux attach-session -t"
alias ns="npm start"
# Load external aliases
for f in ~/.config/aliases/*-alias.sh; do source $f; done
 
#########################
# Utility Functions     #
#########################
 
pcd() {
    builtin cd $1 && ls -la
}
 
 
mk() {
    # creates new dir and auto cds to it
    mkdir -p $1 && pcd $1
}
 
addenv() {
    # configure environment variables
    echo "export $1=$2" >> ~/.zshenv
    source ~/.zshenv
}

#########################
# Startup Commands      #
#########################
# source ~/.local/bin/virtualenvwrapper.sh 
 
 
#########################
# NVM Lazy Loading      #
#########################
 
# Add every binary that requires nvm, npm or node to run to an array of node globals
NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")
NODE_GLOBALS+=("nvim")
 
# Lazy-loading nvm + npm on node globals call
 load_nvm () {
   export NVM_DIR=~/.nvm
   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
 }

# Making node global trigger the lazy loading
 for cmd in "${NODE_GLOBALS[@]}"; do
   eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
 done
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Pipenv bash completion
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

# # Comment this line to disable profiling
# zprof 
#

# Golang Setupexport GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/tmp/_MEIHIysmc/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/tmp/_MEIHIysmc/etc/profile.d/conda.sh" ]; then
        . "/tmp/_MEIHIysmc/etc/profile.d/conda.sh"
    else
        export PATH="/tmp/_MEIHIysmc/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# pnpm
export PNPM_HOME="/home/joshua/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#

# autoload if nvmrc present
autoload -U add-zsh-hook
load-nvmrc() {
  [[ -a .nvmrc ]] || return
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

