if not game:IsLoaded() then
    local notLoaded = Instance.new("Message", game:GetService("CoreGui"))
    notLoaded.Text = 'SAZA HUB is waiting for the game to load'
    game.Loaded:Wait()
    notLoaded:Destroy()
end

if getconnections then
    for _,v in next, getconnections(game:GetService("LogService").MessageOut) do
        v:Disable()
    end
    for _,v in next, getconnections(game:GetService("ScriptContext").Error) do
        v:Disable()
    end
    
 end

    if game:GetService("CoreGui"):FindFirstChild("Discord") then
        game:GetService("CoreGui"):FindFirstChild("Discord"):Destroy()
    end

local DiscordLib = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local pfp
local user
local tag
local userinfo = {}

pcall(function()
    userinfo = HttpService:JSONDecode(readfile("discordlibinfo.txt"));
end)

pfp = userinfo["pfp"] or "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"
user =  userinfo["user"] or game.Players.LocalPlayer.Name
tag = userinfo["tag"] or tostring(math.random(1000,9999))

local function SaveInfo()
    userinfo["pfp"] = pfp
    userinfo["user"] = user
    userinfo["tag"] = tag
    writefile("discordlibinfo.txt", HttpService:JSONEncode(userinfo));
end

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        object.Position = pos
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
            then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

local function RippleEffect(object)
    spawn(function()
        local Ripple = Instance.new("ImageLabel")

        Ripple.Name = "Ripple"
        Ripple.Parent = object
        Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Ripple.BackgroundTransparency = 1.000
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://2708891598"
        Ripple.ImageTransparency = 0.800
        Ripple.ScaleType = Enum.ScaleType.Fit

        Ripple.Position = UDim2.new((Mouse.X) / object.AbsoluteSize.Y, 0, (Mouse.Y) / object.AbsoluteSize.X, 0)
        TweenService:Create(Ripple, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(3, 0, 3, 0)}):Play()

        wait(0.5)
        TweenService:Create(Ripple, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()

        wait(1)
        Ripple:Destroy()
    end)
end

