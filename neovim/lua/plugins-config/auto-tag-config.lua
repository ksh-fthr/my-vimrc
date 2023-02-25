-- ##############################################
-- Autotag と Autopair
-- ##############################################
-- タグを素早く閉じたい
local status, autotag = pcall(require, "nvim-ts-autotag")
if (not status) then return end

autotag.setup({})

-- ブラケットを閉じる
local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

