# dotfiles

## Situation
### Done

- bashrc

### TODO

- bashrcのmk-script2
- inoutrcの統合
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
search
catでエスケープ不要で、$fooが置換されるのを防ぐ方法

## Develop

### install

```bash
git clone <this rep>
# shell
echo 'source "\$HOME/.dotfiles/.bashrc"' >> ~/.bashrc
echo '\$include ~/.dotfiles/.inputrc' >> ~/.inputrc

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
touch ./.inputrc
# 中身
```

```bash
# cat ~/.bashrc
echo 'source "\$HOME/.dotfiles/.bashrc"' >> ~/.bashrc
# cat ~/.inputrc
echo '\$include ~/.dotfiles/.inputrc' >> ~/.inputrc
```
