DOTFILES="$HOME/.dotfiles"
SHELL_SETTINGS=".zshrc"
SHELL_SETTINGS_MAIN="$DOTFILES/$SHELL_SETTINGS"
SHELL_SETTINGS_BASE="$HOME/$SHELL_SETTINGS"
export DIRG="$HOME/program/ghe"
export DIRSC="$HOME/.scripts"
export PYTHONSTARTUP="$DOTFILES/.pythonrc.py"

export PATH="$DIRSC:$PATH"
fpath=(~/.zsh/completion $fpath)

# Aliases
activate() {
	source .venv/bin/activate
}

alias relogin='exec $SHELL -l'
alias n='nvim '
alias e='emacs '
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -la'

alias gs='git status'
alias ga='git add'
alias gcm='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcom='git checkout origin master'
alias gcomn='git checkout origin main'

alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpomn='git push origin main'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gplnr='git pull --no-rebase'
alias gplo='git pull origin'
alias gf='git fetch'
alias gfp='git fetch --prune'

alias gcl='git clone'
alias gb='git branch'
alias gbr='git branch -r'
alias gd='git diff'
alias grb='git rebase'
alias grhm='git fetch && git reset --hard upstram/master'
alias gr='git remote'
alias grs='git remote show'

alias gl='git log --oneline --graph --decorate'
alias glo='git log --pretty="oneline"'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gclean='git clean -fd'

alias gsp="git stash push -m'Save: automatic save'"
alias gspp='git stash pop stash@{0}'

alias cd-g="cd $DIRG"
alias cd-2='mkdir -p $1 && cd $1'
alias cd-c='cd "$(find $DIRG -maxdepth 1 -type d | fzf)"'

alias cat-me="cat ./README*"
cat-me-git() {
  cat $(git rev-parse --show-toplevel)/README*
}
cat-todo-git() {
  cat $(git rev-parse --show-toplevel)/TODO*
}
fix-me-git() {
  open $(git rev-parse --show-toplevel)/README*
}
fix-todo-git() {
  open $(git rev-parse --show-toplevel)/TODO*
}

# Settings
ops-shell() {
  open $SHELL_SETTINGS_BASE
}
ops-shell2() {
  open $SHELL_SETTINGS_MAIN
}
alias ops-sh="open $SHELL_SETTINGS_BASE"
alias ops-sh2="open $SHELL_SETTINGS_MAIN"
# alias ops-vscode="gnome-text-editor ~/.config/Code/User/settings.json"
# alias ops-vscode-key="gnome-text-editor ~/.config/Code/User/keybindings.json"
# alias ops-tmux="open ~/.tmux.conf"
# alias ops-tex="open ~/.latexmkrc"
# alias ops-emacs="open ~/.emacs.d/init.el"
# alias ops-nvim="open ~/.config/nvim/init.vim"

alias opc="(cat <(echo $HOME/.dotfiles) <(echo $DIRSC) <(find ~/program -maxdepth 2 -type d)) | fzf | xargs code"


re-shell() {
  exec $SHELL -l
}

# Misc
# command ez
ez-docker() {
    [ -z "$1" ] && echo "Error: No image name provided" && return 1
    docker build -t $1 .
    docker run --rm $1
}

# util
# lg: lazygitでの移動を反映
lg() {
  export LAZYGIT_NEW_DIR_FILE=$HOME/.lazygit/newdir

  lazygit "$@"

  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
    rm -f $LAZYGIT_NEW_DIR_FILE >/dev/null
  fi
}

# mk-
output() {
  cd $HOME/program/github/profile/qiita_posts
  n note.md
}

mk-template() {
  [ -n "$1" ] && zed $HOME/Templates/$1
}

mk-from-template() {
  [ $# -eq 1 ] && ext="${1##*.}" && template="$HOME"/Templates/*."$ext" && \
  [ -e $template ] && cp $template "$1" && echo "Created $1 from template" $template \
  || echo "Usage: mk-from-template <filename>; $(ls ~/Templates)"
}

mk-rep() {
	gh repo create
	cp ~/Templtes/README.md ~/Templates/docker-compose.yml .
}

mk-me() {
  n REDAME.md
}

mk-todo() {
  n TODO.md
}

mk-note() {
  n .note.md
}

mk-makefile() {
	cat <<'END' >>Makefile
.PHONY: all
all:
  pass
END
}

mk-dockercompose() {
    cat <<'END' >>docker-compose.yml
version: '3.8'

services:
  web:
    image: nginx:latest
    container_name: nginx-container
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    networks:
      - app-network

  db:
    image: postgres:latest
    container_name: postgres-container
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: exampledb
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - app-network

  app:
    image: your-app-image:latest
    container_name: app-container
    build:
      context: ./app
    environment:
      - DATABASE_URL=postgres://user:password@db:5432/exampledb
    depends_on:
      - db
    networks:
      - app-network
    ports:
      - "5000:5000"

networks:
  app-network:
    driver: bridge

volumes:
  postgres-data:
END
}

mk-script-there() {
	cat <<'DONE' >"$DIRSC/$1"
#!/bin/bash
## Usage: ${1}

usage()
{
    echo "usage: ${1} [[-o1] [-o2] [-h]]"
}

while (( "$#" )); do
    case "$1" in
        -o1 | --o1)         o1=1
                            shift
                            ;;
        -o2  | --o2)        o2=1
                            shift
                            ;;
        -a   | --all)       o1=1
                            o2=1
                            shift
                            ;;
        -h   | --help)      usage
                            exit 1
                            ;;
        *)                  usage
                            exit 1
    esac
done

ROOT=$(pwd)
WORKDIR=${ROOT}/repos
SUBREP="git@bitbucket.org:foo.git"
OUTPUT=${ROOT}/output

if [ ! -d "${WORKDIR}" ]
then
    echo "# Cloning repos locally ... "

    mkdir $WORKDIR
    git clone ${SUBREP} "${WORKDIR}/foo"
else
    echo "# Updating repos locally ... "

    git clean -Xdf "${WORKDIR}/foo"; cd "${WORKDIR}/foo"; git pull; cd ..
fi

if [ ! -z "${o1}" ]; then
    echo "# Work on foo1"
    git checkout master
fi

if [ ! -z "${o2}" ]; then
    echo "# Work on foo2"
    git checkout master
fi

cd $ROOT

}
DONE
	chmod +x "$DIRSC/$1"
	code "$DIRSC/$1"
}

check-command() {
  if alias "$1" >/dev/null 2>&1; then
    # 引数がエイリアス名の場合
    echo "'$1' is an alias:"
    alias "$1"
  elif typeset -f "$1" >/dev/null 2>&1; then
    # 引数が関数名の場合
    echo "'$1' is a function:"
    typeset -f "$1"
  else
    # 引数がエイリアスでも関数でもない場合
    echo "'$1' is neither an alias nor a function."
  fi
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
