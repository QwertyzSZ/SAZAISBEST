local Notification = {}

local previousUiExists = game:GetService("CoreGui"):FindFirstChild("MainNotify")
if previousUiExists then previousUiExists:Destroy() end

local MainNotify = instance.new("ScreenGui")
MainNotify.Name = "MainNotify"
MainNotify.Parent = game:GetService("CoreGui")
MainNotify.ZIndexBehavior = Enum.ZIndexBehavior.Global
MainNotify.ResetOnSpawn = false

function Notification.new(titel,text,delays)
local NotiFrame = Instance.new("Frame")
NotiFrame.Name = "NotiFrame"
NotiFrame.Parent = MainNotify
NotiFrame.AnchorPoint = Vector2.new(0.5, 0.5)
NotiFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
NotiFrame.BorderSizePixel = 0
NotiFrame.Position = UDim2.new(1, -210, 1, -500)
NotiFrame.Size = UDim2.new(0, 400, 0, 500)
NotiFrame.ClipsDescendants = true
NotiFrame.BackgroundTransparency = 1

local Notilistlayout = Instance.new("UIListLayout")
Notilistlayout.Parent = NotiFrame
Notilistlayout.SortOrder = Enum.SortOrder.LayoutOrder
Notilistlayout.Padding = UDim.new(0, 5)

local TitleFrame = Instance.new("Frame")
TitleFrame.Name = "TitleFrame"
TitleFrame.Parent = NotiFrame
TitleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
TitleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleFrame.BorderSizePixel = 0
TitleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TitleFrame.Size = UDim2.new(0, 0, 0, 0)
TitleFrame.ClipsDescendants = true
TitleFrame.BackgroundTransparency = 0

local ConnerTitile = Instance.new("UICorner")

ConnerTitile.CornerRadius = UDim.new(0, 4)
ConnerTitile.Name = ""
ConnerTitile.Parent = TitleFrame

TitleFrame:TweenSizeAndPosition(UDim2.new(0, 400 - 10, 0, 70), UDim2.new(0.5, 0, 0.5, 0), "Out", "Quad", 0.3, true)

local imagenoti = Instance.new("ImageLabel")

imagenoti.Parent = TitleFrame
imagenoti.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
imagenoti.BackgroundTransparency = 1.000
imagenoti.AnchorPoint = Vector2.new(0.5, 0.5)
imagenoti.Position = UDim2.new(0.9, 0, 0.5, 0)
imagenoti.Size = UDim2.new(0, 50, 0, 50)
--  imagenoti.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=7578496318&width=0&height=0&format=png"

local txdlid = Instance.new("TextLabel")

txdlid.Parent = TitleFrame
txdlid.Name = "TextLabel_Tap"
txdlid.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
txdlid.Size = UDim2.new(0, 160, 0, 25)
txdlid.Font = Enum.Font.GothamBold
txdlid.Text = titel
txdlid.TextColor3 = Color3.fromRGB(255, 255, 255)
txdlid.TextSize = 13.000
txdlid.AnchorPoint = Vector2.new(0.5, 0.5)
txdlid.Position = UDim2.new(0.23, 0, 0.3, 0)
-- txdlid.TextYAlignment = Enum.TextYAlignment.Top
txdlid.TextXAlignment = Enum.TextXAlignment.Left
txdlid.BackgroundTransparency = 1

local LableFrame = Instance.new("Frame")
LableFrame.Name = "LableFrame"
LableFrame.Parent = TitleFrame
LableFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LableFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LableFrame.BorderSizePixel = 0
LableFrame.Position = UDim2.new(0.36, 0, 0.67, 0)
LableFrame.Size = UDim2.new(0, 260, 0, 25)
LableFrame.ClipsDescendants = true
LableFrame.BackgroundTransparency = 1

local TextNoti = Instance.new("TextLabel")

TextNoti.Parent = LableFrame
TextNoti.Name = "TextLabel_Tap"
TextNoti.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextNoti.Size = UDim2.new(0, 260, 0, 25)
TextNoti.Font = Enum.Font.GothamBold
TextNoti.Text = text
TextNoti.TextColor3 = Color3.fromRGB(150, 150, 150)
TextNoti.TextSize = 13.000
TextNoti.AnchorPoint = Vector2.new(0.5, 0.5)
TextNoti.Position = UDim2.new(0.5, 0, 0.5, 0)
-- TextNoti.TextYAlignment = Enum.TextYAlignment.Top
TextNoti.TextXAlignment = Enum.TextXAlignment.Left
TextNoti.BackgroundTransparency = 1

repeat
    wait()
until TitleFrame.Size == UDim2.new(0, 400 - 10, 0, 70)

local Time = Instance.new("Frame")
Time.Name = "Time"
Time.Parent = TitleFrame
--Time.AnchorPoint = Vector2.new(0.5, 0.5)
Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Time.BorderSizePixel = 0
Time.Position = UDim2.new(0, 0, 0., 0)
Time.Size = UDim2.new(0, 0, 0, 0)
Time.ClipsDescendants = false
Time.BackgroundTransparency = 0

local ConnerTitile_Time = Instance.new("UICorner")

ConnerTitile_Time.CornerRadius = UDim.new(0, 4)
ConnerTitile_Time.Name = ""
ConnerTitile_Time.Parent = Time

Time:TweenSizeAndPosition(UDim2.new(0, 400 - 10, 0, 3), UDim2.new(0., 0, 0., 0), "Out", "Quad", 0.3, true)
repeat
    wait()
until Time.Size == UDim2.new(0, 400 - 10, 0, 3)

TweenService:Create(
    Time,
    TweenInfo.new(tonumber(delays), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
    {Size = UDim2.new(0, 0, 0, 3)} -- UDim2.new(0, 128, 0, 25)
):Play()
delay(
    tonumber(delays),
    function()
        TweenService:Create(
            TitleFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
            {Size = UDim2.new(0, 0, 0, 0)} -- UDim2.new(0, 128, 0, 25)
        ):Play()
        wait(0.3)
        TitleFrame:Destroy()
    end
)
end
return Notification
