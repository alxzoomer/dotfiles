alias prj="cd ~/projects"
alias spr="cd ~/projects/steritech-portal"
#alias spr="cd ~/projects/mountain-khakis"
alias meld="/Applications/Meld.app/Contents/MacOS/Meld"
alias rmorig="find . -name '*.orig' -delete"
alias goenvoff="unset GOPATH"
alias gomod="export GO111MODULE=on"
alias gomodoff="unset GO111MODULE"
alias m=make
alias sqlops="/Applications/Azure\ Data\ Studio.app/Contents/Resources/app/bin/code"
alias comp="/Applications/Araxis\ Merge.app/Contents/Utilities/compare"
alias glsub="ls -1d */ | xargs -L1d -I{} -- sh -c \"pushd {} > /dev/null ; echo {}; git pull ; popd > /dev/null\""

alias gstsub="ls -1d */ | xargs -L1d -I{} -- sh -c \"pushd {} > /dev/null ; echo {}; git status -s ; popd > /dev/null\""
alias gbrsub="ls -1d */ | xargs -L1d -I{} -- sh -c \"pushd {} > /dev/null ; echo {}; git status | head -n 1; echo \"\"; popd > /dev/null\""
alias grepos="ls -1d */ | xargs -L1d -I{} -- sh -c \"pushd {} > /dev/null ; echo \\\"gcl \\\$(git config --get remote.origin.url) {}\\\" ; popd > /dev/null\""

alias c="code ."

alias dnsr="sudo killall -HUP mDNSResponder"

alias avpe="EDITOR=\"code -w -n\" ANSIBLE_VAULT_PASSWORD_FILE=/Users/alexeyn/projects/automation/playbooks-hv/ansible-vault-pass-prod ansible-vault edit"

alias avp="EDITOR=\"code -w -n\" ANSIBLE_VAULT_PASSWORD_FILE=/Users/alexeyn/projects/automation/playbooks-hv/ansible-vault-pass-prod ansible-vault"

alias avs="EDITOR=\"code -w -n\" ANSIBLE_VAULT_PASSWORD_FILE=/Users/alexeyn/projects/automation/playbooks-hv/ansible-vault-pass-sqa ansible-vault"

alias lzd='lazydocker'

alias vmw1rdpssh='ssh -L 3389:10.10.0.21:3389 virtgw.hv -N'

goenv () {
    export GOPATH=${PWD}
    echo $PWD
}


# example: extract file
extract () {
 if [ -f $1 ] ; then
 case $1 in
 *.tar.bz2)   tar xjf $1        ;;
 *.tar.gz)    tar xzf $1     ;;
 *.bz2)       bunzip2 $1       ;;
 *.rar)       unrar x $1     ;;
 *.gz)        gunzip $1     ;;
 *.tar)       tar xf $1        ;;
 *.tbz2)      tar xjf $1      ;;
 *.tbz)       tar -xjvf $1    ;;
 *.tgz)       tar xzf $1       ;;
 *.zip)       unzip $1     ;;
 *.Z)         uncompress $1  ;;
 *.7z)        7z x $1    ;;
 *)           echo "I don't know how to extract '$1'..." ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
}

# example: pk tar file
pk () {
 if [ $1 ] ; then
 case $1 in
 tbz)       tar cjvf $2.tar.bz2 $2      ;;
 tgz)       tar czvf $2.tar.gz  $2       ;;
 tar)      tar cpvf $2.tar  $2       ;;
 bz2)    bzip $2 ;;
 gz)        gzip -c -9 -n $2 > $2.gz ;;
 zip)       zip -r $2.zip $2   ;;
 7z)        7z a $2.7z $2    ;;
 *)         echo "'$1' cannot be packed via pk()" ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi

}

curltxt () {
if [ $1 ] ; then
curl -s $1 | pandoc -f html -t plain
fi
}
