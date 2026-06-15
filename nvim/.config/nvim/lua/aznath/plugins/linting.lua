return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		lint.linters_by_ft = {
			javascript = {"biomejs"},
			typescript = {"biomejs"},
			javascriptreact = {"biomejs"},
			typescriptreact = {"biomejs"},
			svelte = { "biomejs" },
			python = { "pylint" },
		}

		-- Use venv's pylint if available; otherwise add --init-hook so
		-- the system pylint can resolve packages from the venv.
		local default_pylint = lint.linters.pylint
		lint.linters.pylint = vim.tbl_deep_extend("force", default_pylint or {}, {
			cmd = function()
				local venv_root = require("aznath.python_venv").find_venv_root(vim.api.nvim_get_current_buf())
				if venv_root then
					local pylint_path = venv_root .. "/bin/pylint"
					if vim.fn.filereadable(pylint_path) == 1 then
						return pylint_path
					end
				end
				return "pylint"
			end,
			args = function()
				local bufnr = vim.api.nvim_get_current_buf()
				local args = {
					"--from-stdin",
					vim.api.nvim_buf_get_name(bufnr),
					"-f", "json",
				}
				local venv = require("aznath.python_venv")
				local venv_root = venv.find_venv_root(bufnr)
				if venv_root then
					local sp = venv.find_site_packages(venv_root)
					if sp then
						local hook = 'import sys; sys.path.insert(0, "' .. sp .. '")'
						table.insert(args, 1, "--init-hook=" .. hook)
					end
				end
				return args
			end,
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
