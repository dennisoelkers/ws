autoload colors; colors;
setopt prompt_subst

ZSH_THEME_GIT_PROMPT_CLEAN_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_CLEAN_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY_PREFIX="%{$reset_color%}%{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_DIRTY_SUFFIX="]%{$reset_color%}"

# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

# show red star if there are uncommitted changes
parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN_PREFIX${git_where#(refs/heads/|tags/)}$ZSH_THEME_GIT_PROMPT_CLEAN_SUFFIX"
  else
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY_PREFIX${git_where#(refs/heads/|tags/)}$ZSH_THEME_GIT_PROMPT_DIRTY_SUFFIX"
  fi
}

# if in a git repo, show dirty indicator + git branch
git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(parse_git_dirty)"
}

PROMPT='%{$fg[cyan]%}%~% %(?.%{$fg[green]%}.%{$fg[red]%}) $(git_custom_status)%{$fg[blue]%}$ '
