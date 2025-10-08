M = {}

M.next_prev_diagnostic = function(config)
  local next = { key = ']', count = 1, message = 'Next' }
  local prev = { key = '[', count = -1, message = 'Previous' }

  for _, conf in ipairs { next, prev } do
    vim.keymap.set('n', conf.key .. config.key, function()
      vim.diagnostic.jump {
        count = conf.count,
        float = true,
        severity = config.severity,
      }
    end, { desc = conf.message .. ' ' .. config.message })
  end
end

M.populate_workspace_diagnostics = function(client, bufnr)
  vim.schedule(function()
    client:notify('textDocument/didOpen', {
      textDocument = {
        uri = vim.uri_from_bufnr(bufnr),
        version = 0,
        text = vim.lsp._buf_get_full_text(bufnr),
        languageId = client.get_language_id(bufnr, vim.bo[bufnr].filetype),
      },
    })
  end)
end

return M
