#!/bin/bash

echo "🍺 Updating Homebrew Brewfile..."
brew bundle dump --file="$HOME/.dotfiles/Brewfile" --describe --force

echo "📦 Saving global npm packages..."
npm list -g --depth=0 | tail -n +2 | awk '{print $2}' > ~/.dotfiles/npm-packages.txt

echo "🦀 Saving installed cargo packages..."
cargo install --list | grep -E '^\w+' | awk '{print $1}' > ~/.dotfiles/cargo-packages.txt

echo "🐍 Saving pip packages..."
pip freeze > ~/.dotfiles/pip-packages.txt

echo "🧩 Saving VS Code extensions..."
code --list-extensions > ~/.dotfiles/vscode-extensions.txt

echo "✅ All package lists updated!"
