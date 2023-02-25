# 利用前の準備
## ドットファイルのシンボリックリンクを作成する

```bash
#
# ~/.config に nvim ディレクトクトリを作成 & 移動
#
% cd ~/.config
% mkdir nvim
% cd nvim

#
# /path/to/my_vimrc はリポジトリルートへの path
#

#
# init.lua のシンボリックリンク
#
% ln -s /path/to/my-vimrc/neovim/init.lua
```

## 各種設定ファイルのディレクトリのシンボリックリンクを作成する

```bash
#
# ( 上記に続けて行うので作業ディレクトリは `~/.config/nvim` のまま )
# ~/.config/nvim に設定ファイルのシンボリックリンクを作成
#
% ln -s /path/to/my-vimrc/neovim/lua
```
