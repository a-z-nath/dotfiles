local M = {}
local VENV_NAMES = { ".venv", "venv", ".env", "env" }

--- Walk up from the buffer's directory to find a venv root.
--- Returns the venv root path (e.g. /project/.venv), or nil.
function M.find_venv_root(bufnr)
  local buf_path = vim.api.nvim_buf_get_name(bufnr)
  if buf_path == "" then return nil end
  local dir = vim.fn.fnamemodify(buf_path, ":p:h")

  while true do
    for _, name in ipairs(VENV_NAMES) do
      local python = dir .. "/" .. name .. "/bin/python"
      if vim.fn.filereadable(python) == 1 then
        return dir .. "/" .. name, dir  -- CHANGED: also return the dir that owns the venv
      end
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then break end
    dir = parent
  end
  return nil, nil
end

--- Find the site-packages directory inside a venv root.
function M.find_site_packages(venv_root)
  local lib_dir = venv_root .. "/lib"
  local handle = vim.uv or vim.loop
  if not handle then return nil end
  local dir = handle.fs_scandir(lib_dir)
  if not dir then return nil end
  while true do
    local name, type = handle.fs_scandir_next(dir)
    if not name then break end
    if type == "directory" and name:match("^python3") then
      local sp = lib_dir .. "/" .. name .. "/site-packages"
      if vim.fn.isdirectory(sp) == 1 then
        return sp
      end
    end
  end
  return nil
end

--- Walk up from buffer to find monorepo/project root (first dir with .git).
function M.find_project_root(bufnr)
  local buf_path = vim.api.nvim_buf_get_name(bufnr or 0)
  if buf_path == "" then return nil end
  local dir = vim.fn.fnamemodify(buf_path, ":p:h")
  while true do
    if vim.fn.isdirectory(dir .. "/.git") == 1 then
      return dir
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then break end
    dir = parent
  end
  return nil
end

--- Check if a directory looks like a Python service/package root.
--- True when it contains any of the standard Python project markers.
local function is_python_root(dir)
  local markers = {
    "pyproject.toml", "setup.py", "setup.cfg",
    "requirements.txt", "Pipfile",
  }
  for _, m in ipairs(markers) do
    if vim.fn.filereadable(dir .. "/" .. m) == 1 then
      return true
    end
  end
  return false
end

local function add_unique(list, item)
  for _, v in ipairs(list) do
    if v == item then return list end
  end
  table.insert(list, item)
  return list
end

