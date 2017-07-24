# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function pgex_git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}
# mountain_khakis_dev
repo_name="steritech_portal_dev"

function dev_db_name() {
  branch=`pgex_git_current_branch | sed -e 's/[\.\/\-]/_/g' | tr '[A-Z]' '[a-z]'`

  if [[ $branch == 'master' || $branch == 'develop' ]]; then
    echo "${repo_name}"
  else
    echo "${repo_name}_${branch}"
  fi
}
alias pgd='dropdb -w `dev_db_name`'
alias pgrs='pg_restore --no-owner -v -d `dev_db_name`'
alias pgr='pg_restore --no-owner -v -j 9 -d `dev_db_name`'
alias pgc='createdb -O postgres `dev_db_name`'
alias pgsr='psql -w `dev_db_name` < '

alias pgall='pgd && pgc && pgr'
