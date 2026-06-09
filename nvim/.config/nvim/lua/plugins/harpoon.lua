return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim" 
  },

  -- We don't need a heavy config function because we put the logic in the keys
  config = function()
    require("harpoon"):setup()
  end,

  keys = {
    -- 1. ADD FILE
    { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },

    -- 2. REMOVE FILE (Your request)
    { "<leader>hr", function() require("harpoon"):list():remove() end, desc = "Harpoon Remove File" },

    -- 3. OPEN MENU (TELESCOPE)
    -- We put the logic here so it loads when you press <C-e>
    { "<C-e>", function()
        local harpoon = require("harpoon")
        local conf = require("telescope.config").values
        
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end, desc = "Open Harpoon (Telescope)" },

    -- 4. NAVIGATION
    -- Replaced <C-1> with <leader>1 to avoid terminal issues
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
    -- 5. CLEAR ALL (The nuclear option)
    { "<leader>hc", function() 
        local harpoon = require("harpoon")
        harpoon:list():clear() 
    end, desc = "Harpoon Clear All" },
    -- Replaced ]b with <leader>hn (Harpoon Next) to avoid NvChad conflict
    { "<leader>hn", function() require("harpoon"):list():next() end, desc = "Harpoon Next" },
    { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "Harpoon Prev" },
  },
}
