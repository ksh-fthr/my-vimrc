# 利用前の準備
## vim-plug を導入する
[公式](https://github.com/junegunn/vim-plug) の手順にそって `vim-plug` を導入します。


## ドットファイルのシンボリックリンクを作成する
home ディレクトリで下記を実施して各ファイルのシンボリックリンクを作成します。

```bash
#
# /path/to/my_vimrc はリポジトリルートへの path
#

#
# 各種設定 のシンボリックリンク
#
# vimrc, gvimrc
% ln -s /path/to/my-vimrc/vim/vimrc .vimrc
% ln -s /path/to/my-vimrc/vim/gvimrc .gvimrc

#
# キーマップやプラグインの設定
# home フォルダの .vim/ に設定用のディレクトリを作成して移動する
% mkdir -p ~/.vim/settings
% cd ~/.vim/settings/

% ln -s /path/to/my-vimrc/vim/settings/keymapping       # キーマッピング
% ln -s /path/to/my-vimrc/vim/settings/plugin           # プラグインの設定
% ln -s /path/to/my-vimrc/vim/settings/one              # プラグイン以外の設定
% ln -s /path/to/my-vimrc/vim/settings/program-language # プログラム言語の設定

#
# vim-theme のシンボリックリンク]
cd ~/.vim/colors
% ln -s /path/to/my-vimrc/vim/settings/colors/throne.vim throne.vim
% ln -s /path/to/my-vimrc/vim/settings/colors/zabanya.vim zabanya.vim
```

## neovim のための準備
vim の設定と neovim の設定を共用したい場合の設定です。
次のコマンドを実行して .vimrc や .vim 配下の内容を neovim からも参照できるようにします。

```bash
#
# 出力先のドットファイルは環境にあわせて変更する
% echo "export XDG_CONFIG_HOME=~/.config" >> ~/.zshrc
% mkdir -p ~/.config
#
# vim の設定を参照する
% ln -s ~/.vim ~/.config/nvim
% ln -s ~/.vimrc ~/.config/nvim/init.vim
```

## 各プラグインをインストールする
`vim/neovim を起動して `PlugInstall` を実行します。

