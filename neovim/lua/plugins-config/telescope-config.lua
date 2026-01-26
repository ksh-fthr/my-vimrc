-- ##############################################
-- Telescope Config
-- ##############################################

local status, telescope = pcall(require, "telescope")
if not status then return end

local actions = require('telescope.actions')

-- file_browser のアクションを安全に取得するための関数
local function get_fb_actions()
  local fb_status, fb = pcall(require, "telescope._extensions.file_browser.actions")
  if fb_status then
    return fb
  end
  return nil
end

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

-- 初期設定
telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- netrw を無効化して telescope-file-browser を使用
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- fb_actions が利用可能な場合のみマッピングを設定
          ["N"] = function(prompt_bufnr)
            local fb_actions = get_fb_actions()
            if fb_actions then fb_actions.create(prompt_bufnr) end
          end,
          ["h"] = function(prompt_bufnr)
            local fb_actions = get_fb_actions()
            if fb_actions then fb_actions.goto_parent_dir(prompt_bufnr) end
          end,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

-- 拡張機能のロード
pcall(telescope.load_extension, "file_browser")

-- キーマッピング
vim.keymap.set("n", "sf", function()
  -- telescope.extensions.file_browser が存在するか確認して実行
  local ok, fb = pcall(function() return telescope.extensions.file_browser.file_browser end)
  if ok then
    fb({
      path = "%:p:h",
      cwd = telescope_buffer_dir(),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
      layout_config = { height = 40 }
    })
  else
    print("Telescope file_browser extension is not loaded yet.")
  end
end)
