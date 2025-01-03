SHELL_SETTINGS_F=".zshrc"
SHELL_SETTINGS="$HOME/.dotfiles/.zshrc"

export PATH="$HOME/.scripts:$PATH"
fpath=(~/.zsh/completion $fpath)

# Aliases
alias relogin='exec $SHELL -l'

alias n='nvim '
alias e='emacs '
alias cat-me='cat README.md'

alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -la'

alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

re_shell() {
  exec $SHELL -l
}
ops_shell() {
  open $HOME/$SHELL_SETTINGS_F
}
ops_shell2() {
  open $SHELL_SETTINGS
}

mk-rep() {
  gh repo create $1 --public --source=. --remote=github
  cp ~/Templtes/README.md .
}

lg() {
  export LAZYGIT_NEW_DIR_FILE=$HOME/.lazygit/newdir

  lazygit "$@"

  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
    rm -f $LAZYGIT_NEW_DIR_FILE >/dev/null
  fi
}

output() {
  cd $HOME/program/github/profile/qiita_posts
  n note.md
}


# ========================================
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  autoload -Uz compinit
  compinit -u
fi

autoload -Uz promptinit
promptinit
# コマンド補完
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
# デフォルトのプロンプトを walters テーマに設定する
#prompt walters
source ~/.zsh/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
setopt PROMPT_SUBST
PS1='%F{green}%n:%c%f%F{022}$(__git_ps1 "(%s)")%f\$ '

# 履歴検索を有効化
# bashの場合
#bindkey '^P' history-beginning-search-backward # 先頭マッチのヒストリサーチ
#bindkey '^N' history-beginning-search-forward # 先頭マッチのヒストリサーチ

# zshの場合
## zkbd と互換性のあるハッシュテーブルを作成し、他のキーをこのハッシュテーブルに追加する (man 5 terminfo を参照)
typeset -g -A key
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"

## 最後に、zle がアクティブのときにターミナルがアプリケーションモードになるようにする。そのときにだけ、$terminfo の値が有効になる。
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

## 上下キーの利用が可能に
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# fzf
source <(fzf --zsh)

# Dirstack
#autoload -Uz add-zsh-hook

#DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
#if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
#	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
#	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
#fi
#chpwd_dirstack() {
#	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
#}
#add-zsh-hook -Uz chpwd chpwd_dirstack

#DIRSTACKSIZE='20'

#setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## 重複するエントリを削除する
#setopt PUSHD_IGNORE_DUPS

## +/- 演算子をもとに戻す。
#setopt PUSHD_MINUS


# HISTORY
HISTSIZE=10000
SAVEHIST=10000
