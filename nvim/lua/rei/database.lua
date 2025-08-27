-- call db, dump result into RAM, open result in another buffer, nowrap. Look nice as hell
-- depend on cmd installed in local machine
vim.keymap.set('v', '<leader>db', ':w !db | csvlook > /tmp/db.txt 2>&1<CR>:e /tmp/db.txt<CR>:setlocal nowrap<CR>', opts)
