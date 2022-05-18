local GUI = game:GetService("CoreGui"):FindFirstChild("MainNotify")
if not GUI then
    local MainNotify = Instance.new("ScreenGui")
    MainNotify.Name = "MainNotify"
    MainNotify.Parent = game:GetService("CoreGui")
    MainNotify.ZIndexBehavior = Enum.ZIndexBehavior.Global
    MainNotify.ResetOnSpawn = false
  else
end
