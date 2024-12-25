vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.opt.number = true
vim.opt.relativenumber = true

-- File operations
vim.keymap.set('n', '<leader>fn', ':enew<CR>', { desc = 'New file', silent = true })
vim.keymap.set('n', '<leader>fw', ':write<CR>', { desc = 'Save file', silent = true })
vim.keymap.set('n', '<leader>fs', ':write<CR>', { desc = 'Save file', silent = true })

-- Create new file in splits
vim.keymap.set('n', '<leader>fv', ':vnew<CR>', { desc = 'New file in vertical split', silent = true })
vim.keymap.set('n', '<leader>fh', ':new<CR>', { desc = 'New file in horizontal split', silent = true })

-- Quick save
vim.keymap.set('n', '<C-s>', ':write<CR>', { desc = 'Save file', silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:write<CR>a', { desc = 'Save file', silent = true })

-- Create new file relative to current file's path
vim.keymap.set('n', '<leader>fnr', function()
    local current_file = vim.fn.expand('%:p')
    local current_dir = vim.fn.fnamemodify(current_file, ':h')
    
    -- If we're not in a file, use the current working directory
    if current_file == '' then
        current_dir = vim.fn.getcwd()
    end
    
    -- Prompt for the new file path
    local input = vim.fn.input({
        prompt = 'New file: ' .. current_dir .. '/',
        completion = 'file'
    })
    
    if input == '' then
        return
    end
    
    -- Create full path
    local full_path = current_dir .. '/' .. input
    
    -- Create directory if it doesn't exist
    local dir = vim.fn.fnamemodify(full_path, ':h')
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, 'p')
    end
    
    -- Edit the new file
    vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
end, { desc = 'Create new file relative to current', silent = true })
