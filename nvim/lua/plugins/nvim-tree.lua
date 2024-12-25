return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- Recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

	-- enable 24-bit colour
	vim.opt.termguicolors = true 

        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {
                width = 30,
                adaptive_size = false,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        bookmark = "󰆤",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
	    filters = {
                dotfiles = false,  -- Show hidden files
                custom = { "^.git$" },  -- Hide .git folder
            },
            git = {
                enable = true,
                ignore = false,
            },
            actions = {
                open_file = {
                    quit_on_open = false,  -- Don't close tree when opening a file
                    resize_window = true,  -- Resize tree when opening a file
                },
            },
            filesystem_watchers = {
                enable = true,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
        })

        -- Keymaps
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer', silent = true })
        vim.keymap.set('n', '<leader>fe', ':NvimTreeFocus<CR>', { desc = 'Focus file explorer', silent = true })

        -- Auto close
        vim.api.nvim_create_autocmd("BufEnter", {
            nested = true,
            callback = function()
                if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
                    vim.cmd "quit"
                end
            end
        })
    end,
}
