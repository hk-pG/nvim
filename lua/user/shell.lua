-- シェル設定モジュール
local M = {}

-- EnumのようにOS名を定義
M.OS = {
  Windows = "Windows",
  Mac = "Mac",
  Linux = "Linux",
  Unknown = "Unknown",
}

-- OS判定用関数
function M.detect_os()
  if vim.fn.has "win32" == 1 then
    return M.OS.Windows
  elseif vim.fn.has "mac" == 1 then
    return M.OS.Mac
  elseif vim.fn.has "unix" == 1 then
    return M.OS.Linux
  else
    return M.OS.Unknown
  end
end

-- シェル設定関数
function M.configure_shell()
  local os_name = M.detect_os()

  if os_name == M.OS.Windows then
    if vim.fn.executable "pwsh" == 1 then
      vim.opt.shell = "pwsh"
    elseif vim.fn.executable "powershell" == 1 then
      vim.opt.shell = "powershell"
    else
      vim.notify("No suitable shell found (pwsh or powershell)", vim.log.levels.WARN)
    end
  else
    vim.notify("No changes to the default shell for non-Windows systems.", vim.log.levels.INFO)
  end
end

-- call configure function
M.configure_shell()

return M
