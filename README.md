# これはなにか?
vim の個人用設定ファイル.

# 利用前の準備
## vim-plug を導入する
[公式](https://github.com/junegunn/vim-plug) の手順にそって `vim-plug` を導入する.


## ドットファイルのシンボリックリンクを作成する
home ディレクトリで下記を実施して各ファイルのシンボリックリンクを作成する.

```bash
#
# /path/to/my_vimrc はリポジトリルートへの path
#

#
# 各種設定 のシンボリックリンク
#
# vimrc, gvimrc
% ln -s /path/to/my-vimrc/vimrc .vimrc
% ln -s /path/to/my-vimrc/gvimrc .gvimrc


# キーマップやプラグインの設定
# home フォルダの .vim/ に設定用のディレクトリを作成して移動する
% mkdir -p ~/.vim/settings
% cd ~/.vim/settings/

% ln -s /path/to/my-vimrc/settings/keymapping # キーマッピング
% ln -s /path/to/my-vimrc/settings/plugin     # プラグインの設定
% ln -s /path/to/my-vimrc/settings/one        # プラグイン以外の設定
 

# vim-theme のシンボリックリンク]
cd ~/.vim/colors
% ln -s /path/to/my-vimrc/settings/colors/throne.vim throne.vim
% ln -s /path/to/my-vimrc/settings/colors/zabanya.vim zabanya.vim
```

## 各プラグインをインストールする
`vim` を起動して `PlugInstall` を実行する.

