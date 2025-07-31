-- NeoVim 12.0 --
-- Default opts --
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.swapfile = false
vim.g.mapleader = " "
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.signcolumn = "yes"
vim.o.winborder = "rounded"

-- Plugins --
vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/kiddos/gemini.nvim" },
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
})

require("mini.pick").setup({})

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_insalled = { "bash", "python", "go", "lua", "make" },
	highlight = { enable = true },
	auto_install = true,
})

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

local api = require("gemini.api")
require("gemini").setup({
	model_config = {
		model_id = api.MODELS.GEMINI_2_5_PRO,
	}
})

-- Native Code Completion --
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

-- Prevent the completion menu from automatically selecting the first item --
vim.cmd("set completeopt+=noselect")

-- Key mappings --
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>s", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- LSP --
-- Needed when init.lua is in nonstandard location --
require("lspconfig").lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
		 		version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require"
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

require("lspconfig").bashls.setup {
    settings = {
        bashls = {
            formatCommand = "shfmt",
            formatArguments = { "-i", "2", "-s" },
        }
    }
}

vim.lsp.enable({ "bashls", "pyright", "gopls", "lua_ls" })

-- Color Theme --
vim.cmd(":colorscheme gruvbox")
vim.cmd(":hi statusline guibg=None")
