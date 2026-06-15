return {
	"thePrimeagen/harpoon",
	enabled = true,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		-- local conf = require("telescope.config").values

		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		-- NOTE: Experimenting
		-- Telescope into Harpoon function
		-- local function toggle_telescope(harpoon_files)
		-- 	local file_paths = {}
		-- 	for _, item in ipairs(harpoon_files.items) do
		-- 		table.insert(file_paths, item.value)
		-- 	end
		-- 	require("telescope.pickers")
		-- 		.new({}, {
		-- 			prompt_title = "Harpoon",
		-- 			finder = require("telescope.finders").new_table({
		-- 				results = file_paths,
		-- 			}),
		-- 			previewer = conf.file_previewer({}),
		-- 			sorter = conf.generic_sorter({}),
		-- 		})
		-- 		:find()
		-- end

		--Harpoon Nav Interface
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Mark file with Harpoon" })
		vim.keymap.set("n", "<C-\\>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })

		--Harpoon marked files
		vim.keymap.set("n", "<C-q>", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon mark 1" })
		vim.keymap.set("n", "<C-w>", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon mark 2" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon mark 3" })
		vim.keymap.set("n", "<C-r>", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon mark 4" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end, { desc = "Harpoon previous" })
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end, { desc = "Harpoon next" })

		-- Telescope inside Harpoon Window
		-- vim.keymap.set("n", "<C-f>", function()
		-- 	toggle_telescope(harpoon:list())
		-- end)
	end,
}
