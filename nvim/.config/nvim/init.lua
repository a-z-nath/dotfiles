vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require("aznath.core")
require("aznath.lazy")

-- load base46 cached highlights
pcall(function()
    local cache_dir = vim.g.base46_cache
    if vim.fn.isdirectory(cache_dir) == 1 then
        for _, v in ipairs(vim.fn.readdir(cache_dir)) do
            dofile(cache_dir .. v)
        end
    end
end)
require("current-theme")