local Discord = Instance.new("ScreenGui")
Discord.Name = "Discord"
Discord.Parent = game.CoreGui
Discord.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function DiscordLib:Window(text)
    local PresetColor = mainclr or Color3.fromRGB(0, 255, 255) or _G.Color
    local CloseBind = cls or Enum.KeyCode.RightControl or _G.Toggle
    local currentservertoggled = ""
    local minimized = false
    local fs = false
    local settingsopened = false
    local MainFrame = Instance.new("Frame")
    local TopFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseBtn = Instance.new("TextButton")
    local CloseIcon = Instance.new("ImageLabel")
    local MinimizeBtn = Instance.new("TextButton")
    local MinimizeIcon = Instance.new("ImageLabel")
    local ServersHolder = Instance.new("Folder")
    local Userpad = Instance.new("Frame")
    local UserIcon = Instance.new("Frame")
    local UserIconCorner = Instance.new("UICorner")
    local UserImage = Instance.new("ImageLabel")
    local UserCircleImage = Instance.new("ImageLabel")
    local UserName = Instance.new("TextLabel")
    local UserTag = Instance.new("TextLabel")
    local ServersHoldFrame = Instance.new("Frame")
    local ServersHold = Instance.new("ScrollingFrame")
    local ServersHoldLayout = Instance.new("UIListLayout")
    local ServersHoldPadding = Instance.new("UIPadding")
    local TopFrameHolder = Instance.new("Frame")
    local OutLayFrame = Instance.new("Frame")
    local OutLayFrameCorner = Instance.new("UICorner")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Discord
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    MainFrame.BackgroundTransparency = 1
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 618, 0, 407)

    local uitoggled = false
    UserInputService.InputBegan:Connect(function(io, p)
        pcall(function()
            if io.KeyCode == CloseBind then
                if uitoggled == false then
                    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                    wait(.3)
                    Discord.Enabled = false
                    uitoggled = true
                else
                    Discord.Enabled = true
                    MainFrame:TweenSize(UDim2.new(0, 618, 0, 407), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                    uitoggled = false
                end
            end
        end)
    end)

    TopFrame.Name = "TopFrame"
    TopFrame.Parent = MainFrame
    TopFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    TopFrame.BackgroundTransparency = 1.000
    TopFrame.BorderSizePixel = 0
    TopFrame.Position = UDim2.new(-0.000658480625, 0, 0, 0)
    TopFrame.Size = UDim2.new(0, 681, 0, 65)
    
    TopFrameHolder.Name = "TopFrameHolder"
    TopFrameHolder.Parent = TopFrame
    TopFrameHolder.BackgroundColor3 = Color3.fromRGB(20,20,20)
    TopFrameHolder.BackgroundTransparency = 1.000
    TopFrameHolder.BorderSizePixel = 0
    TopFrameHolder.Position = UDim2.new(-0.000658480625, 0, 0, 0)
    TopFrameHolder.Size = UDim2.new(0, 681, 0, 22)

    Title.Name = "Title"
    Title.Parent = TopFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0102790017, 0, 0, 0)
    Title.Size = UDim2.new(0, 192, 0, 23)
    Title.Font = Enum.Font.Gotham
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    ServersHolder.Name = "ServersHolder"
    ServersHolder.Parent = TopFrameHolder

    Userpad.Name = "Userpad"
    Userpad.Parent = TopFrameHolder
    Userpad.BackgroundColor3 = Color3.fromRGB(41, 43, 47)
    Userpad.BackgroundTransparency = 1
    Userpad.BorderSizePixel = 0
    Userpad.Position = UDim2.new(0.0010243297, 0, 15.8807148, 0)
    Userpad.Size = UDim2.new(0, 179, 0, 43)

    UserIcon.Name = "UserIcon"
    UserIcon.Parent = Userpad
    UserIcon.BackgroundColor3 = Color3.fromRGB(20,20,20)
    UserIcon.BorderSizePixel = 0
    UserIcon.Position = UDim2.new(0.0340000018, 0, 0.123999998, 0)
    UserIcon.Size = UDim2.new(0, 32, 0, 32)

    UserIconCorner.CornerRadius = UDim.new(1, 8)
    UserIconCorner.Name = "UserIconCorner"
    UserIconCorner.Parent = UserIcon

    UserImage.Name = "UserImage"
    UserImage.Parent = UserIcon
    UserImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserImage.BackgroundTransparency = 1.000
    UserImage.Size = UDim2.new(0, 32, 0, 32)
    UserImage.Image = "http://www.roblox.com/asset/?id=8401150805"
    -----------------------------------------------------------------
    UserCircleImage.Name = "UserImage"
    UserCircleImage.Parent = UserImage
    UserCircleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserCircleImage.BackgroundTransparency = 1.000
    UserCircleImage.Size = UDim2.new(0, 32, 0, 32)
    UserCircleImage.Image = "rbxassetid://8401150805"
    UserCircleImage.ImageColor3 = Color3.fromRGB(255,255,255)

    UserName.Name = "UserName"
    UserName.Parent = Userpad
    UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserName.BackgroundTransparency = 1.000
    UserName.BorderSizePixel = 0
    UserName.Position = UDim2.new(0.230000004, 0, 0.115999997, 0)
    UserName.Size = UDim2.new(0, 98, 0, 17)
    UserName.Font = Enum.Font.GothamSemibold
    UserName.TextSize = 13.000
    UserName.TextTransparency = 1
    UserName.TextXAlignment = Enum.TextXAlignment.Center
    UserName.ClipsDescendants = true

    UserTag.Name = "UserTag"
    UserTag.Parent = Userpad
    UserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserTag.BackgroundTransparency = 1.000
    UserTag.BorderSizePixel = 0
    UserTag.Position = UDim2.new(0.230000004, 0, 0.275000013, 0)
    UserTag.Size = UDim2.new(0, 95, 0, 17)
    UserTag.Font = Enum.Font.GothamBold
    UserTag.TextColor3 = Color3.fromRGB(255,255,255)
    UserTag.TextSize = 13.000
    UserTag.TextTransparency = 0
    UserTag.TextXAlignment = Enum.TextXAlignment.Center

    UserName.Text = " | SAZA HUB"
    UserTag.Text = "" .. "Version 1.1.5"

    ServersHoldFrame.Name = "ServersHoldFrame"
    ServersHoldFrame.Parent = MainFrame
    ServersHoldFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServersHoldFrame.BackgroundTransparency = 1.000
    ServersHoldFrame.BorderColor3 = Color3.fromRGB(20,20,20)
    ServersHoldFrame.Size = UDim2.new(0, 71, 0, 396)

    ServersHold.Name = "ServersHold"
    ServersHold.Parent = ServersHoldFrame
    ServersHold.Active = true
    ServersHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServersHold.BackgroundTransparency = 1.000
    ServersHold.BorderSizePixel = 0
    ServersHold.Position = UDim2.new(-0.000359333731, 0, 0.0580808073, 0)
    ServersHold.Size = UDim2.new(0, 71, 0, 373)
    ServersHold.ScrollBarThickness = 1
    ServersHold.ScrollBarImageTransparency = 1
    ServersHold.CanvasSize = UDim2.new(0, 0, 0, 0)

    ServersHoldLayout.Name = "ServersHoldLayout"
    ServersHoldLayout.Parent = ServersHold
    ServersHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ServersHoldLayout.Padding = UDim.new(0, 7)

    ServersHoldPadding.Name = "ServersHoldPadding"
    ServersHoldPadding.Parent = ServersHold

    ServersHoldPadding.Name = "ServersHoldPadding"
    ServersHoldPadding.Parent = ServersHold

    local NotiFrame = Instance.new("Frame")
    NotiFrame.Name = "NotiFrame"
    NotiFrame.Parent = Discord
    NotiFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    NotiFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    NotiFrame.BorderSizePixel = 0
    NotiFrame.Position =  UDim2.new(1, -210, 1, -500)
    NotiFrame.Size = UDim2.new(0, 400, 0, 500)
    NotiFrame.ClipsDescendants = true
    NotiFrame.BackgroundTransparency = 1
    
    local Notilistlayout = Instance.new("UIListLayout")
    Notilistlayout.Parent = NotiFrame
    Notilistlayout.SortOrder = Enum.SortOrder.LayoutOrder
    Notilistlayout.Padding = UDim.new(0, 5)		

    function DiscordLib:Notification(titel,text,delays)
        local TitleFrame = Instance.new("Frame")
        TitleFrame.Name = "TitleFrame"
        TitleFrame.Parent = NotiFrame
        TitleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        TitleFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
        TitleFrame.BorderSizePixel = 0
        TitleFrame.Position =  UDim2.new(0.5, 0, 0.5,0)
        TitleFrame.Size = UDim2.new(0, 0, 0, 0)
        TitleFrame.ClipsDescendants = true
        TitleFrame.BackgroundTransparency = 0
    
        local ConnerTitile = Instance.new("UICorner")
    
        ConnerTitile.CornerRadius = UDim.new(0, 4)
        ConnerTitile.Name = ""
        ConnerTitile.Parent = TitleFrame
    
        TitleFrame:TweenSizeAndPosition(UDim2.new(0, 400-10, 0, 70),  UDim2.new(0.5, 0, 0.5,0), "Out", "Quad", 0.3, true)
    
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
        txdlid.BackgroundColor3 = Color3.fromRGB(50,50,50)
        txdlid.Size =UDim2.new(0, 160, 0,25 )
        txdlid.Font = Enum.Font.GothamBold
        txdlid.Text = titel
        txdlid.TextColor3 = Color3.fromRGB(255,255,255)
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
        LableFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
        LableFrame.BorderSizePixel = 0
        LableFrame.Position =  UDim2.new(0.36, 0, 0.67,0)
        LableFrame.Size = UDim2.new(0, 260, 0,25 )
        LableFrame.ClipsDescendants = true
        LableFrame.BackgroundTransparency = 1
    
        local TextNoti = Instance.new("TextLabel")
    
        TextNoti.Parent = LableFrame
        TextNoti.Name = "TextLabel_Tap"
        TextNoti.BackgroundColor3 = Color3.fromRGB(255,255,255)
        TextNoti.Size =UDim2.new(0, 260, 0,25 )
        TextNoti.Font = Enum.Font.GothamBold
        TextNoti.Text = text
        TextNoti.TextColor3 = Color3.fromRGB(150,150,150)
        TextNoti.TextSize = 13.000
        TextNoti.AnchorPoint = Vector2.new(0.5, 0.5)
        TextNoti.Position = UDim2.new(0.5, 0, 0.5, 0)
        -- TextNoti.TextYAlignment = Enum.TextYAlignment.Top
        TextNoti.TextXAlignment = Enum.TextXAlignment.Left
        TextNoti.BackgroundTransparency = 1
    
        repeat wait() until TitleFrame.Size == UDim2.new(0, 400-10, 0, 70)
    
        local Time = Instance.new("Frame")
        Time.Name = "Time"
        Time.Parent = TitleFrame
    --Time.AnchorPoint = Vector2.new(0.5, 0.5)
        Time.BackgroundColor3 =  Color3.fromRGB(255,255,255)
        Time.BorderSizePixel = 0
        Time.Position =  UDim2.new(0, 0, 0.,0)
        Time.Size = UDim2.new(0, 0,0,0)
        Time.ClipsDescendants = false
        Time.BackgroundTransparency = 0
    
        local ConnerTitile_Time = Instance.new("UICorner")
    
        ConnerTitile_Time.CornerRadius = UDim.new(0, 4)
        ConnerTitile_Time.Name = ""
        ConnerTitile_Time.Parent = Time
    
    
        Time:TweenSizeAndPosition(UDim2.new(0, 400-10, 0, 3),  UDim2.new(0., 0, 0.,0), "Out", "Quad", 0.3, true)
        repeat wait() until Time.Size == UDim2.new(0, 400-10, 0, 3)
    
        TweenService:Create(
            Time,
            TweenInfo.new(tonumber(delays), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
            {Size = UDim2.new(0, 0, 0, 3)} -- UDim2.new(0, 128, 0, 25)
        ):Play()
        delay(tonumber(delays),function()
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

    MakeDraggable(TopFrame, MainFrame)
    ServersHoldPadding.PaddingLeft = UDim.new(0, 14)
    local ServerHold = {}
    function ServerHold:Server(text, img)
        local fc = false
        local currentchanneltoggled = ""
        local Server = Instance.new("TextButton")
        local ServerBtnCorner = Instance.new("UICorner")
        local ServerIco = Instance.new("ImageLabel")
        local ServerWhiteFrame = Instance.new("Frame")
        local ServerWhiteFrameCorner = Instance.new("UICorner")

        Server.Name = text .. "Server"
        Server.Parent = ServersHold
        Server.BackgroundColor3 = Color3.fromRGB(120,120,120)
        Server.Position = UDim2.new(0.125, 0, 0, 0)
        Server.Size = UDim2.new(0, 47, 0, 47)
        Server.AutoButtonColor = false
        Server.Font = Enum.Font.Gotham
        Server.Text = ""
        Server.BackgroundTransparency = 1
        Server.TextTransparency = 1
        Server.TextColor3 = Color3.fromRGB(233, 25, 42)
        Server.TextSize = 18.000

        ServerBtnCorner.CornerRadius = UDim.new(1, 0)
        ServerBtnCorner.Name = "ServerCorner"
        ServerBtnCorner.Parent = Server

        ServerWhiteFrame.Name = "ServerWhiteFrame"
        ServerWhiteFrame.Parent = Server
        ServerWhiteFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        ServerWhiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerWhiteFrame.BackgroundTransparency = 1
        ServerWhiteFrame.Position = UDim2.new(-0.347378343, 0, 0.502659559, 0)
        ServerWhiteFrame.Size = UDim2.new(0, 11, 0, 10)

        ServerWhiteFrameCorner.CornerRadius = UDim.new(1, 0)
        ServerWhiteFrameCorner.Name = "ServerWhiteFrameCorner"
        ServerWhiteFrameCorner.Parent = ServerWhiteFrame
        ServersHold.CanvasSize = UDim2.new(0, 0, 0, ServersHoldLayout.AbsoluteContentSize.Y)

        local ServerFrame = Instance.new("Frame")
        local ServerFrame1 = Instance.new("Frame")
        local ServerFrame2 = Instance.new("Frame")
        local ServerTitleFrame = Instance.new("Frame")
        local ServerTitle = Instance.new("TextLabel")
        local GlowFrame = Instance.new("Frame")
        local Glow = Instance.new("ImageLabel")
        local ServerContentFrame = Instance.new("Frame")
        local ServerCorner = Instance.new("UICorner")
        local ChannelTitleFrame = Instance.new("Frame")
        local ChannelTitleFrameCorner = Instance.new("UICorner")
        local ChannelTitle = Instance.new("TextLabel")
        local ChannelContentFrame = Instance.new("Frame")
        local Hashtag = Instance.new("TextLabel")
        local ChannelContentFrameCorner = Instance.new("UICorner")
        local GlowChannel = Instance.new("ImageLabel")
        local ServerChannelHolder = Instance.new("ScrollingFrame")
        local ServerChannelHolderLayout = Instance.new("UIListLayout")
        local ServerChannelHolderPadding = Instance.new("UIPadding")
        local TimeGlobal = Instance.new("TextLabel")

        ServerFrame.Name = "ServerFrame"
        ServerFrame.Parent = ServersHolder
        ServerFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        ServerFrame.BorderSizePixel = 0
        ServerFrame.ClipsDescendants = true
        ServerFrame.Position = UDim2.new(0.005356875, 0, 0.32262593, 13)
        ServerFrame.Size = UDim2.new(0, 609, 0, 373)
        ServerFrame.Visible = false

        ServerTitleFrame.Name = "ServerTitleFrame"
        ServerTitleFrame.Parent = ServerFrame
        ServerTitleFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        ServerTitleFrame.BackgroundTransparency = 1.000
        ServerTitleFrame.BorderSizePixel = 0
        ServerTitleFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
        ServerTitleFrame.Size = UDim2.new(0, 180, 0, 40)

        ServerTitle.Name = "ServerTitle"
        ServerTitle.Parent = ServerTitleFrame
        ServerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerTitle.BackgroundTransparency = 1.000
        ServerTitle.BorderSizePixel = 0
        ServerTitle.Position = UDim2.new(0.0751359761, 0, 0, 0)
        ServerTitle.Size = UDim2.new(0, 97, 0, 39)
        ServerTitle.Font = Enum.Font.GothamSemibold
        ServerTitle.Text = text
        ServerTitle.TextColor3 = Color3.fromRGB(255,255,255)
        ServerTitle.TextSize = 15.000
        ServerTitle.TextXAlignment = Enum.TextXAlignment.Left

        GlowFrame.Name = "GlowFrame"
        GlowFrame.Parent = ServerFrame
        GlowFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        GlowFrame.BackgroundTransparency = 1.000
        GlowFrame.BorderSizePixel = 0
        GlowFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
        GlowFrame.Size = UDim2.new(0, 609, 0, 40)

        Glow.Name = "Glow"
        Glow.Parent = GlowFrame
        Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Glow.BackgroundTransparency = 1.000
        Glow.BorderSizePixel = 0
        Glow.Position = UDim2.new(0, -15, 0, -15)
        Glow.Size = UDim2.new(1, 30, 1, 30)
        Glow.ZIndex = 0
        Glow.Image = "rbxassetid://4996891970"
        Glow.ImageColor3 = Color3.fromRGB(15, 15, 15)
        Glow.ScaleType = Enum.ScaleType.Slice
        Glow.SliceCenter = Rect.new(20, 20, 280, 280)

        ServerContentFrame.Name = "ServerContentFrame"
        ServerContentFrame.Parent = ServerFrame
        ServerContentFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        ServerContentFrame.BackgroundTransparency = 1.000
        ServerContentFrame.BorderSizePixel = 0
        ServerContentFrame.Position = UDim2.new(-0.0010054264, 0, 0.106338218, 0)
        ServerContentFrame.Size = UDim2.new(0, 180, 0, 333)

        ServerCorner.CornerRadius = UDim.new(0, 9)
        ServerCorner.Name = "ServerCorner"
        ServerCorner.Parent = ServerFrame

        ChannelTitleFrame.Name = "ChannelTitleFrame"
        ChannelTitleFrame.Parent = ServerFrame
        ChannelTitleFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
        ChannelTitleFrame.BorderSizePixel = 0
        ChannelTitleFrame.Position = UDim2.new(0.294561088, 0, -0.000900391256, 0)
        ChannelTitleFrame.Size = UDim2.new(0, 429, 0, 40)

        ChannelTitleFrameCorner.CornerRadius = UDim.new(0, 7)
        ChannelTitleFrameCorner.Name = "ChannelTitleFrameCorner"
        ChannelTitleFrameCorner.Parent = ChannelTitleFrame

        local LocalizationService = game:GetService("LocalizationService")
        local player = game.Players.LocalPlayer
         
        local result, code = pcall(function()
            return LocalizationService:GetCountryRegionForPlayerAsync(player)
        end)   
                    
        TimeGlobal.Name = "TimeGlobal"
        TimeGlobal.Parent = ChannelTitleFrame
        TimeGlobal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TimeGlobal.Position = UDim2.new(0.9462470865, 0, 0, 0)
        TimeGlobal.Size = UDim2.new(0, 95, 0, 39)
        TimeGlobal.BackgroundTransparency = 1
        TimeGlobal.ZIndex = 3
        TimeGlobal.Font = Enum.Font.GothamSemibold
        TimeGlobal.Text = ""
        TimeGlobal.TextColor3 = Color3.fromRGB(255,255,255)
        TimeGlobal.TextSize = 15.000
        TimeGlobal.TextXAlignment = Enum.TextXAlignment.Left

        spawn(function()
            while wait() do
                TimeGlobal.Text = ""..code.."" 
            end
        end)

        Hashtag.Name = "Hashtag"
        Hashtag.Parent = ChannelTitleFrame
        Hashtag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Hashtag.BackgroundTransparency = 1.000
        Hashtag.BorderSizePixel = 0
        Hashtag.Position = UDim2.new(0.0279720277, 0, 0, 0)
        Hashtag.Size = UDim2.new(0, 19, 0, 39)
        Hashtag.Font = Enum.Font.Gotham
        Hashtag.Text = "|"
        Hashtag.TextColor3 = Color3.fromRGB(111, 111, 111)
        Hashtag.TextSize = 25.000

        ChannelTitle.Name = "ChannelTitle"
        ChannelTitle.Parent = ChannelTitleFrame
        ChannelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ChannelTitle.BackgroundTransparency = 1.000
        ChannelTitle.BorderSizePixel = 0
        ChannelTitle.Position = UDim2.new(0.0862470865, 0, 0, 0)
        ChannelTitle.Size = UDim2.new(0, 95, 0, 39)
        ChannelTitle.Font = Enum.Font.GothamSemibold
        ChannelTitle.Text = ""
        ChannelTitle.TextColor3 = Color3.fromRGB(255,255,255)
        ChannelTitle.TextSize = 15.000
        ChannelTitle.TextXAlignment = Enum.TextXAlignment.Left

        ChannelContentFrame.Name = "ChannelContentFrame"
        ChannelContentFrame.Parent = ServerFrame
        ChannelContentFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
        ChannelContentFrame.BorderSizePixel = 0
        ChannelContentFrame.ClipsDescendants = true
        ChannelContentFrame.Position = UDim2.new(0.294561088, 0, 0.106338218, 0)
        ChannelContentFrame.Size = UDim2.new(0, 429, 0, 333)

        ChannelContentFrameCorner.CornerRadius = UDim.new(0, 7)
        ChannelContentFrameCorner.Name = "ChannelContentFrameCorner"
        ChannelContentFrameCorner.Parent = ChannelContentFrame

        GlowChannel.Name = "GlowChannel"
        GlowChannel.Parent = ChannelContentFrame
        GlowChannel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        GlowChannel.BackgroundTransparency = 1.000
        GlowChannel.BorderSizePixel = 0
        GlowChannel.Position = UDim2.new(0, -33, 0, -91)
        GlowChannel.Size = UDim2.new(1.06396091, 30, 0.228228226, 30)
        GlowChannel.ZIndex = 0
        GlowChannel.Image = "rbxassetid://4996891970"
        GlowChannel.ImageColor3 = Color3.fromRGB(15, 15, 15)
        GlowChannel.ScaleType = Enum.ScaleType.Slice
        GlowChannel.SliceCenter = Rect.new(20, 20, 280, 280)

        ServerChannelHolder.Name = "ServerChannelHolder"
        ServerChannelHolder.Parent = ServerContentFrame
        ServerChannelHolder.Active = true
        ServerChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerChannelHolder.BackgroundTransparency = 1.000
        ServerChannelHolder.BorderSizePixel = 0
        ServerChannelHolder.Position = UDim2.new(0.00535549596, 0, 0.0241984241, 0)
        ServerChannelHolder.Selectable = false
        ServerChannelHolder.Size = UDim2.new(0, 179, 0, 278)
        ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
        ServerChannelHolder.ScrollBarThickness = 4
        ServerChannelHolder.ScrollBarImageColor3 = Color3.fromRGB(18, 19, 21)
        ServerChannelHolder.ScrollBarImageTransparency = 1

        ServerChannelHolderLayout.Name = "ServerChannelHolderLayout"
        ServerChannelHolderLayout.Parent = ServerChannelHolder
        ServerChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ServerChannelHolderLayout.Padding = UDim.new(0, 4)

        ServerChannelHolderPadding.Name = "ServerChannelHolderPadding"
        ServerChannelHolderPadding.Parent = ServerChannelHolder
        ServerChannelHolderPadding.PaddingLeft = UDim.new(0, 9)
        
        ServerChannelHolder.MouseEnter:Connect(function()
            ServerChannelHolder.ScrollBarImageTransparency = 0
        end)

        ServerChannelHolder.MouseLeave:Connect(function()
            ServerChannelHolder.ScrollBarImageTransparency = 1
        end)

        Server.MouseEnter:Connect(function()
            if currentservertoggled ~= Server.Name then
                TweenService:Create(
                    Server,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}
                ):Play()
                TweenService:Create(
                    ServerBtnCorner,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {CornerRadius = UDim.new(0, 15)}
                ):Play()
                ServerWhiteFrame:TweenSize(
                    UDim2.new(0, 11, 0, 27),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .3,
                    true
                )
            end
        end)

        Server.MouseLeave:Connect(function()
            if currentservertoggled ~= Server.Name then
                TweenService:Create(
                    Server,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(47, 49, 54)}
                ):Play()
                TweenService:Create(
                    ServerBtnCorner,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {CornerRadius = UDim.new(1, 0)}
                ):Play()
                ServerWhiteFrame:TweenSize(
                    UDim2.new(0, 11, 0, 10),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .3,
                    true
                )
            end
        end)

        Server.MouseButton1Click:Connect(function()
            currentservertoggled = Server.Name
            for i, v in next, ServersHolder:GetChildren() do
                if v.Name == "ServerFrame" then
                    v.Visible = false
                end
                ServerFrame.Visible = true
            end
            for i, v in next, ServersHold:GetChildren() do
                if v.ClassName == "TextButton" then
                    TweenService:Create(
                        v,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(47, 49, 54)}
                    ):Play()
                    TweenService:Create(
                        Server,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}
                    ):Play()
                    TweenService:Create(
                        v.ServerCorner,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {CornerRadius = UDim.new(1, 0)}
                    ):Play()
                    TweenService:Create(
                        ServerBtnCorner,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {CornerRadius = UDim.new(0, 15)}
                    ):Play()
                    v.ServerWhiteFrame:TweenSize(
                        UDim2.new(0, 11, 0, 10),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .3,
                        true
                    )
                    ServerWhiteFrame:TweenSize(
                        UDim2.new(0, 11, 0, 46),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .3,
                        true
                    )
                end
            end
        end)

        if img == "" then
            Server.Text = string.sub(text, 1, 1)
        else
            ServerIco.Image = img
        end

    if fs == false then
        TweenService:Create(
            Server,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}
        ):Play()
        TweenService:Create(
            ServerBtnCorner,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {CornerRadius = UDim.new(0, 15)}
        ):Play()
        ServerWhiteFrame:TweenSize(
            UDim2.new(0, 11, 0, 46),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .3,
            true
        )
        ServerFrame.Visible = true
        Server.Name = text .. "Server"
        currentservertoggled = Server.Name
        fs = true
    end
        
        local ChannelHold = {}
        function ChannelHold:Channel(text, ico)
            local Icon = ico or ""
            local ChannelBtn = Instance.new("TextButton")
            local ChannelBtnCorner = Instance.new("UICorner")
            local ChannelBtnHashtag = Instance.new("TextLabel")
            local ChannelBtnTitle = Instance.new("TextLabel")

            ChannelBtn.Name = text .. "ChannelBtn"
            ChannelBtn.Parent = ServerChannelHolder
            ChannelBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
            ChannelBtn.BorderSizePixel = 0
            ChannelBtn.Position = UDim2.new(0.24118948, 0, 0.578947365, 0)
            ChannelBtn.Size = UDim2.new(0, 160, 0, 30)
            ChannelBtn.AutoButtonColor = false
            ChannelBtn.Font = Enum.Font.SourceSans
            ChannelBtn.Text = ""
            ChannelBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ChannelBtn.TextSize = 14.000

            ChannelBtnCorner.CornerRadius = UDim.new(0, 6)
            ChannelBtnCorner.Name = "ChannelBtnCorner"
            ChannelBtnCorner.Parent = ChannelBtn

            ChannelBtnTitle.Name = "ChannelBtnTitle"
            ChannelBtnTitle.Parent = ChannelBtn
            ChannelBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChannelBtnTitle.BackgroundTransparency = 1.000
            ChannelBtnTitle.BorderSizePixel = 0
            ChannelBtnTitle.Position = UDim2.new(0.173747092, 0, -0.166666672, 0)
            ChannelBtnTitle.Size = UDim2.new(0, 95, 0, 39)
            ChannelBtnTitle.Font = Enum.Font.Gotham
            ChannelBtnTitle.Text = text
            ChannelBtnTitle.TextColor3 = Color3.fromRGB(255,255,255)
            ChannelBtnTitle.TextSize = 14.000
            ChannelBtnTitle.TextXAlignment = Enum.TextXAlignment.Center
            ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ServerChannelHolderLayout.AbsoluteContentSize.Y)

            local ChannelHolder = Instance.new("ScrollingFrame")
            local ChannelHolderLayout = Instance.new("UIListLayout")

            ChannelHolder.Name = "ChannelHolder"
            ChannelHolder.Parent = ChannelContentFrame
            ChannelHolder.Active = true
            ChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChannelHolder.BackgroundTransparency = 1.000
            ChannelHolder.BorderSizePixel = 0
            ChannelHolder.Position = UDim2.new(0.0360843192, 0, 0.0241984241, 0)
            ChannelHolder.Size = UDim2.new(0, 412, 0, 314)
            ChannelHolder.ScrollBarThickness = 6
            ChannelHolder.CanvasSize = UDim2.new(0,0,0,0)
            ChannelHolder.ScrollBarImageTransparency = 0
            ChannelHolder.ScrollBarImageColor3 = Color3.fromRGB(18, 19, 21)
            ChannelHolder.Visible = false
            ChannelHolder.ClipsDescendants = false

            ChannelHolderLayout.Name = "ChannelHolderLayout"
            ChannelHolderLayout.Parent = ChannelHolder
            ChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ChannelHolderLayout.Padding = UDim.new(0, 6)
            
            ChannelBtn.MouseEnter:Connect(function()
                if currentchanneltoggled ~= ChannelBtn.Name then
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(220,220,220)
                    ChannelBtnTitle.TextColor3 = Color3.fromRGB(27, 27, 27)
                end
            end)

            ChannelBtn.MouseLeave:Connect(function()
                if currentchanneltoggled ~= ChannelBtn.Name then
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                    ChannelBtnTitle.TextColor3 = Color3.fromRGB(220,220,220)
                end
            end)

            ChannelBtn.MouseEnter:Connect(function()
                if currentchanneltoggled == ChannelBtn.Name then
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(220,220,220)
                    ChannelBtnTitle.TextColor3 = Color3.fromRGB(27, 27, 27)
                end
            end)

            ChannelBtn.MouseLeave:Connect(function()
                if currentchanneltoggled == ChannelBtn.Name then
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
                    ChannelBtnTitle.TextColor3 = Color3.fromRGB(220,220,220)
                end
            end)
            
            ChannelBtn.MouseButton1Click:Connect(function()
                for i, v in next, ChannelContentFrame:GetChildren() do
                    if v.Name == "ChannelHolder" then
                        v.Visible = false
                    end
                    ChannelHolder.Visible = true
                end
                for i, v in next, ServerChannelHolder:GetChildren() do
                    if v.ClassName == "TextButton" then
                        v.BackgroundColor3 = Color3.fromRGB(27,27,27)
                        v.ChannelBtnTitle.TextColor3 =  Color3.fromRGB(220,220,220)
                    end
                    ServerFrame.Visible = true
                end
                ChannelTitle.Text = text
                ChannelBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
                ChannelBtnTitle.TextColor3 =  Color3.fromRGB(220,220,220)
                currentchanneltoggled = ChannelBtn.Name
            end)
            
            if fc == false then
                fc = true
                ChannelTitle.Text = text
                ChannelBtn.BackgroundColor3 = Color3.fromRGB(27,27,27)
                ChannelBtnTitle.TextColor3 = Color3.fromRGB(220,220,220)
                currentchanneltoggled = ChannelBtn.Name
                ChannelHolder.Visible = true
            end
            local ChannelContent = {}
            function ChannelContent:Button(text,callback)
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")

                Button.Name = "Button"
                Button.Parent = ChannelHolder
                Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
                Button.Size = UDim2.new(0, 401, 0, 30)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.Gotham
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14.000
                Button.Text = text

                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(120,120,120)}
                    ):Play()
                end)
                
                Button.MouseButton1Click:Connect(function()
                    pcall(callback)
                    Button.TextSize = 0
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextSize = 14}
                    ):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(35,35,35)}
                    ):Play()
                end)
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            end
            function ChannelContent:Toggle(text,default,callback)
                local toggled = false
                local Toggle = Instance.new("TextButton")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleTitle = Instance.new("TextLabel")
                local ToggleFrame = Instance.new("Frame")
                local ToggleFrameCorner = Instance.new("UICorner")
                local ToggleFrameCircle = Instance.new("Frame")
                local ToggleFrameCircleCorner = Instance.new("UICorner")
                local Icon = Instance.new("ImageLabel")

                Toggle.Name = "Toggle"
                Toggle.Parent = ChannelHolder
                Toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
                Toggle.BorderSizePixel = 0
                Toggle.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                Toggle.Size = UDim2.new(0, 401, 0, 30)
                Toggle.AutoButtonColor = false
                Toggle.Font = Enum.Font.Gotham
                Toggle.Text = ""
                Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.TextSize = 14.000

                ToggleCorner.CornerRadius = UDim.new(0, 6)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = Toggle

                ToggleTitle.Name = "ToggleTitle"
                ToggleTitle.Parent = Toggle
                ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleTitle.BackgroundTransparency = 1.000
                ToggleTitle.Position = UDim2.new(0, 5, 0, 0)
                ToggleTitle.Size = UDim2.new(0, 200, 0, 30)
                ToggleTitle.Font = Enum.Font.Gotham
                ToggleTitle.Text = text
                ToggleTitle.TextColor3 = Color3.fromRGB(255,255,255)
                ToggleTitle.TextSize = 14.000
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = Toggle
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                ToggleFrame.Position = UDim2.new(0.900481343, -5, 0.13300018, 0)
                ToggleFrame.Size = UDim2.new(0, 40, 0, 21)

                ToggleFrameCorner.CornerRadius = UDim.new(1, 8)
                ToggleFrameCorner.Name = "ToggleFrameCorner"
                ToggleFrameCorner.Parent = ToggleFrame

                ToggleFrameCircle.Name = "ToggleFrameCircle"
                ToggleFrameCircle.Parent = ToggleFrame
                ToggleFrameCircle.BackgroundColor3 = Color3.fromRGB(119,119,119)
                ToggleFrameCircle.Position = UDim2.new(0.234999999, -5, 0.133000001, 0)
                ToggleFrameCircle.Size = UDim2.new(0, 15, 0, 15)

                ToggleFrameCircleCorner.CornerRadius = UDim.new(1, 0)
                ToggleFrameCircleCorner.Name = "ToggleFrameCircleCorner"
                ToggleFrameCircleCorner.Parent = ToggleFrameCircle

                Icon.Name = "Icon"
                Icon.Parent = ToggleFrameCircle
                Icon.AnchorPoint = Vector2.new(0.5, 0.5)
                Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Icon.BackgroundTransparency = 1.000
                Icon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Icon.Position = UDim2.new(0, 8, 0, 8)
                Icon.Size = UDim2.new(0, 13, 0, 13)
                Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                Icon.ImageColor3 = Color3.fromRGB(30,30,30)

                if default == true then
                    TweenService:Create(
                        Icon,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(255,255,255)}
                    ):Play()
                    TweenService:Create(
                        ToggleFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(255,255,255)}
                    ):Play()
                    ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3,true)
                    TweenService:Create(
                        Icon,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageTransparency = 1}
                    ):Play()
                    Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                    wait(.1)
                    TweenService:Create(
                        Icon,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageTransparency = 0}
                    ):Play()
                    toggled = not toggled
                    pcall(callback, toggled)
                end
                
                Toggle.MouseButton1Click:Connect(function()
                    if toggled == false then
                        TweenService:Create(
                            Icon,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = Color3.fromRGB(255,255,255)}
                        ):Play()
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255,255,255)}
                        ):Play()
                        ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        TweenService:Create(
                            Icon,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageTransparency = 1}
                        ):Play()
                        Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                        wait(.1)
                        TweenService:Create(
                            Icon,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageTransparency = 0}
                        ):Play()
                    else
                        TweenService:Create(
                            Icon,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = Color3.fromRGB(0,0,0)}
                        ):Play()
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(0,0,0)}
                        ):Play()
                        ToggleFrameCircle:TweenPosition(UDim2.new(0.234999999, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        TweenService:Create(
                            Icon,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageTransparency = 1}
                        ):Play()
                        Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                        wait(.1)
                        TweenService:Create(
                            Icon,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageTransparency = 0}
                        ):Play()
                    end
                    toggled = not toggled
                    pcall(callback, toggled)
                end)
                
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            end
            
            function ChannelContent:Slider(text, min, max, start, callback)
                local SliderFunc = {}
                local dragging = false
                local Slider = Instance.new("TextButton")
                local SliderCorner = Instance.new("UICorner")
                local SliderTitle = Instance.new("TextLabel")
                local SliderFrame = Instance.new("Frame")
                local SliderFrameCorner = Instance.new("UICorner")
                local CurrentValueFrame = Instance.new("Frame")
                local CurrentValueFrameCorner = Instance.new("UICorner")
                local Zip = Instance.new("Frame")
                local ZipCorner = Instance.new("UICorner")
                local ValueBubble = Instance.new("Frame")
                local ValueBubbleCorner = Instance.new("UICorner")
                local SquareBubble = Instance.new("Frame")
                local GlowBubble = Instance.new("ImageLabel")
                local ValueLabel = Instance.new("TextLabel")


                Slider.Name = "Slider"
                Slider.Parent = ChannelHolder
                Slider.BackgroundColor3 = Color3.fromRGB(40,40,40)
                Slider.BorderSizePixel = 0
                Slider.Position = UDim2.new(0, 0, 0.216560602, 0)
                Slider.Size = UDim2.new(0, 401, 0, 38)
                Slider.AutoButtonColor = false
                Slider.Font = Enum.Font.Gotham
                Slider.Text = ""
                Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider.TextSize = 14.000

                SliderCorner.CornerRadius = UDim.new(0, 4)
                SliderCorner.Name = "SliderCorner"
                SliderCorner.Parent = Slider 

                SliderTitle.Name = "SliderTitle"
                SliderTitle.Parent = Slider
                SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.BackgroundTransparency = 1.000
                SliderTitle.Position = UDim2.new(0, 5, 0, -4)
                SliderTitle.Size = UDim2.new(0, 200, 0, 27)
                SliderTitle.Font = Enum.Font.Gotham
                SliderTitle.Text = text
                SliderTitle.TextColor3 = Color3.fromRGB(255,255,255)
                SliderTitle.TextSize = 14.000
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = Slider
                SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
                SliderFrame.Position = UDim2.new(0.497999996, 0, 0.757000029, 0)
                SliderFrame.Size = UDim2.new(0, 385, 0, 8)

                SliderFrameCorner.Name = "SliderFrameCorner"
                SliderFrameCorner.Parent = SliderFrame

                CurrentValueFrame.Name = "CurrentValueFrame"
                CurrentValueFrame.Parent = SliderFrame
                CurrentValueFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
                CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 8)

                CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
                CurrentValueFrameCorner.Parent = CurrentValueFrame

                Zip.Name = "Zip"
                Zip.Parent = SliderFrame
                Zip.BackgroundColor3 = Color3.fromRGB(255,255,255)
                Zip.Position = UDim2.new((start or 0)/max, -6,-0.644999981, 0)
                Zip.Size = UDim2.new(0, 10, 0, 18)
                ZipCorner.CornerRadius = UDim.new(0, 3)
                ZipCorner.Name = "ZipCorner"
                ZipCorner.Parent = Zip

                ValueBubble.Name = "ValueBubble"
                ValueBubble.Parent = Zip
                ValueBubble.AnchorPoint = Vector2.new(0.5, 0.5)
                ValueBubble.BackgroundColor3 = Color3.fromRGB(40,40,40)
                ValueBubble.Position = UDim2.new(0.5, 0, -1.00800002, 0)
                ValueBubble.Size = UDim2.new(0, 36, 0, 21)
                ValueBubble.Visible = false
                
    
                Zip.MouseEnter:Connect(function()
                    if dragging == false then
                        ValueBubble.Visible = true
                    end
                end)
                
                Zip.MouseLeave:Connect(function()
                    if dragging == false then
                        ValueBubble.Visible = false
                    end
                end)
    

                ValueBubbleCorner.CornerRadius = UDim.new(0, 3)
                ValueBubbleCorner.Name = "ValueBubbleCorner"
                ValueBubbleCorner.Parent = ValueBubble

                SquareBubble.Name = "SquareBubble"
                SquareBubble.Parent = ValueBubble
                SquareBubble.AnchorPoint = Vector2.new(0.5, 0.5)
                SquareBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                SquareBubble.BorderSizePixel = 0
                SquareBubble.Position = UDim2.new(0.493000001, 0, 0.637999971, 0)
                SquareBubble.Rotation = 45.000
                SquareBubble.Size = UDim2.new(0, 19, 0, 19)

                GlowBubble.Name = "GlowBubble"
                GlowBubble.Parent = ValueBubble
                GlowBubble.BackgroundColor3 = Color3.fromRGB(0,0,0)
                GlowBubble.BackgroundTransparency = 1.000
                GlowBubble.BorderSizePixel = 0
                GlowBubble.Position = UDim2.new(0, -15, 0, -15)
                GlowBubble.Size = UDim2.new(1, 30, 1, 30)
                GlowBubble.ZIndex = 0
                GlowBubble.Image = "rbxassetid://4996891970"
                GlowBubble.ImageColor3 = Color3.fromRGB(15, 15, 15)
                GlowBubble.ScaleType = Enum.ScaleType.Slice
                GlowBubble.SliceCenter = Rect.new(20, 20, 280, 280)

                ValueLabel.Name = "ValueLabel"
                ValueLabel.Parent = ValueBubble
                ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ValueLabel.BackgroundTransparency = 1.000
                ValueLabel.Size = UDim2.new(0, 36, 0, 21)
                ValueLabel.Font = Enum.Font.Gotham
                ValueLabel.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
                ValueLabel.TextColor3 = Color3.fromRGB(255,255,255)
                ValueLabel.TextSize = 10.000
                local function move(input)
                    local pos = UDim2.new(math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0 , 1), -6, -0.644999981, 0)
                    local pos1 = UDim2.new(math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1), 0, 0, 8)
                    CurrentValueFrame.Size = pos1
                    Zip.Position = pos
                    local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                    ValueLabel.Text = tostring(value)
                    pcall(callback, value)
                end
                Zip.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            ValueBubble.Visible = true
                        end
                    end
                )
                Zip.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                            ValueBubble.Visible = false
                        end
                    end
                )
                game:GetService("UserInputService").InputChanged:Connect(
                function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        move(input)
                    end
                end
                )
                
                function SliderFunc:Change(tochange)
                    CurrentValueFrame.Size = UDim2.new((tochange or 0) / max, 0, 0, 8)
                    Zip.Position = UDim2.new((tochange or 0)/max, -6,-0.644999981, 0)
                    ValueLabel.Text = tostring(tochange and math.floor((tochange / max) * (max - min) + min) or 0)
                    pcall(callback, tochange)
                end
                
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
                return SliderFunc
            end
            function ChannelContent:Seperator()
                local Seperator1 = Instance.new("Frame")
                local Seperator2 = Instance.new("Frame")
                local SeperatorCorner = Instance.new("UICorner")

                Seperator1.Name = "Seperator1"
                Seperator1.Parent = ChannelHolder
                Seperator1.BackgroundColor3 = Color3.fromRGB(45,45,45)
                Seperator1.BackgroundTransparency = 1.000
                Seperator1.Position = UDim2.new(0, 0, 0.350318581, 0)
                Seperator1.Size = UDim2.new(0, 100, 0, 8)

                Seperator2.Name = "Seperator2"
                Seperator2.Parent = Seperator1
                Seperator2.BackgroundColor3 = Color3.fromRGB(45,45,45)
                Seperator2.BorderSizePixel = 0
                Seperator2.Position = UDim2.new(0, 0, 0, 4)
                Seperator2.Size = UDim2.new(0, 401, 0, 5)
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)

                SeperatorCorner.CornerRadius = UDim.new(0, 4)
                SeperatorCorner.Name = "SeperatorCorner"
                SeperatorCorner.Parent = Seperator2
            end
            function ChannelContent:Dropdown(text, list, callback)
                local DropFunc = {}
                local itemcount = 0
                local framesize = 0
                local DropTog = false
                local Dropdown = Instance.new("Frame")
                local DropdownTitle = Instance.new("TextLabel")
                local DropdownFrameOutline = Instance.new("Frame")
                local DropdownFrameOutlineCorner = Instance.new("UICorner")
                local DropdownFrame = Instance.new("Frame")
                local DropdownFrameCorner = Instance.new("UICorner")
                local CurrentSelectedText = Instance.new("TextLabel")
                local ArrowImg = Instance.new("ImageLabel")
                local DropdownFrameBtn = Instance.new("TextButton")

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = ChannelHolder
                Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Dropdown.BackgroundTransparency = 1.000
                Dropdown.Position = UDim2.new(0.0995974985, 0, 0.445175439, 0)
                Dropdown.Size = UDim2.new(0, 403, 0, 60)

                DropdownTitle.Name = "DropdownTitle"
                DropdownTitle.Parent = Dropdown
                DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTitle.BackgroundTransparency = 1.000
                DropdownTitle.Position = UDim2.new(0, 5, 0, 0)
                DropdownTitle.Size = UDim2.new(0, 200, 0, 29)
                DropdownTitle.Font = Enum.Font.Gotham
                DropdownTitle.Text = ""
                DropdownTitle.TextColor3 = Color3.fromRGB(255,255,255)
                DropdownTitle.TextSize = 14.000
                DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

                DropdownFrameOutline.Name = "DropdownFrameOutline"
                DropdownFrameOutline.Parent = DropdownTitle
                DropdownFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
                DropdownFrameOutline.BackgroundColor3 = Color3.fromRGB(50,50,50)
                DropdownFrameOutline.Position = UDim2.new(0.988442957, 0, 1.0197437, 0)
                DropdownFrameOutline.Size = UDim2.new(0, 396, 0, 36)

                DropdownFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
                DropdownFrameOutlineCorner.Name = "DropdownFrameOutlineCorner"
                DropdownFrameOutlineCorner.Parent = DropdownFrameOutline

                DropdownFrame.Name = "DropdownFrame"
                DropdownFrame.Parent = DropdownTitle
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
                DropdownFrame.ClipsDescendants = true
                DropdownFrame.Position = UDim2.new(0.00899999978, 0, 0.46638527, 0)
                DropdownFrame.Selectable = true
                DropdownFrame.Size = UDim2.new(0, 392, 0, 32)

                DropdownFrameCorner.CornerRadius = UDim.new(0, 3)
                DropdownFrameCorner.Name = "DropdownFrameCorner"
                DropdownFrameCorner.Parent = DropdownFrame

                CurrentSelectedText.Name = "CurrentSelectedText"
                CurrentSelectedText.Parent = DropdownFrame
                CurrentSelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                CurrentSelectedText.BackgroundTransparency = 1.000
                CurrentSelectedText.Position = UDim2.new(0.0178571437, 0, 0, 0)
                CurrentSelectedText.Size = UDim2.new(0, 193, 0, 32)
                CurrentSelectedText.Font = Enum.Font.Gotham
                CurrentSelectedText.Text = text
                CurrentSelectedText.TextColor3 = Color3.fromRGB(255,255,255)
                CurrentSelectedText.TextSize = 14.000
                CurrentSelectedText.TextXAlignment = Enum.TextXAlignment.Left

                ArrowImg.Name = "ArrowImg"
                ArrowImg.Parent = CurrentSelectedText
                ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ArrowImg.BackgroundTransparency = 1.000
                ArrowImg.Position = UDim2.new(1.84974098, 0, 0.167428851, 0)
                ArrowImg.Size = UDim2.new(0, 22, 0, 22)
                ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818372"
                ArrowImg.ImageColor3 = Color3.fromRGB(255,255,255)

                DropdownFrameBtn.Name = "DropdownFrameBtn"
                DropdownFrameBtn.Parent = DropdownFrame
                DropdownFrameBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownFrameBtn.BackgroundTransparency = 1.000
                DropdownFrameBtn.Size = UDim2.new(0, 392, 0, 32)
                DropdownFrameBtn.Font = Enum.Font.SourceSans
                DropdownFrameBtn.Text = ""
                DropdownFrameBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropdownFrameBtn.TextSize = 14.000

                local DropdownFrameMainOutline = Instance.new("Frame")
                local DropdownFrameMainOutlineCorner = Instance.new("UICorner")
                local DropdownFrameMain = Instance.new("Frame")
                local DropdownFrameMainCorner = Instance.new("UICorner")
                local DropItemHolderLabel = Instance.new("TextLabel")
                local DropItemHolder = Instance.new("ScrollingFrame")
                local DropItemHolderLayout = Instance.new("UIListLayout")

                DropdownFrameMainOutline.Name = "DropdownFrameMainOutline"
                DropdownFrameMainOutline.Parent = DropdownTitle
                DropdownFrameMainOutline.BackgroundColor3 = Color3.fromRGB(50,50,50)
                DropdownFrameMainOutline.Position = UDim2.new(-0.00155700743, 0, 1.66983342, 0)
                DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 81)
                DropdownFrameMainOutline.Visible = false

                DropdownFrameMainOutlineCorner.CornerRadius = UDim.new(0, 3)
                DropdownFrameMainOutlineCorner.Name = "DropdownFrameMainOutlineCorner"
                DropdownFrameMainOutlineCorner.Parent = DropdownFrameMainOutline

                DropdownFrameMain.Name = "DropdownFrameMain"
                DropdownFrameMain.Parent = DropdownTitle
                DropdownFrameMain.BackgroundColor3 = Color3.fromRGB(0,0,0)
                DropdownFrameMain.ClipsDescendants = true
                DropdownFrameMain.Position = UDim2.new(0.00799999978, 0, 1.7468965, 0)
                DropdownFrameMain.Selectable = true
                DropdownFrameMain.Size = UDim2.new(0, 392, 0, 77)
                DropdownFrameMain.Visible = false

                DropdownFrameMainCorner.CornerRadius = UDim.new(0, 3)
                DropdownFrameMainCorner.Name = "DropdownFrameMainCorner"
                DropdownFrameMainCorner.Parent = DropdownFrameMain

                DropItemHolderLabel.Name = "ItemHolderLabel"
                DropItemHolderLabel.Parent = DropdownFrameMain
                DropItemHolderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropItemHolderLabel.BackgroundTransparency = 1.000
                DropItemHolderLabel.Position = UDim2.new(0.0178571437, 0, 0, 0)
                DropItemHolderLabel.Size = UDim2.new(0, 193, 0, 13)
                DropItemHolderLabel.Font = Enum.Font.Gotham
                DropItemHolderLabel.Text = ""
                DropItemHolderLabel.TextColor3 = Color3.fromRGB(255,255,255)
                DropItemHolderLabel.TextSize = 14.000
                DropItemHolderLabel.TextXAlignment = Enum.TextXAlignment.Left

                DropItemHolder.Name = "ItemHolder"
                DropItemHolder.Parent = DropItemHolderLabel
                DropItemHolder.Active = true
                DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropItemHolder.BackgroundTransparency = 1.000
                DropItemHolder.Position = UDim2.new(0, 0, 0.215384638, 0)
                DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropItemHolder.ScrollBarThickness = 6
                DropItemHolder.BorderSizePixel = 0
                DropItemHolder.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)

                DropItemHolderLayout.Name = "ItemHolderLayout"
                DropItemHolderLayout.Parent = DropItemHolder
                DropItemHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropItemHolderLayout.Padding = UDim.new(0, 0)
                
                DropdownFrameBtn.MouseButton1Click:Connect(function()
                    if DropTog == false then
                        DropdownFrameMain.Visible = true
                        DropdownFrameMainOutline.Visible = true
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.5, Enum.EasingStyle.Quart),
                            {Size = UDim2.new(0, 403, 0, 60 + DropdownFrameMainOutline.AbsoluteSize.Y)}
                        ):Play()
                        TweenService:Create(
                            ChannelHolder,
                            TweenInfo.new(.5, Enum.EasingStyle.Quart),
                            {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}
                        ):Play()
                    else
                        DropdownFrameMain.Visible = false
                        DropdownFrameMainOutline.Visible = false
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.5, Enum.EasingStyle.Quart),
                            {Size = UDim2.new(0, 403, 0, 60)}
                        ):Play()
                        TweenService:Create(
                            ChannelHolder,
                            TweenInfo.new(.5, Enum.EasingStyle.Quart),
                            {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}
                        ):Play()
                        wait(.2)
                    end
                    DropTog = not DropTog
                end)
                
                
                for i,v in next, list do
                    itemcount = itemcount + 1
                    
                    if itemcount == 1 then
                        framesize = 29
                    elseif itemcount == 2 then
                        framesize = 58
                    elseif itemcount >= 3 then
                        framesize = 87
                    end
                    
                    local Item = Instance.new("TextButton")
                    local ItemCorner = Instance.new("UICorner")
                    local ItemText = Instance.new("TextLabel")

                    Item.Name = "Item"
                    Item.Parent = DropItemHolder
                    Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                    Item.Size = UDim2.new(0, 379, 0, 29)
                    Item.AutoButtonColor = false
                    Item.Font = Enum.Font.SourceSans
                    Item.Text = ""
                    Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Item.TextSize = 14.000
                    Item.BackgroundTransparency = 1

                    ItemCorner.CornerRadius = UDim.new(0, 4)
                    ItemCorner.Name = "ItemCorner"
                    ItemCorner.Parent = Item

                    ItemText.Name = "ItemText"
                    ItemText.Parent = Item
                    ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                    ItemText.BackgroundTransparency = 1.000
                    ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
                    ItemText.Size = UDim2.new(0, 192, 0, 29)
                    ItemText.Font = Enum.Font.Gotham
                    ItemText.TextColor3 = Color3.fromRGB(255,255,255)
                    ItemText.TextSize = 14.000
                    ItemText.TextXAlignment = Enum.TextXAlignment.Left
                    ItemText.Text = v
                    
                    Item.MouseEnter:Connect(function()
                        ItemText.TextColor3 = Color3.fromRGB(255,255,255)
                        Item.BackgroundTransparency = 0
                    end)
                    
                    Item.MouseLeave:Connect(function()
                        ItemText.TextColor3 = Color3.fromRGB(255,255,255)
                        Item.BackgroundTransparency = 1
                    end)
                    
                    Item.MouseButton1Click:Connect(function()
                        CurrentSelectedText.Text = v
                        CurrentSelectedText.TextTransparency = 0.250
                        pcall(callback, v)
                        DropdownFrameMain.Visible = false
                        DropdownFrameMainOutline.Visible = false
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.5, Enum.EasingStyle.Quart),
                            {Size = UDim2.new(0, 403, 0, 60)}
                        ):Play()
                        TweenService:Create(
                            ChannelHolder,
                            TweenInfo.new(.5, Enum.EasingStyle.Quart),
                            {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}
                        ):Play()
                        wait(.2)
                        DropTog = not DropTog
                    end)

                    DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropItemHolderLayout.AbsoluteContentSize.Y)

                    DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
                    DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
                    DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
                end

                ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                
                function DropFunc:Clear()
                    for i,v in next, DropItemHolder:GetChildren() do
                        if v.Name == "Item" then
                            v:Destroy()
                        end
                    end						
                    
                    CurrentSelectedText.Text = "..."
                    
                    itemcount = 0
                    framesize = 0
                    DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
                    DropdownFrameMain.Size = UDim2.new(0, 392, 0, 0)
                    DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 0)
                    Dropdown.Size = UDim2.new(0, 403, 0, 73)
                    DropdownFrameMain.Visible = false
                    DropdownFrameMainOutline.Visible = false
                    ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                function DropFunc:Add(textadd)
                    itemcount = itemcount + 1

                    if itemcount == 1 then
                        framesize = 29
                    elseif itemcount == 2 then
                        framesize = 58
                    elseif itemcount >= 3 then
                        framesize = 87
                    end

                    local Item = Instance.new("TextButton")
                    local ItemCorner = Instance.new("UICorner")
                    local ItemText = Instance.new("TextLabel")

                    Item.Name = "Item"
                    Item.Parent = DropItemHolder
                    Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                    Item.Size = UDim2.new(0, 379, 0, 29)
                    Item.AutoButtonColor = false
                    Item.Font = Enum.Font.SourceSans
                    Item.Text = ""
                    Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Item.TextSize = 14.000
                    Item.BackgroundTransparency = 1

                    ItemCorner.CornerRadius = UDim.new(0, 4)
                    ItemCorner.Name = "ItemCorner"
                    ItemCorner.Parent = Item

                    ItemText.Name = "ItemText"
                    ItemText.Parent = Item
                    ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                    ItemText.BackgroundTransparency = 1.000
                    ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
                    ItemText.Size = UDim2.new(0, 192, 0, 29)
                    ItemText.Font = Enum.Font.Gotham
                    ItemText.TextColor3 = Color3.fromRGB(212, 212, 212)
                    ItemText.TextSize = 14.000
                    ItemText.TextXAlignment = Enum.TextXAlignment.Left
                    ItemText.Text = textadd

                    Item.MouseEnter:Connect(function()
                        ItemText.TextColor3 = Color3.fromRGB(255,255,255)
                        Item.BackgroundTransparency = 0
                    end)

                    Item.MouseLeave:Connect(function()
                        ItemText.TextColor3 = Color3.fromRGB(212, 212, 212)
                        Item.BackgroundTransparency = 1
                    end)

                    Item.MouseButton1Click:Connect(function()
                        CurrentSelectedText.Text = textadd
                        pcall(callback, textadd)
                        Dropdown.Size = UDim2.new(0, 403, 0, 73)
                        DropdownFrameMain.Visible = false
                        DropdownFrameMainOutline.Visible = false
                        ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
                        DropTog = not DropTog
                    end)

                    DropItemHolder.CanvasSize = UDim2.new(0,0,0,DropItemHolderLayout.AbsoluteContentSize.Y)

                    DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
                    DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
                    DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
                end
                return DropFunc
            end
            function ChannelContent:Colorpicker(text, preset, callback)
                local OldToggleColor = Color3.fromRGB(0, 0, 0)
                local OldColor = Color3.fromRGB(0, 0, 0)
                local OldColorSelectionPosition = nil
                local OldHueSelectionPosition = nil
                local ColorH, ColorS, ColorV = 1, 1, 1
                local RainbowColorPicker = false
                local ColorPickerInput = nil
                local ColorInput = nil
                local HueInput = nil
                
                local Colorpicker = Instance.new("Frame")
                local ColorpickerTitle = Instance.new("TextLabel")
                local ColorpickerFrameOutline = Instance.new("Frame")
                local ColorpickerFrameOutlineCorner = Instance.new("UICorner")
                local ColorpickerFrame = Instance.new("Frame")
                local ColorpickerFrameCorner = Instance.new("UICorner")
                local Color = Instance.new("ImageLabel")
                local ColorCorner = Instance.new("UICorner")
                local ColorSelection = Instance.new("ImageLabel")
                local Hue = Instance.new("ImageLabel")
                local HueCorner = Instance.new("UICorner")
                local HueGradient = Instance.new("UIGradient")
                local HueSelection = Instance.new("ImageLabel")
                local PresetClr = Instance.new("Frame")
                local PresetClrCorner = Instance.new("UICorner")

                Colorpicker.Name = "Colorpicker"
                Colorpicker.Parent = ChannelHolder
                Colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Colorpicker.BackgroundTransparency = 1.000
                Colorpicker.Position = UDim2.new(0.0895741582, 0, 0.474232763, 0)
                Colorpicker.Size = UDim2.new(0, 403, 0, 175)

                ColorpickerTitle.Name = "ColorpickerTitle"
                ColorpickerTitle.Parent = Colorpicker
                ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerTitle.BackgroundTransparency = 1.000
                ColorpickerTitle.Position = UDim2.new(0, 5, 0, 0)
                ColorpickerTitle.Size = UDim2.new(0, 200, 0, 29)
                ColorpickerTitle.Font = Enum.Font.Gotham
                ColorpickerTitle.Text = "Colorpicker"
                ColorpickerTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
                ColorpickerTitle.TextSize = 14.000
                ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

                ColorpickerFrameOutline.Name = "ColorpickerFrameOutline"
                ColorpickerFrameOutline.Parent = ColorpickerTitle
                ColorpickerFrameOutline.BackgroundColor3 = Color3.fromRGB(37, 40, 43)
                ColorpickerFrameOutline.Position = UDim2.new(-0.00100000005, 0, 0.991999984, 0)
                ColorpickerFrameOutline.Size = UDim2.new(0, 238, 0, 139)

                ColorpickerFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
                ColorpickerFrameOutlineCorner.Name = "ColorpickerFrameOutlineCorner"
                ColorpickerFrameOutlineCorner.Parent = ColorpickerFrameOutline

                ColorpickerFrame.Name = "ColorpickerFrame"
                ColorpickerFrame.Parent = ColorpickerTitle
                ColorpickerFrame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
                ColorpickerFrame.ClipsDescendants = true
                ColorpickerFrame.Position = UDim2.new(0.00999999978, 0, 1.06638515, 0)
                ColorpickerFrame.Selectable = true
                ColorpickerFrame.Size = UDim2.new(0, 234, 0, 135)

                ColorpickerFrameCorner.CornerRadius = UDim.new(0, 3)
                ColorpickerFrameCorner.Name = "ColorpickerFrameCorner"
                ColorpickerFrameCorner.Parent = ColorpickerFrame

                Color.Name = "Color"
                Color.Parent = ColorpickerFrame
                Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
                Color.Position = UDim2.new(0, 10, 0, 10)
                Color.Size = UDim2.new(0, 154, 0, 118)
                Color.ZIndex = 10
                Color.Image = "rbxassetid://4155801252"

                ColorCorner.CornerRadius = UDim.new(0, 3)
                ColorCorner.Name = "ColorCorner"
                ColorCorner.Parent = Color

                ColorSelection.Name = "ColorSelection"
                ColorSelection.Parent = Color
                ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorSelection.BackgroundTransparency = 1.000
                ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
                ColorSelection.Size = UDim2.new(0, 18, 0, 18)
                ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
                ColorSelection.ScaleType = Enum.ScaleType.Fit

                Hue.Name = "Hue"
                Hue.Parent = ColorpickerFrame
                Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hue.Position = UDim2.new(0, 171, 0, 10)
                Hue.Size = UDim2.new(0, 18, 0, 118)

                HueCorner.CornerRadius = UDim.new(0, 3)
                HueCorner.Name = "HueCorner"
                HueCorner.Parent = Hue

                HueGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
                    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
                    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
                    ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
                }				
                HueGradient.Rotation = 270
                HueGradient.Name = "HueGradient"
                HueGradient.Parent = Hue

                HueSelection.Name = "HueSelection"
                HueSelection.Parent = Hue
                HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueSelection.BackgroundTransparency = 1.000
                HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
                HueSelection.Size = UDim2.new(0, 18, 0, 18)
                HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"

                PresetClr.Name = "PresetClr"
                PresetClr.Parent = ColorpickerFrame
                PresetClr.BackgroundColor3 = preset
                PresetClr.Position = UDim2.new(0.846153855, 0, 0.0740740746, 0)
                PresetClr.Size = UDim2.new(0, 25, 0, 25)

                PresetClrCorner.CornerRadius = UDim.new(0, 3)
                PresetClrCorner.Name = "PresetClrCorner"
                PresetClrCorner.Parent = PresetClr
                
                local function UpdateColorPicker(nope)
                    PresetClr.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                    Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

                    pcall(callback, PresetClr.BackgroundColor3)
                end

                ColorH =
                    1 -
                    (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                        Hue.AbsoluteSize.Y)
                ColorS =
                    (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                        Color.AbsoluteSize.X)
                ColorV =
                    1 -
                    (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                        Color.AbsoluteSize.Y)

                PresetClr.BackgroundColor3 = preset
                Color.BackgroundColor3 = preset
                pcall(callback, PresetClr.BackgroundColor3)

                Color.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then

                            if ColorInput then
                                ColorInput:Disconnect()
                            end

                            ColorInput =
                                RunService.RenderStepped:Connect(
                                    function()
                                    local ColorX =
                                        (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                                            Color.AbsoluteSize.X)
                                    local ColorY =
                                        (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                                            Color.AbsoluteSize.Y)

                                    ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                                    ColorS = ColorX
                                    ColorV = 1 - ColorY

                                    UpdateColorPicker(true)
                                end
                                )
                        end
                    end
                )

                Color.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if ColorInput then
                                ColorInput:Disconnect()
                            end
                        end
                    end
                )

                Hue.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then


                            if HueInput then
                                HueInput:Disconnect()
                            end

                            HueInput =
                                RunService.RenderStepped:Connect(
                                    function()
                                    local HueY =
                                        (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                                            Hue.AbsoluteSize.Y)

                                    HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                                    ColorH = 1 - HueY

                                    UpdateColorPicker(true)
                                end
                                )
                        end
                    end
                )

                Hue.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if HueInput then
                                HueInput:Disconnect()
                            end
                        end
                    end
                )
                
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            end
            
            function ChannelContent:Textbox(text, placetext, disapper, callback)
                local Textbox = Instance.new("Frame")
                local TextboxCorner = Instance.new("UICorner")
                local TextboxTitle = Instance.new("TextLabel")
                local TextboxFrameOutline = Instance.new("Frame")
                local TextboxFrameOutlineCorner = Instance.new("UICorner")
                local TextboxFrame = Instance.new("Frame")
                local TextboxFrameCorner = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")

                Textbox.Name = "Textbox"
                Textbox.Parent = ChannelHolder
                Textbox.BackgroundColor3 = Color3.fromRGB(35,35,35)
                Textbox.BackgroundTransparency = 0
                Textbox.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
                Textbox.Size = UDim2.new(0, 403, 0, 73)

                TextboxCorner.CornerRadius = UDim.new(0, 5)
                TextboxCorner.Name = "TextboxCorner"
                TextboxCorner.Parent = Textbox

                TextboxTitle.Name = "TextboxTitle"
                TextboxTitle.Parent = Textbox
                TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.BackgroundTransparency = 1.000
                TextboxTitle.Position = UDim2.new(0, 5, 0, 0)
                TextboxTitle.Size = UDim2.new(0, 200, 0, 29)
                TextboxTitle.Font = Enum.Font.Gotham
                TextboxTitle.Text = text
                TextboxTitle.TextColor3 = Color3.fromRGB(255,255,255)
                TextboxTitle.TextSize = 14.000
                TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

                TextboxFrameOutline.Name = "TextboxFrameOutline"
                TextboxFrameOutline.Parent = TextboxTitle
                TextboxFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
                TextboxFrameOutline.BackgroundColor3 = Color3.fromRGB(50,50,50)
                TextboxFrameOutline.Position = UDim2.new(0.988442957, 0, 1.6197437, 0)
                TextboxFrameOutline.Size = UDim2.new(0, 396, 0, 36)

                TextboxFrameOutlineCorner.CornerRadius = UDim.new(0, 4)
                TextboxFrameOutlineCorner.Name = "TextboxFrameOutlineCorner"
                TextboxFrameOutlineCorner.Parent = TextboxFrameOutline

                TextboxFrame.Name = "TextboxFrame"
                TextboxFrame.Parent = TextboxTitle
                TextboxFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
                TextboxFrame.ClipsDescendants = true
                TextboxFrame.Position = UDim2.new(0.00999999978, 0, 1.06638527, 0)
                TextboxFrame.Selectable = true
                TextboxFrame.Size = UDim2.new(0, 392, 0, 32)

                TextboxFrameCorner.CornerRadius = UDim.new(0, 3)
                TextboxFrameCorner.Name = "TextboxFrameCorner"
                TextboxFrameCorner.Parent = TextboxFrame

                TextBox.Parent = TextboxFrame
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.Position = UDim2.new(0.0178571437, 0, 0, 0)
                TextBox.Size = UDim2.new(0, 377, 0, 32)
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderColor3 = Color3.fromRGB(255,255,255)
                TextBox.PlaceholderText = placetext
                TextBox.Text = ""
                TextBox.TextColor3 = Color3.fromRGB(255,255,255)
                TextBox.TextSize = 14.000
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                
                TextBox.Focused:Connect(function()
                    TweenService:Create(
                        TextboxFrameOutline,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(0,0,0)}
                    ):Play()
                end)
                
                TextBox.FocusLost:Connect(function(ep)
                    TweenService:Create(
                        TextboxFrameOutline,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50,50,50)}
                    ):Play()
                    if ep then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                            if disapper then
                                TextBox.Text = ""
                            end
                        end
                    end
                end)
                
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            end
            
            function ChannelContent:Label(text)
                local Label = Instance.new("TextButton")
                local LabelTitle = Instance.new("TextLabel")
                local LabelCorner = Instance.new("UICorner")
                local labelfunc = {}
                local Linear = text

                Label.Name = "Label"
                Label.Parent = ChannelHolder
                Label.BackgroundColor3 = Color3.fromRGB(35,35,35)
                Label.BorderSizePixel = 0
                Label.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                Label.Size = UDim2.new(0, 401, 0, 30)
                Label.AutoButtonColor = false
                Label.Font = Enum.Font.Gotham
                Label.Text = ""
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 14.000

                LabelCorner.Name = "LabelCorner"
                LabelCorner.Parent = Label
                LabelCorner.CornerRadius = UDim.new(0, 3)

                LabelTitle.Name = "LabelTitle"
                LabelTitle.Parent = Label
                LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.BackgroundTransparency = 1.000
                LabelTitle.Position = UDim2.new(0, 5, 0, 0)
                LabelTitle.Size = UDim2.new(0, 200, 0, 30)
                LabelTitle.Font = Enum.Font.Gotham
                LabelTitle.Text = "|| "..text.." ||"
                LabelTitle.TextColor3 = Color3.fromRGB(255,255,255)
                LabelTitle.TextSize = 14.000
                LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)

                function labelfunc:Refresh(tochange)
                    Label.Text = tochange
                end
                return labelfunc
            end

            function ChannelContent:Label2(text)
                local Label2 = Instance.new("TextButton")
                local LabelTitle2 = Instance.new("TextLabel")
                local LabelCorner2 = Instance.new("UICorner")
                local labelfunc2 = {}

                Label2.Name = "Label2"
                Label2.Parent = ChannelHolder
                Label2.BackgroundColor3 = Color3.fromRGB(35,35,35)
                Label2.BorderSizePixel = 0
                Label2.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                Label2.Size = UDim2.new(0, 401, 0, 30)
                Label2.AutoButtonColor = false
                Label2.Font = Enum.Font.Gotham
                Label2.Text = ""
                Label2.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label2.TextSize = 14.000

                LabelCorner2.Name = "LabelCorner2"
                LabelCorner2.Parent = Label2
                LabelCorner2.CornerRadius = UDim.new(0, 3)

                LabelTitle2.Name = "LabelTitle2"
                LabelTitle2.Parent = Label2
                LabelTitle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle2.BackgroundTransparency = 1.000
                LabelTitle2.Position = UDim2.new(0, 5, 0, 0)
                LabelTitle2.Size = UDim2.new(0, 200, 0, 30)
                LabelTitle2.Font = Enum.Font.Gotham
                LabelTitle2.Text = text
                LabelTitle2.TextColor3 = Color3.fromRGB(255,255,255)
                LabelTitle2.TextSize = 14.000
                LabelTitle2.TextXAlignment = Enum.TextXAlignment.Left
                
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)

                function labelfunc2:Refresh(tochange)
                    Label2.Text = tochange
                end
                return labelfunc2
            end
            
            function ChannelContent:Bind(text, presetbind, callback)
                local Key = presetbind.Name
                local Keybind = Instance.new("TextButton")
                local KeybindTitle = Instance.new("TextLabel")
                local KeybindText = Instance.new("TextLabel")

                Keybind.Name = "Keybind"
                Keybind.Parent = ChannelHolder
                Keybind.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
                Keybind.BorderSizePixel = 0
                Keybind.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                Keybind.Size = UDim2.new(0, 401, 0, 30)
                Keybind.AutoButtonColor = false
                Keybind.Font = Enum.Font.Gotham
                Keybind.Text = ""
                Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
                Keybind.TextSize = 14.000

                KeybindTitle.Name = "KeybindTitle"
                KeybindTitle.Parent = Keybind
                KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindTitle.BackgroundTransparency = 1.000
                KeybindTitle.Position = UDim2.new(0, 5, 0, 0)
                KeybindTitle.Size = UDim2.new(0, 200, 0, 30)
                KeybindTitle.Font = Enum.Font.Gotham
                KeybindTitle.Text = text
                KeybindTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
                KeybindTitle.TextSize = 14.000
                KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

                KeybindText.Name = "KeybindText"
                KeybindText.Parent = Keybind
                KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindText.BackgroundTransparency = 1.000
                KeybindText.Position = UDim2.new(0, 316, 0, 0)
                KeybindText.Size = UDim2.new(0, 85, 0, 30)
                KeybindText.Font = Enum.Font.Gotham
                KeybindText.Text = presetbind.Name
                KeybindText.TextColor3 = Color3.fromRGB(127, 131, 137)
                KeybindText.TextSize = 14.000
                KeybindText.TextXAlignment = Enum.TextXAlignment.Right
                
                Keybind.MouseButton1Click:Connect(function()
                    KeybindText.Text = "..."
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        KeybindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                    end
                end)
                
                game:GetService("UserInputService").InputBegan:connect(
                function(current, pressed)
                    if not pressed then
                        if current.KeyCode.Name == Key then
                            pcall(callback)
                        end
                    end
                end
                )
                ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            end
            
            return ChannelContent
        end
        
        return ChannelHold
    end
    return ServerHold
