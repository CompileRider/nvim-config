return {
  'Civitasv/cmake-tools.nvim',
  lazy = true,
  init = function()
    local loaded = false
    local function check()
      local cwd = vim.uv.cwd()
      if vim.fn.filereadable(cwd .. '/CMakeLists.txt') == 1 then
        if not loaded then
          loaded = true
          require('lazy').load({ plugins = { 'cmake-tools.nvim' } })
        end
      end
    end
    check()
    vim.api.nvim_create_autocmd('DirChanged', {
      callback = check,
    })
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'akinsho/toggleterm.nvim', -- For advanced terminal integration
    'stevearc/overseer.nvim',  -- For task management
  },
  config = function()
    local osys = require('cmake-tools.osys')
    require('cmake-tools').setup({
      -- Core CMake Configuration
      cmake_command = 'cmake',
      ctest_command = 'ctest',
      cmake_use_preset = true,
      cmake_regenerate_on_save = true, -- Auto-regenerate on CMakeLists.txt save
      
      -- Advanced Build Configuration with Macro Support
      cmake_generate_options = { 
        '-DCMAKE_EXPORT_COMPILE_COMMANDS=1',
        '-DCMAKE_BUILD_TYPE=${variant:buildType}',
        '-DCMAKE_INSTALL_PREFIX=${workspaceFolder}/install',
        '-DCMAKE_TOOLCHAIN_FILE=${kit}',
        '-G${kitGenerator}',
        -- Sanitizer flags for memory debugging (use with Debug build)
        '-DCMAKE_C_FLAGS_DEBUG=-g -O0 -fsanitize=address,undefined -fno-omit-frame-pointer',
        '-DCMAKE_CXX_FLAGS_DEBUG=-g -O0 -fsanitize=address,undefined -fno-omit-frame-pointer',
        '-DCMAKE_EXE_LINKER_FLAGS_DEBUG=-fsanitize=address,undefined',
      },
      cmake_build_options = {
        '--parallel',
        '--config ${variant:buildType}',
        '--target ${variant:buildTarget}',
      },
      
      -- Dynamic Build Directory with Platform Support
      cmake_build_directory = function()
        if osys.iswin32 then
          return 'build\\${variant:buildType}'
        end
        return 'build/${variant:buildType}'
      end,
      
      -- Advanced Compile Commands Integration
      cmake_compile_commands_options = {
        action = 'soft_link', -- soft_link, copy, lsp, none
        target = vim.loop.cwd(),
      },
      
      -- CMake Kits Support (like VSCode CMake Tools)
      cmake_kits_path = nil, -- Will use default ~/.local/share/CMakeTools/cmake-tools-kits.json
      
      -- Variant Messages Configuration
      cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_length = 40 },
      },
      
      -- Advanced DAP Integration
      cmake_dap_configuration = {
        name = 'cpp',
        type = 'codelldb',
        request = 'launch',
        stopOnEntry = false,
        runInTerminal = true,
        console = 'integratedTerminal',
        args = {},
        cwd = '${workspaceFolder}',
        environment = {},
        externalConsole = false,
        MIMode = 'gdb',
        miDebuggerPath = '/usr/bin/gdb',
        setupCommands = {
          {
            description = 'Enable pretty-printing for gdb',
            text = '-enable-pretty-printing',
            ignoreFailures = true,
          },
        },
      },
      
      -- Professional Executor Configuration
      cmake_executor = {
        name = 'toggleterm',
        opts = {
          direction = 'float',
          close_on_exit = false,
          auto_scroll = true,
          singleton = true,
          size = function(term)
            if term.direction == 'horizontal' then
              return 15
            elseif term.direction == 'vertical' then
              return vim.o.columns * 0.4
            end
          end,
          float_opts = {
            border = 'curved',
            winblend = 0,
            highlights = {
              border = 'Normal',
              background = 'Normal',
            },
          },
        },
        default_opts = {
          quickfix = {
            show = 'always',
            position = 'belowright',
            size = 10,
            encoding = 'utf-8',
            auto_close_when_success = true,
          },
          toggleterm = {
            direction = 'float',
            close_on_exit = false,
            auto_scroll = true,
            singleton = true,
          },
          overseer = {
            new_task_opts = {
              strategy = {
                'toggleterm',
                direction = 'horizontal',
                auto_scroll = true,
                quit_on_exit = 'success',
              },
            },
            on_new_task = function(task)
              require('overseer').open({ enter = false, direction = 'right' })
            end,
          },
          terminal = {
            name = 'CMake Build Terminal',
            prefix_name = '[CMakeTools]: ',
            split_direction = 'horizontal',
            split_size = 11,
            single_terminal_per_instance = true,
            single_terminal_per_tab = true,
            keep_terminal_static_location = true,
            auto_resize = true,
            start_insert = false,
            focus = false,
            do_not_add_newline = false,
          },
        },
      },
      
      -- Professional Runner Configuration
      cmake_runner = {
        name = 'toggleterm',
        opts = {
          direction = 'float',
          close_on_exit = false,
          auto_scroll = true,
          singleton = true,
        },
        default_opts = {
          quickfix = {
            show = 'always',
            position = 'belowright',
            size = 10,
            encoding = 'utf-8',
            auto_close_when_success = true,
          },
          toggleterm = {
            direction = 'float',
            close_on_exit = false,
            auto_scroll = true,
            singleton = true,
          },
          overseer = {
            new_task_opts = {
              strategy = {
                'toggleterm',
                direction = 'horizontal',
                auto_scroll = true,
                quit_on_exit = 'success',
              },
            },
            on_new_task = function(task) end,
          },
          terminal = {
            name = 'CMake Run Terminal',
            prefix_name = '[CMakeRun]: ',
            split_direction = 'horizontal',
            split_size = 11,
            single_terminal_per_instance = true,
            single_terminal_per_tab = true,
            keep_terminal_static_location = true,
            auto_resize = true,
            start_insert = false,
            focus = false,
            do_not_add_newline = false,
          },
        },
      },
      
      -- Apple-Style Notifications with Advanced Spinner
      cmake_notifications = {
        runner = { enabled = true },
        executor = { enabled = true },
        spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        refresh_rate_ms = 100,
      },
      
      -- Advanced Features
      cmake_virtual_text_support = true, -- Show target info as virtual text
      cmake_use_scratch_buffer = false,  -- Disable scratch buffer for cleaner UI
      
      -- Session Management (maintains project-specific settings)
      cmake_session_file_name = '.cmake-tools-session.json',
      
      -- Advanced Keymaps (optional, can be customized)
      cmake_keymaps = {
        generate = '<leader>cg',
        build = '<leader>cb',
        run = '<leader>cr',
        debug = '<leader>cd',
        clean = '<leader>cc',
        build_and_run = '<leader>cR',
        build_and_debug = '<leader>cD',
        select_build_type = '<leader>ct',
        select_target = '<leader>cT',
        select_kit = '<leader>ck',
        select_preset = '<leader>cp',
      },
    })
    
    -- Advanced Keymaps Setup
    local keymap = vim.keymap.set
    keymap('n', '<leader>cg', '<cmd>CMakeGenerate<cr>', { desc = 'CMake Generate' })
    keymap('n', '<leader>cb', '<cmd>CMakeBuild<cr>', { desc = 'CMake Build' })
    keymap('n', '<leader>cr', '<cmd>CMakeRun<cr>', { desc = 'CMake Run' })
    keymap('n', '<leader>cd', '<cmd>CMakeDebug<cr>', { desc = 'CMake Debug' })
    keymap('n', '<leader>cc', '<cmd>CMakeClean<cr>', { desc = 'CMake Clean' })
    keymap('n', '<leader>cR', '<cmd>CMakeBuildAndRun<cr>', { desc = 'CMake Build & Run' })
    keymap('n', '<leader>cD', '<cmd>CMakeBuildAndDebug<cr>', { desc = 'CMake Build & Debug' })
    keymap('n', '<leader>ct', '<cmd>CMakeSelectBuildType<cr>', { desc = 'Select Build Type' })
    keymap('n', '<leader>cT', '<cmd>CMakeSelectBuildTarget<cr>', { desc = 'Select Build Target' })
    keymap('n', '<leader>ck', '<cmd>CMakeSelectKit<cr>', { desc = 'Select CMake Kit' })
    keymap('n', '<leader>cp', '<cmd>CMakeSelectConfigurePreset<cr>', { desc = 'Select Configure Preset' })
    keymap('n', '<leader>cP', '<cmd>CMakeSelectBuildPreset<cr>', { desc = 'Select Build Preset' })
    keymap('n', '<leader>ci', '<cmd>CMakeInstall<cr>', { desc = 'CMake Install' })
    keymap('n', '<leader>co', '<cmd>CMakeOpen<cr>', { desc = 'Open CMake Console' })
    keymap('n', '<leader>cC', '<cmd>CMakeClose<cr>', { desc = 'Close CMake Console' })
    keymap('n', '<leader>cs', '<cmd>CMakeStop<cr>', { desc = 'Stop CMake Process' })
  end,
}
