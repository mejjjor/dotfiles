# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH="/home/riko/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-syntax-highlighting fzf)

source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit 

# General
alias d="docker"
alias dc="docker-compose"

# Git
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend"
alias gco="git checkout"
alias gf="git fetch"
alias glog="git log"
alias glg="git lg"
alias gl="git pull"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gst="git status"
alias gsu="git stash -u"
alias gsp="git stash pop"
alias gsa="git stash apply"
alias gsc="git stash clear"
alias gd="git diff"

# ls
alias l="ls"
alias ls="ls --color"

alias bat="batcat"

# ssh-agent
alias ssha="ssh-add $HOME/.ssh/id_rsa"


export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export ANDROID_HOME=/usr/lib/android-sdk
export ANDROID_SDK_ROOT=/usr/lib/android-sdk

export PATH="$PATH:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$HOME/.fnm/:$HOME/scripts/"

# fnm
eval "`fnm env`"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