--- Collect extraPaths for a given project root + optional venv site-packages.
--- Handles: single repo, monorepo (frontend+backend), microservices.
function M.collect_extra_paths(project_root, venv_sp)
  local extra = {}
  if venv_sp then
    table.insert(extra, venv_sp)
  end

  -- Always add project_root itself and its src/ if present
  extra = add_unique(extra, project_root)
  local root_src = project_root .. "/src"
  if vim.fn.isdirectory(root_src) == 1 then
    extra = add_unique(extra, root_src)
  end

  -- 1. Parse pyproject.toml for workspace member definitions
  local pyproject = project_root .. "/pyproject.toml"
  if vim.fn.filereadable(pyproject) == 1 then
    local lines = vim.fn.readfile(pyproject)
    local in_workspace = false
    local in_poetry_pkgs = false
    local globs = {}

    for _, line in ipairs(lines) do
      local section = line:match("^%[([%w_%.]+)%]$")
      if section then
        in_workspace = section:match("^tool%.[%w_%.]+%.workspace$") ~= nil
        in_poetry_pkgs = section == "tool.poetry.packages"
      elseif in_workspace then
        for str in line:gmatch('"([^"]-)"') do
          if str:match("%*") then
            table.insert(globs, str)
          end
        end
      elseif in_poetry_pkgs then
        local include = line:match('include%s*=%s*"([^"]-)"')
        local from    = line:match('from%s*=%s*"([^"]-)"')
        if include then
          local pkg_dir = from
            and (project_root .. "/" .. from .. "/" .. include)
            or  (project_root .. "/" .. include)
          local pkg_src = pkg_dir .. "/src"
          if vim.fn.isdirectory(pkg_src) == 1 then
            extra = add_unique(extra, pkg_src)
          elseif vim.fn.isdirectory(pkg_dir) == 1 then
            extra = add_unique(extra, pkg_dir)
          end
        end
      end
    end

    for _, glob in ipairs(globs) do
      local matches = vim.fn.glob(project_root .. "/" .. glob, false, true)
      for _, match_dir in ipairs(matches) do
        if vim.fn.isdirectory(match_dir) == 1 then
          local src = match_dir .. "/src"
          if vim.fn.isdirectory(src) == 1 then
            extra = add_unique(extra, src)
          else
            extra = add_unique(extra, match_dir)
          end
        end
      end
    end
  end

  -- 2. Scan depth-1 subdirs for Python packages (microservices, backend dirs)
  local function scan(dir)
    local handle = (vim.uv or vim.loop).fs_scandir(dir)
    if not handle then return end
    while true do
      local name, ftype = (vim.uv or vim.loop).fs_scandir_next(handle)
      if not name then break end
      if ftype == "directory" and not name:match("^%.") and name ~= "__pycache__" then
        local sub = dir .. "/" .. name
        if is_python_root(sub) then
          local src = sub .. "/src"
          if vim.fn.isdirectory(src) == 1 then
            extra = add_unique(extra, src)
          else
            extra = add_unique(extra, sub)
          end
        end
      end
    end
  end

  scan(project_root)
  for _, group in ipairs({ "packages", "apps", "libs", "services" }) do
    local group_dir = project_root .. "/" .. group
    if vim.fn.isdirectory(group_dir) == 1 then
      scan(group_dir)
    end
  end

  return extra
end

return M
-- local M = {}

-- local VENV_NAMES = { ".venv", "venv", ".env", "env" }

-- --- Walk up from the buffer's directory to find a venv root.
-- --- Returns the venv root path (e.g. /project/.venv), or nil.
-- function M.find_venv_root(bufnr)
--   local buf_path = vim.api.nvim_buf_get_name(bufnr)
--   if buf_path == "" then return nil end
--   local dir = vim.fn.fnamemodify(buf_path, ":p:h")

--   while true do
--     for _, name in ipairs(VENV_NAMES) do
--       local python = dir .. "/" .. name .. "/bin/python"
--       if vim.fn.filereadable(python) == 1 then
--         return dir .. "/" .. name
--       end
--     end
--     local parent = vim.fn.fnamemodify(dir, ":h")
--     if parent == dir then break end
--     dir = parent
--   end
--   return nil
-- end

-- --- Find the site-packages directory inside a venv root.
-- function M.find_site_packages(venv_root)
--   local lib_dir = venv_root .. "/lib"
--   local handle = vim.uv or vim.loop
--   if not handle then return nil end
--   local dir = handle.fs_scandir(lib_dir)
--   if not dir then return nil end
--   while true do
--     local name, type = handle.fs_scandir_next(dir)
--     if not name then break end
--     if type == "directory" and name:match("^python3") then
--       local sp = lib_dir .. "/" .. name .. "/site-packages"
--       if vim.fn.isdirectory(sp) == 1 then
--         return sp
--       end
--     end
--   end
--   return nil
-- end

-- --- Walk up from buffer to find monorepo/project root (first dir with .git).
-- function M.find_project_root(bufnr)
--   local buf_path = vim.api.nvim_buf_get_name(bufnr or 0)
--   if buf_path == "" then return nil end
--   local dir = vim.fn.fnamemodify(buf_path, ":p:h")
--   while true do
--     if vim.fn.isdirectory(dir .. "/.git") == 1 then
--       return dir
--     end
--     local parent = vim.fn.fnamemodify(dir, ":h")
--     if parent == dir then break end
--     dir = parent
--   end
--   return nil
-- end

