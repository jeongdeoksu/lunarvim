local M = {}

local banner = {
  "                                                                                     ",
  "                                                                                     ",
  "                                                                                     ",
  "                    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗               ",
  "                    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
  "                    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║          ",    
  "                    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ",
  "                    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "                    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                     ",
}

M.banner_alt_1 = {
  "                                                                                     ",
  "                                                                                     ",
  "                                                                                     ",
  "                    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗               ",
  "                    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
  "                    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║          ",    
  "                    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ",
  "                    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "                    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                     ",
}

M.banner_alt_2 = {
  "                                                                                     ",
  "                                                                                     ",
  "                                                                                     ",
  "                    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗               ",
  "                    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
  "                    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║          ",    
  "                    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ",
  "                    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "                    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                     ",
}

if vim.o.lines < 36 then
  banner = vim.list_slice(banner, 16, 22)
end

function M.get_sections()
  local header = {
    type = "text",
    val = banner,
    opts = {
      position = "center",
      hl = "Label",
    },
  }

  local text = require "lvim.interface.text"
  local lvim_version = require("lvim.utils.git").get_lvim_version()

  local footer = {
    type = "text",
    val = text.align_center({ width = 0 }, {
      "",
      "lunarvim.org",
      lvim_version,
    }, 0.5),
    opts = {
      position = "center",
      hl = "Number",
    },
  }
  local buttons = {}

  local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
  if status_ok then
    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = "Include"
      return b
    end
    buttons = {
      val = {
        button("f", lvim.icons.ui.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>"),
        button("n", lvim.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>"),
        button("p", lvim.icons.ui.Project .. "  Projects ", "<CMD>Telescope projects<CR>"),
        button("r", lvim.icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>"),
        button("t", lvim.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>"),
        button(
          "c",
          lvim.icons.ui.Gear .. "  Configuration",
          "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>"
        ),
      },
    }
  end

  return {
    header = header,
    buttons = buttons,
    footer = footer,
  }
end

return M
