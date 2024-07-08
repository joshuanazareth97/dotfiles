export WORKON_HOME="~/.virtualenvs" # Virtualenv Wrapper directory
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3" # Virtualenv Wrapper directory

# zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh

export PATH=$PATH:~/scripts:/usr/local/go/bin

# Go Env Vars
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

. "$HOME/.cargo/env"
# PyEnv Vars
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
