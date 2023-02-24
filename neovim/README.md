# 利用前の準備
## ドットファイルのシンボリックリンクを作成する
下記を実施して各ファイルのシンボリックリンクを作成します。

```bash
# ~/.config に nvim ディレクトクトリを作成 & 移動
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

