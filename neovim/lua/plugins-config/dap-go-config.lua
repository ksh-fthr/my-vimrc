-- ##########################################
-- lua/plugins-config/dap-go-config.lua
-- Go デバッグ設定( Delve )
-- ##########################################
local dap_go = require("dap-go")

dap_go.setup({
  -- delve の設定
  delve = {
    path = "dlv",                -- delve 実行ファイルのパス
    initialize_timeout_sec = 20, -- delve 初期化のタイムアウト秒数
    port = "${port}",            -- ポート番号 (デフォルトは自動割り当て)
    args = {},                   -- delve に渡す追加の引数
    build_flags = "",            -- ビルドフラグ (必要に応じて設定)
    detached = true,             -- デタッチモード (true にするとデバッグセッション終了後もプロセスが継続)
  },
  -- デバッグテストの設定
  dap_configurations = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}", -- 現在のファイルをデバッグ
    },
    {
      type = "go",
      name = "Debug Test",
      request = "launch",
      mode = "test",                        -- テストモード
      program = "./${relativeFileDirname}", -- 現在のファイルのディレクトリをデバッグ
    },
    {
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    }
  },
})

-- キーマップ追加
vim.keymap.set("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "Debug Go Test" })

vim.keymap.set("n", "<leader>dgl", function()
  require("dap-go").debug_last_test()
end, { desc = "Debug Last Go Test" })
