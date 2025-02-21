# dotfiles

## How to Use and Develop

```bash
brew install hammerspoon
ln -sfn ~/.dotfiles/macos/.hammerspoon/init.lua ~/.hammerspoon/init.lua
```

cat ~/.hammerspoon/init.lua
cat ~/.config/zellij/config.kdl
cat ~/.config/alacritty/alacritty.toml
cat ~/.config/Code/User/settings.json
cat ~/.config/Code/User/keybindings.json
cat ~/.config/xremap/config.yml
cat ~/.config/autostart/fusuma.desktop
cat ~/.config/fusuma/config.yml
cat ~/.config/mozc/config1.db
cat ~/.config/mozc/user_dictionary.db
vimrc

```sh
#1
cat /etc/systemd/system/xremap.service

#2
sudo nano /etc/udev/rules.d/99-xremap.rules
'
# /dev/input デバイスに変化があったときに xremap.service を起動
KERNEL=="event*", SUBSYSTEM=="input", ACTION=="add|change|remove", RUN+="/usr/bin/systemctl restart xremap.service"
'
sudo udevadm control --reload
#sudo udevadm trigger --subsystem-match=input

sudo systemctl status xremap.service
sudo udevadm monitor --subsystem-match=input
```

~/.global_git_ignore
~/.gitconfig
```
[alias]
    st = status
    co = checkout
    br = branch
    cm = commit
    amend = commit --amend
    lg = log --oneline --graph --decorate
```

### install

```bash
git clone <this rep>

echo 'source "$HOME/.dotfiles/.bashrc"' >> ~/.bashrc
echo '$include ~/.dotfiles/.inputrc' >> ~/.inputrc

git clone https://github.com/b4b4r07/enhancd ./.enhancd
echo 'source $HOME/.dotfiles/.enhancd/init.sh' >> ~/.bashrc  # または ~/.zshrc
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
