DOTFILES="$HOME/.dotfiles"
SHELL_SETTINGS=".bashrc"
SHELL_SETTINGS_MAIN="$DOTFILES/$SHELL_SETTINGS"
SHELL_SETTINGS_BASE="$HOME/$SHELL_SETTINGS"
export DIRG="$HOME/github"
export DIRSC="$HOME/.sc"
export PYTHONSTARTUP="$DOTFILES/.pythonrc.py"

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

export PATH="$DIRSC:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
#export PATH="~/vnev/system/bin:$PATH"
export PATH="/home/moatom/.mozbuild/git-cinnabar:$PATH"

if [ -d "$HOME/.dotfiles/.bash_completion.d" ]; then
  shopt -s nullglob
  for file in "$HOME/.dotfiles/.bash_completion.d/"*; do
      [ -f "$file" ] && source "$file"
  done
  shopt -u nullglob
fi

alias sudo="sudo "

# alias
activate() {
	source .venv/bin/activate
}

alias rcp="rsync -avP"

alias relogin='exec $SHELL -l'
alias s='ssh'
alias n='nvim '
alias r='redis-cli'
alias e='emacs '
alias c='cd'
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -la'

alias gst='git status'
alias ga='git add'
alias gcm='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
# complete -o default -F _git_checkout_wrapper gco
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
alias grau='git remote add upstream'
alias grao='git remote add origin'

alias gl='git log --oneline --graph --decorate'
alias glo='git log --pretty="oneline"'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gclean='git clean -fd'

alias gs="git stash"
alias gsp="git stash push -u -m'Save: automatic save'"
alias gspp='git stash pop stash@{0}'

alias dcu-m="docker-compose -f docker-compose-only-middleware.yml up -d"
alias dcu-l="docker-compose -f docker-compose-localtest.yml up -d"
alias dcd-m="docker-compose -f docker-compose-only-middleware.yml down -v"
alias dcd-l="docker-compose -f docker-compose-localtest.yml down -v"
alias dcs='docker stop $(docker ps -q)'
dcc() { # clean
  docker ps -aq | grep -v $(docker ps -aq --filter "name=k8s_POD_") | xargs docker stop
  docker ps -aq | grep -v $(docker ps -aq --filter "name=k8s_POD_") | xargs docker rm
  docker volume prune -f
}

alias cd-g="cd $DIRG"
alias cd-2='mkdir -p $1 && cd $1'
alias cd-c='cd "$(find $DIRG -maxdepth 1 -type d | fzf)"'

alias treem="tree -ah -I 'node_modules|.git|.DS_Store' --dirsfirst"

# docker run -it -u root -v $(pwd):/home/k6 grafana/k6:latest run --env HOST=$host foo.js
alias k6-d="docker run -it -u root -v $(pwd):/home/k6 grafana/k6:latest"

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
alias ops-sc="open ~/.sc/"
alias ops-sh="open $SHELL_SETTINGS_BASE"
alias ops-sh2="open $SHELL_SETTINGS_MAIN"
alias ops-alacritty="open ~/.config/alacritty/font.toml ~/.config/alacritty/theme.toml ~/.config/alacritty/alacritty.toml"
alias ops-zellij="open ~/.config/zellij/config.kdl"
alias ops-xremap="open ~/.config/xremap/config.yml"
alias ops-fusuma="open ~/.config/fusuma/config.yml"
alias ops-vscode="gnome-text-editor ~/.config/Code/User/settings.json"
alias ops-vscode-key="gnome-text-editor ~/.config/Code/User/keybindings.json"
# alias ops-tmux="open ~/.tmux.conf"
# alias ops-tex="open ~/.latexmkrc"
# alias ops-emacs="open ~/.emacs.d/init.el"
# alias ops-nvim="open ~/.config/nvim/init.vim"

alias o="(cat <(echo $HOME/.dotfiles) <(echo /etc/systemd/system/) <(echo $HOME/Templates) <(echo $HOME/.sc) <(echo $HOME/.bashrc) <(find $DIRG -maxdepth 1 -type d)) | fzf | xargs code"
alias o2="(cat <(echo $HOME/.dotfiles) <(echo $DIRSC) <(find ~/program -maxdepth 2 -type d)) | fzf | xargs idea1"

#alias open="xdg-open"
open() {
	i=0
	for x in $@; do
		if [[ $i -eq "${#@}" ]]; then
			/usr/bin/xdg-open $x &&
				xdottool key alt+esc
		else
			/usr/bin/xdg-open $x &
		fi
		let i++
	done
}

