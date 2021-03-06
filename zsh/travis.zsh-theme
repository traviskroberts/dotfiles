# ZSH Theme

function ruby_info_for_prompt {
  if [[ -s "~/.rvm/bin/rvm-prompt" ]]; then
    ruby_version=$(~/.rvm/bin/rvm-prompt i v g)
  fi

  if [[ -s $(brew --prefix asdf) ]]; then
    ruby_version=${$(asdf current ruby)[2]}
  fi

  if [ -n "$ruby_version" ]; then
    echo "[ruby-$ruby_version]"
  fi
}

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export RPS1=%{$(echotc UP 1)%}%{$fg[magenta]%}[${timer_show}s]%{$reset_color%}%{$(echotc DO 1)%}
    unset timer
  fi
}

local user_host='%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}'
local rvm_ruby=' %{$fg[yellow]%}$(ruby_info_for_prompt)%{$reset_color%}'
local current_dir=':%~'
local git_branch='$(git_prompt_info)%{$reset_color%}'
local git_radar='$(git-radar --zsh)%{$reset_color%}'

PROMPT="
┌[${user_host}]${rvm_ruby}${current_dir}${git_radar}
└[%B%{$fg[blue]%}$%{$reset_color%}%b] "

TRAVIS_GIT_CLEAN_COLOR="%{$fg[green]%}"
TRAVIS_GIT_DIRTY_COLOR="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[red]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" $TRAVIS_GIT_CLEAN_COLOR✔"
ZSH_THEME_GIT_PROMPT_DIRTY=" $TRAVIS_GIT_DIRTY_COLOR±"
