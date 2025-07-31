# nvim-mini
Extremely minimal opinionated Neovim 12 Configuration.

## About

This repository contains a minimal Neovim configuration designed for a fast and efficient coding experience.
It includes a curated set of plugins for enhanced functionality, such as:

 - file picking with `mini.pick` 
 - syntax highlighting with `nvim-treesitter`
 - language server protocol (LSP) support with `nvim-lspconfig`
 - gemini code assist with `gemini.nvim`

 The configuration also integrates `gitsigns.nvim` for Git indicators and sets the `gruvbox` color scheme.

 ## Bob, Neovim Version Manager

 To install and manage Neovim versions, I recommend using [Bob](https://github.com/MordechaiHadad/bob).
 `bob` allows to maintain multiple Neovim configurations simultaneously.

 ### Install Neovim 12 Nightly

 ```sh
 bob install nightly
 bob use nightly
 ```
## Multi version Neovim Setup

### Create custom config

```sh
 git clone https://github.com/nikitabugrovsky/nvim-mini.git ~/.config/nvim-mini
 ```
### Add Neovim custom config folder & aliases to `.zshrc` or `.bashrc`

 ```sh
 export NVIM_APPNAME="nvim-mini"
 alias vim="$(which nvim)"
 alias vi="$(which nvim)"
 ```
### Check Neovim Health

```vim
:checkhealth
 ```
