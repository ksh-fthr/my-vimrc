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
本リポジトリの構成では [lazy.nvim](https://github.com/folke/lazy.nvim) でプラグイン管理を行っているので、次のコマンドを実行して各プラグインをインストールする。


```bash
# nvim 起動後下記を実行する
:Lazy sync
```


## 各種プラグインを使うための準備
Lsp や Treesitter を導入しているので、それらを使用するための準備として下記を実行する。

### Mason を実行して各言語の Lsp / Linter / Formatter をインストール

```bash
# nvim 起動後下記を実行してリストから任意の Lsp をインストールする
:Mason
```

**参考: 2024/04現在入れているモノ**
```text
  Installed
    ◍ typescript-language-server
    ◍ tailwindcss-language-server
    ◍ eslint_d
    ◍ glint
    ◍ gofumpt
    ◍ goimports
    ◍ golangci-lint
    ◍ golangci-lint-langserver
    ◍ golines
    ◍ gopls
    ◍ html-lsp
    ◍ htmlhint
    ◍ json-lsp
    ◍ prettier
    ◍ quick-lint-js
    ◍ svelte-language-server
    ◍ vue-language-server
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

下記を実行して `prettierd` をインストールする。

```bash
% sudo npm install -g @fsouza/prettierd
```

### ripgrep のインストール

`Telescope live_grep` で `grep` を実現させている｡
そのために `ripgrep` が必要なので下記でインストールしておく｡

```bash
% brew install ripgrep
```


## Copilot との連携

### Copilot 認証 

```vim
:Copilot auth
```

### 補完

```vim
Ctrl-n / Ctrl-p
```

### Copilot Chat

```vim
:CopilotChatOpen: チャットウィンドウを右側に開きます。
:CopilotChatExplain: 視覚的に選択（Visual Mode）しているコードの解説を求めます。
:CopilotChatOptimize: 選択したコードの最適化を提案させます。
:CopilotChatModels: 使用するAIモデル（GPT-4oなど）を切り替えられます。
```

**便利な使い方***

- コードの改善依頼
  - 適当な関数をビジュアルモード（v）で選択して `:CopilotChatOptimize` を実行すると、リファクタリング案が日本語で返ってくる
- コミットメッセージの生成
  - Git で変更がある時に `:CopilotChatCommit` を打つと、変更内容を読み取ってコミットメッセージのドラフトを作ってくれる
- ストップウォッチ/タイマーの作成 (例):
  - 「Go 言語で 5 分のタイマーを作るコードを書いて」のようにチャットに投げるとコードが生成され、それをそのままエディタに貼り付けられる
  