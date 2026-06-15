local util = require 'aznath.lsp.utils'

return {
    name = 'csharp_ls',
    config = {
        cmd = function(dispatchers, config)
            return vim.lsp.rpc.start({ 'csharp-ls' }, dispatchers, {
                cwd = config.cmd_cwd or config.root_dir,
                env = config.cmd_env,
                detached = config.detached,
            })
        end,
        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(util.root_pattern '*.sln' (fname) or util.root_pattern '*.slnx' (fname) or
            util.root_pattern '*.csproj' (fname))
        end,
        filetypes = { 'cs' },
        init_options = {
            AutomaticWorkspaceInit = true,
        },
        get_language_id = function(_, ft)
            if ft == 'cs' then
                return 'csharp'
            end
            return ft
        end,
    },
}
