-- ##############################################
-- Telescope (lua/plugins-config/telescope-config.lua)
-- ##############################################
local status, telescope = pcall(require, "telescope")
if not status then return end

local actions = require('telescope.actions')

-- file_browser 拡張が存在するか安全に確認
local fb_actions = nil
local fb_ok, fb_mod = pcall(require, "telescope._extensions.file_browser.actions")
if fb_ok then fb_actions = fb_mod end

telescope.setup {
  defaults = {
    preview = {
      treesitter = false, -- treesitter プレビューを無効化( 安定性向上 )
    },
    mappings = {
      n = { ["q"] = actions.close },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = { ["<C-w>"] = function() vim.cmd('normal vbd') end },
        ["n"] = {
          ["N"] = function(prompt_bufnr) if fb_actions then fb_actions.create(prompt_bufnr) end end,
          ["h"] = function(prompt_bufnr) if fb_actions then fb_actions.goto_parent_dir(prompt_bufnr) end end,
          ["/"] = function() vim.cmd('startinsert') end,
        },
      },
    },
  },
}

pcall(telescope.load_extension, "file_browser")

-- 既存の "sf" マッピングを完全保持
vim.keymap.set("n", "sf", function()
  if telescope.extensions.file_browser then
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      cwd = vim.fn.expand('%:p:h'),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
      layout_config = { height = 40 }
    })
  end
end)
