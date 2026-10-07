
do

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<leader>pd', function()
    return builtin.find_files({
      prompt_title = "Select Directory",
      find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
      attach_mappings = function(prompt_bufnr, map)
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            local dir = selection[1] or selection.value
            vim.cmd("cd " .. vim.fn.fnameescape(dir))
            
            -- Safely open NvimTree if loaded
            local ok, tree_api = pcall(require, "nvim-tree.api")
            if ok then
              tree_api.tree.open({ path = dir })
            end
          end
        end)
        return true
      end,
    })
  end, { desc = 'Find directory and cd' });
  vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope Git Files' })
  vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
  end, { desc = 'Telescope find files' } )
end