# reload settings
re-sh() {
	exec $SHELL
}
alias re-xremap="sudo systemctl restart xremap"
re-fusuma() {
	kill $(ps aux | grep 'fusuma -d' | grep -v 'grep' | awk '{print $2}') && \\
	fusuma -d
}

# misc
# command ez
ez-docker() {
	[ -z "$1" ] && echo "Error: No image name provided" && return 1
	docker build -t $1 .
	docker run --rm $1
}
ez-podman() {
	podman build -t $1 .
	podman run --rm $1
}

# clip: only linux (bash)!
alias pbcopy='xsel --clipboard --input'

# util
alias win_title="busctl --user call org.gnome.Shell /com/k0kubun/Xremap com.k0kubun.Xremap WMClasses"

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
alias mk-clip="xsel --clipboard --output > "

mk-template() {
	[ -n "$1" ] && zed $HOME/Templates/$1
}

mk-from-template() {
	[ $# -eq 1 ] && ext="${1##*.}" && template="$HOME"/Templates/*."$ext" &&
		[ -e $template ] && cp $template "$1" && echo "Created $1 from template" $template ||
		echo "Usage: mk-from-template <filename>; $(ls ~/Templates)"
}

mk-rep() {
  cd $DIRG
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

mk-python() {
  n /tmp/a.py
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

# keen style
mk-script-here() {
	cat <<'SHELLSCRIPT' >"$1"
#!/bin/sh
# modified@{templated by http://qiita.com/blackenedgold/items/c9e60e089974392878c8}
usage() {
    cat <<HELP
NAME:
   $0 -- {one sentence description}

SYNOPSIS:
  $0 [-h|--help]
  $0 [--verbose]

DESCRIPTION:
   {description here}

  -h  --help      Print this help.
      --verbose   Enables verbose mode.

EXAMPLE:
  {examples if any}

HELP
}

main() {
    SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

    while [ $# -gt 0 ]; do
        case "$1" in
            --help) usage; exit 0;;
            --verbose) set -x; shift;;
            --) shift; break;;
            -*)
                OPTIND=1
                while getopts h OPT "$1"; do
                    case "$OPT" in
                        h) usage; exit 0;;
                    esac
                done
                shift
                ;;
            *) break;;
        esac
    done

    # do something
    if [ ! -d "" ]
    then
        echo "# do something ... "
    else
        echo "# do something ... "
    fi

    if [ ! -z "" ]; then
        echo "# do something ... "
    fi
}

main "$@"

SHELLSCRIPT
	chmod +x "$1"
	code "$1"
}

# collect reps, mk sc to unifying dirs
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

# interpret/playground/play
rust() {
	local toolchain=+stable

	if [[ "$1" =~ "\+.+" ]]; then
		toolchain="$1"
		shift
	fi
	cargo "$toolchain" play "$@"
}

alias rusti="evcxr"

# c() {
# 	local tmp st
# 	tmp=$(mktemp)

# 	gcc -Wall -Wextra -o "$tmp" "$@"
# 	st="$?"
# 	if [ "$st" != 0 ]; then
# 		rm "$tmp"
# 		return "$st"
# 	fi

# 	"$tmp"
# 	st="$?"
# 	rm "$tmp"
# 	return "$st"
# }

cpp() {
	local tmp st
	tmp=$(mktemp)

	g++ -o "$tmp" "$@"
	st="$?"
	if [ "$st" != 0 ]; then
		rm "$tmp"
		return "$st"
	fi

	"$tmp"
	st="$?"
	rm "$tmp"
	return "$st"
}

# https://zenn.dev/tkithrta/articles/62bc35b5f1cec9
alias pg-bash="open 'https://www.onlinegdb.com/online_bash_shell'"
alias pg-*="open 'https://leetcode.com/playground/new/empty'"

alias pl-vim="npm create vite@latest"

ck-command() {
	if alias "$1" >/dev/null 2>&1; then
		# 引数がエイリアス名の場合
		echo "'$1' is an alias:"
		alias "$1"
	elif declare -f "$1" >/dev/null 2>&1; then
		# 引数が関数名の場合
		echo "'$1' is a function:"
		declare -f "$1"
	else
		# 引数がエイリアスでも関数でもない場合
		echo "'$1' is neither an alias nor a function."
	fi
}
ck-alias() {
  cat $SHELL_SETTINGS_MAIN $SHELL_SETTINGS_BASE | grep -E "^alias .*="
}