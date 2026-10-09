-- Treesitter-based removal of comments / docstrings in Python buffers.
-- Unlike regexes, this never touches '#' or '"""' inside ordinary strings.
local M = {}

local function root(buf)
  local parser = vim.treesitter.get_parser(buf, "python", { error = false })
  if not parser then
    vim.notify("No Python treesitter parser available", vim.log.levels.WARN)
    return nil
  end
  return parser:parse()[1]:root()
end

-- Apply edits bottom-up so earlier positions stay valid.
local function apply(buf, edits)
  table.sort(edits, function(a, b)
    if a.sr ~= b.sr then return a.sr > b.sr end
    return a.sc > b.sc
  end)
  for _, e in ipairs(edits) do
    e.apply(buf)
  end
  return #edits
end

-- Delete lines sr..er if the range [sc, ec) is the only thing on them, otherwise just the text.
local function delete_range(buf, sr, sc, er, ec)
  local first = vim.api.nvim_buf_get_lines(buf, sr, sr + 1, false)[1]
  local last = vim.api.nvim_buf_get_lines(buf, er, er + 1, false)[1]
  if first:sub(1, sc):match("^%s*$") and last:sub(ec + 1):match("^%s*$") then
    vim.api.nvim_buf_set_lines(buf, sr, er + 1, false, {})
  else
    local before = first:sub(1, sc):gsub("%s+$", "")
    vim.api.nvim_buf_set_text(buf, sr, #before, er, ec, {})
  end
end

function M.remove_comments(buf)
  buf = buf or 0
  local tree = root(buf)
  if not tree then return end

  local query = vim.treesitter.query.parse("python", "(comment) @c")
  local edits = {}
  for _, node in query:iter_captures(tree, buf) do
    local sr, sc, er, ec = node:range()
    local text = vim.treesitter.get_node_text(node, buf)
    -- Keep the shebang and encoding declaration
    local keep = (sr == 0 and text:match("^#!")) or (sr <= 1 and text:match("coding[:=]"))
    if not keep then
      table.insert(edits, { sr = sr, sc = sc, apply = function(b) delete_range(b, sr, sc, er, ec) end })
    end
  end
  vim.notify(("Removed %d comment(s)"):format(apply(buf, edits)))
end

local function first_statement(scope)
  local count, first = 0, nil
  for child in scope:iter_children() do
    if child:named() and child:type() ~= "comment" then
      count = count + 1
      first = first or child
    end
  end
  return first, count
end

function M.remove_docstrings(buf)
  buf = buf or 0
  local tree = root(buf)
  if not tree then return end

  local query = vim.treesitter.query.parse("python", "[(module) (block)] @scope")
  local edits = {}
  for _, scope in query:iter_captures(tree, buf) do
    local parent = scope:parent()
    local is_doc_scope = scope:type() == "module"
      or (parent and (parent:type() == "function_definition" or parent:type() == "class_definition"))
    if is_doc_scope then
      local stmt, count = first_statement(scope)
      if stmt and stmt:type() == "expression_statement" and stmt:named_child_count() == 1
          and stmt:named_child(0):type() == "string" then
        local sr, sc, er, ec = stmt:range()
        local only_stmt = count == 1 and scope:type() == "block"
        table.insert(edits, {
          sr = sr,
          sc = sc,
          apply = function(b)
            if only_stmt then
              -- A body can't be empty: replace the docstring with `pass`
              vim.api.nvim_buf_set_text(b, sr, sc, er, ec, { "pass" })
            else
              delete_range(b, sr, sc, er, ec)
            end
          end,
        })
      end
    end
  end
  vim.notify(("Removed %d docstring(s)"):format(apply(buf, edits)))
end

return M
