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

## 各種プラグインをインストール
本リポジトリの構成では [packer](https://github.com/wbthomason/packer.nvim) でプラグイン管理を行っているので、次のコマンドを実行して各プラグインをインストールする。


```bash
# nvim 起動後下記を実行する
:PackerInstall
```


## 各種プラグインを使うための準備
Lsp や Treesitter を導入しているので、それらを使用するための準備として下記を実行する。

### Mason を実行して各言語の Lsp をインストール

```bash
# nvim 起動後下記を実行してリストから任意の Lsp をインストールする
:Mason
```

### TSInstall を実行して各言語のシンタックスハイライト等を整える
例)
typescript のための準備

```bash
# nvim 起動後下記を実行してリストから任意の Lsp をインストールする
:TSInstall typescript
```

### エラーメッセージに応じて適宜環境を整える
例)
typescript のための準備

```bash
% npm install -g typescript typescript-language-server
```

### prettier をインストールする
neovim を起動して次のエラーがでたら...

```text
[prettier.vim] prettierd not found Did you forget to install it
```

下記を実行して prettierd をインストールする。

```bash
% sudo npm install -g @fsouza/prettierd
```
