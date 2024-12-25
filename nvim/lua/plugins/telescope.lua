return {
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.8',
	dependencies = { 
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
		},
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
        	local telescope = require('telescope')
        	local actions = require('telescope.actions')

        	telescope.setup({
            	defaults = {
                	path_display = { truncate = 3 },
                	mappings = {
                    	i = {
                        	['<C-k>'] = actions.move_selection_previous,
	                        ['<C-j>'] = actions.move_selection_next,
	                        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        	                ['<Esc>'] = actions.close,
                	    },
                	},
	                file_ignore_patterns = {
        	            "node_modules",
                	    ".git/",
	                    ".cache",
	                    "%.o",
        	            "%.a",
                	    "%.out",
	                    "%.class",
        	            "%.pdf",
                	    "%.mkv",
	                    "%.mp4",
        	            "%.zip",
                	},
	                layout_config = {
        	            horizontal = {
                	        preview_width = 0.6,
	                    },
        	        },
	            },
		    pickers = {
	                find_files = {
        	            hidden = true,
                	},
	                live_grep = {
        	            additional_args = function()
                	        return { "--hidden" }
	                    end
        	        },
	            },
        	    extensions = {
	                fzf = {
        	            fuzzy = true,
                	    override_generic_sorter = true,
	                    override_file_sorter = true,
        	            case_mode = "smart_case",
	                }
        	    }
	        })
	
	        -- Load extensions
        	telescope.load_extension('fzf')

	        -- Keymaps
	        local builtin = require('telescope.builtin')
        	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
	        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
	        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
        	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
	        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
        	vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Find word under cursor' })
	        vim.keymap.set('n', '<leader>/', function()
        	    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
	                winblend = 10,
        	        previewer = false,
	            })
        	end, { desc = 'Fuzzy search in current buffer' })
	    end,
}
