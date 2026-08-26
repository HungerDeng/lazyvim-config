return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "debugpy") then
        table.insert(opts.ensure_installed, "debugpy")
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = false,
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = nil
      dap.listeners.before.event_exited["dapui_config"] = nil
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local dap = require("dap")
      local dap_python = require("dap-python")
      local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

      dap_python.setup(vim.fn.executable(debugpy_python) == 1 and debugpy_python or "debugpy-adapter")

      local function project_root()
        local file = vim.api.nvim_buf_get_name(0)
        local start = file ~= "" and vim.fs.dirname(file) or vim.fn.getcwd()
        local marker = vim.fs.find({ "pyproject.toml", "setup.py", "setup.cfg", ".git" }, {
          path = start,
          upward = true,
        })[1]
        return marker and vim.fs.dirname(marker) or vim.fn.getcwd()
      end

      local function project_python()
        local python = project_root() .. "/.venv/bin/python"
        return vim.uv.fs_stat(python) and python or nil
      end

      for _, config in ipairs(dap.configurations.python or {}) do
        config.justMyCode = false
        if config.request == "launch" then
          config.cwd = project_root
          config.pythonPath = project_python
        end
      end

      local python_adapter = dap.adapters.python
      if type(python_adapter) == "function" then
        dap.adapters.python = function(callback, config)
          config.justMyCode = false
          if config.request == "launch" then
            config.cwd = project_root()
            config.pythonPath = project_python() or config.pythonPath
          end
          return python_adapter(callback, config)
        end
        dap.adapters.debugpy = dap.adapters.python
      end
    end,
  },
}
