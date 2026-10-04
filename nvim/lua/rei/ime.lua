local fcitx_group = vim.api.nvim_create_augroup("FcitxToggle", { clear = true })
local ime_state = 1 -- 1: inactive/direct, 2: active

-- Save IME state and disable it when leaving Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = fcitx_group,
  callback = function()
    -- fcitx5-remote returns 1 (inactive) or 2 (active)
    ime_state = tonumber(vim.fn.system("fcitx5-remote")) or 1
    if ime_state == 2 then
      vim.fn.system("fcitx5-remote -c") -- Close/deactivate IME
    end
  end,
})

-- Restore IME state when entering Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = fcitx_group,
  callback = function()
    if ime_state == 2 then
      vim.fn.system("fcitx5-remote -o") -- Open/activate IME
    end
  end,
})
