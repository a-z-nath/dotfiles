local function set_python_path(command)
    local path = command.args
    local clients = vim.lsp.get_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = "pyright",
    }
    for _, client in ipairs(clients) do
        if client.settings then
            client.settings.python = vim.tbl_deep_extend(
                "force",
                client.settings.python,
                { pythonPath = path }
            )
        else
            client.config.settings = vim.tbl_deep_extend(
                "force",
                client.config.settings,
                { python = { pythonPath = path } }
            )
        end
        client:notify("workspace/didChangeConfiguration", { settings = nil })
    end
end

return {
    name = "pyright",
    config = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
            "pyrightconfig.json",
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            ".git",
        },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "openFilesOnly",
                },
            },
        },
        on_attach = function(client, bufnr)
            local venv = require "aznath.python_venv"

            local venv_root, venv_owner_dir = venv.find_venv_root(bufnr)
            local sp = venv_root and venv.find_site_packages(venv_root)
            local git_root = venv.find_project_root(bufnr)
            local python_root = venv_owner_dir or git_root
            local venv_name = venv_root and vim.fn.fnamemodify(venv_root, ":t") or nil

            local extra_paths = {}
            if python_root then
                extra_paths = venv.collect_extra_paths(python_root, sp)
            elseif sp then
                extra_paths = { sp }
            end

            client.settings.python = vim.tbl_deep_extend("force", client.settings.python, {
                venvPath = python_root,
                venv = venv_name,
                extraPaths = extra_paths,
                analysis = {
                    typeCheckingMode = "basic",
                    autoImportCompletions = true,
                    diagnosticMode = "workspace",
                    extraPaths = extra_paths,
                },
            })
            client:notify("workspace/didChangeConfiguration", { settings = nil })

            vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
                local params = {
                    command = "pyright.organizeimports",
                    arguments = { vim.uri_from_bufnr(bufnr) },
                }
                client:request("workspace/executeCommand", params, nil, bufnr)
            end, { desc = "Organize Imports" })

            vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
                desc = "Reconfigure pyright with the provided python path",
                nargs = 1,
                complete = "file",
            })
        end,
    },
}