end


    local IMightKillMyselfCauseOfThis = {
            --Misc
            ['VIP'] = {'VIP'};
            --Spawn
            ['Town'] = {'Town', 'Town FRONT'}; ['Forest'] = {'Forest', 'Forest FRONT'}; ['Beach'] = {'Beach', 'Beach FRONT'}; ['Mine'] = {'Mine', 'Mine FRONT'}; ['Winter'] = {'Winter', 'Winter FRONT'}; ['Glacier'] = {'Glacier', 'Glacier Lake'}; ['Desert'] = {'Desert', 'Desert FRONT'}; ['Volcano'] = {'Volcano', 'Volcano FRONT'};
            -- Fantasy init
            ['Enchanted Forest'] = {'Enchanted Forest', 'Enchanted Forest FRONT'}; ['Ancient Island'] = {'Ancient Island'}; ['Samurai Island'] = {'Samurai Island', 'Samurai FRONT'}; ['Candy Island'] = {'Candy Island'}; ['Haunted Island'] = {'Haunted Island', 'Haunted FRONT'}; ['Hell Island'] = {'Hell Island'}; ['Heaven Island'] = {'Heaven Island'};
            -- Tech
            ['Ice Tech'] = {'Ice Tech'}; ['Tech City'] = {'Tech City'; 'Tech City FRONT'}; ['Dark Tech'] = {'Dark Tech'; 'Dark Tech FRONT'}; ['Steampunk'] = {'Steampunk'; 'Steampunk FRONT'}, ['Alien Forest'] = {"Alien Forest"; "Alien Forest FRONT"}, ['Alien Lab'] = {"Alien Forest"; "Alien Lab FRONT"}, ['Glitch'] = {"Glitch"; "Glitch FRONT"}, ["Hacker Portal"] = {'Hacker Portal'; "Hacker Portal FRONT"}
    }
    
     local AreaList = {
        'VIP';
        'Town'; 'Forest'; 'Beach'; 'Mine'; 'Winter'; 'Glacier'; 'Desert'; 'Volcano';
        'Enchanted Forest'; 'Ancient Island'; 'Samurai Island'; 'Candy Island'; 'Haunted Island'; 'Hell Island'; 'Heaven Island';
        'Ice Tech'; 'Tech City'; 'Dark Tech'; 'Steampunk'; 'Alien Lab'; 'Alien Forest'; 'Glitch'; 'Hacker Portal';

    }
    

    local Chests = {
            -- Spawn
            "Magma Chest",
            -- Fantasy
            "Enchanted Chest", "Hell Chest", "Haunted Chest", "Angel Chest", "Grand Heaven Chest",
            -- Tech
            "Giant Tech Chest"; "Giant Steampunk Chest"; "Giant Alien Chest"; "Giant Hacker Chest"
            }
    
    local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
    local Network = GameLibrary.Network
    local Run_Service = game:GetService("RunService")
    local rs = Run_Service.RenderStepped
    local CurrencyOrder = {"Tech Coins", "Fantasy Coins", "Coins", "Diamonds"}
    
    local Library = require(game:GetService("ReplicatedStorage").Framework.Library)
    local IDToName = {}
    local NameToID = {}
    for i,v in pairs(Library.Directory.Pets ) do
     IDToName[i] = v.name
     NameToID[v.name] = i
    end      
     
       local AreaWorldTable = {}
     for _, v in pairs(game:GetService("ReplicatedStorage").Game.Coins:GetChildren()) do
      for _, b in pairs(v:GetChildren()) do
          table.insert(AreaWorldTable, b.Name)
      end
      table.insert(AreaWorldTable, v.Name)
     end
     
     function AllChests()
        local returntable = {}
        local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
        for i,v in pairs(ListCoins) do
            local shit = v
            shit.index = i
            for aa,bb in pairs(AreaWorldTable) do
                if string.find(v.n, bb) or string.find(v.n, "Giant") then
                    local thing = string.gsub(v.n, bb.." ", "")
                    if table.find(Chests, thing) then
                        shit.n = thing
                        table.insert(returntable, shit)
                    end
                end
            end
        end
        return returntable
    end
    
    
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "buy egg")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "join coin")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "farm coin")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "claim orbs")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "change pet target")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "get trade")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "add trade pet")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "remove trade pet")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "convert to dark matter")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "redeem dark matter pet")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "redeem rank rewards")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "redeem vip rewards")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "toggle setting")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("a", "activate boost")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "use golden machine")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "use rainbow machine")
    workspace.__THINGS.__REMOTES.MAIN:FireServer("b", "buy merchant item")
    
    function FarmCoin(CoinID, PetID)
        game.workspace['__THINGS']['__REMOTES']["join coin"]:InvokeServer({[1] = CoinID, [2] = {[1] = PetID}})
        game.workspace['__THINGS']['__REMOTES']["farm coin"]:FireServer({[1] = CoinID, [2] = PetID})
     end
    
          function getGemid()
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetDescendants()) do
                if v:IsA"MeshPart" then
                    if v.MeshId == 'rbxassetid://7041620873' or v.MeshId == 'rbxassetid://7041621431' or v.MeshId == 'rbxassetid://7041621329' or v.MeshId == 'rbxassetid://7041620873' then
                        a = v.Parent.Name
                    end
                end
            end
            return a
        end
    
         
         function GetMyPets()
            local returntable = {}
            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets:GetChildren()) do
                if v.ClassName == 'TextButton' and v.Equipped.Visible then
                    table.insert(returntable, v.Name)
                end
            end
            return returntable
         end
    
      function GetPets()
        local MyPets = {}
        for i,v in pairs(GameLibrary.Save.Get().Pets) do
                local ThingyThingyTempTypeThing = (v.g and 'Gold') or (v.r and 'Rainbow') or (v.dm and 'Dark Matter') or 'Normal'
                local TempString = ThingyThingyTempTypeThing .. IDToName[v.id]
                if MyPets[TempString] then
                    table.insert(MyPets[TempString], v.uid)
                else
                    MyPets[TempString] = {}
                    table.insert(MyPets[TempString], v.uid)
                end
        end
        return MyPets
      end
    
      function GetCoinss(area)
        local returntable = {}
        local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
        for i,v in pairs(ListCoins) do
            if string.lower(v.a) == string.lower(area) then
                table.insert(returntable, i)
            end
        end
        return returntable
     end

      if getgenv().MyConnection then getgenv().MyConnection:Disconnect() end
      getgenv().MyConnection = game.Workspace.__THINGS.Orbs.ChildAdded:Connect(function(Orb)
          game.Workspace.__THINGS.__REMOTES["claim orbs"]:FireServer({{Orb.Name}})
      end)
      
     
    local window = DiscordLib:Window("PET SIMULATOR X")
    local serv = window:Server("SAZA HUB", "http://www.roblox.com/asset/?id=8401150805")
    local AF2 = serv:Channel("Main", "http://www.roblox.com/asset/?id=173616340")
    local AF = serv:Channel("Farming", "http://www.roblox.com/asset/?id=6022668945")
    local AF3 = serv:Channel("Misc", "http://www.roblox.com/asset/?id=4814044817")
    local AF4 = serv:Channel("Egg", "http://www.roblox.com/asset/?id=6396462860")
    local AF5 = serv:Channel("Pets", "http://www.roblox.com/asset/?id=4814044817")
    local AF6 = serv:Channel("GUi", "http://www.roblox.com/asset/?id=3805250049")
    local AF7 = serv:Channel("Webhook", "http://www.roblox.com/asset/?id=846181795")
    
    Client = AF:Label2("Client:")
     
    function UpdateClient()
        local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local Fps = workspace:GetRealPhysicsFPS()
        Client:Refresh("Fps : "..Fps.." Ping : "..Ping)
    end
    
    spawn(function()
        while true do
            UpdateClient()
            wait()
        end
    end)
    
    AF:Seperator()
    
    
    AF:Toggle("Auto Collect Lootbags", false, function(vu)
        getgenv().CollectLootbag = vu
    
        while task.wait(.5) do
            if getgenv().CollectLootbag then
                for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
                    if v:IsA('MeshPart') then
                    v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    end
                    end
            end
            end
    end)
    
    AF:Seperator()
    
    getgenv().selectchest = ""
    AF:Label("ChestFarm")
    
    AF:Dropdown("Select Chest", Chests, function(chestlist)
        if chestlist then
            getgenv().selectchest = chestlist
        end
       end)
       
       AF:Toggle("AutoFarm Chest", false, function(chestfram)
        if chestfram == true then
            getgenv().autoChests = true
        elseif chestfram == false then
            getgenv().autoChests = false
        end
        
        if autoChests and selectchest == "" then
            DiscordLib:Notification("SazaSystem:", "Select Chest First", 3)
        else
    
            while getgenv().autoChests do
                local pethingy = GetMyPets()
                for i,v in pairs(AllChests()) do
                    if (v.n == getgenv().selectchest) or (getgenv().selectchest == 'All') then
                        local starttick = tick()
                        for a, b in pairs(pethingy) do
                            coroutine.wrap(function() FarmCoin(v.index, b) end)()
                        end
                        repeat task.wait() until not game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(v.index) or #game:GetService("Workspace")["__THINGS"].Coins[v.index].Pets:GetChildren() == 0
                        --warn(v.n .. " has been broken in", tick()-starttick)
                    end
                end
           
            end
        end
    
       end)
    
    AF:Seperator()
    AF:Label("FilterFarm")
    
    AF:Toggle("Prioritize Gem", false, function(vu)
        getgenv().farmgem = vu
        while wait() do
            if getgenv().farmgem then
                for i,v in next, GetMyPets() do
                pcall(function() FarmCoin(getGemid(), v) end)
           end
        end
    end
    end)

    AF:Seperator()
    
    AF:Label("|| Tech ||")

    AF:Toggle("Hacker Portal, Note: Make FPS Drop", false, function(t)
        getgenv().Start = t
        getgenv().Area = 'Hacker Portal'

        while Start do
        local CurrentFarmingPets = {}
        local cointhiny = GetCoinss(Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            if i%#pethingy == #pethingy-1 then wait() end
            if not CurrentFarmingPets[pethingy[i%#pethingy+1]] or CurrentFarmingPets[pethingy[i%#pethingy+1]] == nil then
              wait(0.1)
                spawn(function()
                    CurrentFarmingPets[pethingy[i%#pethingy+1]] = 'Farming'
                    FarmCoin(cointhiny[i], pethingy[i%#pethingy+1])
                    repeat rs:wait() until not game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[i]) or #game:GetService("Workspace")["__THINGS"].Coins:FindFirstChild(cointhiny[i]).Pets:GetChildren() == 0 or not Start
                    CurrentFarmingPets[pethingy[i%#pethingy+1]] = nil
                end)
            end      
        end  
      end
end)

    AF:Toggle("Glitch", false, function(t)
        getgenv().Start = t
        getgenv().Area = 'Glitch'
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
end)
    
    AF:Toggle("Alien Forest", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Alien Forest"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
end)
    
    AF:Toggle("Alien Lab", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Alien Lab"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Steampunk", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Steampunk"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    
    AF:Toggle("Dark Tech", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Dark Tech"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Tech City", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Tech City"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Label("|| Fantasy ||")
    
    AF:Toggle("Enchanted Forest", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Enchanted Forest"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Ancient Island", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Ancient Island"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Samurai Island", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Samurai Island"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    
    AF:Toggle("Candy Island", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Candy Island"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
    end)
    
    
    AF:Toggle("Haunted Island", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Haunted Island"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
    end)
    
    AF:Toggle("Hell Island", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Hell Island"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
    end)
    
    AF:Toggle("Heaven Island", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Heaven Island"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    
    AF:Label("|| Spawn ||")
    
    AF:Toggle("Town", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Town"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Forest", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Forest"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    
    AF:Toggle("Beach", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Beach"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Mine", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Mine"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Glacier", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Glacier"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Desert", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Desert"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Toggle("Volcano", false, function(t)
        getgenv().Start = t
        getgenv().Area = "Volcano"
    
        while Start do
            local cointhiny = GetCoinss(Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do
                pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
         end
    end)
    
    AF:Seperator()
    
    local pathToScript = game.Players.LocalPlayer.PlayerScripts.Scripts.Game['Open Eggs']
    local oldFunc = getsenv(pathToScript).OpenEgg
    
    AF2:Label("Credits")
    AF2:Button("Join Discord SAZA HUB", function()
            local request = (syn and syn.request) or (http and http.request) or http_request
         
            if request then 
                request({
                   Url = "http://127.0.0.1:6463/rpc?v=1",
                   Method = "POST",
                   Headers = {
                       ["Content-Type"] = "application/json",
                       ["Origin"] = "https://discord.com"
                   },
                   Body = game:GetService("HttpService"):JSONEncode({
                      cmd = "INVITE_BROWSER",
                       args = {code = "jhnvcjge2h"},
                       nonce = game:GetService("HttpService"):GenerateGUID(false)
                   }),
                })
              
            end
            DiscordLib:Notification("SazaSystem:","Link Discord Has Coppied", 3)
              setclipboard("https://discord.gg/jhnvcjge2h")
         end)
    
         function destroyguis()
            game:GetService("CoreGui")["Discord"]:Destroy()
           end
    
         AF2:Button("Delete Gui", function()
            DiscordLib:Notification("SazaSystem:","Thanks for use SAZA HUB", 3)
            wait(3)
            destroyguis()
         end)

         AF2:Button("Rejoin",function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
         end)
    
         AF3:Button("Unlock Gamepasses", function()
            DiscordLib:Notification("SazaSystem:", "Teleport & SuperMagnet has unlock", 5)
            local main = debug.getupvalues(require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library")).Save.Get)[2][game.Players.LocalPlayer].save.Gamepasses
            table.insert(main,18674296)
            table.insert(main,26398305)
            table.insert(main,18674321)        
        end)
    
        AF3:Button("Stat Tracker", function()
            local gamelibrary = require(game:GetService("ReplicatedStorage").Framework.Library)
            local Save = gamelibrary.Save.Get
            local Commas = gamelibrary.Functions.Commas
            local types = {}
            local menus = game:GetService("Players").LocalPlayer.PlayerGui.Main.Right
            for i, v in pairs(menus:GetChildren()) do
                if v.ClassName == 'Frame' and v.Name ~= 'Rank' and not string.find(v.Name, "2") then
                    table.insert(types, v.Name)
                end
            end
            
            function get(thistype)
                return Save()[thistype]
            end
            
            menus.Diamonds.LayoutOrder = 99988
            menus['Tech Coins'].LayoutOrder = 99992
            menus['Fantasy Coins'].LayoutOrder = 99994
            menus.Coins.LayoutOrder = 99996
            menus.UIListLayout.HorizontalAlignment = 2
            
            getgenv().MyTypes = {}
            for i,v in pairs(types) do
                if menus:FindFirstChild(v.."2") then
                    menus:FindFirstChild(v.."2"):Destroy()
                end
            end
            for i,v in pairs(types) do
                if not menus:FindFirstChild(v.."2") then
                    local tempmaker = menus:FindFirstChild(v):Clone()
                    tempmaker.Name = tostring(tempmaker.Name .. "2")
                    tempmaker.Parent = menus
                    tempmaker.Size = UDim2.new(0, 175, 0, 30)
                    tempmaker.LayoutOrder = tempmaker.LayoutOrder + 1
                    getgenv().MyTypes[v] = tempmaker
                end
            end
            menus.Diamonds2.Add.Visible = false
            
            -- Skidded from byte-chan:tm:
            for i,v in pairs(types) do
                spawn(function()
                    local megatable = {}
                    local imaginaryi = 1
                    local ptime = 0
                    local last = tick()
                    local now = last
                    local TICK_TIME = 0.5
                    while true do
                        if ptime >= TICK_TIME then
                            while ptime >= TICK_TIME do ptime = ptime - TICK_TIME end
                            local currentbal = get(v)
                            megatable[imaginaryi] = currentbal
                            local diffy = currentbal - (megatable[imaginaryi-120] or megatable[1])
                            imaginaryi = imaginaryi + 1
                            getgenv().MyTypes[v].Amount.Text = tostring(Commas(diffy).." in 60s")
                            getgenv().MyTypes[v]["Amount_odometerGUIFX"].Text = tostring(Commas(diffy).." in 60s")
                        end
                        task.wait(0.001)
                        now = tick()
                        ptime = ptime + (now - last)
                        last = now
                    end
                end)
            end        
        end)
    
        AF3:Button("Lag Reducer", function()
            local decalsyeeted = true
            local g = game
            local w = g.Workspace
            local l = g.Lighting
            local t = w.Terrain
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
            t.WaterTransparency = 0
            l.GlobalShadows = false
            l.FogEnd = 9e9
            l.Brightness = 0
            game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.GUIs["Coin Rewards HUD"].Disabled = true
            local a = game:GetService("Workspace")["__DEBRIS"]
            local b = a:Clone()
            b.Parent = a.Parent
            a:Destroy()
            for _,v in pairs(b:GetChildren()) do
             if v.Name == 'RewardBillboard' then
                 v:Destroy()
             end
         end			
            settings().Rendering.QualityLevel = "Level01"
            for i,v in pairs(g:GetDescendants()) do
                if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") and decalsyeeted then 
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then 
                    v.Lifetime = NumberRange.new(0)
                end
            end
        end)
    
     AF2:Label("Press Right-CTRL for Hide Gui")
     AF2:Label("Anti AFK Always On")
    
    AF2:Seperator()
    AF2:Label(" Owner: Zaaa 愛#1688, Saskai#2799")
    
    AF3:Label("AutoRewards")
    
    
    AF3:Toggle("Auto Rewards RANK", false, function(autorewards)
    
     if autorewards == true then
        getgenv().AutoRewards1 = true
     elseif autorewards == false then
        getgenv().AutoRewards1 = false
     end
     
     while task.wait() and getgenv().AutoRewards1 do
         workspace.__THINGS.__REMOTES["redeem rank rewards"]:InvokeServer({})			
     end
    end)
    
    AF3:Toggle("Auto Rewards VIP", false, function(autorewards3)
    
     if autorewards3 == true then
        getgenv().AutoRewards2 = true
     elseif autorewards3 == false then
        getgenv().AutoRewards2 = false
     end
     
     while task.wait() and getgenv().AutoRewards2 do
         workspace.__THINGS.__REMOTES["redeem vip rewards"]:InvokeServer({})		
     end
    end)
    AF3:Seperator()
    AF3:Label("Boost")
    
    AF3:Toggle("Boost 3X Damage", false, function(autotripledamage)
        if autotripledamage == true then
            getgenv().TripleDamage1 = true
        elseif autotripledamage == false  then
            getgenv().TripleDamage1 = false
            end
        
        
        while wait(5) do
          if getgenv().TripleDamage1 then 
            if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Triple Damage") then
                workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Triple Damage"})
            end
          end
        end
        end)
        
        AF3:Toggle("Boost 3X Coins", false, function(autotriplecoins)
        
        if autotriplecoins == true then
            getgenv().TripleCoins1 = true
        elseif autotriplecoins == false then
            getgenv().TripleCoins1 = false
            end
        
        while wait(5) do
            if getgenv().TripleCoins1 then
                if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Triple Coins") then
                    workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Triple Coins"})
            end
          end
        end
        end)
    
        AF3:Toggle("Boost Super Lucky", false, function(autotripledamage)
            if autotripledamage == true then
                getgenv().SuperLucky = true
            elseif autotripledamage == false  then
                getgenv().SuperLucky = false
                end
            
            
            while wait(5) do
              if getgenv().SuperLucky then 
                if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Super Lucky") then
                    workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Super Lucky"})
                end
              end
            end
            end)
            
            AF3:Toggle("Boost Ultra Lucky", false, function(autotriplecoins)
            
            if autotriplecoins == true then
                getgenv().UltraLucky = true
            elseif autotriplecoins == false then
                getgenv().UltraLucky = false
                end
            
            while wait(5) do
                if getgenv().UltraLucky then
                    if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Ultra Lucky") then
                        workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Ultra Lucky"})
                end
              end
            end
            end)

            local MyEggData = {}
            local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
            for i,v in pairs(GameLibrary.Directory.Eggs) do
                local temptable = {}
                temptable['Name'] = i
                temptable['Currency'] = v.currency
                temptable['Price'] = v.cost
                table.insert(MyEggData, temptable)
            end
            
            table.sort(MyEggData, function(a, b)
                return a.Price < b.Price
            end)
            
            local EggData = {}
            for i,v in pairs(CurrencyOrder) do
                table.insert(EggData, " ")
                table.insert(EggData, "|| "..v.." ||")
                for a,b in pairs(MyEggData) do
                    if b.Currency == v then
                        table.insert(EggData, b.Name)
                    end
                end
            end
    
    AF4:Dropdown("Select egg", EggData, function(egglis)
        if egglis then
            getgenv().Egg = egglis
        end
    end)
    
    AF4:Toggle("Auto Egg", false, function(buyegg)
        getgenv().autoeggbuy = buyegg
        end)
        local openeegg = egglis
        game:GetService("RunService").RenderStepped:connect(function()
        if getgenv().autoeggbuy then
            local args = {
                [1] = getgenv().Egg,
                [2] = getgenv().TripleHatch
            }
            workspace.__THINGS.__REMOTES["buy egg"]:InvokeServer(args)
            wait(0.5)
            end
        end)
    
        AF4:Toggle("3x Egg Hatch (Need Gamepasses)", false, function(tripleegg)
            if tripleegg == true then
                getgenv().TripleHatch = true
            elseif tripleegg == false then
                getgenv().TripleHatch = false
                end
            end)
            getgenv().TripleHatch = false
           
           
           AF4:Toggle("Remove Animation", false, function(removeanimation)
            if removeanimation == true then 
                getsenv(pathToScript).OpenEgg = function() return end 
            else
                getsenv(pathToScript).OpenEgg = oldFunc
            end 
           end)
           
           AF5:Label("RB/GOLD")
           AF5:Slider("Select pet amount",0, 6, 4, function(countcombinefunc)
            if countcombinefunc then
                getgenv().CountCombineFunc1 = countcombinefunc
            end
           end)
           
            AF5:Toggle("Converted Gold", false, function(autocombinefunc)
                if autocombinefunc == true then
                    getgenv().AutoCom = true
                elseif autocombinefunc == false then
                    getgenv().AutoCom = false
                end
                getgenv().togrbgold = 'Gold'
                game:GetService("RunService").RenderStepped:connect(function()
                if getgenv().AutoCom then
                    for i, v in pairs(GetPets()) do
                        if #v >= getgenv().CountCombineFunc1 and getgenv().AutoCom then
                            if string.find(i, "Normal") and getgenv().AutoCom and getgenv().togrbgold == 'Gold' then
                                local Args = {}
                                for eeeee = 1, getgenv().CountCombineFunc1 do
                                    Args[#Args+1] = v[#Args+1]
                                end
                                Library.Network.Invoke("use golden machine", Args)
                            end
                        end
                end
            end
           end)
           end)
           
           AF5:Toggle("Converted Rainbow", false, function(combinerb)
            if combinerb == true then
                getgenv().autoRB = true
            elseif combinerb == false then
                getgenv().autoRB = false
            end
            getgenv().togrb = 'Rainbow'
            game:GetService("RunService").RenderStepped:connect(function()
            if getgenv().autoRB then
                for i, v in pairs(GetPets()) do
                    if #v >= getgenv().CountCombineFunc1 and getgenv().autoRB then
                        if string.find(i, "Gold") and getgenv().autoRB and getgenv().togrb == 'Rainbow'then
                            local Args = {}
                            for eeeee = 1, getgenv().CountCombineFunc1 do
                                Args[#Args+1] = v[#Args+1]
                            end
                            Library.Network.Invoke("use rainbow machine", Args)
                            wait(.1)
                        end
                    end
              end
           end
           end)
           end)

           AF5:Seperator()

           local function SecondsToClock(seconds) 
            local days = math.floor(seconds / 86400)
            seconds = seconds - days * 86400
            local hours = math.floor(seconds / 3600 )
            seconds = seconds - hours * 3600
            local minutes = math.floor(seconds / 60) 
            seconds = seconds - minutes * 60
    
            return string.format("%d d, %d h, %d m, %d s.",days,hours,minutes,seconds)
          end
          
           AF5:Label("Dark Matter")


           AF5:Toggle("Auto Claim Dark Matter", false ,function(vu)
            getgenv().ClaimDarkMatter = vu

            while task.wait() and getgenv().AutoClaimDarkMatter do
                for i,v in pairs(GameLibrary.Save.Get().DarkMatterQueue) do
                    if math.floor(v.readyTime - os.time()) < 0 then
                        workspace.__THINGS.__REMOTES["redeem dark matter pet"]:InvokeServer({[1] = i})
                    end
                    end
                task.wait(15)
            end
           end)

           AF5:Button("Check Time", function()
            local PetList = {}
            for i,v in pairs(GameLibrary.Directory.Pets) do
            PetList[i] = v.name
            end
    
            local returnstring = ""
            for i,v in pairs(GameLibrary.Save.Get().DarkMatterQueue) do
                local timeleft = 'Ready.'
                if math.floor(v.readyTime - os.time()) > 0 then
                    timeleft = SecondsToClock(math.floor(v.readyTime - os.time()))
                end
                local stringthing = PetList[v.petId] .." going to be ready in: ".. timeleft
                returnstring = returnstring .. stringthing .. "\n"
            end
            require(game:GetService("ReplicatedStorage").Framework.Modules.Client["5 | Message"]).New(returnstring)
    end)
    
        
    AF6:Label("Important GUi")
    AF6:Button("Bank Guis", function()
        game:GetService("Players").LocalPlayer.PlayerGui.Bank.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.Bank.Enabled
       end)
       
       AF6:Button("Pet Collection Guis", function()
        game:GetService("Players").LocalPlayer.PlayerGui.Collection.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.Collection.Enabled
       end)
       
       AF6:Button("Fuse Pets Guis", function()
              game:GetService("Players").LocalPlayer.PlayerGui.FusePets.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.FusePets.Enabled
          end)
       
          AF6:Button("Gold Guis", function()
              game:GetService("Players").LocalPlayer.PlayerGui.Golden.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.Golden.Enabled
          end)
       
          AF6:Button("Rainbow Guis", function()
              game:GetService("Players").LocalPlayer.PlayerGui.Rainbow.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.Rainbow.Enabled
          end)
       
          AF6:Button("Dark Matter Guis", function()
              game:GetService("Players").LocalPlayer.PlayerGui.DarkMatter.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.DarkMatter.Enabled
          end)
       
          AF6:Button("Merchant Guis", function()
              game:GetService("Players").LocalPlayer.PlayerGui.Merchant.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.Merchant.Enabled
          end)
       
          AF6:Button("Enchant Guis", function()
              game:GetService("Players").LocalPlayer.PlayerGui.EnchantPets.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.EnchantPets.Enabled
          end)

    AF7:Slider("Delay", 1,120,60, function(v)
        _G.Delay = v
    end)
    
    AF7:Textbox("Webhook Stats Tracker", "Your Webhook URL", false,function(v)
        webhook = v
    end)
    
    AF7:Toggle("Loop Webhook Stat Tracker", false, function(v)
        if v == true then
            _G.stop = true
        elseif v == false then
            _G.stop = false
        end
        

        game.Players.PlayerAdded:Connect(function(plr)
            local character = plr.Character or plr.CharacterAdded:Wait()
                end)
               
                local webhookcheck =
                is_sirhurt_closure and "s" or pebc_execute and "p" or syn and "s" or
                secure_load and "s" or
                KRNL_LOADED and "k" or
                SONA_LOADED and "s" or
                "e"
         
             local url = webhook
         
             local data = {
                ["content"] = "",
                     ["embeds"] = {{
                         ["title"] = "__**Pet Simulator X Stat Tracker**__",
                         ["description"] = "Sending first webhook in 60 seconds...", 
                         ["type"] = "rich",
                         ["color"] = tonumber(0x0E980E),
                        },
                    }
                
            }
        local newdata = game:GetService("HttpService"):JSONEncode(data)
        
        local headers = {
           ["content-type"] = "application/json"
        }
        request = http_request or request or HttpPost or syn.request
        local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
        request(abcdef)
            
        
                _G.Tracking = 'Fantasy Coins' 
                _G.trackD = 'Diamonds'
                _G.trackC = 'Coins'
                _G.trackT = 'Tech Coins'
               
        
                local waitTime = 60
                local currentTime = 0
                local startc; local endc; local coin; local difc; local tablec = {};
                local startd; local endd; local diamondc; local difd; local tabled = {};
                local startfc; local endfc; local fantasyc; local diffc; local tablefc = {};
                local startT; local endT; local tech; local dift; local tablet = {};
                
                
                local function add(table)
                    local value = 0
                    for i, v in next, table do
                        value = value + v
                    end
                    return value
                end
                local function comma_Value(amount)
                    local formatted = amount
                    while true do
                        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
                        if (k == 0) then
                            break
                        end
                    end
                    return formatted
                end
                local username = game:GetService("Players").LocalPlayer.Name
                local egg1 = 2970000000
                local egg2 = 330000000
        
         
                
                local function start()
                    startfc = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.Tracking].Amount.Text, ",", "")
                    startd = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.trackD].Amount.Text, ",", "")
                    startc = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.trackC].Amount.Text, ",", "")
                    startT = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.trackT].Amount.Text, ",", "")
                    
                end
                local function ending()
                    endfc = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.Tracking].Amount.Text, ",", "")
                    endd = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.trackD].Amount.Text, ",", "")
                    endc = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.trackC].Amount.Text, ",", "")
                    endT = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right[_G.trackT].Amount.Text, ",", "")
                     
                end
                local function initialvalue()
                    coin = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right.Coins.Amount.Text, ",", "")
                    diamondc = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right.Diamonds.Amount.Text, ",", "")
                    fantasyc = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right["Fantasy Coins"].Amount.Text, ",", "")
                    tech = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right["Tech Coins"].Amount.Text, ",", "")
                   
                    costofegg2 = tech / egg1
                    costofegg = tech / egg2
                    enchants = diamondc / 10000
                    rank = string.gsub(game.Players.LocalPlayer.PlayerGui.Main.Right.Rank.RankName.Text, ",", "")
                end
                local function dif()
                    diffc = tonumber(endfc) - tonumber(startfc)
                    difd = tonumber(endd) - tonumber(startd)
                    difc = tonumber(endc) - tonumber(startc)
                    dift = tonumber(endT) - tonumber(startT) 
                 
        
                    table.insert(tablec, difc)
                    table.insert(tabled, difd)
                    table.insert(tablefc, diffc)
                    table.insert(tablet, dift)
                   
                end
        
                while _G.stop do
                    
        
                    initialvalue()
                    start()
                print("Sending Webhook In 60 Seconds....")
                    wait(_G.Delay)
                
                    currentTime = currentTime + waitTime
                
                ending()
                dif()
                print("Webhook Sent!!")
                local webhookcheck =
               is_sirhurt_closure and "s" or pebc_execute and "p" or syn and "s" or
               secure_load and "s" or
               KRNL_LOADED and "k" or
               SONA_LOADED and "s" or
               "e"
        
            local url = webhook
        
            local data = {
               ["content"] = "",
                    ["embeds"] = {{
                        ["title"] = "__**Pet Simulator X Stat Tracker**__",
                        ["description"] = "Next webhook in 60 seconds...", 
                        ["type"] = "rich",
                        ["color"] = tonumber(0x0E980E),
                        ["fields"] = {
                            {
                                ["name"] = "__Username__",
                                ["value"] = ("||%s||"):format(username),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Rank__",
                                ["value"] = ("%s"):format(rank),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Tech Coins__",
                                ["value"] = ("%s"):format(comma_Value(endT)),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Coins__",
                                ["value"] = ("%s"):format(comma_Value(endc)),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Fantasy Coins__",
                                ["value"] = ("%s"):format(comma_Value(endfc)),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Diamonds__",
                                ["value"] = ("%s"):format(comma_Value(endd)),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Planet Egg__",
                                ["value"] = ("%s"):format(comma_Value(math.round(costofegg))),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Golden Planet Egg__",
                                ["value"] = ("%s"):format(comma_Value(math.round(costofegg2))),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Enchant Purchases__",
                                ["value"] = ("%s"):format(comma_Value(math.round(enchants))),
                                ["inline"] = false
                            }
                        },
                    },
                    {
                        ["title"] = "__**Diamonds**__",
                        ["type"] = "rich",
                        ["color"] = tonumber(0x0096FF),
                        ["fields"] = {
                            {
                                ["name"] = "__Diamonds Earned In The Last Minute__",
                                ["value"] = comma_Value(difd),
                                ["inline"] = false
                            },
                            {
                                ["name"] = ("__Total Diamonds This %s Minute Session__"):format(math.round(currentTime/60)),
                                ["value"] = comma_Value(add(tabled)),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Average Diamonds Per Minute__",
                                ["value"] = comma_Value(math.round(add(tabled) / math.round(currentTime/60))),
                                ["inline"] = false
                            }
                        },
                    }, 
                    {
                        ["title"] = "__**Tech Coins**__",
                        ["type"] = "rich",
                        ["color"] = tonumber(0x00008B),
                        ["fields"] = {
                            {
                                ["name"] = "__Tech Coins Earned In The Last Minute__",
                                ["value"] = comma_Value(dift),
                                ["inline"] = false
                            },
                            {
                                ["name"] = ("__Total Tech Coins This %s Minute Session __"):format(math.round(currentTime/60)),
                                ["value"] = comma_Value(add(tablet)),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Average Tech Coins Per Minute__",
                                ["value"] = comma_Value(math.round(add(tablet) / math.round(currentTime/60))),
                                ["inline"] = false
                            }
                        },
                    },
                    {
                        ["title"] = "__**Fantasy Coins**__",
                        ["type"] = "rich",
                        ["color"] = tonumber(0x454545),
                        ["fields"] = {
                            {
                                ["name"] = "__Fantasy Coins Earned In The Last Minute__",
                                ["value"] = comma_Value(diffc),
                                ["inline"] = false
                            },
                            {
                                ["name"] = ("__Total Fantasy Coins This %s Minute Session __"):format(math.round(currentTime/60)),
                                ["value"] = comma_Value(add(tablefc)),
                                ["inline"] = false
                            },
                            {
                                ["name"] = "__Average Fantasy Coins Per Minute__",
                                ["value"] = comma_Value(math.round(add(tablefc) / math.round(currentTime/60))),
                                ["inline"] = false
                            },
                        }
                    }}
                }
            local newdata = game:GetService("HttpService"):JSONEncode(data)
        
            local headers = {
               ["content-type"] = "application/json"
            }
            request = http_request or request or HttpPost or syn.request
            local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
            request(abcdef)
                end
    end)

    AF7:Seperator()


    
    AF3:Seperator()
    AF3:Label("Hoverboard")
    AF3:Label("[G] To use Hoverboard")
    getgenv().Enabledboard = nil
    AF3:Dropdown("Hoverboard Skin", {"Original", "VIP", "Sleigh", "Flame", "Bling", "Blue Flying Carpet", "Red Flying Carpet", "Rainbow", "Cat"}, function(vu)

        getgenv().Hoverboard = vu

        local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
        while not v1.Loaded do
            game:GetService("RunService").Heartbeat:Wait();
        end;
        local l__ID__2 = v1.Directory.Gamepasses.Hoverboard.ID;
        local u1 = nil;
        local u2 = { 57.5, 75, 90 };
        function Create(p1)
            v1.Variables.UsingHoverboard = true
            local v3 = p1 == v1.LocalPlayer;
            local u3 = v1.Player.Get("Character", p1);
            local u4 = v1.Player.Get("HumanoidRootPart", p1);
            local u5 = v1.Player.Get("Humanoid", p1);
            local function v4()
                local v5 = not v1.Variables.LoadingWorld and (u3 and (u4 and 0 < u5.Health));
                return v5;
            end;
            if not v4() then
                return;
            end;
            local v6 = v1.Save.Get(p1);
            if not v6 then
                return;
            end;
            local l__EquippedHoverboard__7 = getgenv().Hoverboard
            local v8 = v1.Directory.Hoverboards[l__EquippedHoverboard__7];
            if l__EquippedHoverboard__7 ~= "" then
                if not v8 then
                    return;
                end;
            else
                return;
            end;
            if u3:FindFirstChild("__HOVERBOARD") then
                Remove(p1);
            end;
            local v9 = v8.board:Clone();
            local v10 = u5.HipHeight + u4.Size.Y / 2;
            v9.CFrame = u4.CFrame * CFrame.Angles(0, math.rad(90), 0) - Vector3.new(0, v10, 0) - Vector3.new(0, v9:FindFirstChild("Center").Position.Y, 0);
            v9.CanCollide = false;
            v9.Name = "__HOVERBOARD";
            v9.Parent = u3;
            local v11 = v1.Functions.Weld(u4, v9);
            local l__Sparkles__12 = v9.Back:FindFirstChild("Sparkles");
            local l__Running__13 = v1.Player.Get("RootPart", p1):FindFirstChild("Running");
            local v14 = nil;
            if l__Running__13 then
                v14 = l__Running__13.Volume;
                l__Running__13.Volume = 0;
            end;
            local v15 = nil;
            local v16 = nil;
            if v3 then
                v15 = Instance.new("BodyPosition");
                v15.MaxForce = Vector3.new(0, math.huge, 0);
                v15.Position = v9.Position;
                v15.D = 1400;
                v15.Parent = v9;
                v16 = Instance.new("BodyGyro");
                v16.MaxTorque = Vector3.new(math.huge, math.huge, math.huge);
                v16.CFrame = CFrame.Angles(0, math.rad(-90), 0);
                v16.Parent = v9;
            end;
            local v17 = v1.Assets.Particles:FindFirstChild("Hoverboard Spawn"):Clone();
            v17.Parent = v9.Center;
            v17:Emit(10);
            v1.Audio.Play(v8.sounds.equip, v9.CFrame.p, 1, 0.5);
            if v3 then
                u1 = v1.Functions.Animation(3510226236, u5);
            end;
            local u6 = os.clock();
            local function u7()
                local v18 = v9.Size.X / 2;
                local v19 = v9.Size.Z / 2;
                local v20 = nil;
                local v21 = 1 - 1;
                while true do
                    if v21 == 1 then
                        local v22 = Vector3.new(-v18, 0, v19);
                    elseif v21 == 2 then
                        v22 = Vector3.new(v18, 0, -v19);
                    elseif v21 == 3 then
                        v22 = Vector3.new(v18, 0, v19);
                    elseif v21 == 4 then
                        v22 = Vector3.new(-v18, 0, -v19);
                    else
                        v22 = Vector3.new(0, 0, 0);
                    end;
                    local v23, v24 = game.Workspace:FindPartOnRayWithWhitelist(Ray.new(u4.CFrame.p + v22, Vector3.new(0, -(3 + v10), 0)), { game.Workspace.__MAP });
                    if v23 then
                        if v24 then
                            if v20 then
                                if v20.Y < v24.Y then
                                    v20 = v24;
                                end;
                            else
                                v20 = v24;
                            end;
                        end;
                    end;
                    if 0 <= 1 then
                        if v21 < 5 then
        
                        else
                            break;
                        end;
                    elseif 5 < v21 then
        
                    else
                        break;
                    end;
                    v21 = v21 + 1;		
                end;
                return v20;
            end;
            local u8 = 0;
            local u9 = 0;
            local u10 = u2[v8.speed];
            local u11 = v1.Audio.Play(v8.sounds.idle, v9, 1, 0.1, nil, nil, true);
            v1.RunService:BindToRenderStep("Hoverboard " .. p1.Name, Enum.RenderPriority.Character.Value + 1, function()
                if v9 then
                    if v9.Parent then
                        if not v4() then
                            if l__Running__13 then
                                l__Running__13.Volume = v14;
                            end;
                            pcall(function()
                                v1.RunService:UnbindFromRenderStep("Hoverboard " .. p1.Name);
                            end);
                            return;
                        end;
                    else
                        if l__Running__13 then
                            l__Running__13.Volume = v14;
                        end;
                        pcall(function()
                            v1.RunService:UnbindFromRenderStep("Hoverboard " .. p1.Name);
                        end);
                        return;
                    end;
                else
                    if l__Running__13 then
                        l__Running__13.Volume = v14;
                    end;
                    pcall(function()
                        v1.RunService:UnbindFromRenderStep("Hoverboard " .. p1.Name);
                    end);
                    return;
                end;
                if v3 then
                    u5.PlatformStand = true;
                    local v25 = u7();
                    local v26 = v25 ~= nil;
                    if u8 == nil then u8 = 0 end
                    print(v9.Position)
                    print(v9.Position.Y or "nil pos_y")
                    print(u8 or "nil u8")
                    local new = v9.Position.Y - u8
                    if v26 then new = v25.Y + 3 end
                    v15.Position = Vector3.new(0, (new) + (math.sin((os.clock() - u6) * 3) / 2 - 0.5), 0);
                    local v27
                    if v26 then
                        v27 = 0;
                    else
                        v27 = math.clamp(u8 * 1.065, 2, 10);
                    end;
                    u8 = v27;
                    local v28 = u4.Position + u5.MoveDirection;
                    if v28 ~= u4.Position then
                        v16.CFrame = CFrame.new(u4.Position, v28) * CFrame.Angles(0, math.rad(90), 0);
                    end;
                    if u5.Jump then
                        if v26 then
                            if 1 <= os.clock() - u9 then
                                u9 = os.clock();
                                v1.Audio.Play(v8.sounds.jump, v9, 1.25, 0.4);
                            end;
                        end;
                    end;
                    local v29 = 0;
                    if os.clock() - u9 <= 0.3 then
                        v29 = (1 - math.clamp((os.clock() - u9) / 0.3, 0, 1) ^ 2) * 7000;
                    end;
                    local v30 = u5.MoveDirection * u10;
                    u4.Velocity = u4.Velocity:Lerp(Vector3.new(v30.X, -v29, v30.Z), 0.035);
                end;
                local l__Magnitude__31 = u4.Velocity.Magnitude;
                u11.Pitch = math.clamp(1 + l__Magnitude__31 / u10, 1, 2);
                l__Sparkles__12.Enabled = 8 < l__Magnitude__31;
            end);
        end;
        function Remove(p2)
            v1.Variables.UsingHoverboard = false
            local l____HOVERBOARD__32 = v1.Player.Get("Character", p2):FindFirstChild("__HOVERBOARD");
            if l____HOVERBOARD__32 then
                l____HOVERBOARD__32:Destroy();
            end;
            if p2 == v1.LocalPlayer then
                if u1 then
                    u1:Stop();
                end;
                v1.Player.Get("HumanoidRootPart").Velocity = Vector3.new();
                v1.Player.Get("Humanoid").PlatformStand = false;
                v1.RunService:UnbindFromRenderStep("Hoverboard " .. p2.Name);
            end;
        end;
        local l__Hoverboard__12 = v1.GUI.Main.Tools.Hoverboard;
        local l__Enum_KeyCode_Q__14 = Enum.KeyCode.G;
        
        v1.Signal.Fired("Entered Cannon"):Connect(function()
            if v1.Variables.UsingHoverboard then
                Toggle();
            end;
        end);
        v1.Signal.Fired("World Changed"):Connect(function()
            if v1.Variables.UsingHoverboard then
                Toggle();
            end;
        end);
        
        function Toggle()
            if getgenv().Enabledboard == false then return end
            if v1.Variables.UsingHoverboard then
                Remove(v1.LocalPlayer);
            else
                Create(v1.LocalPlayer);
            end;
        end;
        
        v1.UserInputService.InputBegan:Connect(function(p5, p6)
            if p6 then return end
            if p5.KeyCode == l__Enum_KeyCode_Q__14 then
                Toggle()
            end
        end);
        
        end)
        
        AF3:Seperator()
        local Lib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
        while not Lib.Loaded do
            game:GetService("RunService").Heartbeat:Wait()
        end

        AF3:Toggle("Auto Buy Merchant Slot 1", false, function(vu)
            buyMerchant1 = vu
        end)
        
        spawn(function()
            while wait() do
                if buyMerchant1 then
                     Lib.Network.Invoke("buy merchant item", 1)
                    end
                end  
        end)

        AF3:Toggle("Auto Buy Merchant Slot 2", false, function(vu)
            buyMerchant2 = vu
        end)

        spawn(function()
            while wait() do
                if buyMerchant2 then
                    Lib.Network.Invoke("buy merchant item", 2)
                end  
             end
        end)

        AF3:Toggle("Auto Buy Merchant Slot 3", false, function(vu)
            buyMerchant3 = vu            
        end)

        spawn(function()
            while wait() do
                if buyMerchant3 then
                    Lib.Network.Invoke("buy merchant item", 3)
                    end
                end  
        end)
    
    warn("Anti AFK : Work")
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
       vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
       wait(1)
       vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)

return DiscordLib
