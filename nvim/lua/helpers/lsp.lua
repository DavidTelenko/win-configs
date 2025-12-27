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

--  This function if for LSP when it connects to a particular buffer.
M.on_attach = function(client, buffer)
  local telescope = require 'telescope.builtin'
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = buffer, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

  nmap('gd', telescope.lsp_definitions, 'Goto Definition')
  nmap('gr', telescope.lsp_references, 'Goto References')
  nmap('gI', telescope.lsp_implementations, 'Goto Implementation')

  nmap('<leader>D', telescope.lsp_type_definitions, 'Type Definition')
  nmap('<leader>ss', telescope.lsp_document_symbols, 'Document Symbols')
  nmap(
    '<leader>ws',
    telescope.lsp_dynamic_workspace_symbols,
    'Workspace Symbols'
  )

  nmap('K', function()
    vim.lsp.buf.hover { border = 'rounded' }
  end, 'Hover Documentation')

  nmap('gK', function()
    vim.lsp.buf.signature_help { border = 'rounded' }
  end, 'Signature Documentation')

  -- Lesser used LSP functionality
  -- nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
  nmap(
    '<leader>wr',
    vim.lsp.buf.remove_workspace_folder,
    'Workspace Remove Folder'
  )
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace List Folders')

  vim.api.nvim_buf_create_user_command(buffer, 'LspFormat', function()
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

return M
