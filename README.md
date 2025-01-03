# dotfiles

## How to Use and Develop

### install

```bash
git clone <this rep>

echo 'source "$HOME/.dotfiles/.bashrc"' >> ~/.bashrc
echo '$include ~/.dotfiles/.inputrc' >> ~/.inputrc
```

### Add files

```bash
cat ~/.inputrc
touch ~/.dotfiles/.inputrc
# 中身
echo '$include ~/.dotfiles/.inputrc' >> ~/.inputrc

# opsの奴を追加
cp foo ~/.config/alacritty
cp foo ~/.config/Code
```

### List commands

- cd-
- cat-
- *-ez
- ops-
- opc
- re-
- `<git something>`
- `<languages>`
- pg-
- pl-

## Situation

### TODO

- bashrcのmk-script2を汎用化
- ~/.sc/
  - compose-
  - mk-app-command
  - mk-wr

## Misc

```bash
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
