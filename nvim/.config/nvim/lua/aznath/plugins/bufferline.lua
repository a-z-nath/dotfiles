return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				diagnostics_indicator = function(_, _, diag)
					local icons = { error = " ", warn = " ", info = " " }
					local ret = {}
					if diag.error then
						ret[#ret + 1] = icons.error .. diag.error
					end
					if diag.warning then
						ret[#ret + 1] = icons.warn .. diag.warning
					end
					return table.concat(ret, " ")
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
					},
				},
			},
		})

		vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
		vim.keymap.set("n", "<leader>fr", function()
			require("snacks").picker.buffers()
		end, { desc = "Find open buffers" })
		vim.keymap.set("n", "<leader>bc", function()
			require("snacks").bufdelete()
		end, { desc = "Close current buffer" })
		vim.keymap.set("n", "<leader>ba", function()
			local current = vim.api.nvim_get_current_buf()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
					vim.api.nvim_buf_delete(buf, { force = false })
				end
			end
		end, { desc = "Close all other buffers" })

		vim.keymap.set("n", "<leader>bs", function()
			local current = vim.api.nvim_get_current_buf()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local is_modified = vim.api.nvim_get_option_value("modified", { buf = buf })
				if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and not is_modified then
					vim.api.nvim_buf_delete(buf, { force = false })
				end
			end
		end, { desc = "Close saved buffers" })

		vim.keymap.set("n", "<leader>bx", function()
			local current = vim.api.nvim_get_current_buf()
			local is_modified = vim.api.nvim_get_option_value("modified", { buf = current })
			vim.api.nvim_buf_delete(current, { force = false })
		end, { desc = "Close current buffer" })
	end,
}
