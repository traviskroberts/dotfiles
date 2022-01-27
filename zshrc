# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Homebrew
eval "$(brew shellenv)"

export GIT_RADAR_FORMAT=" %{$fg[magenta]%}git%{$reset_color%}:(%{remote: }%{branch}%{ :local})%{$reset_color%}%{ :changes}"
export AWS_CREDENTIAL_FILE=$HOME/.aws/credentials
export RACK_ENV="development"
export ERL_AFLAGS="-kernel shell_history enabled"

# make VS Code the default editor
export EDITOR="/usr/local/bin/code -nw"
export PSQL_EDITOR="/usr/local/bin/code"

# exa colors
export EXA_COLORS="da=37:uu=37;1:un=37:gu=37;1:gn=37:sb=33:sn=33;1"
export EXA_COLORS="ur=37:uw=37:ux=37;1:ue=37;1:$EXA_COLORS" # user file permissions
export EXA_COLORS="gr=37:gw=37:gx=37;1:$EXA_COLORS" # group file permissions
export EXA_COLORS="tr=37:tw=37:tx=37;1:$EXA_COLORS" # world file permissions
export EXA_COLORS="*.rb=33:$EXA_COLORS" # world file permissions

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="travis"

# Example aliases
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
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/share/npm/bin:/usr/local/heroku/bin:$PATH

# OpenSSL config
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"

# asdf
export RUBY_CONFIGURE_OPTS="--with-zlib-dir=/opt/homebrew/opt/zlib --with-openssl-dir=/opt/homebrew/opt/openssl@1.1 --with-readline-dir=/opt/homebrew/opt/readline --with-libyaml-dir=/opt/homebrew/opt/libyaml"
export RUBY_CFLAGS="-Wno-error=implicit-function-declaration"

source $ZSH/oh-my-zsh.sh
source $HOME/sites/dotfiles/aliases

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "/usr/local/bin/direnv" ]] && eval "$(direnv hook zsh)"
[[ -s $(brew --prefix asdf)/asdf.sh ]] && . $(brew --prefix asdf)/asdf.sh
[[ -s $(brew --prefix mcfly) ]] && eval "$(mcfly init zsh)"

# BetterUp
[[ -s "$HOME/.betterup_profile/init.sh" ]] && emulate sh -c "source $HOME/.betterup_profile/init.sh"
