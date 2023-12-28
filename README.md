<p align=center>
  <a href="https://github.com/simnalamburt">
    <img alt="dotfiles" src="https://raw.githubusercontent.com/simnalamburt/i/master/.dotfiles/logo.png">
  </a>
  <br>
  <b><a href="docs/">documentation</a></b> | <a href="packages/">packages</a>
</p>

<br>

```shell
# Import or initialize secrets:
#   SSH private keys, GPG secret keys, AWSCLI API keys, Terraform API keys,
#   Docker tokens, Cargo tokens, Bundle tokens, NPM tokens, PIP tokens, ...

git clone git@github.com:simnalamburt/.dotfiles.git --depth=1 ~/.dotfiles

# neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
ln -s ~/.dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json
cp ~/.dotfiles/.vimrc.local ~

# zsh
git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
ln -sf ~/.dotfiles/.zshrc ~
cp ~/.dotfiles/.zshrc.local ~
exec zsh
p10k configure

# ssh
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ln -sf ~/.dotfiles/.ssh/config ~/.ssh
cp ~/.dotfiles/.ssh/config.local ~/.ssh

# git
ln -sf ~/.dotfiles/.gitconfig ~
ln -sf ~/.dotfiles/.gitexclude ~
cp ~/.dotfiles/.gitconfig.local ~

# gpg
mkdir -p ~/.gnupg
cp ~/.dotfiles/gpg-agent.conf ~/.gnupg
# Trust my key (bring key or generate new one)
gpg --edit-key 0F85F46EE242057F
# gpg> uid 1
# gpg> trust
# Your decision? 5
# Do you really want to set this key to ultimate trust? (y/N) y
# gpg> save

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/.dotfiles/.tmux.conf ~

# sway
mkdir -p ~/.config/sway
ln -s ~/.dotfiles/sway ~/.config/sway/config
# swaylock
mkdir -p ~/.config/swaylock
ln -s ~/.dotfiles/swaylock ~/.config/swaylock/config

# alacritty
mkdir -p ~/.config/alacritty
ln -s ~/.dotfiles/alacritty.yml ~/.config/alacritty/.

# sirula
mkdir -p ~/.config/sirula
ln -s ~/.dotfiles/sirula.toml ~/.config/sirula/config.toml
ln -s ~/.dotfiles/sirula.css  ~/.config/sirula/style.css

# GTK 3
mkdir -p ~/.config/gtk-3.0
ln -s ~/.dotfiles/gtk3.ini ~/.config/gtk-3.0/settings.ini

# kime
mkdir -p ~/.config/kime
ln -s ~/.dotfiles/kime.yml ~/.config/kime/config.yaml

# Change default shell to zsh
chsh -s /bin/zsh

# Install below for using installed binaries
nodejs curl perl ruby zinit delta g++

neovim via appimage (or use binary for aarch64)
Or via [snap](https://snapcraft.io/install/nvim/debian) and symlink via `sudo ln -s =/usr/bin/snap
/usr/bin/nvim`

[Rust](https://doc.rust-lang.org/book/ch01-01-installation.html)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

lsd
cargo install lsd

erdtree
cargo install exa

ripgrep
cargo install ripgrep

[nvm](https://github.com/nvm-sh/nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# (WSL) Make share directory btwn WSL instances
mkdir /mnt/wsl/share

# (yarn install)
sudo apt remove cmdtest
sudo apt remove yarn
 
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
yarn install

# (Open port of WSL; Reference:
[here](https://github.com/Alex-D/dotfiles#wsl-bridge))

## On WSL
#!/bin/zsh
windowsUserProfile=/mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
# Get the hacky network bridge script
cp ~/dev/dotfiles/wsl2-bridge.ps1 ${windowsUserProfile}/wsl2-bridge.ps1

## On PowerShell(Administrator)

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
PowerShell -File $env:USERPROFILE\\wsl2-bridge.ps1

```
#### Attach nvim setting to vscode[WSL]
Install vscode-neovim in vscode; check useWSL option; assign neovim executable
path and init.vim file.

#### Check out my vim/zsh/tmux plugins
- [simnalamburt/vim-mundo     ](https://github.com/simnalamburt/vim-mundo) - Vim undo tree visualizer
- [simnalamburt/cgitc         ](https://github.com/simnalamburt/cgitc) - Close Git Combat
- [simnalamburt/zsh-expand-all](https://github.com/simnalamburt/zsh-expand-all) - Automatically expands all glob expressions, subcommands, and aliases
- [simnalamburt/ctrlf         ](https://github.com/simnalamburt/ctrlf) - Ctrl+F for your shell
- [simnalamburt/tmux-pane     ](https://github.com/simnalamburt/tmux-pane) - My key-bindings for tmux pane resizing and splitting
- [simnalamburt/shellder      ](https://github.com/simnalamburt/shellder) - Simple and feature-rich zsh/fish shell theme

<br>

--------
*dotfiles* is primarily distributed under the terms of both the [MIT license]
and the [Apache License (Version 2.0)]. See [COPYRIGHT] for details.

[MIT license]: LICENSE-MIT
[Apache License (Version 2.0)]: LICENSE-APACHE
[COPYRIGHT]: COPYRIGHT
