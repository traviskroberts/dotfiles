# ZSH Theme

function ruby_info_for_prompt {
  local output=$(ruby -v 2> /dev/null)
  ruby_version=$(echo "$output" | grep "^ruby" | awk '{print $2}')

  if [ -n "$ruby_version" ]; then
    echo "[ruby-$ruby_version]"
  fi
}

function site_path_prompt_segment {
  local dir=${PWD/#$HOME\//}

  if [[ $dir == sites/* ]]; then
    local site=${dir#sites/}
    site=${site%%/*}

    local subpath=${dir#sites/$site}
    subpath=${subpath#/}

    local color="yellow"
    case "$site" in
      betterup-monolith) color="blue" ;;
      betterup-infrastructure) color="cyan" ;;
      betterup-product) color="magenta" ;;
    esac

    if [[ -n "$subpath" ]]; then
      echo " %{$fg[${color}]%}<${site}:${subpath}>%{$reset_color%}"
    else
      echo " %{$fg[${color}]%}<${site}>%{$reset_color%}"
    fi
  else
    echo ":%~"
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
local ruby_prompt=' %{$fg[yellow]%}$(ruby_info_for_prompt)%{$reset_color%}'
local site_segment='$(site_path_prompt_segment)'
local git_radar='$(git-radar --zsh)%{$reset_color%}'

PROMPT="
┌[${user_host}]${ruby_prompt}${site_segment}${git_radar}
└[%B%{$fg[blue]%}$%{$reset_color%}%b] "
