# virtualenv
export WORKON_HOME="~/.virtualenvs" # Virtualenv Wrapper directory
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3" # Virtualenv Wrapper directory

# zsh
export ZSH_CUSTOM=~/.oh-my-zsh

export PATH=$PATH:~/.scripts

# Setting variables for WSL X Server 
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 # Get Server IP
export LIBGL_ALWAYS_INDIRECT=1
export XDG_RUNTIME_DIR=/run/user/$(id -u)

. "$HOME/.cargo/env"
export DBUDDY_SSH_KEY=~/.ssh/aws-loki.pem