-- local function add_unique(list, item)
--   for _, v in ipairs(list) do
--     if v == item then return list end
--   end
--   table.insert(list, item)
--   return list
-- end

-- --- Collect extraPaths: venv site-packages + monorepo workspace package roots.
-- --- Parses pyproject.toml for workspace globs (PDM, uv, rye), Poetry packages,
-- --- scans depth-1 dirs for Python packages, and checks common grouping dirs.
-- function M.collect_extra_paths(project_root, venv_sp)
--   local extra = {}
--   if venv_sp then
--     table.insert(extra, venv_sp)
--   end

--   -- 1. Parse pyproject.toml for workspace member definitions
--   local pyproject = project_root .. "/pyproject.toml"
--   if vim.fn.filereadable(pyproject) == 1 then
--     local lines = vim.fn.readfile(pyproject)
--     local in_workspace = false
--     local in_poetry_pkgs = false
--     local globs = {}

--     for _, line in ipairs(lines) do
--       local section = line:match("^%[([%w_%.]+)%]$")
--       if section then
--         in_workspace = section:match("^tool%.[%w_%.]+%.workspace$") ~= nil
--         in_poetry_pkgs = section == "tool.poetry.packages"
--       elseif in_workspace then
--         for str in line:gmatch('"([^"]-)"') do
--           if str:match("%*") then
--             table.insert(globs, str)
--           end
--         end
--       elseif in_poetry_pkgs then
--         local include = line:match('include%s*=%s*"([^"]-)"')
--         local from = line:match('from%s*=%s*"([^"]-)"')
--         if include then
--           local pkg_dir = from and (project_root .. "/" .. from .. "/" .. include)
--             or (project_root .. "/" .. include)
--           local pkg_src = pkg_dir .. "/src"
--           if vim.fn.isdirectory(pkg_src) == 1 then
--             extra = add_unique(extra, pkg_src)
--           elseif vim.fn.isdirectory(pkg_dir) == 1 then
--             extra = add_unique(extra, pkg_dir)
--           end
--         end
--       end
--     end

--     -- Resolve workspace globs like "packages/*"
--     for _, glob in ipairs(globs) do
--       local matches = vim.fn.glob(project_root .. "/" .. glob, false, true)
--       for _, match_dir in ipairs(matches) do
--         if vim.fn.isdirectory(match_dir) == 1 then
--           local src = match_dir .. "/src"
--           if vim.fn.isdirectory(src) == 1 then
--             extra = add_unique(extra, src)
--           else
--             extra = add_unique(extra, match_dir)
--           end
--         end
--       end
--     end
--   end

--   -- 2. Scan depth-1 directories that look like Python packages (catches
--   --    anything else, including microservices at the top level)
--   local function scan(dir)
--     local handle = (vim.uv or vim.loop).fs_scandir(dir)
--     if not handle then return end
--     while true do
--       local name, type = (vim.uv or vim.loop).fs_scandir_next(handle)
--       if not name then break end
--       if type == "directory" and not name:match("^%.") and name ~= "__pycache__" then
--         local sub = dir .. "/" .. name
--         if vim.fn.filereadable(sub .. "/pyproject.toml") == 1
--           or vim.fn.filereadable(sub .. "/setup.py") == 1 then
--           local src = sub .. "/src"
--           if vim.fn.isdirectory(src) == 1 then
--             extra = add_unique(extra, src)
--           else
--             extra = add_unique(extra, sub)
--           end
--         end
--       end
--     end
--   end

--   scan(project_root)
--   for _, group in ipairs({ "packages", "apps", "libs", "services" }) do
--     local group_dir = project_root .. "/" .. group
--     if vim.fn.isdirectory(group_dir) == 1 then
--       scan(group_dir)
--     end
--   end

--   -- 3. Add project_root/src if it exists (common single-repo layout)
--   local root_src = project_root .. "/src"
--   if vim.fn.isdirectory(root_src) == 1 then
--     extra = add_unique(extra, root_src)
--   end

--   return extra
-- end

-- return M
