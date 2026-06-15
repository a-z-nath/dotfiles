local lsp = vim.lsp

local M = { path = {} }

M.default_config = {
    log_level = lsp.protocol.MessageType.Warning,
    message_level = lsp.protocol.MessageType.Warning,
    settings = vim.empty_dict(),
    init_options = vim.empty_dict(),
    handlers = {},
    autostart = true,
    capabilities = lsp.protocol.make_client_capabilities(),
}

M.on_setup = nil

local function escape_wildcards(path)
    return path:gsub('([%[%]%?%*])', '\\%1')
end

function M.root_pattern(...)
    local patterns = vim.iter({ ... }):flatten(math.huge):totable()
    return function(startpath)
        startpath = M.strip_archive_subpath(startpath)
        for _, pattern in ipairs(patterns) do
            local match = M.search_ancestors(startpath, function(path)
                for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true)) do
                    if vim.uv.fs_stat(p) then
                        return path
                    end
                end
            end)
            if match then
                local real = vim.uv.fs_realpath(match)
                return real or match
            end
        end
    end
end

function M.search_ancestors(startpath, fn)
    if fn(startpath) then
        return startpath
    end
    for path in vim.fs.parents(startpath) do
        if fn(path) then
            return path
        end
    end
end

function M.root_markers_with_field(root_files, new_names, field, fname, match_mode)
    local path = vim.fn.fnamemodify(fname, ':h')
    local found = vim.fs.find(new_names, { path = path, upward = true, type = 'file' })
    local fields = type(field) == 'string' and { field } or field
    local matcher = (match_mode or 'any') == 'any'
        and function(line)
            return vim.iter(fields):any(function(s)
                return line:find(s)
            end)
        end
        or function(line)
            local remaining = vim.iter(fields):filter(function(s)
                return not line:find(s)
            end):totable()
            if #remaining == 0 then
                return true
            end
            return false
        end
    for _, f in ipairs(found or {}) do
        local file = assert(io.open(f, 'r'))
        for line in file:lines() do
            if matcher(line) then
                root_files[#root_files + 1] = vim.fs.basename(f)
                break
            end
        end
        file:close()
    end
    return root_files
end

function M.insert_package_json(root_files, field, fname)
    return M.root_markers_with_field(root_files, { 'package.json', 'package.json5' }, field, fname)
end

function M.strip_archive_subpath(path)
    path = path:gsub('zipfile://(.-)::[^\\].*$', '%1')
    path = path:gsub('tarfile:(.-)::.*$', '%1')
    return path
end

function M.get_typescript_server_path(root_dir)
    local project_roots = vim.fs.find('node_modules', { path = root_dir, upward = true, limit = math.huge })
    for _, project_root in ipairs(project_roots) do
        local typescript_path = project_root .. '/typescript'
        local stat = vim.uv.fs_stat(typescript_path)
        if stat and stat.type == 'directory' then
            return typescript_path .. '/lib'
        end
    end
    return ''
end

function M.path.is_descendant(root, path)
    if not path then
        return false
    end
    for parent in vim.fs.parents(path) do
        if parent == root then
            return true
        end
    end
    return false
end

function M.tbl_flatten(t)
    return vim.iter(t):flatten(math.huge):totable()
end

local opts_aliases = {
    ['description'] = 'desc',
}

return M
