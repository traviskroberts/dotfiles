# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export GIT_RADAR_FORMAT=" %{$fg[magenta]%}git%{$reset_color%}:(%{remote: }%{branch}%{ :local})%{$reset_color%}%{ :changes}"
export JAVA_HOME=$(/usr/libexec/java_home)
export CS_HOME=$HOME/.aws/cloud-search-tools
export AWS_CREDENTIAL_FILE=$HOME/.aws/credentials
export LIVE_RELOAD=1
export RACK_ENV="development"

# make Atom the default editor
export EDITOR="/usr/local/bin/atom -nw"
export PSQL_EDITOR="/usr/local/bin/atom"

# set nvm dir
export NVM_DIR="$HOME/.nvm"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="travis"

# Example aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias df="source $HOME/.zshrc"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler)


# Customize to your needs...
export PATH=/Users/travis/Library/Python/2.7/bin:$HOME/.rvm/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/npm/bin:$CS_HOME/bin:$PATH

source $ZSH/oh-my-zsh.sh
export LSCOLORS="exfxcxdxbxegedabagacad"
source $HOME/bin/dotfiles/aliases

[[ -s "$(brew --prefix nvm)/nvm.sh" ]] && . "$(brew --prefix nvm)/nvm.sh"
