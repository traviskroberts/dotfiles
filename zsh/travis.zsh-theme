# ZSH Theme

function rvm_info_for_prompt {
  ruby_version=$(~/.rvm/bin/rvm-prompt i v g)
  if [ -n "$ruby_version" ]; then
    echo "[$ruby_version]"
  fi
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}'
local rvm_ruby=' %{$fg[yellow]%}$(rvm_info_for_prompt)%{$reset_color%}'
local current_dir=':%~'
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="
┌[${user_host}]${rvm_ruby}${current_dir}${git_branch}
└[%B%{$fg[blue]%}$%{$reset_color%}%b] "
RPS1="${return_code}"

TRAVIS_GIT_CLEAN_COLOR="%{$fg[green]%}"
TRAVIS_GIT_DIRTY_COLOR="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[red]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" $TRAVIS_GIT_CLEAN_COLOR✔"
ZSH_THEME_GIT_PROMPT_DIRTY=" $TRAVIS_GIT_DIRTY_COLOR±"
