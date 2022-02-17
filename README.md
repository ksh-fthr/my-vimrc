# これはなにか?
vim の個人用設定ファイル.

# 利用前の準備
home ディレクトリで下記を実施して各ファイルのシンボリックリンクを作成する.

```bash
#
# /path/to/my_vimrc はリポジトリルートへの path
#

#
# 各種 dotfiles のシンボリックリンク
#
# vimrc, gvimrc
% ln -s /path/to/my-vimrc/vimrc .vimrc
% ln -s /path/to/my-vimrc/gvimrc .gvimrc

# キーマッピング
% ln -s /path/to/my-vimrc/keymapping/keymapping.vim .keymapping.vim

# プラグインの設定
% ln -s /path/to/my-vimrc/plugin-settings/fern-vim-settings.vim .fern-vim-settings.vim
% ln -s /path/to/my-vimrc/plugin-settings/vim-airline-settings.vim .vim-airline-settings.vim
% ln -s /path/to/my-vimrc/plugin-settings/vesession-settings.vim .vesession-settings.vim

# プラグイン以外の設定
% ln -s /path/to/my-vimrc/my-settings/buffer-close-settings.vim .buffer-close-settings.vim

# vim-theme のシンボリックリンク
% ln -s /path/to/my-vimrc/colors/throne.vim throne.vim
% ln -s /path/to/my-vimrc/colors/zabanya.vim zabanya.vim
```

