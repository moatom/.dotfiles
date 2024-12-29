# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

export PATH="~/.sc:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
#export PATH="~/vnev/system/bin:$PATH"

export DIRG="$HOME/github"

alias sudo="sudo "

activate() {
	source .venv/bin/activate
}

# shortcut
alias cd-g="cd $DIRG"
alias cd-2='mkdir -p $1 && cd $1'

alias cat-me="cat ./README*"
cat-me-git() {
  cat $(git rev-parse --show-toplevel)/TODO*
}
cat-todo-git() {
  cat $(git rev-parse --show-toplevel)/README*
}

fix-me-git() {
  open $(git rev-parse --show-toplevel)/TODO*
}
fix-todo-git() {
  open $(git rev-parse --show-toplevel)/README*
}

# command ez
docker-ez() {
    [ -z "$1" ] && echo "Error: No image name provided" && return 1
    docker build -t $1 .
    docker run --rm $1
}
podman-ez() {
    podman build -t $1 .
    podman run --rm $1
}

# open settings/path/
#alias open="xdg-open"
alias ops-sh="open ~/.bashrc"
alias ops-sh2="open ~/.dotfiles/.bashrc"
alias ops-sc="open ~/.sc/"
alias ops-alacritty="open ~/.config/alacritty/font.toml ~/.config/alacritty/theme.toml ~/.config/alacritty/alacritty.toml"
alias ops-xremap="open ~/.config/xremap/config.yml"
alias ops-fusuma="open ~/.config/fusuma/config.yml"
alias ops-vscode="gnome-text-editor ~/.config/Code/User/settings.json"
alias ops-vscode-key="gnome-text-editor ~/.config/Code/User/keybindings.json"
alias ops-zellij="open ~/.config/zellij/config.kdl"

alias opc="(cat <(echo $HOME/.dotfiles) <(find ~/github -maxdepth 1 -type d)) | fzf | xargs code"

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
alias re-xremap="sudo systemctl restart xremap"
re-sh() {
	exec $SHELL
}
re-fusuma() {
	kill $(ps aux | grep 'fusuma -d' | grep -v 'grep' | awk '{print $2}') && \\
	fusuma -d
}

# misc
alias win_title="busctl --user call org.gnome.Shell /com/k0kubun/Xremap com.k0kubun.Xremap WMClasses"

# clip: only linux (bash)!
alias pbcopy='xsel --clipboard --input'
alias mk-clip="xsel --clipboard --output > "

# Git alias
alias gco='git checkout'
alias gst='git status'

alias gcm='git commit'
alias gca='git commit --amend'

alias gf='git fetch'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gp='git push'
alias gpo='git push origin'

alias gbr='git branch'
alias gcl='git clone'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias grb='git rebase'

alias gclean='git clean -fd'

alias gsp="git stash push -m'Save: automatic save'"
alias gspp='git stash pop stash@{0}'

# mk-
mk-rep() {
	gh repo create
	cp ~/Templtes/README.md ~/Templates/docker-compose.yml .
}

mk-makefile() {
	cat <<END >>Makefile
.PHONY: all
all:
  pass
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

c() {
	local tmp st
	tmp=$(mktemp)

	gcc -Wall -Wextra -o "$tmp" "$@"
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
