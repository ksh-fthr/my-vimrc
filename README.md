# これはなにか?
vim の個人用設定ファイル.

# 利用前の準備
home ディレクトリで下記を実施して各ファイルのシンボリックリンクを作成する.

```bash
#
# /path/to/my_vimrc はリポジトリルートへの path
#

# 各種 dotfiles のシンボリックリンク
% ln -s /path/to/my-vimrc/vimrc .vimrc
% ln -s /path/to/my-vimrc/gvimrc .gvimrc
% ln -s /path/to/my-vimrc/script/keymapping.vim .keymapping.vim

# vim-theme のシンボリックリンク
% ln -s /path/to/my-vimrc/colors/throne.vim throne.vim
% ln -s /path/to/my-vimrc/colors/zabanya.vim zabanya.vim
```

