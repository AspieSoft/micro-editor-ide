local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")

function init()
  config.MakeCommand("git-init", gitInit, config.NoComplete)
  config.MakeCommand("git-commit", gitCommit, config.NoComplete)


  config.MakeCommand("tsplit", termTab, config.NoComplete)
  config.TryBindKey("Alt-p", "command:tsplit", false)

  config.MakeCommand("ideinit", ideInit, config.NoComplete)
  config.TryBindKey("Alt-i", "command:ideinit", false)


  config.RegisterGlobalOption("ide", "ide", false)

  if config.GetGlobalOption("ide") then
    ideInit(micro.CurPane())
  end
end

function getInit(bp, args)
  local _, err = shell.ExecCommand("ls", ".git")
  if not err then
    local branch = "main"
    if #args == 1 then
      branch = args[1]
    end

    shell.ExecCommand("git", "init", "-b", branch)
    return
  end

  shell.ExecCommand("git", "init", "-b", "main")

  if #args >= 2 then
    shell.ExecCommand("git", "remote", "add", "origin", "git@github.com:"+args[1]+"/"+args[2]+".git")
  end

  local msg = "Initial commit"
  if #args >= 3 then
    msg = args[3]
  end

  shell.ExecCommand("git", "add", ".")
  shell.ExecCommand("git", "commit", "-a", "-m", msg)
  shell.ExecCommand("git", "push", "-u", "origin", "main")
end

function gitCommit(bp, args)
  local _, err = shell.ExecCommand("ls", ".git")
  if err then
    -- todo: git init
    return
  end

  local msg = "Updated"
  if #args >= 1 then
    msg = args[1]
  end

  shell.ExecCommand("git", "add", ".")
  shell.ExecCommand("git", "commit", "-a", "-m", msg)
  shell.ExecCommand("git", "push")
end


function termTab(bp)
  bp:HSplitAction()

  local tab = bp:Tab()
  local pane = tab:CurPane()
  -- local id = pane:ID()
  -- local node = tab:GetPane(id)

  -- pane:ResizePane(node.Y + 7)
  bp:ResizePane(30)

  pane:HandleCommand("term")

  openTerm = true
end

function ideInit(bp)
  local tab = bp:Tab()
  local pane = tab:CurPane()

  pane:HandleCommand("tree")
  pane:SetActive(true)
  termTab(pane)
  tab:SetActive(0)
  pane:SetActive(true)
end
