# 利用前の準備

## Wezterm 用の設定ファイル

※ [Wezterm](https://wezterm.org/index.html) で使用する場合の設定
※ フォントは [HackGen#HackGen_NF_vx.xx.xx.zip](https://github.com/yuru7/HackGen/releases) を指定している

### windows + WSL

powershell 上で実行.

```
% wsl -l -v
  NAME            STATE           VERSION
* Ubuntu-24.04    Running         2
```

NAME に表示された文字列を dotfiles/wezterm.lua の下記に設定する.

```lua
    config.default_domain = 'WSL:Ubuntu-24.04'
```

wezterm.lua を下記にリネームして配置する.

```bash
C:\Users\（ユーザー名）\.wezterm.lua
```

### mac

```bash
# ~/.wezterm.lua を配置する
% cd ~/
% ln -s /path/to/my-vimrc/neovim/dotfiles/wezterm.lua ./.wezterm.lua
```

## nvim 用の設定ファイル

### ドットファイルのシンボリックリンクを作成する

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

### 各種設定ファイルのディレクトリのシンボリックリンクを作成する

```bash
#
# ( 上記に続けて行うので作業ディレクトリは `~/.config/nvim` のまま )
# ~/.config/nvim に設定ファイルのシンボリックリンクを作成
#
% ln -s /path/to/my-vimrc/neovim/lua

# ~/.config/nvim にlua のフォーマット設定ファイルに対するシンボリックリンクを作成
% ln -s /path/to/my-vimrc/neovim/dotfiles/stylua.toml ./.stylua.toml
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

**便利な使い方\***

- コードの改善依頼
  - 適当な関数をビジュアルモード（v）で選択して `:CopilotChatOptimize` を実行すると、リファクタリング案が日本語で返ってくる
- コミットメッセージの生成
  - Git で変更がある時に `:CopilotChatCommit` を打つと、変更内容を読み取ってコミットメッセージのドラフトを作ってくれる
- ストップウォッチ/タイマーの作成 (例):
  - 「Go 言語で 5 分のタイマーを作るコードを書いて」のようにチャットに投げるとコードが生成され、それをそのままエディタに貼り付けられる

### Lspsaga キーマップ機能解説一覧

| カテゴリ      | キー  | コマンド                  | 具体的な挙動・効果                                                                                                                  |
| :------------ | :---- | :------------------------ | :---------------------------------------------------------------------------------------------------------------------------------- |
| **検索/定義** | `gh`  | `lsp_finder`              | **最強の検索窓。** 定義元と参照先（使われている場所）を同時にリストアップし、プレビューしながら移動先を探せます。                   |
|               | `gd`  | `goto_definition`         | **定義ジャンプ。** 関数や変数が作られた本体へ直接ジャンプします（ファイルが切り替わります）。                                       |
|               | `gp`  | `peek_definition`         | **定義のチラ見。** 今の場所を離れず、浮遊ウィンドウで定義の中身を確認できます。少し確認したいだけの時に便利。                       |
|               | `gt`  | `goto_type_definition`    | **型の定義へ。** クラスやインターフェースそのものの定義場所に飛びます。                                                             |
|               | `C-o` | `jump backward`           | **「古い」ジャンプ先へ戻る。** ブラウザの「戻る」ボタンのように、以前カーソルがいた場所（ジャンプリスト内の過去の地点）へ戻ります。 |
| **編集**      | `ga`  | `code_action`             | **クイックフィックス。** エラー修正、不足インポートの自動追加、リファクタリングのメニューを表示します。                             |
|               | `gr`  | `rename`                  | **一括置換。** 変数名を変えると、プロジェクト内の全ファイルで矛盾が出ないように名前を一気に書き換えます。                           |
| **診断**      | `sc`  | `show_cursor_diagnostics` | **今の場所のエラー詳細。** カーソル位置のエラー内容を小さな窓で表示します。                                                         |
|               | `sb`  | `show_buf_diagnostics`    | **ファイル全体のエラー。** 今開いているファイル内の警告やエラーを一覧表示します。                                                   |
|               | `[e`  | `diagnostic_jump_prev`    | **前のエラーへ。** 前にある問題箇所へカーソルを飛ばします。                                                                         |
|               | `]e`  | `diagnostic_jump_next`    | **次のエラーへ。** 後ろにある問題箇所へカーソルを飛ばします。                                                                       |
| **情報/構造** | `K`   | `hover_doc`               | **説明書を表示。** 関数の使い方、型情報、ドキュメントコメントをポップアップで見られます。                                           |
|               | `to`  | `outline`                 | **目次表示。** 画面右側にファイル内の関数や変数の構造を一覧表示し、全体像を把握しやすくします。                                     |
|               | `ci`  | `incoming_calls`          | **呼び出し元。** 今の関数を「使っている」側のコードをリストアップします。                                                           |
|               | `co`  | `outgoing_calls`          | **呼び出し先。** 今の関数が「使っている」内部の関数をリストアップします。                                                           |
