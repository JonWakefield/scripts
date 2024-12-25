return {
	{
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup()
	end
	},
	{
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",

	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = { 
				"lua_ls",
				"pyright",
				"gopls",
				"tsserver",
			}
		})
		-- LSP Keybindings
            	local on_attach = function(client, bufnr)
                	local bufopts = { noremap=true, silent=true, buffer=bufnr }
                	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        	        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
                	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        	        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
            	end
		local capabilities = require('cmp_nvim_lsp').default_capabilities()	
		-- Individual LSP server configurations
            	require("mason-lspconfig").setup_handlers {
                -- Default handler for all servers
                function (server_name)
                    require("lspconfig")[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                end,
                
                -- Custom configurations for specific servers
                ["pyright"] = function()
                    require("lspconfig").pyright.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                }
                            }
                        }
                    }
                end,
                
                ["gopls"] = function()
                    require("lspconfig").gopls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                },
                                staticcheck = true,
                            }
                        }
                    }
                end,
                
                ["tsserver"] = function()
                    require("lspconfig").tsserver.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
                    }
                end
            }
        end
	},
	-- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end
    },
	-- Provides UI for LSP
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup()
            
            -- Trouble keymaps
            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
            vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
            vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
        end
    },
	{
	"neovim/nvim-lspconfig",
	
	config = function()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({})
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
	end
	},
}
