#!/bin/bash

echo "🏗 Installing Brew packages..."
brew bundle --file="$HOME/.dotfiles/Brewfile"

echo "📦 Installing npm packages..."
xargs npm install -g < ~/.dotfiles/npm-packages.txt

echo "🦀 Installing cargo packages..."
xargs -n1 cargo install < ~/.dotfiles/cargo-packages.txt

echo "🐍 Installing pip packages..."
pip install -r ~/.dotfiles/pip-packages.txt

echo "🧩 Installing VS Code extensions..."
xargs -n1 code --install-extension < ~/.dotfiles/vscode-extensions.txt

# echo "🧱 Applying macOS system preferences..."
# bash ~/.dotfiles/macos-defaults.sh

echo "✅ Environment setup complete!"
