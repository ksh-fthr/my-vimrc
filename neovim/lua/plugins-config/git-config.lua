-- ##############################################
-- Git 関連 (lua/plugins-config/git-config.lua)
-- ##############################################
local status_gitsigns, gitsigns = pcall(require, "gitsigns")
if status_gitsigns then
  gitsigns.setup({})
end

local status_git, git = pcall(require, "git")
if not status_git then return end

git.setup({
  keymaps = {
    -- 既存のキーマップを完全保持
    blame = "<Leader>gb",
    browse = "<Leader>go",
  }
})
