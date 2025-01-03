# dotfiles

## Situation
### Done

- bashrc

### TODO

- bashrcのmk-script2を汎用化
- zshrc
- ~/.sc/
  - compose-
  - mk-app-command
  - mk-wr

#### .inputrc
```
# see options: bind -p | grep comp

"\e[A": history-search-backward # ↑
"\e[B": history-search-forward # ↓

set completion-ignore-case on
set history-preserve-point
TAB: menu-complete
set show-all-if-ambiguous on
"\e[Z": menu-complete-backward # Shift-Tab
```

### Idea
catでエスケープ不要で、$fooが置換されるのを防ぐ方法

## Develop

### install

```bash
git clone <this rep>
# shell
echo 'source "$HOME/.dotfiles/.bashrc"' >> ~/.bashrc
echo '$include ~/.dotfiles/.inputrc' >> ~/.inputrc

# opsの奴を追加
cp ~/.config/alacritty
cp ~/.config/Code
```

### List commands

- cd-
- cat-
- *-ez
- ops-
- opc
- re-
- <git something>
- <languages>
- pg-
- pl-


### Add files

```bash
cat ~/.inputrc
touch ~/.dotfiles/.inputrc
# 中身
echo '$include ~/.dotfiles/.inputrc' >> ~/.inputrc
```


# Misc

```
SHELL_SETTINGS="$HOME/.dotfiles/.zshrc"
[ -f $SHELL_SETTINGS ] && source $SHELL_SETTINGS

# echo '[ -f ~/.config/.sh ] && source ~/.config/.sh' >> ~/.zshrc
# See: https://wiki.archlinux.jp/index.php/Zsh#.E3.82.AD.E3.83.BC.E3.83.90.E3.82.A4.E3.83.B3.E3.83.89


cp .sh ~/.config/.sh
cp .zshrc ~/.zshrc

ln .sh ~/.config/.sh
ln -s .zshrc ~/.zshrc
```

- macOSで隠れファイル表示：`Cmd+Shift+.`
- direnvか何かのせいで、$SHELLが/bin/shになる。。。
