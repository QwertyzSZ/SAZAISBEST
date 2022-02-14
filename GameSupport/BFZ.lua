

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
local SazaUi = Instance.new("ScreenGui")
local SAZAHUB = Instance.new("ScreenGui")
SAZAHUB.Name = "Discord"
SAZAHUB.Parent = game.CoreGui
SAZAHUB.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local SZOPENCLOSE = Instance.new("ImageButton")
SZOPENCLOSE.Parent = SAZAHUB
SZOPENCLOSE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SZOPENCLOSE.BackgroundTransparency = 1.000
SZOPENCLOSE.Position = UDim2.new(0.0447916649, 0, 0.0845824406, 0)
SZOPENCLOSE.Size = UDim2.new(0, 74, 0, 68)
SZOPENCLOSE.AutoButtonColor = false
SZOPENCLOSE.Image = "http://www.roblox.com/asset/?id=8401150805"
SZOPENCLOSE.MouseButton1Click:Connect(function()
   game.CoreGui:FindFirstChild("SazaUi").Enabled = not game.CoreGui:FindFirstChild("SazaUi").Enabled
end)   



do
    if game:GetService("CoreGui"):FindFirstChild("SazaUi") then
        game:GetService("CoreGui").SazaUi:Destroy()
    end
 end  

function DiscordLib:Window(text)
    local PresetColor = mainclr or Color3.fromRGB(0, 255, 255) or _G.Color
    local CloseBind = cls or Enum.KeyCode.RightControl or _G.Toggle
    local currentservertoggled = ""
    local minimized = false
    local fs = false
    local settingsopened = false
    local MainFrame = Instance.new("Frame")
    local Corner_1 = Instance.new("UICorner")
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
    local TopFramess = Instance.new("Frame")
    local OutLayFrame = Instance.new("Frame")
    local OutLayFrameCorner = Instance.new("UICorner")

    SazaUi.Name = "SazaUi"
    SazaUi.Parent = game.CoreGui
    SazaUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = SazaUi
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
	MainFrame.BackgroundTransparency = 1
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.Size = UDim2.new(0, 611, 0, 396)

	Corner_1.CornerRadius = UDim.new(0, 7)
	Corner_1.Name = "UserIconCorner"
	Corner_1.Parent = MainFrame

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
	TopFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TopFrame.BackgroundTransparency = 1
	TopFrame.BorderSizePixel = 0
	TopFrame.Position = UDim2.new(-0.000658480625, 0, 0, 0)
	TopFrame.Size = UDim2.new(0, 681, 0, 22)

	TopFramess.Name = "TopFramess"
	TopFramess.Parent = TopFrame
	TopFramess.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TopFramess.BackgroundTransparency = 1
	TopFramess.BorderSizePixel = 0
	TopFramess.ZIndex = 99
	TopFramess.Position = UDim2.new(-0.2, 0, 1.3, 0)
	TopFramess.Size = UDim2.new(0, 681, 0, 22)

	TopFrameHolder.Name = "TopFrameHolder"
	TopFrameHolder.Parent = TopFrame
	TopFrameHolder.BackgroundColor3 = Color3.fromRGB(20,20,20)
	TopFrameHolder.BackgroundTransparency = 1.000
	TopFrameHolder.BorderSizePixel = 0
	TopFrameHolder.Position = UDim2.new(-0.000658480625, 0, 0, 0)
	TopFrameHolder.Size = UDim2.new(0, 20, 0, 22)

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

    MinimizeBtn.Name = "MinimizeButton"
	MinimizeBtn.Parent = TopFrame
	MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
	MinimizeBtn.BackgroundTransparency = 1
	MinimizeBtn.Position = UDim2.new(0.85, 0, 1.3, 0)
	MinimizeBtn.Size = UDim2.new(0, 28, 0, 22)
	MinimizeBtn.Font = Enum.Font.Gotham
	MinimizeBtn.Text = ""
	MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeBtn.TextSize = 14.000
	MinimizeBtn.BorderSizePixel = 0
	MinimizeBtn.AutoButtonColor = false

	MinimizeIcon.Name = "MinimizeLabel"
	MinimizeIcon.Parent = MinimizeBtn
	MinimizeIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MinimizeIcon.BackgroundTransparency = 1.000
	MinimizeIcon.Position = UDim2.new(0.2, 0, 0.128935531, 0)
	MinimizeIcon.Size = UDim2.new(0, 17, 0, 17)
	MinimizeIcon.Image = "http://www.roblox.com/asset/?id=6035067836"
	MinimizeIcon.ImageColor3 = Color3.fromRGB(220, 221, 222)

	ServersHolder.Name = "ServersHolder"
	ServersHolder.Parent = TopFrameHolder

	Userpad.Name = "Userpad"
	Userpad.Parent = TopFrameHolder
	Userpad.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Userpad.BorderSizePixel = 0
	Userpad.Position = UDim2.new(0.106243297, 0, 15.9807148, 0)
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

	MinimizeBtn.MouseEnter:Connect(
		function()
			MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
		end
	)

	MinimizeBtn.MouseLeave:Connect(
		function()
			MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
		end
	)

	MinimizeBtn.MouseButton1Click:Connect(
		function()
			if minimized == false then
				MainFrame:TweenSize(
					UDim2.new(0, 611, 0, 64),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quart,
					.3,
					true
				)
			else
				MainFrame:TweenSize(
					UDim2.new(0, 611, 0, 396),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quart,
					.3,
					true
				)
			end
			minimized = not minimized
		end
	)

	local SettingsOpenBtn = Instance.new("TextButton")
	local SettingsOpenBtnIco = Instance.new("ImageLabel")

	SettingsOpenBtn.Name = "SettingsOpenBtn"
	SettingsOpenBtn.Parent = Userpad
	SettingsOpenBtn.BackgroundColor3 = Color3.fromRGB(53, 56, 62)
	SettingsOpenBtn.BackgroundTransparency = 1.000
	SettingsOpenBtn.Position = UDim2.new(0.849161983, 0, 0.279069781, 0)
	SettingsOpenBtn.Size = UDim2.new(0, 0, 0, 0)
	SettingsOpenBtn.Font = Enum.Font.SourceSans
	SettingsOpenBtn.Text = ""
	SettingsOpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	SettingsOpenBtn.TextSize = 14.000

	SettingsOpenBtnIco.Name = "SettingsOpenBtnIco"
	SettingsOpenBtnIco.Parent = SettingsOpenBtn
	SettingsOpenBtnIco.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
	SettingsOpenBtnIco.BackgroundTransparency = 1.000
	SettingsOpenBtnIco.Size = UDim2.new(0, 0, 0, 0)
	SettingsOpenBtnIco.ImageTransparency = 1
	SettingsOpenBtnIco.ImageColor3 = Color3.fromRGB(220, 220, 220)
	local SettingsFrame = Instance.new("Frame")
	local Settings = Instance.new("Frame")
	local SettingsHolder = Instance.new("Frame")
	local CloseSettingsBtn = Instance.new("TextButton")
	local CloseSettingsBtnCorner = Instance.new("UICorner")
	local CloseSettingsBtnCircle = Instance.new("Frame")
	local CloseSettingsBtnCircleCorner = Instance.new("UICorner")
	local CloseSettingsBtnIcon = Instance.new("ImageLabel")
	local TextLabel = Instance.new("TextLabel")
	local UserPanel = Instance.new("Frame")
	local UserSettingsPad = Instance.new("Frame")
	local UserSettingsPadCorner = Instance.new("UICorner")
	local UsernameText = Instance.new("TextLabel")
	local UserSettingsPadUserTag = Instance.new("Frame")
	local UserSettingsPadUser = Instance.new("TextLabel")
	local UserSettingsPadUserTagLayout = Instance.new("UIListLayout")
	local UserSettingsPadTag = Instance.new("TextLabel")
	local EditBtn = Instance.new("TextButton")
	local EditBtnCorner = Instance.new("UICorner")
	local UserPanelUserIcon = Instance.new("TextButton")
	local UserPanelUserImage = Instance.new("ImageLabel")
	local UserPanelUserCircle = Instance.new("ImageLabel")
	local BlackFrame = Instance.new("Frame")
	local BlackFrameCorner = Instance.new("UICorner")
	local ChangeAvatarText = Instance.new("TextLabel")
	local SearchIcoFrame = Instance.new("Frame")
	local SearchIcoFrameCorner = Instance.new("UICorner")
	local SearchIco = Instance.new("ImageLabel")
	local UserPanelUserTag = Instance.new("Frame")
	local UserPanelUser = Instance.new("TextLabel")
	local UserPanelUserTagLayout = Instance.new("UIListLayout")
	local UserPanelTag = Instance.new("TextLabel")
	local UserPanelCorner = Instance.new("UICorner")
	local LeftFrame = Instance.new("Frame")
	local MyAccountBtn = Instance.new("TextButton")
	local MyAccountBtnCorner = Instance.new("UICorner")
	local MyAccountBtnTitle = Instance.new("TextLabel")
	local SettingsTitle = Instance.new("TextLabel")
	local DiscordInfo = Instance.new("TextLabel")
	local CurrentSettingOpen = Instance.new("TextLabel")

	SettingsFrame.Name = "SettingsFrame"
	SettingsFrame.Parent = MainFrame
	SettingsFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	SettingsFrame.BackgroundTransparency = 1.000
	SettingsFrame.Size = UDim2.new(0, 681, 0, 396)
	SettingsFrame.Visible = false

	Settings.Name = "Settings"
	Settings.Parent = SettingsFrame
	Settings.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
	Settings.BorderSizePixel = 0
	Settings.Position = UDim2.new(0, 0, 0.0530303046, 0)
	Settings.Size = UDim2.new(0, 681, 0, 375)

	SettingsHolder.Name = "SettingsHolder"
	SettingsHolder.Parent = Settings
	SettingsHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	SettingsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SettingsHolder.BackgroundTransparency = 1.000
	SettingsHolder.ClipsDescendants = true
	SettingsHolder.Position = UDim2.new(0.49926579, 0, 0.498666674, 0)
	SettingsHolder.Size = UDim2.new(0, 0, 0, 0)

	CloseSettingsBtn.Name = "CloseSettingsBtn"
	CloseSettingsBtn.Parent = SettingsHolder
	CloseSettingsBtn.AnchorPoint = Vector2.new(0.5, 0.5)
	CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	CloseSettingsBtn.Position = UDim2.new(0.952967286, 0, 0.0853333324, 0)
	CloseSettingsBtn.Selectable = false
	CloseSettingsBtn.Size = UDim2.new(0, 30, 0, 30)
	CloseSettingsBtn.AutoButtonColor = false
	CloseSettingsBtn.Font = Enum.Font.SourceSans
	CloseSettingsBtn.Text = ""
	CloseSettingsBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	CloseSettingsBtn.TextSize = 14.000

	CloseSettingsBtnCorner.CornerRadius = UDim.new(1, 0)
	CloseSettingsBtnCorner.Name = "CloseSettingsBtnCorner"
	CloseSettingsBtnCorner.Parent = CloseSettingsBtn

	CloseSettingsBtnCircle.Name = "CloseSettingsBtnCircle"
	CloseSettingsBtnCircle.Parent = CloseSettingsBtn
	CloseSettingsBtnCircle.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
	CloseSettingsBtnCircle.Position = UDim2.new(0.0879999995, 0, 0.118000001, 0)
	CloseSettingsBtnCircle.Size = UDim2.new(0, 24, 0, 24)

	CloseSettingsBtnCircleCorner.CornerRadius = UDim.new(1, 0)
	CloseSettingsBtnCircleCorner.Name = "CloseSettingsBtnCircleCorner"
	CloseSettingsBtnCircleCorner.Parent = CloseSettingsBtnCircle

	CloseSettingsBtnIcon.Name = "CloseSettingsBtnIcon"
	CloseSettingsBtnIcon.Parent = CloseSettingsBtnCircle
	CloseSettingsBtnIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseSettingsBtnIcon.BackgroundTransparency = 1.000
	CloseSettingsBtnIcon.Position = UDim2.new(0, 2, 0, 2)
	CloseSettingsBtnIcon.Size = UDim2.new(0, 19, 0, 19)
	CloseSettingsBtnIcon.ImageColor3 = Color3.fromRGB(222, 222, 222)

	CloseSettingsBtn.MouseButton1Click:Connect(function()
		settingsopened = false
		TopFrameHolder.Visible = true
		ServersHoldFrame.Visible = true
		SettingsHolder:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
		TweenService:Create(
			Settings,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 1}
		):Play()
		for i,v in next, SettingsHolder:GetChildren() do
			TweenService:Create(
				v,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
		end
		wait(.3)
		SettingsFrame.Visible = false
	end)

	CloseSettingsBtn.MouseEnter:Connect(function()
		CloseSettingsBtnCircle.BackgroundColor3 = Color3.fromRGB(72,76,82)
	end)

	CloseSettingsBtn.MouseLeave:Connect(function()
		CloseSettingsBtnCircle.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
	end)

	UserInputService.InputBegan:Connect(
		function(io, p)
			if io.KeyCode == Enum.KeyCode.RightControl then
				if settingsopened == true then
					settingsopened = false
					TopFrameHolder.Visible = true
					ServersHoldFrame.Visible = true
					SettingsHolder:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
					TweenService:Create(
						Settings,
						TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					for i,v in next, SettingsHolder:GetChildren() do
						TweenService:Create(
							v,
							TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundTransparency = 1}
						):Play()
					end
					wait(.3)
					SettingsFrame.Visible = false
				end
			end
		end
	)

	TextLabel.Parent = CloseSettingsBtn
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(-0.0666666701, 0, 1.06666672, 0)
	TextLabel.Size = UDim2.new(0, 34, 0, 22)
	TextLabel.Font = Enum.Font.GothamSemibold
	TextLabel.Text = "rightctrl"
	TextLabel.TextColor3 = Color3.fromRGB(113, 117, 123)
	TextLabel.TextSize = 11.000

	UserPanel.Name = "UserPanel"
	UserPanel.Parent = SettingsHolder
	UserPanel.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
	UserPanel.Position = UDim2.new(0.365638763, 0, 0.130666673, 0)
	UserPanel.Size = UDim2.new(0, 362, 0, 164)

	UserSettingsPad.Name = "UserSettingsPad"
	UserSettingsPad.Parent = UserPanel
	UserSettingsPad.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
	UserSettingsPad.Position = UDim2.new(0.0331491716, 0, 0.568140388, 0)
	UserSettingsPad.Size = UDim2.new(0, 337, 0, 56)

	UserSettingsPadCorner.Name = "UserSettingsPadCorner"
	UserSettingsPadCorner.Parent = UserSettingsPad

	UsernameText.Name = "UsernameText"
	UsernameText.Parent = UserSettingsPad
	UsernameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UsernameText.BackgroundTransparency = 1.000
	UsernameText.Position = UDim2.new(0.0419999994, 0, 0.154714286, 0)
	UsernameText.Size = UDim2.new(0, 65, 0, 19)
	UsernameText.Font = Enum.Font.GothamBold
	UsernameText.Text = "USERNAME"
	UsernameText.TextColor3 = Color3.fromRGB(126, 130, 136)
	UsernameText.TextSize = 11.000
	UsernameText.TextXAlignment = Enum.TextXAlignment.Left

	UserSettingsPadUserTag.Name = "UserSettingsPadUserTag"
	UserSettingsPadUserTag.Parent = UserSettingsPad
	UserSettingsPadUserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingsPadUserTag.BackgroundTransparency = 1.000
	UserSettingsPadUserTag.Position = UDim2.new(0.0419999994, 0, 0.493999988, 0)
	UserSettingsPadUserTag.Size = UDim2.new(0, 65, 0, 19)

	UserSettingsPadUser.Name = "UserSettingsPadUser"
	UserSettingsPadUser.Parent = UserSettingsPadUserTag
	UserSettingsPadUser.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingsPadUser.BackgroundTransparency = 1.000
	UserSettingsPadUser.Font = Enum.Font.Gotham
	UserSettingsPadUser.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingsPadUser.TextSize = 13.000
	UserSettingsPadUser.TextXAlignment = Enum.TextXAlignment.Left
	UserSettingsPadUser.Text = user
	UserSettingsPadUser.Size = UDim2.new(0, UserSettingsPadUser.TextBounds.X + 2, 0, 19)

	UserSettingsPadUserTagLayout.Name = "UserSettingsPadUserTagLayout"
	UserSettingsPadUserTagLayout.Parent = UserSettingsPadUserTag
	UserSettingsPadUserTagLayout.FillDirection = Enum.FillDirection.Horizontal
	UserSettingsPadUserTagLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UserSettingsPadTag.Name = "UserSettingsPadTag"
	UserSettingsPadTag.Parent = UserSettingsPadUserTag
	UserSettingsPadTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingsPadTag.BackgroundTransparency = 1.000
	UserSettingsPadTag.Position = UDim2.new(0.0419999994, 0, 0.493999988, 0)
	UserSettingsPadTag.Size = UDim2.new(0, 65, 0, 19)
	UserSettingsPadTag.Font = Enum.Font.Gotham
	UserSettingsPadTag.Text = "#" .. tag
	UserSettingsPadTag.TextColor3 = Color3.fromRGB(184, 186, 189)
	UserSettingsPadTag.TextSize = 13.000
	UserSettingsPadTag.TextXAlignment = Enum.TextXAlignment.Left

	EditBtn.Name = "EditBtn"
	EditBtn.Parent = UserSettingsPad
	EditBtn.BackgroundColor3 = Color3.fromRGB(116, 127, 141)
	EditBtn.Position = UDim2.new(0.797671914, 0, 0.232142866, 0)
	EditBtn.Size = UDim2.new(0, 55, 0, 30)
	EditBtn.Font = Enum.Font.Gotham
	EditBtn.Text = "Edit"
	EditBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	EditBtn.TextSize = 14.000
	EditBtn.AutoButtonColor = false

	EditBtn.MouseEnter:Connect(function()
		TweenService:Create(
			EditBtn,
			TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundColor3 = Color3.fromRGB(104,114,127)}
		):Play()
	end)

	EditBtn.MouseLeave:Connect(function()
		TweenService:Create(
			EditBtn,
			TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundColor3 = Color3.fromRGB(116, 127, 141)}
		):Play()
	end)

	EditBtnCorner.CornerRadius = UDim.new(0, 3)
	EditBtnCorner.Name = "EditBtnCorner"
	EditBtnCorner.Parent = EditBtn

	UserPanelUserIcon.Name = "UserPanelUserIcon"
	UserPanelUserIcon.Parent = UserPanel
	UserPanelUserIcon.BackgroundColor3 = Color3.fromRGB(31, 33, 36)
	UserPanelUserIcon.BorderSizePixel = 0
	UserPanelUserIcon.Position = UDim2.new(0.0340000018, 0, 0.074000001, 0)
	UserPanelUserIcon.Size = UDim2.new(0, 71, 0, 71)
	UserPanelUserIcon.AutoButtonColor = false
	UserPanelUserIcon.Text = ""

	UserPanelUserImage.Name = "UserPanelUserImage"
	UserPanelUserImage.Parent = UserPanelUserIcon
	UserPanelUserImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserPanelUserImage.BackgroundTransparency = 1.000
	UserPanelUserImage.Size = UDim2.new(0, 71, 0, 71)
	UserPanelUserImage.Image = pfp

	UserPanelUserCircle.Name = "UserPanelUserCircle"
	UserPanelUserCircle.Parent = UserPanelUserImage
	UserPanelUserCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserPanelUserCircle.BackgroundTransparency = 1.000
	UserPanelUserCircle.Size = UDim2.new(0, 71, 0, 71)
	UserPanelUserCircle.Image = "rbxassetid://4031889928"
	UserPanelUserCircle.ImageColor3 = Color3.fromRGB(47, 49, 54)

	BlackFrame.Name = "BlackFrame"
	BlackFrame.Parent = UserPanelUserIcon
	BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	BlackFrame.BackgroundTransparency = 0.400
	BlackFrame.BorderSizePixel = 0
	BlackFrame.Size = UDim2.new(0, 71, 0, 71)
	BlackFrame.Visible = false

	BlackFrameCorner.CornerRadius = UDim.new(1, 8)
	BlackFrameCorner.Name = "BlackFrameCorner"
	BlackFrameCorner.Parent = BlackFrame

	ChangeAvatarText.Name = "ChangeAvatarText"
	ChangeAvatarText.Parent = BlackFrame
	ChangeAvatarText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ChangeAvatarText.BackgroundTransparency = 1.000
	ChangeAvatarText.Size = UDim2.new(0, 71, 0, 71)
	ChangeAvatarText.Font = Enum.Font.GothamBold
	ChangeAvatarText.Text = "CHAGNE    AVATAR"
	ChangeAvatarText.TextColor3 = Color3.fromRGB(255, 255, 255)
	ChangeAvatarText.TextSize = 11.000
	ChangeAvatarText.TextWrapped = true

	SearchIcoFrame.Name = "SearchIcoFrame"
	SearchIcoFrame.Parent = UserPanelUserIcon
	SearchIcoFrame.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
	SearchIcoFrame.Position = UDim2.new(0.657999992, 0, 0, 0)
	SearchIcoFrame.Size = UDim2.new(0, 20, 0, 20)

	SearchIcoFrameCorner.CornerRadius = UDim.new(1, 8)
	SearchIcoFrameCorner.Name = "SearchIcoFrameCorner"
	SearchIcoFrameCorner.Parent = SearchIcoFrame

	SearchIco.Name = "SearchIco"
	SearchIco.Parent = SearchIcoFrame
	SearchIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchIco.BackgroundTransparency = 1.000
	SearchIco.Position = UDim2.new(0.150000006, 0, 0.100000001, 0)
	SearchIco.Size = UDim2.new(0, 15, 0, 15)
	SearchIco.ImageColor3 = Color3.fromRGB(114, 118, 125)

	UserPanelUserIcon.MouseEnter:Connect(function()
		BlackFrame.Visible = true
	end)

	UserPanelUserIcon.MouseLeave:Connect(function()
		BlackFrame.Visible = false
	end)

	UserPanelUserIcon.MouseButton1Click:Connect(function()
		local NotificationHolder = Instance.new("TextButton")
		NotificationHolder.Name = "NotificationHolder"
		NotificationHolder.Parent = SettingsHolder
		NotificationHolder.BackgroundColor3 = Color3.fromRGB(22,22,22)
		NotificationHolder.Position = UDim2.new(-0.00881057233, 0, -0.00266666664, 0)
		NotificationHolder.Size = UDim2.new(0, 687, 0, 375)
		NotificationHolder.AutoButtonColor = false
		NotificationHolder.Font = Enum.Font.SourceSans
		NotificationHolder.Text = ""
		NotificationHolder.TextColor3 = Color3.fromRGB(0, 0, 0)
		NotificationHolder.TextSize = 14.000
		NotificationHolder.BackgroundTransparency = 1
		NotificationHolder.Visible = true
		TweenService:Create(
			NotificationHolder,
			TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0.2}
		):Play()



		local AvatarChange = Instance.new("Frame")
		local UserChangeCorner = Instance.new("UICorner")
		local UnderBar = Instance.new("Frame")
		local UnderBarCorner = Instance.new("UICorner")
		local UnderBarFrame = Instance.new("Frame")
		local Text1 = Instance.new("TextLabel")
		local Text2 = Instance.new("TextLabel")
		local TextBoxFrame = Instance.new("Frame")
		local TextBoxFrameCorner = Instance.new("UICorner")
		local TextBoxFrame1 = Instance.new("Frame")
		local TextBoxFrame1Corner = Instance.new("UICorner")
		local AvatarTextbox = Instance.new("TextBox")
		local ChangeBtn = Instance.new("TextButton")
		local ChangeCorner = Instance.new("UICorner")
		local CloseBtn2 = Instance.new("TextButton")
		local Close2Icon = Instance.new("ImageLabel")
		local CloseBtn1 = Instance.new("TextButton")
		local CloseBtn1Corner = Instance.new("UICorner")
		local ResetBtn = Instance.new("TextButton")
		local ResetCorner = Instance.new("UICorner")


		AvatarChange.Name = "AvatarChange"
		AvatarChange.Parent = NotificationHolder
		AvatarChange.AnchorPoint = Vector2.new(0.5, 0.5)
		AvatarChange.BackgroundColor3 = Color3.fromRGB(20,20,20)
		AvatarChange.ClipsDescendants = true
		AvatarChange.Position = UDim2.new(0.513071597, 0, 0.4746176, 0)
		AvatarChange.Size = UDim2.new(0, 0, 0, 0)
		AvatarChange.BackgroundTransparency = 1

		AvatarChange:TweenSize(UDim2.new(0, 346, 0, 198), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
		TweenService:Create(
			AvatarChange,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()


		UserChangeCorner.CornerRadius = UDim.new(0, 5)
		UserChangeCorner.Name = "UserChangeCorner"
		UserChangeCorner.Parent = AvatarChange

		UnderBar.Name = "UnderBar"
		UnderBar.Parent = AvatarChange
		UnderBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
		UnderBar.Position = UDim2.new(-0.000297061284, 0, 0.945048928, 0)
		UnderBar.Size = UDim2.new(0, 346, 0, 13)

		UnderBarCorner.CornerRadius = UDim.new(0, 5)
		UnderBarCorner.Name = "UnderBarCorner"
		UnderBarCorner.Parent = UnderBar

		UnderBarFrame.Name = "UnderBarFrame"
		UnderBarFrame.Parent = UnderBar
		UnderBarFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
		UnderBarFrame.BorderSizePixel = 0
		UnderBarFrame.Position = UDim2.new(-0.000297061284, 0, -2.53846145, 0)
		UnderBarFrame.Size = UDim2.new(0, 346, 0, 39)

		Text1.Name = "Text1"
		Text1.Parent = AvatarChange
		Text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text1.BackgroundTransparency = 1.000
		Text1.Position = UDim2.new(-0.000594122568, 0, 0.0202020202, 0)
		Text1.Size = UDim2.new(0, 346, 0, 68)
		Text1.Font = Enum.Font.GothamSemibold
		Text1.Text = "Change your avatar"
		Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text1.TextSize = 20.000

		Text2.Name = "Text2"
		Text2.Parent = AvatarChange
		Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text2.BackgroundTransparency = 1.000
		Text2.Position = UDim2.new(-0.000594122568, 0, 0.141587839, 0)
		Text2.Size = UDim2.new(0, 346, 0, 63)
		Text2.Font = Enum.Font.Gotham
		Text2.Text = "Enter your new profile in a Roblox decal link."
		Text2.TextColor3 = Color3.fromRGB(171, 172, 176)
		Text2.TextSize = 14.000

		TextBoxFrame.Name = "TextBoxFrame"
		TextBoxFrame.Parent = AvatarChange
		TextBoxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBoxFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
		TextBoxFrame.Position = UDim2.new(0.49710983, 0, 0.560606062, 0)
		TextBoxFrame.Size = UDim2.new(0, 319, 0, 38)

		TextBoxFrameCorner.CornerRadius = UDim.new(0, 3)
		TextBoxFrameCorner.Name = "TextBoxFrameCorner"
		TextBoxFrameCorner.Parent = TextBoxFrame

		TextBoxFrame1.Name = "TextBoxFrame1"
		TextBoxFrame1.Parent = TextBoxFrame
		TextBoxFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBoxFrame1.BackgroundColor3 = Color3.fromRGB(48, 51, 57)
		TextBoxFrame1.ClipsDescendants = true
		TextBoxFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBoxFrame1.Size = UDim2.new(0, 317, 0, 36)

		TextBoxFrame1Corner.CornerRadius = UDim.new(0, 3)
		TextBoxFrame1Corner.Name = "TextBoxFrame1Corner"
		TextBoxFrame1Corner.Parent = TextBoxFrame1

		AvatarTextbox.Name = "AvatarTextbox"
		AvatarTextbox.Parent = TextBoxFrame1
		AvatarTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		AvatarTextbox.BackgroundTransparency = 1.000
		AvatarTextbox.Position = UDim2.new(0.0378548913, 0, 0, 0)
		AvatarTextbox.Size = UDim2.new(0, 293, 0, 37)
		AvatarTextbox.Font = Enum.Font.Gotham
		AvatarTextbox.Text = ""
		AvatarTextbox.TextColor3 = Color3.fromRGB(193, 195, 197)
		AvatarTextbox.TextSize = 14.000
		AvatarTextbox.TextXAlignment = Enum.TextXAlignment.Left

		ChangeBtn.Name = "ChangeBtn"
		ChangeBtn.Parent = AvatarChange
		ChangeBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
		ChangeBtn.Position = UDim2.new(0.749670506, 0, 0.823232353, 0)
		ChangeBtn.Size = UDim2.new(0, 76, 0, 27)
		ChangeBtn.Font = Enum.Font.Gotham
		ChangeBtn.Text = "Change"
		ChangeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		ChangeBtn.TextSize = 13.000
		ChangeBtn.AutoButtonColor = false

		ChangeBtn.MouseEnter:Connect(function()
			TweenService:Create(
				ChangeBtn,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(103,123,196)}
			):Play()
		end)

		ChangeBtn.MouseLeave:Connect(function()
			TweenService:Create(
				ChangeBtn,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
			):Play()
		end)

		ChangeBtn.MouseButton1Click:Connect(function()
			pfp = tostring(AvatarTextbox.Text)
			UserImage.Image = pfp
			UserPanelUserImage.Image = pfp
			SaveInfo()

			AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				AvatarChange,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationHolder,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait(.2)
			NotificationHolder:Destroy()
		end)



		ChangeCorner.CornerRadius = UDim.new(0, 4)
		ChangeCorner.Name = "ChangeCorner"
		ChangeCorner.Parent = ChangeBtn

		CloseBtn2.Name = "CloseBtn2"
		CloseBtn2.Parent = AvatarChange
		CloseBtn2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn2.BackgroundTransparency = 1.000
		CloseBtn2.Position = UDim2.new(0.898000002, 0, 0, 0)
		CloseBtn2.Size = UDim2.new(0, 26, 0, 26)
		CloseBtn2.Font = Enum.Font.Gotham
		CloseBtn2.Text = ""
		CloseBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn2.TextSize = 14.000

		Close2Icon.Name = "Close2Icon"
		Close2Icon.Parent = CloseBtn2
		Close2Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Close2Icon.BackgroundTransparency = 1.000
		Close2Icon.Position = UDim2.new(-0.0384615399, 0, 0.312910825, 0)
		Close2Icon.Size = UDim2.new(0, 25, 0, 25)
		Close2Icon.ImageColor3 = Color3.fromRGB(119, 122, 127)

		CloseBtn1.Name = "CloseBtn1"
		CloseBtn1.Parent = AvatarChange
		CloseBtn1.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
		CloseBtn1.BackgroundTransparency = 1.000
		CloseBtn1.Position = UDim2.new(0.495000005, 0, 0.823000014, 0)
		CloseBtn1.Size = UDim2.new(0, 76, 0, 27)
		CloseBtn1.Font = Enum.Font.Gotham
		CloseBtn1.Text = "Close"
		CloseBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn1.TextSize = 13.000

		CloseBtn1Corner.CornerRadius = UDim.new(0, 4)
		CloseBtn1Corner.Name = "CloseBtn1Corner"
		CloseBtn1Corner.Parent = CloseBtn1

		ResetBtn.Name = "ResetBtn"
		ResetBtn.Parent = AvatarChange
		ResetBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
		ResetBtn.BackgroundTransparency = 1.000
		ResetBtn.Position = UDim2.new(0.260895967, 0, 0.823000014, 0)
		ResetBtn.Size = UDim2.new(0, 76, 0, 27)
		ResetBtn.Font = Enum.Font.Gotham
		ResetBtn.Text = "Reset"
		ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		ResetBtn.TextSize = 13.000

		ResetBtn.MouseButton1Click:Connect(function()
			pfp = "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"
			UserImage.Image = pfp
			UserPanelUserImage.Image = pfp
			SaveInfo()

			AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				AvatarChange,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationHolder,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait(.2)
			NotificationHolder:Destroy()
		end)

		ResetCorner.CornerRadius = UDim.new(0, 4)
		ResetCorner.Name = "ResetCorner"
		ResetCorner.Parent = ResetBtn

		CloseBtn1.MouseButton1Click:Connect(function()
			AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				AvatarChange,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationHolder,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait(.2)
			NotificationHolder:Destroy()
		end)

		CloseBtn2.MouseButton1Click:Connect(function()
			AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				AvatarChange,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationHolder,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait(.2)
			NotificationHolder:Destroy()
		end)

		CloseBtn2.MouseEnter:Connect(function()
			TweenService:Create(
				Close2Icon,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ImageColor3 = Color3.fromRGB(210,210,210)}
			):Play()
		end)

		CloseBtn2.MouseLeave:Connect(function()
			TweenService:Create(
				Close2Icon,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ImageColor3 = Color3.fromRGB(119, 122, 127)}
			):Play()
		end)


		AvatarTextbox.Focused:Connect(function()
			TweenService:Create(
				TextBoxFrame,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
			):Play()
		end)

		AvatarTextbox.FocusLost:Connect(function()
			TweenService:Create(
				TextBoxFrame,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(37, 40, 43)}
			):Play()
		end)


	end)

	UserPanelUserTag.Name = "UserPanelUserTag"
	UserPanelUserTag.Parent = UserPanel
	UserPanelUserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserPanelUserTag.BackgroundTransparency = 1.000
	UserPanelUserTag.Position = UDim2.new(0.271143615, 0, 0.231804818, 0)
	UserPanelUserTag.Size = UDim2.new(0, 113, 0, 19)

	UserPanelUser.Name = "UserPanelUser"
	UserPanelUser.Parent = UserPanelUserTag
	UserPanelUser.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserPanelUser.BackgroundTransparency = 1.000
	UserPanelUser.Font = Enum.Font.GothamSemibold
	UserPanelUser.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserPanelUser.TextSize = 17.000
	UserPanelUser.TextXAlignment = Enum.TextXAlignment.Left
	UserPanelUser.Text = user
	UserPanelUser.Size = UDim2.new(0, UserPanelUser.TextBounds.X + 2, 0, 19)


	UserPanelUserTagLayout.Name = "UserPanelUserTagLayout"
	UserPanelUserTagLayout.Parent = UserPanelUserTag
	UserPanelUserTagLayout.FillDirection = Enum.FillDirection.Horizontal
	UserPanelUserTagLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UserPanelTag.Name = "UserPanelTag"
	UserPanelTag.Parent = UserPanelUserTag
	UserPanelTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserPanelTag.BackgroundTransparency = 1.000
	UserPanelTag.Position = UDim2.new(0.0419999994, 0, 0.493999988, 0)
	UserPanelTag.Size = UDim2.new(0, 65, 0, 19)
	UserPanelTag.Font = Enum.Font.Gotham
	UserPanelTag.Text = "#" .. tag
	UserPanelTag.TextColor3 = Color3.fromRGB(184, 186, 189)
	UserPanelTag.TextSize = 17.000
	UserPanelTag.TextXAlignment = Enum.TextXAlignment.Left

	UserPanelCorner.Name = "UserPanelCorner"
	UserPanelCorner.Parent = UserPanel

	LeftFrame.Name = "LeftFrame"
	LeftFrame.Parent = SettingsHolder
	LeftFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	LeftFrame.BorderSizePixel = 0
	LeftFrame.Position = UDim2.new(0, 0, -0.000303059904, 0)
	LeftFrame.Size = UDim2.new(0, 233, 0, 375)

	MyAccountBtn.Name = "MyAccountBtn"
	MyAccountBtn.Parent = LeftFrame
	MyAccountBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	MyAccountBtn.BorderSizePixel = 0
	MyAccountBtn.Position = UDim2.new(0.271232396, 0, 0.101614028, 0)
	MyAccountBtn.Size = UDim2.new(0, 160, 0, 30)
	MyAccountBtn.AutoButtonColor = false
	MyAccountBtn.Font = Enum.Font.SourceSans
	MyAccountBtn.Text = ""
	MyAccountBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	MyAccountBtn.TextSize = 14.000

	MyAccountBtnCorner.CornerRadius = UDim.new(0, 6)
	MyAccountBtnCorner.Name = "MyAccountBtnCorner"
	MyAccountBtnCorner.Parent = MyAccountBtn

	MyAccountBtnTitle.Name = "MyAccountBtnTitle"
	MyAccountBtnTitle.Parent = MyAccountBtn
	MyAccountBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MyAccountBtnTitle.BackgroundTransparency = 1.000
	MyAccountBtnTitle.BorderSizePixel = 0
	MyAccountBtnTitle.Position = UDim2.new(0.0759999976, 0, -0.166999996, 0)
	MyAccountBtnTitle.Size = UDim2.new(0, 95, 0, 39)
	MyAccountBtnTitle.Font = Enum.Font.GothamSemibold
	MyAccountBtnTitle.Text = "My Account"
	MyAccountBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	MyAccountBtnTitle.TextSize = 14.000
	MyAccountBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

	SettingsTitle.Name = "SettingsTitle"
	SettingsTitle.Parent = LeftFrame
	SettingsTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SettingsTitle.BackgroundTransparency = 1.000
	SettingsTitle.Position = UDim2.new(0.308999985, 0, 0.0450000018, 0)
	SettingsTitle.Size = UDim2.new(0, 65, 0, 19)
	SettingsTitle.Font = Enum.Font.GothamBlack
	SettingsTitle.Text = "SETTINGS"
	SettingsTitle.TextColor3 = Color3.fromRGB(142, 146, 152)
	SettingsTitle.TextSize = 11.000
	SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left

	DiscordInfo.Name = "DiscordInfo"
	DiscordInfo.Parent = LeftFrame
	DiscordInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DiscordInfo.BackgroundTransparency = 1.000
	DiscordInfo.Position = UDim2.new(0.304721028, 0, 0.821333349, 0)
	DiscordInfo.Size = UDim2.new(0, 133, 0, 44)
	DiscordInfo.Font = Enum.Font.Gotham
	DiscordInfo.Text = "Stable 1.0.0 (00001)  Host 0.0.0.1                Roblox Lua Engine    "
	DiscordInfo.TextColor3 = Color3.fromRGB(101, 108, 116)
	DiscordInfo.TextSize = 13.000
	DiscordInfo.TextWrapped = true
	DiscordInfo.TextXAlignment = Enum.TextXAlignment.Left
	DiscordInfo.TextYAlignment = Enum.TextYAlignment.Top

	CurrentSettingOpen.Name = "CurrentSettingOpen"
	CurrentSettingOpen.Parent = LeftFrame
	CurrentSettingOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CurrentSettingOpen.BackgroundTransparency = 1.000
	CurrentSettingOpen.Position = UDim2.new(1.07294846, 0, 0.0450000018, 0)
	CurrentSettingOpen.Size = UDim2.new(0, 65, 0, 19)
	CurrentSettingOpen.Font = Enum.Font.GothamBlack
	CurrentSettingOpen.Text = "MY ACCOUNT"
	CurrentSettingOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
	CurrentSettingOpen.TextSize = 14.000
	CurrentSettingOpen.TextXAlignment = Enum.TextXAlignment.Left


	SettingsOpenBtn.MouseButton1Click:Connect(function ()
		settingsopened = true
		TopFrameHolder.Visible = false
		ServersHoldFrame.Visible = false
		SettingsFrame.Visible = true
		SettingsHolder:TweenSize(UDim2.new(0, 681, 0, 375), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
		Settings.BackgroundTransparency = 1
		TweenService:Create(
			Settings,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()
		for i,v in next, SettingsHolder:GetChildren() do
			v.BackgroundTransparency = 1
			TweenService:Create(
				v,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 0}
			):Play()
		end
	end)

	EditBtn.MouseButton1Click:Connect(function()
		local NotificationHolder = Instance.new("TextButton")
		NotificationHolder.Name = "NotificationHolder"
		NotificationHolder.Parent = SettingsHolder
		NotificationHolder.BackgroundColor3 = Color3.fromRGB(22,22,22)
		NotificationHolder.Position = UDim2.new(-0.00881057233, 0, -0.00266666664, 0)
		NotificationHolder.Size = UDim2.new(0, 687, 0, 375)
		NotificationHolder.AutoButtonColor = false
		NotificationHolder.Font = Enum.Font.SourceSans
		NotificationHolder.Text = ""
		NotificationHolder.TextColor3 = Color3.fromRGB(0, 0, 0)
		NotificationHolder.TextSize = 14.000
		NotificationHolder.BackgroundTransparency = 1
		NotificationHolder.Visible = true
		TweenService:Create(
			NotificationHolder,
			TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0.2}
		):Play()

		local UserChange = Instance.new("Frame")
		local UserChangeCorner = Instance.new("UICorner")
		local UnderBar = Instance.new("Frame")
		local UnderBarCorner = Instance.new("UICorner")
		local UnderBarFrame = Instance.new("Frame")
		local Text1 = Instance.new("TextLabel")
		local Text2 = Instance.new("TextLabel")
		local TextBoxFrame = Instance.new("Frame")
		local TextBoxFrameCorner = Instance.new("UICorner")
		local TextBoxFrame1 = Instance.new("Frame")
		local TextBoxFrame1Corner = Instance.new("UICorner")
		local UsernameTextbox = Instance.new("TextBox")
		local Seperator = Instance.new("Frame")
		local HashtagLabel = Instance.new("TextLabel")
		local TagTextbox = Instance.new("TextBox")
		local ChangeBtn = Instance.new("TextButton")
		local ChangeCorner = Instance.new("UICorner")
		local CloseBtn2 = Instance.new("TextButton")
		local Close2Icon = Instance.new("ImageLabel")
		local CloseBtn1 = Instance.new("TextButton")
		local CloseBtn1Corner = Instance.new("UICorner")

		UserChange.Name = "UserChange"
		UserChange.Parent = NotificationHolder
		UserChange.AnchorPoint = Vector2.new(0.5, 0.5)
		UserChange.BackgroundColor3 = Color3.fromRGB(25,25,25)
		UserChange.ClipsDescendants = true
		UserChange.Position = UDim2.new(0.513071597, 0, 0.4746176, 0)
		UserChange.Size = UDim2.new(0, 0, 0, 0)
		UserChange.BackgroundTransparency = 1

		UserChange:TweenSize(UDim2.new(0, 346, 0, 198), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
		TweenService:Create(
			UserChange,
			TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()

		UserChangeCorner.CornerRadius = UDim.new(0, 5)
		UserChangeCorner.Name = "UserChangeCorner"
		UserChangeCorner.Parent = UserChange

		UnderBar.Name = "UnderBar"
		UnderBar.Parent = UserChange
		UnderBar.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
		UnderBar.Position = UDim2.new(-0.000297061284, 0, 0.945048928, 0)
		UnderBar.Size = UDim2.new(0, 346, 0, 13)

		UnderBarCorner.CornerRadius = UDim.new(0, 5)
		UnderBarCorner.Name = "UnderBarCorner"
		UnderBarCorner.Parent = UnderBar

		UnderBarFrame.Name = "UnderBarFrame"
		UnderBarFrame.Parent = UnderBar
		UnderBarFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
		UnderBarFrame.BorderSizePixel = 0
		UnderBarFrame.Position = UDim2.new(-0.000297061284, 0, -2.53846145, 0)
		UnderBarFrame.Size = UDim2.new(0, 346, 0, 39)

		Text1.Name = "Text1"
		Text1.Parent = UserChange
		Text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text1.BackgroundTransparency = 1.000
		Text1.Position = UDim2.new(-0.000594122568, 0, 0.0202020202, 0)
		Text1.Size = UDim2.new(0, 346, 0, 68)
		Text1.Font = Enum.Font.GothamSemibold
		Text1.Text = "Change your username"
		Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text1.TextSize = 20.000

		Text2.Name = "Text2"
		Text2.Parent = UserChange
		Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text2.BackgroundTransparency = 1.000
		Text2.Position = UDim2.new(-0.000594122568, 0, 0.141587839, 0)
		Text2.Size = UDim2.new(0, 346, 0, 63)
		Text2.Font = Enum.Font.Gotham
		Text2.Text = "Enter your new username."
		Text2.TextColor3 = Color3.fromRGB(171, 172, 176)
		Text2.TextSize = 14.000

		TextBoxFrame.Name = "TextBoxFrame"
		TextBoxFrame.Parent = UserChange
		TextBoxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBoxFrame.BackgroundColor3 = Color3.fromRGB(37, 40, 43)
		TextBoxFrame.Position = UDim2.new(0.49710983, 0, 0.560606062, 0)
		TextBoxFrame.Size = UDim2.new(0, 319, 0, 38)

		TextBoxFrameCorner.CornerRadius = UDim.new(0, 3)
		TextBoxFrameCorner.Name = "TextBoxFrameCorner"
		TextBoxFrameCorner.Parent = TextBoxFrame

		TextBoxFrame1.Name = "TextBoxFrame1"
		TextBoxFrame1.Parent = TextBoxFrame
		TextBoxFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBoxFrame1.BackgroundColor3 = Color3.fromRGB(48, 51, 57)
		TextBoxFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBoxFrame1.Size = UDim2.new(0, 317, 0, 36)

		TextBoxFrame1Corner.CornerRadius = UDim.new(0, 3)
		TextBoxFrame1Corner.Name = "TextBoxFrame1Corner"
		TextBoxFrame1Corner.Parent = TextBoxFrame1

		UsernameTextbox.Name = "UsernameTextbox"
		UsernameTextbox.Parent = TextBoxFrame1
		UsernameTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UsernameTextbox.BackgroundTransparency = 1.000
		UsernameTextbox.Position = UDim2.new(0.0378548913, 0, 0, 0)
		UsernameTextbox.Size = UDim2.new(0, 221, 0, 37)
		UsernameTextbox.Font = Enum.Font.Gotham
		UsernameTextbox.Text = user
		UsernameTextbox.TextColor3 = Color3.fromRGB(193, 195, 197)
		UsernameTextbox.TextSize = 14.000
		UsernameTextbox.TextXAlignment = Enum.TextXAlignment.Left

		Seperator.Name = "Seperator"
		Seperator.Parent = TextBoxFrame1
		Seperator.AnchorPoint = Vector2.new(0.5, 0.5)
		Seperator.BackgroundColor3 = Color3.fromRGB(25,25,25)
		Seperator.BorderSizePixel = 0
		Seperator.Position = UDim2.new(0.753000021, 0, 0.500999987, 0)
		Seperator.Size = UDim2.new(0, 1, 0, 25)

		HashtagLabel.Name = "HashtagLabel"
		HashtagLabel.Parent = TextBoxFrame1
		HashtagLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HashtagLabel.BackgroundTransparency = 1.000
		HashtagLabel.Position = UDim2.new(0.765877604, 0, -0.0546001866, 0)
		HashtagLabel.Size = UDim2.new(0, 23, 0, 37)
		HashtagLabel.Font = Enum.Font.Gotham
		HashtagLabel.Text = "#"
		HashtagLabel.TextColor3 = Color3.fromRGB(79, 82, 88)
		HashtagLabel.TextSize = 16.000

		TagTextbox.Name = "TagTextbox"
		TagTextbox.Parent = TextBoxFrame1
		TagTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TagTextbox.BackgroundTransparency = 1.000
		TagTextbox.Position = UDim2.new(0.824999988, 0, -0.0280000009, 0)
		TagTextbox.Size = UDim2.new(0, 59, 0, 38)
		TagTextbox.Font = Enum.Font.Gotham
		TagTextbox.PlaceholderColor3 = Color3.fromRGB(210, 211, 212)
		TagTextbox.Text = tag
		TagTextbox.TextColor3 = Color3.fromRGB(193, 195, 197)
		TagTextbox.TextSize = 14.000
		TagTextbox.TextXAlignment = Enum.TextXAlignment.Left

		ChangeBtn.Name = "ChangeBtn"
		ChangeBtn.Parent = UserChange
		ChangeBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
		ChangeBtn.Position = UDim2.new(0.749670506, 0, 0.823232353, 0)
		ChangeBtn.Size = UDim2.new(0, 76, 0, 27)
		ChangeBtn.Font = Enum.Font.Gotham
		ChangeBtn.Text = "Change"
		ChangeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		ChangeBtn.TextSize = 13.000
		ChangeBtn.AutoButtonColor = false

		ChangeBtn.MouseEnter:Connect(function()
			TweenService:Create(
				ChangeBtn,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(103,123,196)}
			):Play()
		end)

		ChangeBtn.MouseLeave:Connect(function()
			TweenService:Create(
				ChangeBtn,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
			):Play()
		end)

		ChangeBtn.MouseButton1Click:Connect(function()
			user = UsernameTextbox.Text
			tag = TagTextbox.Text
			UserSettingsPadUser.Text = user
			UserSettingsPadUser.Size = UDim2.new(0, UserSettingsPadUser.TextBounds.X + 2, 0, 19)
			UserSettingsPadTag.Text = "#" .. tag
			UserPanelTag.Text = "#" .. tag
			UserPanelUser.Text = user
			UserPanelUser.Size = UDim2.new(0, UserPanelUser.TextBounds.X + 2, 0, 19)
			UserName.Text = user
			UserTag.Text = "#" .. tag
			SaveInfo()

			UserChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				UserChange,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationHolder,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait(.2)
			NotificationHolder:Destroy()
		end)

		ChangeCorner.CornerRadius = UDim.new(0, 4)
		ChangeCorner.Name = "ChangeCorner"
		ChangeCorner.Parent = ChangeBtn

		CloseBtn2.Name = "CloseBtn2"
		CloseBtn2.Parent = UserChange
		CloseBtn2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn2.BackgroundTransparency = 1.000
		CloseBtn2.Position = UDim2.new(0.898000002, 0, 0, 0)
		CloseBtn2.Size = UDim2.new(0, 26, 0, 26)
		CloseBtn2.Font = Enum.Font.Gotham
		CloseBtn2.Text = ""
		CloseBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn2.TextSize = 14.000

		Close2Icon.Name = "Close2Icon"
		Close2Icon.Parent = CloseBtn2
		Close2Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Close2Icon.BackgroundTransparency = 1.000
		Close2Icon.Position = UDim2.new(-0.0384615399, 0, 0.312910825, 0)
		Close2Icon.Size = UDim2.new(0, 25, 0, 25)
		Close2Icon.ImageColor3 = Color3.fromRGB(119, 122, 127)

		CloseBtn1.Name = "CloseBtn1"
		CloseBtn1.Parent = UserChange
		CloseBtn1.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
		CloseBtn1.BackgroundTransparency = 1.000
		CloseBtn1.Position = UDim2.new(0.495000005, 0, 0.823000014, 0)
		CloseBtn1.Size = UDim2.new(0, 76, 0, 27)
		CloseBtn1.Font = Enum.Font.Gotham
		CloseBtn1.Text = "Close"
		CloseBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseBtn1.TextSize = 13.000

		CloseBtn1Corner.CornerRadius = UDim.new(0, 4)
		CloseBtn1Corner.Name = "CloseBtn1Corner"
		CloseBtn1Corner.Parent = CloseBtn1

		CloseBtn1.MouseButton1Click:Connect(function()
			UserChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				UserChange,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationHolder,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait(.2)
			NotificationHolder:Destroy()
		end)

		CloseBtn2.MouseButton1Click:Connect(function()
			UserChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				UserChange,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			TweenService:Create(
				NotificationHolder,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait(.2)
			NotificationHolder:Destroy()
		end)

		CloseBtn2.MouseEnter:Connect(function()
			TweenService:Create(
				Close2Icon,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ImageColor3 = Color3.fromRGB(210,210,210)}
			):Play()
		end)

		CloseBtn2.MouseLeave:Connect(function()
			TweenService:Create(
				Close2Icon,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ImageColor3 = Color3.fromRGB(119, 122, 127)}
			):Play()
		end)

		TagTextbox.Changed:Connect(function()
			TagTextbox.Text = TagTextbox.Text:sub(1,4)
		end)

		TagTextbox:GetPropertyChangedSignal("Text"):Connect(function()
			TagTextbox.Text = TagTextbox.Text:gsub('%D+', '');
		end)

		UsernameTextbox.Changed:Connect(function()
			UsernameTextbox.Text = UsernameTextbox.Text:sub(1,13)
		end)

		TagTextbox.Focused:Connect(function()
			TweenService:Create(
				TextBoxFrame,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
			):Play()
		end)

		TagTextbox.FocusLost:Connect(function()
			TweenService:Create(
				TextBoxFrame,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(37, 40, 43)}
			):Play()
		end)

		UsernameTextbox.Focused:Connect(function()
			TweenService:Create(
				TextBoxFrame,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
			):Play()
		end)

		UsernameTextbox.FocusLost:Connect(function()
			TweenService:Create(
				TextBoxFrame,
				TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(37, 40, 43)}
			):Play()
		end)

	end)
    

    local NotiFrame = Instance.new("Frame")
    NotiFrame.Name = "NotiFrame"
    NotiFrame.Parent = SazaUi
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

    MakeDraggable(TopFramess, MainFrame)
    ServersHoldPadding.PaddingLeft = UDim.new(0, 14)
    local ServerHold = {}
	function ServerHold:Server(text,textgame, img)
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
		local ServerTitle2 = Instance.new("TextLabel")
		local GlowFrame = Instance.new("Frame")
		local Glow = Instance.new("ImageLabel")
		local ServerContentFrame = Instance.new("Frame")
		local ServerCorner = Instance.new("UICorner")
		local ChannelCorner = Instance.new("UICorner")
		local ChannelTitleFrame = Instance.new("Frame")
		local Hashtag = Instance.new("TextLabel")
		local ChannelTitle = Instance.new("TextLabel")
		local ChannelContentFrame = Instance.new("Frame")
		local GlowChannel = Instance.new("ImageLabel")
		local ServerChannelHolder = Instance.new("ScrollingFrame")
		local ServerChannelHolderLayout = Instance.new("UIListLayout")
		local ServerChannelHolderPadding = Instance.new("UIPadding")


		ServerFrame.Name = "ServerFrame"
		ServerFrame.Parent = ServersHolder
		ServerFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
		ServerFrame.BorderSizePixel = 0
		ServerFrame.ClipsDescendants = true
		ServerFrame.Position = UDim2.new(0.105726875, 0, 1.01262593, 0)
		ServerFrame.Size = UDim2.new(0, 609, 0, 373)
		ServerFrame.Visible = false

		ServerFrame1.Name = "ServerFrame1"
		ServerFrame1.Parent = ServerFrame
		ServerFrame1.BackgroundColor3 = Color3.fromRGB(20,20,20)
		ServerFrame1.BorderSizePixel = 0
		ServerFrame1.Position = UDim2.new(0, 0, 0.972290039, 0)
		ServerFrame1.Size = UDim2.new(0, 12, 0, 10)

		ServerFrame2.Name = "ServerFrame2"
		ServerFrame2.Parent = ServerFrame
		ServerFrame2.BackgroundColor3 = Color3.fromRGB(20,20,20)
		ServerFrame2.BorderSizePixel = 0
		ServerFrame2.Position = UDim2.new(0.980295539, 0, 0.972290039, 0)
		ServerFrame2.Size = UDim2.new(0, 12, 0, 9)

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

		ServerTitle2.Name = "ServerTitle"
		ServerTitle2.Parent = ServerTitleFrame
		ServerTitle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ServerTitle2.BackgroundTransparency = 1
		ServerTitle2.BorderSizePixel = 0
		ServerTitle2.Position = UDim2.new(0.0541359761, 0, 7.5, 0)
		ServerTitle2.Size = UDim2.new(0, 97, 0, 39)
		ServerTitle2.ZIndex = 999
		ServerTitle2.Font = Enum.Font.GothamSemibold
		ServerTitle2.Text = textgame
		ServerTitle2.TextColor3 = Color3.fromRGB(255, 255, 255)
		ServerTitle2.TextTransparency = 0.8
		ServerTitle2.TextSize = 13.000
		ServerTitle2.TextXAlignment = Enum.TextXAlignment.Left

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

		ServerCorner.CornerRadius = UDim.new(0, 4)
		ServerCorner.Name = "ServerCorner"
		ServerCorner.Parent = ServerFrame

		ChannelTitleFrame.Name = "ChannelTitleFrame"
		ChannelTitleFrame.Parent = ServerFrame
		ChannelTitleFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
		ChannelTitleFrame.BorderSizePixel = 0
		ChannelTitleFrame.Position = UDim2.new(0.294561088, 0, -0.000900391256, 0)
		ChannelTitleFrame.Size = UDim2.new(0, 429, 0, 40)

		Hashtag.Name = "Hashtag"
		Hashtag.Parent = ChannelTitleFrame
		Hashtag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Hashtag.BackgroundTransparency = 1.000
		Hashtag.BorderSizePixel = 0
		Hashtag.Position = UDim2.new(0.0279720277, 0, 0, 0)
		Hashtag.Size = UDim2.new(0, 19, 0, 39)
		Hashtag.Font = Enum.Font.Gotham
		Hashtag.Text = "●"
		Hashtag.TextColor3 = Color3.fromRGB(114, 118, 125)
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
		ChannelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		ChannelTitle.TextSize = 15.000
		ChannelTitle.TextXAlignment = Enum.TextXAlignment.Left

		ChannelContentFrame.Name = "ChannelContentFrame"
		ChannelContentFrame.Parent = ServerFrame
		ChannelContentFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
		ChannelContentFrame.BorderSizePixel = 0
		ChannelContentFrame.ClipsDescendants = true
		ChannelContentFrame.Position = UDim2.new(0.294561088, 0, 0.106338218, 0)
		ChannelContentFrame.Size = UDim2.new(0, 429, 0, 333)

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


		if fs == false then
			TweenService:Create(
				Server,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(25,25,25)}
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
		function ChannelHold:Channel(text)
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
				Dropdown.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
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
				CurrentSelectedText.TextTransparency = 0.250
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
				DropItemHolderLabel.TextColor3 = PresetColor
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

				for i, v in next, list do
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
						ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
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
					for i, v in next, DropItemHolder:GetChildren() do
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

Old_World = false
New_World = false
Three_World = false
local placeId = game.PlaceId
if placeId == 2753915549 then
    Old_World = true
elseif placeId == 4442272183 then
    New_World = true
elseif placeId == 7449423635 then
    Three_World = true
end

local window = DiscordLib:Window("Blox Fruits")
local serv = window:Server("SAZA HUB", "")
local AF2 = serv:Channel("Main", "http://www.roblox.com/asset/?id=173616340")
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

AF2:Button("Rejoin Server", function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").localPlayer)
end)

AF2:Button("Delete Gui", function()
DiscordLib:Notification("SazaSystem:","Thanks for use SAZA HUB", 3)
wait(3)
destroyguis()
end)

AF2:Label("Press Right-CTRL for Hide Gui")
AF2:Label("Anti AFK Always On")

AF2:Seperator()
AF2:Label(" Owner: Zaaa 愛#6969, Saskai#2799")

function Simulation()
    if setsimulationradius then
       sethiddenproperty(LP, "SimulationRadius", 10000)
    end
    if setsimulationradius then
       sethiddenproperty(LP, "MaxSimulationRadius", math.huge)
    end
    if setsimulationradius then
       sethiddenproperty(LP, "SimulationRadius", math.huge)
    end
 end

spawn(function()
    while wait() do
       LP = game:GetService("Players").LocalPlayer
       Char = LP.Character
       HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart")
       Humanoid = Char:FindFirstChild("Humanoid")
    end
 end)

LP = game:GetService("Players").LocalPlayer
Char = LP.Character
HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart")
Humanoid = Char:FindFirstChild("Humanoid")

function Alive()
    if LP and Char then
       if Humanoid and HumanoidRootPart then
          if Humanoid.Health > 0 then
             return true
          end 
       end
    end
    return true
end

SelectToolWeapon = ""

Wapon = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
    if v:IsA("Tool") then
       table.insert(Wapon ,v.Name)
    end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
    if v:IsA("Tool") then
       table.insert(Wapon, v.Name)
    end
end

local AF = serv:Channel("Farming", "http://www.roblox.com/asset/?id=6022668945")

AF:Label("Weapon One For All")

local SelectWeapon = AF:Dropdown("Select Weapon", Wapon,function(Value)
    SelectToolWeapon = Value
    SelectToolWeaponOld = Value
end)

AF:Button("Refresh Weapon", function()
    SelectWeapon:Clear()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            SelectWeapon:Add(v.Name)
        end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            SelectWeapon:Add(v.Name)
        end
    end
end)

AF:Toggle("AutoFarm Level", _G.AutoFarmLevel, function(vu)
    _G.AutoFarm = vu
    if _G.AutoFarm and SelectToolWeapon == "" then
        DiscordLib:Notification("SazaSystem","Select Weapon First",3)
    else
        Auto_Farm = vu
        SelectMonster = ""
        if vu == false then
            wait(1)
            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end
end)

AF:Toggle("Auto Superhuman", _G.AutoSuperhuman, function(vu)
    Superhuman = vu
    if vu == false then
        SelectToolWeapon = ""
    end
end)

AF:Toggle("Auto Death Step", _G.DeathStep,function(vu)
    DeathStep = vu
    if vu == false then
        SelectToolWeapon = ""
    end
end)
if Three_World then
AF:Toggle("Auto Dragon Talon", _G.DragonTelon,function(vu)
    DA = vu
    if vu == false then
        SelectToolWeapon = ""
    end
end)
end

AF:Toggle("Auto Electro", _G.Electro, function(vu)
    Electro = vu
    if vu == false then
        SelectToolWeapon = ""
    end
end)

if Old_World then

    local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value

    AF:Toggle("Auto Open Saber Room ",false,function(vu)
          if SelectToolWeapon == "" and vu then
            DiscordLib:Notification("SazaSystem","Select Weapon First", 3)
        elseif game.Workspace.Map.Jungle.Final.Part.Transparency == 1 then
            DiscordLib:Notification("SazaSystem","Saber Room Succeed", 3)
        elseif Lv < 200 then
            DiscordLib:Notification("SazaSystem","Not Enough Lv, Must LV 200 ", 3)
        else
            _G.AutoSaber = vu
        end  
    end) 


    AF:Toggle("Auto New World", _G.AutoNewworld, function(vu)
        Auto_Newworld = vu
        if vu == false then
            wait(1)
            TP(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        end
    end)
end

local Stats = serv:Channel("Stats","http://www.roblox.com/asset/?id=5917153832")

Stats:Label2(""):Refresh("Your Stats")

local Point = Stats:Label2("")
local StatDefense = Stats:Label2("")
local StatMelee = Stats:Label2("")
local StatSword = Stats:Label2("")
local StatGun = Stats:Label2("")
local StatFruit = Stats:Label2("")

spawn(function()
    while game:GetService("RunService").Heartbeat:wait() do
        Point:Refresh("Point : "..tostring(game:GetService("Players").LocalPlayer.Data.Points.Value))
        StatMelee:Refresh("Melee : "..tostring(game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value))
        StatDefense:Refresh("Defense : "..tostring(game:GetService("Players").LocalPlayer.Data.Stats.Defense.Level.Value))
        StatSword:Refresh("Sword : "..tostring(game:GetService("Players").LocalPlayer.Data.Stats.Sword.Level.Value))
        StatGun:Refresh("Gun : "..tostring(game:GetService("Players").LocalPlayer.Data.Stats.Gun.Level.Value))
        StatFruit:Refresh("Devil Fruit : "..tostring(game:GetService("Players").LocalPlayer.Data.Stats["Demon Fruit"].Level.Value))
    end
end)

Stats:Seperator()

Stats:Toggle("Melee", _G.Melee, function(vu)
    Mad = vu
end)

Stats:Toggle("Defense", _G.Defense, function(vu)
    Gan = vu
end)

Stats:Toggle("Sword", _G.Sword, function(vu)
    Dap = vu
end)

Stats:Toggle("Gun", _G.Gun, function(vu)
    Pun = vu
end)

Stats:Toggle("Devil Fruit", _G.DevilFruit, function(vu)
    DevilFruit = vu
end)

SelectPoint = 1
Stats:Slider("Point", 1,500,1, function(Point)
    SelectPoint = Point
end)

spawn(function()
    while wait(.1) do
        if Mad then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", SelectPoint)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if Gan then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", SelectPoint)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if Dap then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", SelectPoint)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if Pun then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", SelectPoint)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if DevilFruit then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", SelectPoint)
        end
    end
end)

spawn(function()
    while wait(.1) do
        if _G.AutoStat then
            for i,v in pairs(_G.AutoStat) do
                if v == "Melee" and game.Players.LocalPlayer.Data.Stats.Melee.Level.Value ~= 2100 then
                    repeat game:GetService("RunService").Heartbeat:wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
                    until game.Players.LocalPlayer.Data.Stats.Melee.Level.Value == 2100
                elseif v == "Defense" and game.Players.LocalPlayer.Data.Stats.Defense.Level.Value ~= 2100 then
                    repeat game:GetService("RunService").Heartbeat:wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
                    until game.Players.LocalPlayer.Data.Stats.Defense.Level.Value == 2100
                elseif v == "Sword" and game.Players.LocalPlayer.Data.Stats.Sword.Level.Value ~= 2100 then
                    repeat game:GetService("RunService").Heartbeat:wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
                    until game.Players.LocalPlayer.Data.Stats.Sword.Level.Value == 2100
                elseif v == "Gun" and game.Players.LocalPlayer.Data.Stats.Gun.Level.Value ~= 2100 then
                    repeat game:GetService("RunService").Heartbeat:wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1)
                    until game.Players.LocalPlayer.Data.Stats.Gun.Level.Value == 2100
                elseif v == "DevilFruit" and game.Players.LocalPlayer.Data.Stats["Demon Fruit"].Level.Value ~= 2100 then
                    repeat game:GetService("RunService").Heartbeat:wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
                    until game.Players.LocalPlayer.Data.Stats.Gun.Level.Value == 2100
                end
            end
        end
    end
end)

local Tp = serv:Channel("Teleport","http://www.roblox.com/asset/?id=7044226690")

function TP(P1)
    Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance <= 300 then
        Speed = 1000
    elseif Distance <= 500 and Distance > 300 then
        Speed = 350
    else
        Speed = 275
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    ):Play()
end

function TP2(P1)
    Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 1000 then
        Speed = 400
    elseif Distance >= 1000 then
        Speed = 300
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    ):Play()
    Clip = true
    wait(Distance/Speed)
    Clip = false
end

if Old_World then
    
    Tp:Label("Teleport")

    Tp:Button("Teleport To Second Sea", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end)

    Tp:Button("Teleport To Third Sea", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end)

    Tp:Seperator()
  
    Tp:Button("MarineFord", function()
        TP2(CFrame.new(-4930.43555, 40.6778603, 4163.87988, -0.274516672, 1.16451586e-08, -0.961582363, -9.29829547e-10, 1, 1.23758639e-08, 0.961582363, 4.2914885e-09, -0.274516672))
    end)

    Tp:Button("Midle Town", function()
        TP2(CFrame.new(-663.114075, 27.6780567, 1697.3313, 0.98013711, 0, 0.198321342, -0, 1.00000012, -0, -0.198321342, 0, 0.98013711))
    end)

    Tp:Button("Marine", function()
        TP2(CFrame.new(-2771.7395, 24.5146275, 2041.42114, -0.230635583, -0, -0.973040164, -0, 1, -0, 0.973040283, 0, -0.230635554))
    end)

    Tp:Button("Pirate Village", function()
        TP2(CFrame.new(-1161.20874, 4.77785349, 3811.73926, -0.971826673, 0, 0.235696957, 0, 1.00000012, -0, -0.235696957, 0, -0.971826673))
    end)

    Tp:Button("Starter Island", function()
        TP2(CFrame.new(896.894348, 16.5424118, 1428.57617, 0.0727247, 0, -0.997352004, -0, 1, -0, 0.997352123, 0, 0.0727246925))
    end)

    Tp:Button("Jungle", function()
        TP2(CFrame.new(-1436.58545, 61.877758, -23.9062748, -0.963764966, 0, 0.266753078, 0, 1.00000012, -0, -0.266753078, 0, -0.963764966))
    end)

    Tp:Button("Desert", function()
        TP2(CFrame.new(906.342285, 6.48269415, 4369.03516, -0.922807872, -0, -0.385260701, -0, 1.00000012, -0, 0.385260761, 0, -0.922807753))
    end)

    Tp:Button("Frozen Village", function()
        TP2(CFrame.new(-1508.67249, 7.41514063, -2976.67529, -0.865556717, -0, -0.500810921, -0, 1, -0, 0.500810921, 0, -0.865556717))
    end)

    Tp:Button("Prison", function()
        TP2(CFrame.new(4857.6982421875, 5.6780304908752, 732.75750732422))
    end)

    Tp:Button("Colosseum", function()
        TP2(CFrame.new(-1667.5869140625, 39.385631561279, -3135.5817871094))
    end)

    Tp:Button("UnderWater City", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
    end)

    Tp:Button("Magma Village", function()
        TP2(CFrame.new(-5328.8740234375, 8.6164798736572, 8427.3994140625))
    end)

    Tp:Button("UnderWater Gate", function()
        TP2(CFrame.new(3948.8894, 14.635211, -1661.89661, 0.761867225, 0, -0.647733331, -0, 1.00000012, -0, 0.647733331, 0, 0.761867225))
    end)

    Tp:Button("Sky Island", function()
        TP2(CFrame.new(-4850.46436, 717.73822, -2631.52319, -0.831235468, 0, 0.555920482, 0, 1, -0, -0.555920422, 0, -0.831235588))
    end)

    Tp:Button("Sky Island 2ND", function()
        TP2(CFrame.new(-7884.38281, 5545.51758, -344.140198, 0.523121238, 0, -0.852258325, -0, 1, -0, 0.852258325, 0, 0.523121238))
    end)

    Tp:Button("Sky Island 3TH", function()
        TP2(CFrame.new(-7870.48145, 5642.13965, -1349.74451, 0.7301355, 0, -0.683302462, -0, 1.00000012, -0, 0.683302462, 0, 0.7301355))
    end)

    Tp:Button("Fountain City", function()
        TP2(CFrame.new(5206.12598, 59.5271606, 4043.94409, -0.68709439, -0, -0.726568162, -0, 1, -0, 0.726568222, 0, -0.687094331))
    end)

elseif New_World then

    Tp:Label("Teleport")
        
    Tp:Button("Teleport To First Sea", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end)

    Tp:Button("Teleport To Third Sea", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end)

    Tp:Seperator()

    Tp:Button("Cafe", function()
        TP2(CFrame.new(-379.70889282227, 73.0458984375, 304.84692382813))
    end)

    Tp:Button("Kingdom Of Rose", function()
        TP2(CFrame.new(-388.29895019531, 138.35575866699, 1132.1662597656))
    end)

    Tp:Button("Sunflower Field", function()
        TP2(CFrame.new(-1576.7171630859, 198.61849975586, 13.725157737732))
    end)

    Tp:Button("Mansion", function()
        TP2(CFrame.new(-390.34829711914, 321.89730834961, 869.00506591797))
    end)

    Tp:Button("Colossuem", function()
        TP2(CFrame.new(-1871.8974609375, 45.820514678955, 1359.6843261719))
    end)

    Tp:Button("Jeramy Mountain", function()
        TP2(CFrame.new(1986.3519287109, 448.95678710938, 796.70239257813))
    end)

    Tp:Button("Graveyard", function()
        TP2(CFrame.new(-5617.5927734375, 492.22183227539, -778.3017578125))
    end)

    Tp:Button("Factory", function()
        TP2(CFrame.new(349.53750610352, 74.446998596191, -355.62420654297))
    end)


    Tp:Button("Green Bit", function()
        TP2(CFrame.new(-2202.3706054688, 73.097663879395, -2819.2687988281))
    end)

    Tp:Button("The Bridge", function()
        TP2(CFrame.new(-1860.6354980469, 88.384948730469, -1859.1593017578))
    end)

    Tp:Button("Snow Mountain", function()
        TP2(CFrame.new(561.23834228516, 401.44781494141, -5297.14453125))
    end)

    Tp:Button("Forgotten Island", function()
        TP2(CFrame.new(-3051.9514160156, 238.87203979492, -10250.807617188))
    end)

    
    Tp:Button("Mini Sky", function()
        TP2(CFrame.new(-262.11901855469, 49325.69140625, -35272.49609375))
    end)

    Tp:Button("Cold Island", function()
        TP2(CFrame.new(-5924.716796875, 15.977565765381, -4996.427734375))
    end)

    Tp:Button("Dark Area", function()
        TP2(CFrame.new(3464.7700195313, 13.375151634216, -3368.90234375))
    end)

    Tp:Button("Hot Island", function()
        TP2(CFrame.new(-5505.9633789063, 15.977565765381, -5366.6123046875))
    end)

    Tp:Button("Ice Castle", function()
        TP2(CFrame.new(6111.7109375, 294.41259765625, -6716.4829101563))
    end)

    Tp:Button("Usopp Island", function()
        TP2(CFrame.new(4760.4985351563, 8.3444719314575, 2849.2426757813))
    end)

    Tp:Button("Ghost Ship", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
    end)


elseif Three_World then

    Tp:Label("Teleport")

    Tp:Button("Teleport to First Sea", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end)

    Tp:Button("Teleport to Second Sea", function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end)

    Tp:Seperator()

    Tp:Button("Port Town", function()
        TP2(CFrame.new(-275.21615600586, 43.755737304688, 5451.0659179688))
    end)

    Tp:Button("Hydra Island", function()
        TP2(CFrame.new(5541.2685546875, 668.30456542969, 195.48069763184))
    end)
    
    Tp:Button("Giant Tree", function()
        TP2(CFrame.new(2276.0859375, 25.87850189209, -6493.03125))
    end)
    
    Tp:Button("Turtle Island", function()
        TP2(CFrame.new(-10034.40234375, 331.78845214844, -8319.6923828125))
    end)
    
    Tp:Button("Mansion", function()
        TP2(CFrame.new(-12548.998046875, 332.40396118164, -7603.1865234375))
    end)

    Tp:Button("Castle on the Sea", function()
        TP2(CFrame.new(-5498.0458984375, 313.79473876953, -2860.6022949219))
    end)

    Tp:Button("Graveyard Island", function()
        TP2(CFrame.new(-9515.07324, 142.130615, 5537.58398))
    end)

    Tp:Button("Raid Lab", function()
        TP2(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
    end)

    Tp:Button("Mini Sky", function()
        TP2(CFrame.new(-263.66668701172, 49325.49609375, -35260))
    end)

    Tp:Button("Peanut Island", function()
        TP2(CFrame.new(-2041.48083, 9.70129871, -9932.20215, 0.997000456, 0, 0.0773966089, -0, 1, -0, -0.0773966163, 0, 0.997000337))
    end)
    Tp:Button("Ice Cream Island", function()
        TP2(CFrame.new(-884.760559, 65.8452759, -10897.167, 0.800284684, 1.25159803e-08, -0.599620283, 1.69200636e-08, 1, 4.34555822e-08, 0.599620283, -4.4922448e-08, 0.800284684))
    end)
end

local BuyItem = serv:Channel("Buy Item","http://www.roblox.com/asset/?id=7294901968")

BuyItem:Label("Candy Shop")

local Candy = BuyItem:Label2("")

spawn(function()
    while game:GetService("RunService").Heartbeat:wait(60) do
        Candy:Refresh("Total Candy : "..tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Check")))
    end
end)

BuyItem:Button("Buy Elf Hat (250 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",3,1)
end)

BuyItem:Button("Buy Santa Hat (500 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",3,2)
end)

BuyItem:Button("Buy Sleigh (1000 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",3,3)
end)

BuyItem:Button("Buy 2x Exp (50 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",1,1)
end)

BuyItem:Button("Buy 300 Fragment (50 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",2,1)
end)

BuyItem:Button("Buy 700 Fragment (100 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",2,2)
end)

BuyItem:Button("Buy Reset Stats (75 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",1,2)
end)

BuyItem:Button("Buy Reroll Race (100 Candy)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Candies","Buy",1,3)
end)

BuyItem:Seperator()

BuyItem:Label("Bone Shop")

local Bone = BuyItem:Label2("")

spawn(function()
while game:GetService("RunService").Heartbeat:wait() do
    Bone:Refresh("Total Bone : "..tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Check")))
end
end)

BuyItem:Button("Buy Random Surprise", function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
end)

BuyItem:Toggle("Auto Buy Random Surprise", false, function(vu)
AutoBuySurprise = vu
end)


spawn(function()
while wait(.1) do
    if AutoBuySurprise then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
    end
end
end)

BuyItem:Seperator()

BuyItem:Label("Accessory")

BuyItem:Button("Black Cape", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
end)

BuyItem:Button("Toemo Ring", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
end)

BuyItem:Button("Swordsman Hat", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
end)

BuyItem:Label("Ability")
BuyItem:Button("Buso Haki", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
end)

BuyItem:Button("Ken Haki", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
end)

BuyItem:Button("Soru", function()
   game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
end)

BuyItem:Button("Skyjump", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
end)

BuyItem:Seperator()
BuyItem:Label("Frag Shop")

BuyItem:Button("Reset Stats (2500 Frag)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
end)

BuyItem:Button("Reroll Race (3000 Frag)", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
end)

BuyItem:Seperator()

BuyItem:Label("Sword")

BuyItem:Button("Katana", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Katana")
end)

BuyItem:Button("Cutlass", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
end)

BuyItem:Button("Duel Katana", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
end)

BuyItem:Button("Iron Mace", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
end)

BuyItem:Button("Triple Katana", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
end)

BuyItem:Button("Dual-Headed Blade", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
end)

BuyItem:Button("Bisento", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Bisento")
end)

BuyItem:Button("Soul Cane", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
end)

BuyItem:Button("Pipe", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Pipe")
end)

BuyItem:Seperator()

BuyItem:Label("Fighting Style")

BuyItem:Button("Black Leg", function()
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
end)

BuyItem:Button("Electro", function()
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
end)

BuyItem:Button("Fishman Karate", function()
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
end)

BuyItem:Button("Dragon Claw", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
end)

BuyItem:Button("Superhuman", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
end)
BuyItem:Button("Death Step", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
end)
BuyItem:Button("Sharkman Karate", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end)
BuyItem:Button("Electric Claw", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
end)

BuyItem:Button("Dragon Talon", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon",true)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
end)

BuyItem:Seperator()

BuyItem:Label("Gun")

BuyItem:Button("Slingshot", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
end)

BuyItem:Button("Musket", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Musket")
end)

BuyItem:Button("Cannon", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cannon")
end)

BuyItem:Button("Kabucha", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","1")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
end)

BuyItem:Button("Flintlock", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
end)

BuyItem:Button("Refined Flintlock", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
end)

local Devil = serv:Channel("DevilFruit","http://www.roblox.com/asset/?id=7044284832")

SelectDevil = ""
CheckF = false
Devil:Dropdown("Select Devil Fruit",
{
    "Bomb-Bomb",
    "Spike-Spike",
    "Chop-Chop",
    "Spring-Spring",
    "Kilo-Kilo",
    "Spin-Spin",
    "Bird: Falcon",
    "Smoke-Smoke",
    "Flame-Flame",
    "Ice-Ice",
    "Sand-Sand",
    "Dark-Dark",
    "Revive-Revive",
    "Diamond-Diamond",
    "Light-Light",
    "Love-Love",
    "Rubber-Rubber",
    "Barrier-Barrier",
    "Magma-Magma",
    "Door-Door",
    "Quake-Quake",
    "Human-Human: Buddha",
    "String-String",
    "Bird-Bird: Phoenix",
    "Rumble-Rumble",
    "Paw-Paw",
    "Gravity-Gravity",
    "Dough-Dough",
    "Shadow-Shadow",
    "Venom-Venom",
    "Control-Control",
    "Soul-Soul",
    "Dragon-Dragon"
    }
    ,function(ply)
        SelectDevil = ply
end)
Devil:Toggle("Buy DF Sniper",false,function(vu)
    BuyFruitSinper = vu
end)
spawn(function()
    while wait(.1) do
        if BuyFruitSinper then
            local args = {
                [1] = "GetFruits"
            }
            
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            local args = {
                [1] = "PurchaseRawFruit",
                [2] = SelectDevil
            }
            
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end 
    end
end)
Devil:Button("Buy Random Devil Fruit", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
end)

Devil:Toggle("Auto Buy Random DF", false, function(v)
    DevilAutoBuy = v
end)

spawn(function()
    while wait(.1) do
        if DevilAutoBuy then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
        end
    end
end)
Devil:Seperator()

Devil:Toggle("Bring Fruit (Dropped)", _G.BringFruit, function(value)
    BringFruit = value
end)

spawn(function()
    pcall(function()
        while wait(.1) do
            if BringFruit then
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if string.find(v.Name, "Fruit") then
                        if v:IsA("Tool") then
                            v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
                            wait(.2)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
                        end
                    end
                end
            end
        end
    end)
end)

local msc = serv:Channel("Misc","http://www.roblox.com/asset/?id=7044233235")

msc:Button("Join Pirates Team", function()
    local args = {
        [1] = "SetTeam",
        [2] = "Pirates"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) 
    local args = {
        [1] = "BartiloQuestProgress"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

msc:Button("Join Marines Team",function()
    local args = {
        [1] = "SetTeam",
        [2] = "Marines"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    local args = {
        [1] = "BartiloQuestProgress"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
msc:Seperator()

    msc:Button("Devil Shop", function()
        local args = {
            [1] = "GetFruits"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        game.Players.localPlayer.PlayerGui.Main.FruitShop.Visible = true
    end)

    msc:Button("Color Haki", function()
        game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
    end)
    
    msc:Button("Title Name", function()
        local args = {
            [1] = "getTitles"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
    end)
    
    msc:Button("Inventory", function()
        local args = {
            [1] = "getInventoryWeapons"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        wait(1)
        game.Players.localPlayer.PlayerGui.Main.Inventory.Visible = true
    end)
    
    msc:Button("Fruit Inventory", function()
        local args = {
            [1] = "getInventoryFruits"
        }
        
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryFruits")
        game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitInventory.Visible = true
    end)

    msc:Seperator()

    msc:Label("ESP")

    msc:Toggle("ESP Player", false,function(Value)
        PlayerESP = Value
        while PlayerESP do wait()
            UpdatePlayer()
        end
    end)
    msc:Toggle("ESP Chest", false,function(Value)
        ChestESP = Value
        while ChestESP do wait()
            UpdateChest()
        end
    end)
    msc:Toggle("ESP Devil Fruit",false,function(Value)
        DevilESP = Value
        while DevilESP do wait()
            UpdateDevilFruit()
        end
    end)

    if placeId == 4442272183 then

        msc:Toggle("ESP Flower",false,function(Value)
                FlowerESP = Value
                while FlowerESP do wait()
                    UpdateFlower()
                end
            end)
        end
    
            Number = math.random(1,1000000)
    
            function UpdateChest()
                for i,v in pairs(game.Workspace:GetChildren()) do
                    pcall(function()
                        if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
                            if ChestESP then
                                if (v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3") and (v.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 60000 then
                                    if not v:FindFirstChild("ChestESP"..Number) then
                                        local Bb = Instance.new("BillboardGui", v)
                                        Bb.Name = "ChestESP"..Number
                                        Bb.ExtentsOffset = Vector3.new(0, 1, 0)
                                        Bb.Size = UDim2.new(1, 200, 1, 30)
                                        Bb.Adornee = v
                                        Bb.AlwaysOnTop = true
                                        local Textlb = Instance.new("TextLabel", Bb)
                                        Textlb.Font = "GothamBold"
                                        Textlb.FontSize = "Size14"
                                        Textlb.Size = UDim2.new(1,0,1,0)
                                        Textlb.BackgroundTransparency = 1
                                        Textlb.TextStrokeTransparency = 0.5
                                        if v.Name == "Chest1" then
                                            Textlb.TextColor3 = Color3.fromRGB(174, 123, 47)
                                            Textlb.Text = "Bronze Chest".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                                        end
                                        if v.Name == "Chest2" then
                                            Textlb.TextColor3 = Color3.fromRGB(255, 255, 127)
                                            Textlb.Text = "Gold Chest".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                                        end
                                        if v.Name == "Chest3" then
                                            Textlb.Text = "Diamond Chest".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                                            Textlb.TextColor3 = Color3.fromRGB(5, 243, 255)
                                        end
                                    else
                                        v["ChestESP"..Number].TextLabel.Text = v.Name.."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                                    end
                                end
                            else
                                if v:FindFirstChild("ChestESP"..Number) then
                                    v:FindFirstChild("ChestESP"..Number):Destroy()
                                end
                            end
                        end
                    end)
                end
            end
    
    function UpdatePlayer()
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            pcall(function()
                if v.Character then
                    if PlayerESP then
                        if v.Character.Head and not v.Character.Head:FindFirstChild("PlayerESP"..Number) then
                            local Bb = Instance.new("BillboardGui", v.Character.Head)
                            Bb.Name = "PlayerESP"..Number
                            Bb.ExtentsOffset = Vector3.new(0, 1, 0)
                            Bb.Size = UDim2.new(1, 200, 1, 30)
                            Bb.Adornee = v.Character.Head
                            Bb.AlwaysOnTop = true
                            local Textlb = Instance.new("TextLabel", Bb)
                            Textlb.Font = "GothamBold"
                            Textlb.FontSize = "Size14"
                            Textlb.Text = v.Name.."\n"..math.round((v.Character.Head.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                            Textlb.Size = UDim2.new(1,0,1,0)
                            Textlb.BackgroundTransparency = 1
                            Textlb.TextStrokeTransparency = 0.5
                            if v.Team == game:GetService("Players").LocalPlayer.Team then
                                Textlb.TextColor3 = Color3.new(0, 255, 0)
                            else
                                Textlb.TextColor3 = Color3.new(0, 0, 204)
                            end
                        else
                            v.Character.Head["PlayerESP"..Number].TextLabel.Text = v.Name.."\n"..math.round((v.Character.Head.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                        end
                    else
                        if v.Character.Head:FindFirstChild("PlayerESP"..Number) then
                            v.Character.Head:FindFirstChild("PlayerESP"..Number):Destroy()
                        end
                    end
                end
            end)
        end
    end
    
    function UpdateDevilFruit()
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            pcall(function()
                if string.find(v.Name, "Fruit") then
                    if DevilESP then
                        if string.find(v.Name, "Fruit") then
                            if not v.Handle:FindFirstChild("DevilESP"..Number) then
                                local Bb = Instance.new("BillboardGui", v.Handle)
                                Bb.Name = "DevilESP"..Number
                                Bb.ExtentsOffset = Vector3.new(0, 1, 0)
                                Bb.Size = UDim2.new(1, 200, 1, 30)
                                Bb.Adornee = v.Handle
                                Bb.AlwaysOnTop = true
                                local Textlb = Instance.new("TextLabel", Bb)
                                Textlb.Font = "GothamBold"
                                Textlb.FontSize = "Size14"
                                Textlb.Size = UDim2.new(1,0,1,0)
                                Textlb.BackgroundTransparency = 1
                                Textlb.TextStrokeTransparency = 0.5
                                Textlb.Text = v.Name.."\n"..math.round((v.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                                Textlb.TextColor3 = Color3.new(255, 255, 255)
                            else
                                v.Handle["DevilESP"..Number].TextLabel.Text = v.Name.."\n"..math.round((v.Handle.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                            end
                        end
                    else
                        if v.Handle:FindFirstChild("DevilESP"..Number) then
                            v.Handle:FindFirstChild("DevilESP"..Number):Destroy()
                        end
                    end
                end
            end)
        end
    end
    
    function UpdateFlower()
        for i,v in pairs(game.Workspace:GetChildren()) do
            pcall(function()
                if v.Name == "Flower2" or v.Name == "Flower1" then
                    if FlowerESP then
                        if not v:FindFirstChild("FindFlower"..Number) then
                            local bill = Instance.new("BillboardGui",v)
                            bill.Name = "FindFlower"..Number
                            bill.ExtentsOffset = Vector3.new(0, 1, 0)
                            bill.Size = UDim2.new(1,200,1,30)
                            bill.Adornee = v
                            bill.AlwaysOnTop = true
                            local name = Instance.new("TextLabel",bill)
                            name.Font = "GothamBold"
                            name.FontSize = "Size14"
                            name.TextWrapped = true
                            name.Size = UDim2.new(1,0,1,0)
                            name.TextYAlignment = "Top"
                            name.BackgroundTransparency = 1
                            name.TextStrokeTransparency = 0.5
                            name.TextColor3 = Color3.fromRGB(248, 41, 41)
                            if v.Name == "Flower1" then
                                name.Text = ("Blue Flower".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(28, 126, 255)
                            end
                            if v.Name == "Flower2" then
                                name.Text = ("Red Flower".."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(248, 41, 41)
                            end
                        else
                            v["FindFlower"..Number].TextLabel.Text = (v.Name.."\n"..math.round((v.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                        end
                    else
                        if v:FindFirstChild("FindFlower"..Number) then
                            v:FindFirstChild("FindFlower"..Number):Destroy()
                        end
                    end
                end
            end)
        end
    end
    
    function UpdateFruits()
        for i,v in pairs(game.Workspace:GetChildren()) do
            pcall(function()
                if v.Name == "Banana" or v.Name == "Apple" or v.Name == "Pineapple" then
                    if FindFruits then
                        if not v:FindFirstChild("FindFruit"..Number) then
                            local bill = Instance.new("BillboardGui",v)
                            bill.Name = "FindFruit"..Number
                            bill.ExtentsOffset = Vector3.new(0, 1, 0)
                            bill.Size = UDim2.new(1,200,1,30)
                            bill.Adornee = v
                            bill.AlwaysOnTop = true
                            local name = Instance.new("TextLabel",bill)
                            name.Font = "GothamBold"
                            name.FontSize = "Size14"
                            name.TextWrapped = true
                            name.Size = UDim2.new(1,0,1,0)
                            name.TextYAlignment = "Top"
                            name.BackgroundTransparency = 1
                            name.TextStrokeTransparency = 0.5
                            if v.Name == "Banana" then
                                name.Text = ("Banana".."\n"..math.round((v.Handle.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(255, 255, 0)
                            end
                            if v.Name == "Apple" then
                                name.Text = ("Apple".."\n"..math.round((v.Handle.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(208, 0, 0)
                            end
                            if v.Name == "PineApple" then
                                name.Text = ("PineApple".."\n"..math.round((v.Handle.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                                name.TextColor3 = Color3.fromRGB(255, 128, 0)
                            end
                        else
                            v["FindFruit"..Number].TextLabel.Text = (v.Name.."\n"..math.round((v.Handel.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m.")
                        end
                    else
                        if v:FindFirstChild("FindFruit"..Number) then
                            v:FindFirstChild("FindFruit"..Number):Destroy()
                        end
                    end
                end
            end)
        end
    end

    msc:Seperator()

    
    msc:Dropdown("Change Race",{"Mink","Fishman","Skypien"},function(value)
        Changea = value
        spawn(function()
            pcall(function()
                while wait() do
                    game:GetService("Players")["LocalPlayer"].Data.Race.Value = Changea
                end
            end)
        end)
    end)
    
    function infAb()
        if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
        end
        wait(.1)
        local inf = Instance.new("ParticleEmitter")
        inf.Acceleration = Vector3.new(0,0,0)
        inf.Archivable = true
        inf.Drag = 20
        inf.EmissionDirection = Enum.NormalId.Top
        inf.Enabled = true
        inf.Lifetime = NumberRange.new(0.2,0.2)
        inf.LightInfluence = 0
        inf.LockedToPart = true
        inf.Name = "Agility"
        inf.Rate = 500
        inf.RotSpeed = NumberRange.new(999, 9999)
        inf.Rotation = NumberRange.new(0, 0)
        inf.Speed = NumberRange.new(30, 30)
        inf.SpreadAngle = Vector2.new(360,360)
        inf.Texture = "rbxassetid://243098098"
        inf.VelocityInheritance = 0
        inf.ZOffset = 2
        inf.Transparency = NumberSequence.new(0)
        inf.Color = ColorSequence.new(Color3.fromRGB(222, 0, 31),Color3.fromRGB(104, 0, 15))
        inf.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    end

    msc:Toggle("Inf Ability",false,function(inf)
        if inf == true then
            infAb()
        elseif inf == false then
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
                game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
            end
        else
            if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
                game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
            end
        end
    end)

    msc:Toggle("No Dodge Cooldown", false, function(Value)
        nododgecool = Value
        NoDodgeCool()
    end)
    msc:Toggle("Infinits Energy", false,function(value)
        InfinitsEnergy = value
        originalstam = LocalPlayer.Character.Energy.Value
    end)
    local LocalPlayer = game:GetService'Players'.LocalPlayer
    local originalstam = LocalPlayer.Character.Energy.Value
    function infinitestam()
        LocalPlayer.Character.Energy.Changed:connect(function()
            if InfinitsEnergy then
                LocalPlayer.Character.Energy.Value = originalstam
            end 
        end)
    end
    spawn(function()
        while wait(.1) do
            if InfinitsEnergy then
                wait(0.3)
                originalstam = LocalPlayer.Character.Energy.Value
                infinitestam()
            end
        end
    end)

    nododgecool = false
    function NoDodgeCool()
        if nododgecool then
            for i,v in next, getgc() do
                if game.Players.LocalPlayer.Character.Dodge then
                    if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Dodge then
                        for i2,v2 in next, getupvalues(v) do
                            if tostring(v2) == "0.4" then
                                repeat wait(.1)
                                    setupvalue(v,i2,0)
                                until not nododgecool
                            end
                        end
                    end
                end
            end
        end
    end

    msc:Toggle("Walk On Water", _G.WalkOnWater,function(vu)
        WalkOnWater = vu
    end)

    spawn(function()
        pcall(function()
            while game:GetService("RunService").Heartbeat:wait() do
                if WalkOnWater then
                    if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y <= 1 then
                        if not game:GetService("Workspace"):FindFirstChild("Water") then
                            local Water = Instance.new("Part", game.Workspace)
                            Water.Name = "Water"
                            Water.Size = Vector3.new(10,0.5,10)
                            Water.Transparency = 1
                            Water.Anchored = true
                            game:GetService("Workspace").Water.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,game:GetService("Workspace").Camera["Water;"].CFrame.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
                        else
                            game:GetService("Workspace").Water.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,game:GetService("Workspace").Camera["Water;"].CFrame.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
                        end
                    elseif game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y >= 1 and game:GetService("Workspace"):FindFirstChild("Water") then
                        game:GetService("Workspace"):FindFirstChild("Water"):Destroy()
                    end
                else
                    if game:GetService("Workspace"):FindFirstChild("Water") then
                        game:GetService("Workspace"):FindFirstChild("Water"):Destroy()
                    end
                end
            end
        end)
    end)

local Setting = serv:Channel("Setting","http://www.roblox.com/asset/?id=7040347038")

Setting:Button("Destroy Sound Fx ",function(vu)
    for i, v in pairs(game.Workspace["_WorldOrigin"]:GetChildren()) do
        if v.Name == "Sounds" then
            v:Destroy() 
        end
    end
end)

Setting:Toggle("Auto Set Spawn Point", true, function(vu)
    AutoSetSpawn = vu
end)

Setting:Toggle("BringMob", true, function(vu)
    Magnet = vu
end)

_G.FastAttk = true
Setting:Toggle("Fast Attack",_G.FastAttk,function(value)
    _G.FastAttk = value
end)

local CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework) 
local VirtualUser = game:GetService('VirtualUser')
local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)

function FastAttack()
    pcall(function()
        if _G.FastAttk then
                if Alive() then
                CombatFrameworkR.activeController.timeToNextAttack = 0
                CombatFrameworkR.activeController.active = false
                CombatFrameworkR.activeController.attacking = false
                CombatFrameworkR.activeController.increment = 3
            end
        end
    end)
end

getgenv().HitBox  = true
function HitBoxPlr()
pcall(function()
  if getgenv().HitBox then
     if CombatFrameworkR.activeController.hitboxMagnitude ~= 60 then
        CombatFrameworkR.activeController.hitboxMagnitude = 60 
     end
  end
end)
end

function CheckLevel()
    local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
    if Old_World then
        if Lv == 1 or Lv <= 9 or SelectMonster == "Bandit [Lv. 5]" then -- Bandit
            Ms = "Bandit [Lv. 5]"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameBring = CFrame.new(1065.5896, 16.2730846, 1457.4657, -0.440903872, 0, 0.897554338, 0, 1, -0, -0.897554338, 0, -0.440903872)
            CFrameMon = CFrame.new(929.836243, 56.0851936, 1357.19019, -0.720502079, -2.82129982e-08, -0.693452835, 2.70309872e-08, 1, -6.87701913e-08, 0.693452835, -6.82937724e-08, -0.720502079)
        elseif Lv == 10 or Lv <= 14 or SelectMonster == "Monkey [Lv. 14]" then -- Monkey
            Ms = "Monkey [Lv. 14]"
            NameQuest = "JungleQuest"
            QuestLv = 1
            NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1518.02893, 37.6250801, 31.6329021, 0.800100982, 0, -0.599865437, -0, 1.00000012, -0, 0.599865437, 0, 0.800100982)
        elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
            Ms = "Gorilla [Lv. 20]"
            NameQuest = "JungleQuest"
            QuestLv = 2
            NameMon = "Gorilla"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameBring = CFrame.new(-1243.20825, 6.27936316, -517.844788, 0.259484977, 0, -0.965747118, -0, 1, -0, 0.965747237, 0, 0.259484947)
            CFrameMon = CFrame.new(-1134.87366, 40.4632721, -523.996887, 0.379340768, 0, -0.925257027, -0, 1, -0, 0.925257027, 0, 0.379340768)
        elseif Lv == 30 or Lv <= 39 or SelectMonster == "Pirate [Lv. 35]" then -- Pirate
            Ms = "Pirate [Lv. 35]"
            NameQuest = "BuggyQuest1"
            QuestLv = 1
            NameMon = "Pirate"
            CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameBring = CFrame.new(-1189.01001, 4.7520504, 3884.68701, -0.180904552, 0, 0.983500719, 0, 1.00000012, -0, -0.983500719, 0, -0.180904552)
            CFrameMon = CFrame.new(-1101.80322, 13.7520409, 3896.87207, 0.905991018, -1.54125459e-08, -0.423296899, -1.10116698e-08, 1, -5.99792216e-08, 0.423296899, 5.90018452e-08, 0.905991018)
        elseif Lv == 40 or Lv <= 59 or SelectMonster == "Brute [Lv. 45]" then -- Brute
            Ms = "Brute [Lv. 45]"
            NameQuest = "BuggyQuest1"
            QuestLv = 2
            NameMon = "Brute"
            CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameBring = CFrame.new(-1145.11255, 14.8098736, 4351.24756, -0.936269045, -4.36891554e-08, 0.351283699, -1.39060763e-08, 1, 8.73064323e-08, -0.351283699, 7.68573329e-08, -0.936269045)
            CFrameMon = CFrame.new(-1150.81226, 65.2011261, 4169.78711, -0.96971643, 4.94380981e-10, 0.244233549, 3.45397844e-09, 1, 1.16896253e-08, -0.244233549, 1.2179199e-08, -0.96971643)
        elseif Lv == 60 or Lv <= 74 or SelectMonster == "Desert Bandit [Lv. 60]" then -- Desert Bandit
            Ms = "Desert Bandit [Lv. 60]"
            NameQuest = "DesertQuest"
            QuestLv = 1
            NameMon = "Desert Bandit"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameBring = CFrame.new(927.811584, 6.44851875, 4480.5249, 0.32891655, 0, 0.944358945, -0, 1, -0, -0.944359064, 0, 0.32891652)
            CFrameMon = CFrame.new(1054.34277, 52.4908333, 4489.46875, 0.976962686, 0, 0.213410228, -0, 1, -0, -0.213410228, 0, 0.976962686)
        elseif Lv == 75 or Lv <= 89 or SelectMonster == "Desert Officer [Lv. 70]" then -- Desert Officer
            Ms = "Desert Officer [Lv. 70]"
            NameQuest = "DesertQuest"
            QuestLv = 2
            NameMon = "Desert Officer"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameBring = CFrame.new(1614.53259, 1.61095512, 4370.40186, 0.0494608097, 0, -0.998776078, -0, 1, -0, 0.998776078, 0, 0.0494608097)
            CFrameMon = CFrame.new(1553.27356, 14.4520378, 4383.61621, 0.173646301, 0, -0.984808087, -0, 1, -0, 0.984808087, 0, 0.173646301)
        elseif Lv == 90 or Lv <= 99 or SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandit
            Ms = "Snow Bandit [Lv. 90]"
            NameQuest = "SnowQuest"
            QuestLv = 1
            NameMon = "Snow Bandit"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameBring = CFrame.new(1398.65515, 89.4550552, -1344.64954, 0.999816179, 0, -0.0191765595, -0, 1, -0, 0.0191765614, 0, 0.99981606)
            CFrameMon = CFrame.new(1402.33887, 105.903671, -1281.91724, -0.734338343, -0, -0.678783596, -0, 1, -0, 0.678783596, 0, -0.7343383)
        elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman [Lv. 100]" then -- Snowman
            Ms = "Snowman [Lv. 100]"
            NameQuest = "SnowQuest"
            QuestLv = 2
            NameMon = "Snowman"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameBring = CFrame.new(1140.1803, 105.771606, -1472.59778, 0.898745, 0, 0.438471735, -0, 1, -0, -0.438471735, 0, 0.898745)
            CFrameMon = CFrame.new(1221.05176, 138.011841, -1488.25061, 0.964992762, 0, -0.262276739, -0, 1, -0, 0.262276769, 0, 0.96499264)
        elseif Lv == 120 or Lv <= 149 or SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
            Ms = "Chief Petty Officer [Lv. 120]"
            NameQuest = "MarineQuest2"
            QuestLv = 1 
            NameMon = "Chief Petty Officer"
            CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
            CFrameMon = CFrame.new(-4931.76465, 40.6520576, 4166.97461, -0.58298254, -0, -0.812484741, -0, 1, -0, 0.812484622, 0, -0.582982)
        elseif Lv == 150 or Lv <= 174 or SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
            Ms = "Sky Bandit [Lv. 150]"
            NameQuest = "SkyQuest"
            QuestLv = 1
            NameMon = "Sky Bandit"
            CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
            CFrameBring = CFrame.new(-5017.79688, 278.066986, -2764.32104, -0.933124721, -0, -0.35955295, -0, 1.00000012, -0, 0.35955295, 0, -0)
            CFrameMon = CFrame.new(-4955.73828, 295.744202, -2897.10791, -0.860640109, 0, 0.509213746, 0, 1, -0, -0.509213746, 0, -0.860640109)
        elseif Lv == 175 or Lv <= 224 or SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
            Ms = "Dark Master [Lv. 175]"
            NameQuest = "SkyQuest"
            QuestLv = 2
            NameMon = "Dark Master"
            CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
            CFrameBring = CFrame.new(-5235.47949, 388.651947, -2305.61279, 0.179809004, 8.69885355e-08, 0.983701527, -2.7712014e-08, 1, -8.33643767e-08, -0.983701527, -1.22706849e-08, 0.179809004)
            CFrameMon = CFrame.new(-5147.29248, 438.8396, -2332.75806, -0.636438787, 2.58481787e-08, 0.771327198, 3.01999208e-08, 1, -8.59269189e-09, -0.771327198, 1.78252986e-08, -0.636438787)
        elseif Lv == 225 or Lv <= 274 or SelectMonster == "Toga Warrior [Lv. 225]" then -- Toga Warrior
            Ms = "Toga Warrior [Lv. 225]"
            NameQuest = "ColosseumQuest"
            QuestLv = 1
            NameMon = "Toga Warrior"
            CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
            CFrameBring = CFrame.new(-1930.65173, 7.28907347, -2774.61328, 0.999443352, 0, -0.0333619826, -0, 1, -0, 0.0333619826, 0, 0.99944)
            CFrameMon = CFrame.new(-1591.75989, 20.6318989, -2990.02246, -0.684307992, 0, 0.729193091, 0, 1, -0, -0.729193151, 0, -0.684307933)
        elseif Lv == 275 or Lv <= 299 or SelectMonster == "Gladiator [Lv. 275]" then -- Gladiator
            Ms = "Gladiator [Lv. 275]"
            NameQuest = "ColosseumQuest"
            QuestLv = 2
            NameMon = "Gladiator"
            CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
            CFrameBring = CFrame.new(-1273.14978, 7.44254541, -3259.02271, -0.511646688, -0, -0.859195948, -0, 1, -0, 0.859195948, 0, -0.511646688)
            CFrameMon = CFrame.new(-1493.18384, 49.0537682, -3320.56348, -0.376584917, -0, -0.926382065, -0, 1, -0, 0.926382184, 0, -0.376584858)
        elseif Lv == 300 or Lv <= 329 or SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
            Ms = "Military Soldier [Lv. 300]"
            NameQuest = "MagmaQuest"
            QuestLv = 1
            NameMon = "Military Soldier"
            CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameBring = CFrame.new(-5413.8501, 11.0290976, 8457.70898, 0.842087865, 0, -0.539340496, -0, 1, -0, 0.539340556, 0, 0.842087746)
            CFrameMon = CFrame.new(-5366.96387, 61.0786514, 8557.21191, 0.906642616, 0, 0.421899676, -0, 1.00000012, -0, -0.421899736, 0, 0.906642497)
        elseif Lv == 330 or Lv <= 374 or SelectMonster == "Military Spy [Lv. 330]" then -- Military Spy
            Ms = "Military Spy [Lv. 330]"
            NameQuest = "MagmaQuest"
            QuestLv = 2
            NameMon = "Military Spy"
            CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameBring = CFrame.new(-5937.25928, 77.2306366, 8831.54883, 0.088094227, 0, 0.996112168, -0, 1.00000012, -0, -0.996112168, 0, 0.088094227)
            CFrameMon = CFrame.new(-5788.3999, 120.90551, 8760.28711, -0.343051702, 0, 0.939316571, 0, 1.00000012, -0, -0.939316571, 0, -0.343051702)
        elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior 
            Ms = "Fishman Warrior [Lv. 375]"
            NameQuest = "FishmanQuest"
            QuestLv = 1
            NameMon = "Fishman Warrior"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameBring = CFrame.new(60918.5859, 18.4828167, 1606.18872, 0.911431909, 0, 0.411450982, -0, 0.99999994, -0, -0.411451042, 0, 0.911431789)
            CFrameMon = CFrame.new(60967.9062, 48.6735382, 1538.55066, -0.359812647, -0, -0.933024585, -0, 1, -0, 0.933024585, 0, -0.359812647)
            if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			end
        elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
            Ms = "Fishman Commando [Lv. 400]"
            NameQuest = "FishmanQuest"
            QuestLv = 2
            NameMon = "Fishman Commando"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameBring = CFrame.new(61918.6914, 18.4828186, 1477.48547, 0.67973125, 0, -0.733461261, -0, 1, -0, 0.73346132, 0, 0.67973119)
            CFrameMon = CFrame.new(61722.5977, 96.3471756, 1319.99939, 0.887332737, 0, -0.461129695, -0, 1, -0, 0.461129695, 0, 0.887332737)
            if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			end
        elseif Lv == 450 or Lv <= 474 or SelectMonster == "God's Guard [Lv. 450]" then -- God's Guard
            Ms = "God's Guard [Lv. 450]"
            NameQuest = "SkyExp1Quest"
            QuestLv = 1
            NameMon = "God's Guard"
            CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
            CFrameBring = CFrame.new(-4688.34619, 852.318359, -1851.68567, 0.960764825, 0, 0.277364373, -0, 1, -0, -0.277364373, 0, 0.960764825)
            CFrameMon = CFrame.new(-4656.6792, 872.54248, -1765.41138, 0.875914156, 0, 0.482467115, -0, 1, -0, -0.482467175, 0, 0.875914037)
            if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda [Lv. 475]" then -- Shanda
            Ms = "Shanda [Lv. 475]"
            NameQuest = "SkyExp1Quest"
            QuestLv = 2
            NameMon = "Shanda"
            CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
            CFrameBring = CFrame.new(-7643.59961, 5545.4917, -483.006561, -0.28183794, -0, -0.959461987, -0, 1, -0, 0.959462106, 0, -0.28183791)
            CFrameMon = CFrame.new(-7904.01367, 5617.08643, -459.359528, 0.124752805, 0, -0.992187858, -0, 1, -0, 0.992187858, 0, 0.124752805)
            if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
            Ms = "Royal Squad [Lv. 525]"
            NameQuest = "SkyExp2Quest"
            QuestLv = 1
            NameMon = "Royal Squad"
            CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameBring = CFrame.new(-7674.74512, 5606.87695, -1472.69641, -0.446627408, 0, 0.894720018, 0, 1, -0, -0.894720018, 0, -0.446627408)
            CFrameMon = CFrame.new(-7571.36719, 5628.5332, -1543.75781, -0.72812295, 0, 0.68544656, 0, 1, -0, -0.68544662, 0, -0.72812289)
        elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
            Ms = "Royal Soldier [Lv. 550]"
            NameQuest = "SkyExp2Quest"
            QuestLv = 2
            NameMon = "Royal Soldier"
            CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameBring = CFrame.new(-7830.89941, 5606.87695, -1844.01013, 0.274303228, 0, -0.961643279, -0, 1, -0, 0.961643279, 0, 0.274303228)
            CFrameMon = CFrame.new(-7760.37939, 5644.88037, -1882.74927, -0.0625580773, 0, 0.998041332, 0, 1, -0, -0.998041332, 0, -0.0625580773)
        elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
            Ms = "Galley Pirate [Lv. 625]"
            NameQuest = "FountainQuest"
            QuestLv = 1
            NameMon = "Galley Pirate"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameBring = CFrame.new(5579.22021, 38.5011292, 3926.58228, 0.95617938, 0, 0.29278174, -0, 1, -0, -0.29278177, 0, 0.956179261)
            CFrameMon = CFrame.new(5606.94141, 135.47876, 4118.03369, 0.999111295, 0, 0.0421501845, -0, 1, -0, -0.0421501845, 0, 0.999111295)
        elseif Lv >= 650 or SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
            Ms = "Galley Captain [Lv. 650]"
            NameQuest = "FountainQuest"
            QuestLv = 2
            NameMon = "Galley Captain"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameBring = CFrame.new(5685.43408, 38.5011292, 4933.46924, -0.999981344, 0, 0.00612471299, 0, 1.00000012, -0, -0.00612471392, 0, -0.999981225)
            CFrameMon = CFrame.new(5614.2915, 142.968033, 4736.87109, -0.938153625, 2.56792436e-08, -0.346219212, 7.91038168e-09, 1, 5.27356327e-08, 0.346219212, 4.67354013e-08, -0.938153625)
        end
    end
    if New_World then
        if Lv == 700 or Lv <= 724 or SelectMonster == "Raider [Lv. 700]" then -- Raider
            Ms = "Raider [Lv. 700]"
            NameQuest = "Area1Quest"
            QuestLv = 1
            NameMon = "Raider"
            CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameBring = CFrame.new(367.450226, 39.1399727, 2329.63721, -0.124496244, -0, -0.992220163, -0, 1.00000012, -0, 0.992220163, 0, -0.124496244)
            CFrameMon = CFrame.new(400.140747, 98.8657761, 2522.2666, 0.921809435, 0, 0.387643367, -0, 1, -0, -0.387643367, 0, 0.921809435)
        elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary
            Ms = "Mercenary [Lv. 725]"
            NameQuest = "Area1Quest"
            QuestLv = 2
            NameMon = "Mercenary"
            CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(-874.696228, 140.333313, 1255.41943, -0.534274042, 0, 0.845311344, 0, 1, -0, -0.845311344, 0, -0.534274042)
        elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate
            Ms = "Swan Pirate [Lv. 775]"
            NameQuest = "Area2Quest"
            QuestLv = 1
            NameMon = "Swan Pirate"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameBring = CFrame.new(998.523132, 73.030014, 1235.15601, 0.471589476, 0, 0.881818235, -0, 1, -0, -0.881818235, 0, 0.471589476)
            CFrameMon = CFrame.new(920.634216, 207.763077, 1307.43311, 0.694057703, 0, -0.719919384, -0, 1, -0, 0.719919384, 0, 0.694057703)
        elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff
            Ms = "Factory Staff [Lv. 800]"
            NameQuest = "Area2Quest"
            QuestLv = 2
            NameMon = "Factory Staff"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameBring = CFrame.new(265.490204, 72.9597473, 15.0153828, 0.903564334, 0, -0.428452611, -0, 1.00000012, -0, 0.428452671, 0, 0.903564215)
            CFrameMon = CFrame.new(-26.4848213, 158.520187, 117.739983, 0.686022878, 0, -0.727579951, -0, 1, -0, 0.727579951, 0, 0.686022878)
        elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant
            Ms = "Marine Lieutenant [Lv. 875]"
            NameQuest = "MarineQuest3"
            QuestLv = 1
            NameMon = "Marine Lieutenant"
            CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
        elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain
            Ms = "Marine Captain [Lv. 900]"
            NameQuest = "MarineQuest3"
            QuestLv = 2
            NameMon = "Marine Captain"
            CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
        elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie [Lv. 950]" then -- Zombie
            Ms = "Zombie [Lv. 950]"
            NameQuest = "ZombieQuest"
            QuestLv = 1
            NameMon = "Zombie"
            CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            CFrameBring = CFrame.new(-5604.0415, 48.4801941, -612.511536, 0.962905526, 0, 0.26983881, -0, 1, -0, -0.26983881, 0, 0.962905526)
            CFrameMon = CFrame.new(-5593.81885, 140.238708, -998.828918, -0.951807678, -0, -0.306695849, -0, 1.00000012, -0, 0.306695879, 0, -0.951807559)
        elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire [Lv. 975]" then -- Vampire
            Ms = "Vampire [Lv. 975]"
            NameQuest = "ZombieQuest"
            QuestLv = 2
            NameMon = "Vampire"
            CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            CFrameBring = CFrame.new(-6053.89209, 6.40269995, -1326.09631, -0.808772802, -0, -0.588121235, -0, 1, -0, 0.588121235, 0, -0.808772802)
            CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
        elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper
            Ms = "Snow Trooper [Lv. 1000]"
            NameQuest = "SnowMountainQuest"
            QuestLv = 1
            NameMon = "Snow Trooper"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            CFrameBring = CFrame.new(535.628662, 401.421936, -5356.33105, 0.476002663, 0, 0.879443824, -0, 1, -0, -0.879443944, 0, 0.476002604)
            CFrameMon = CFrame.new(354.023529, 477.068542, -5504.78857, -0.549386799, -0, -0.83556813, -0, 1, -0, 0.835568249, 0, -0.54938674)
        elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior
            Ms = "Winter Warrior [Lv. 1050]"
            NameQuest = "SnowMountainQuest"
            QuestLv = 2
            NameMon = "Winter Warrior"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            CFrameBring = CFrame.new(1320.88879, 429.421875, -5305.99268, 0.80007261, 0, 0.599903166, -0, 1, -0, -0.599903166, 0, 0.80007261)
            CFrameMon = CFrame.new(1189.8988, 461.069153, -5331.96094, -0.550770402, -0, -0.834656775, -0, 1, -0, 0.834656775, 0, -0.550770402)
        elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate
            Ms = "Lab Subordinate [Lv. 1100]"
            NameQuest = "IceSideQuest"
            QuestLv = 1
            NameMon = "Lab Subordinate"
            CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            CFrameBring = CFrame.new(-5701.17578, 15.9516964, -4501.94043, 0.29432866, 0, -0.955704331, -0, 1.00000012, -0, 0.955704331, 0, 0.29432866)
            CFrameMon = CFrame.new(-5630.27979, 50.4335632, -4284.50439, 0.942327559, 0, 0.33469221, -0, 1, -0, -0.33469224, 0, 0.94232744)
        elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior
            Ms = "Horned Warrior [Lv. 1125]"
            NameQuest = "IceSideQuest"
            QuestLv = 2
            NameMon = "Horned Warrior"
            CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            CFrameBring = CFrame.new(-6404.56641, 15.9517555, -5691.99902, -0.998442173, -0, -0.0557967685, -0, 1.00000012, -0, 0.0557967685, 0, -0.998442173)
            CFrameMon = CFrame.new(-6480.78711, 94.2911377, -5386.30518, 0.999555767, 0, 0.0298040863, -0, 1, -0, -0.0298040863, 0, 0.999555767)
        elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja
            Ms = "Magma Ninja [Lv. 1175]"
            NameQuest = "FireSideQuest"
            QuestLv = 1
            NameMon = "Magma Ninja"
            CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameMon = CFrame.new(-5372.38867, 79.5044861, -6045.22559, -0.865931928, -0, -0.500161946, -0, 1.00000012, -0, 0.500161946, 0, -0.865931928)
        elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate [Lv. 1200]" then -- Lava Pirate
            Ms = "Lava Pirate [Lv. 1200]"
            NameQuest = "FireSideQuest"
            QuestLv = 2
            NameMon = "Lava Pirate"
            CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameBring = CFrame.new(-5287.57715, 15.9517612, -4560.87256, -0.5507164, 0, 0.834692359, 0, 0.99999994, -0, -0.834692478, 0, -0.550716341)
            CFrameMon = CFrame.new(-5430.80225, 66.4411469, -4686.84961, 0.402207017, -4.40270709e-10, -0.915548742, -8.80097986e-08, 1, -3.91442043e-08, 0.915548742, 9.63213296e-08, 0.402207017)
        elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand [Lv. 1250]" then -- Ship Deckhand
            Ms = "Ship Deckhand [Lv. 1250]"
            NameQuest = "ShipQuest1"
            QuestLv = 1
            NameMon = "Ship Deckhand"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(913.148987, 125.95813, 33128.0859, -0.997828066, -0, -0.0658725128, -0, 1, -0, 0.0658725128, 0, -0.997828066)
            if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer [Lv. 1275]" then -- Ship Engineer
            Ms = "Ship Engineer [Lv. 1275]"
            NameQuest = "ShipQuest1"
            QuestLv = 2
            NameMon = "Ship Engineer"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
        elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward [Lv. 1300]" then -- Ship Steward
            Ms = "Ship Steward [Lv. 1300]"
            NameQuest = "ShipQuest2"
            QuestLv = 1
            NameMon = "Ship Steward"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
        elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer [Lv. 1325]" then -- Ship Officer
            Ms = "Ship Officer [Lv. 1325]"
            NameQuest = "ShipQuest2"
            QuestLv = 2
            NameMon = "Ship Officer"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
        elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior [Lv. 1350]" then -- Arctic Warrior
            Ms = "Arctic Warrior [Lv. 1350]"
            NameQuest = "FrostQuest"
            QuestLv = 1
            NameMon = "Arctic Warrior"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            CFrameBring = CFrame.new(5992.41748, 28.3670578, -6246.94385, -0.194580659, -0, -0.980886579, -0, 1.00000012, -0, 0.980886579, 0, -0.194580659)
            CFrameMon = CFrame.new(6114.22998, 176.700684, -6389.84766, -0.821000099, 0, 0.570928156, 0, 1.00000012, -0, -0.570928216, 0, -0.82099998)
            if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
            end
        elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker
            Ms = "Snow Lurker [Lv. 1375]"
            NameQuest = "FrostQuest"
            QuestLv = 2
            NameMon = "Snow Lurker"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            CFrameBring = CFrame.new(5493.14795, 28.8435192, -6772.85938, 0.328603983, 0, -0.944467843, -0, 1.00000012, -0, 0.944467843, 0, 0.328603983)
            CFrameMon = CFrame.new(5409.06787, 104.943184, -6834.59424, -0.182068795, -0, -0.983285785, -0, 1, -0, 0.983285785, 0, -0.182068795)
        elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier
            Ms = "Sea Soldier [Lv. 1425]"
            NameQuest = "ForgottenQuest"
            QuestLv = 1
            NameMon = "Sea Soldier"
            CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            CFrameBring = CFrame.new(-3400.05957, 25.784399, -9755.40527, 0.972765982, 0, 0.231789589, -0, 1.00000012, -0, -0.231789589, 0, 0.972765982)
            CFrameMon = CFrame.new(-3366.36011, 106.2882, -9966.90625, -0.999057889, -0, -0.043398492, -0, 1.00000012, -0, 0.043398492, 0, -0.999057889)
        elseif Lv >= 1450 or SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter
            Ms = "Water Fighter [Lv. 1450]"
            NameQuest = "ForgottenQuest"
            QuestLv = 2
            NameMon = "Water Fighter"
            CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            CFrameBring = CFrame.new(-3376.85376, 238.846115, -10550.4834, -0.0732588619, 0, 0.997313023, 0, 1.00000012, -0, -0.997313023, 0, -0.0732588619)
            CFrameMon = CFrame.new(-3622.32153, 322.27301, -10403.5352, 0.681025326, 0, -0.73225987, -0, 1, -0, 0.73225987, 0, 0.681025326)
        end
    end
    if Three_World then
        if Lv == 1500 or Lv <= 1524 or SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire
            Ms = "Pirate Millionaire [Lv. 1500]"
            NameQuest = "PiratePortQuest"
            QuestLv = 1
            NameMon = "Pirate Millionaire"
            CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            CFrameMon = CFrame.new(-217.9254, 258.943237, 5611.38477, -0.974738836, 0, 0.223347992, 0, 1, -0, -0.223348022, 0, -0.974738717)
        elseif Lv == 1525 or Lv <= 1574 or SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billoonaire
            Ms = "Pistol Billionaire [Lv. 1525]"
            NameQuest = "PiratePortQuest"
            QuestLv = 2
            NameMon = "Pistol Billionaire"
            CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            CFrameMon = CFrame.new(-302.9729, 288.176086, 5866.19482, -0.983760536, 0, 0.17948617, 0, 1, -0, -0.179486185, 0, -0.983760417)
        elseif Lv == 1575 or Lv <= 1599 or SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior
            Ms = "Dragon Crew Warrior [Lv. 1575]"
            NameQuest = "AmazonQuest"
            QuestLv = 1
            NameMon = "Dragon Crew Warrior"
            CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
            CFrameMon = CFrame.new(6139.22217, 209.490326, -869.75647, 0.751939297, 0, -0.659232438, -0, 1.00000012, -0, 0.659232438, 0, 0.751939297)
        elseif Lv == 1600 or Lv <= 1624 or SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer
            Ms = "Dragon Crew Archer [Lv. 1600]"
            NameQuest = "AmazonQuest"
            QuestLv = 2
            NameMon = "Dragon Crew Archer"
            CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
            CFrameBring = CFrame.new(6615.81494, 378.421722, 239.602921, -0.513386786, -0, -0.858157337, -0, 1, -0, 0.858157337, 0, -0.513386786)
            CFrameMon = CFrame.new(6776.30518, 462.367035, 180.665054, -0.251656473, 0, 0.967816651, 0, 1, -0, -0.967816651, 0, -0.251656473)
        elseif Lv == 1625 or Lv <= 1649 or SelectMonster == "Female Islander [Lv. 1625]" then -- Female Islander
            Ms = "Female Islander [Lv. 1625]"
            NameQuest = "AmazonQuest2"
            QuestLv = 1
            NameMon = "Female Islander"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameBring = CFrame.new(5680.14746, 781.817261, 832.552551, -0.20408608, -0, -0.978953004, -0, 1.00000012, -0, 0.978953004, 0, -0.20408608)
            CFrameMon = CFrame.new(6015.39795, 862.947815, 702.842285, -0.612255991, 0, 0.790659666, 0, 1.00000012, -0, -0.790659666, 0, -0.612255991)
        elseif Lv == 1650 or Lv <= 1699 or SelectMonster == "Giant Islander [Lv. 1650]" then -- Giant Islander
            Ms = "Giant Islander [Lv. 1650]"
            NameQuest = "AmazonQuest2"
            QuestLv = 2
            NameMon = "Giant Islander"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameBring = CFrame.new(4743.46826, 601.399414, -97.41819, -0.861297071, -0, -0.508101821, -0, 1, -0, 0.508101881, 0, -0.861296952)
            CFrameMon = CFrame.new(4843.11426, 676.0849, -275.986938, -0.955103278, -0, -0.296273082, -0, 1, -0, 0.296273082, 0, -0.955103278)
        elseif Lv == 1700 or Lv <= 1724 or SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore
            Ms = "Marine Commodore [Lv. 1700]"
            NameQuest = "MarineTreeIsland"
            QuestLv = 1
            NameMon = "Marine Commodore"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameBring = CFrame.new(2305.26636, 73.159996, -7158.61816, 0.751957655, 0, 0.659211397, -0, 1, -0, -0.659211397, 0, 0.751957655)
            CFrameMon = CFrame.new(2190.19897, 127.912979, -7105.55908, 0.0820464417, 0, -0.996628523, -0, 1, -0, 0.996628523, 0, 0.0820464417)
        elseif Lv == 1725 or Lv <= 1774 or SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral
            Ms = "Marine Rear Admiral [Lv. 1725]"
            NameQuest = "MarineTreeIsland"
            QuestLv = 2
            NameMon = "Marine Rear Admiral"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameBring = CFrame.new(3640.85229, 160.54985, -7039.15625, 0.419964492, 0, 0.9075405, -0, 1, -0, -0.907540619, 0, 0.419964433)
            CFrameMon = CFrame.new(3319.10645, 396.667938, -7209.05029, -0.384436369, -0, -0.923151493, -0, 1.00000012, -0, 0.923151612, 0, -0.384436309)
        elseif Lv == 1775 or Lv <= 1799 or SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raide
            Ms = "Fishman Raider [Lv. 1775]"
            NameQuest = "DeepForestIsland3"
            QuestLv = 1
            NameMon = "Fishman Raider"
            CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
            CFrameBring = CFrame.new(-10585.21, 331.788422, -8422.38086, 0.321178198, 0, 0.947018802, -0, 1, -0, -0.947018802, 0, 0.3211781)
            CFrameMon = CFrame.new(-10432.9141, 535.655151, -8621.10547, -0.735640585, 0, 0.677372038, 0, 1, -0, -0.677372038, 0, -0.735640585)
        elseif Lv == 1800 or Lv <= 1824 or SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain
            Ms = "Fishman Captain [Lv. 1800]"
            NameQuest = "DeepForestIsland3"
            QuestLv = 2
            NameMon = "Fishman Captain"
            CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
            CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
        elseif Lv == 1825 or Lv <= 1849 or SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate
            Ms = "Forest Pirate [Lv. 1825]"
            NameQuest = "DeepForestIsland"
            QuestLv = 1
            NameMon = "Forest Pirate"
            CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            CFrameBring = CFrame.new(-13377.8926, 332.403931, -7826.79297, 0.999956906, 0, -0.00929417554, -0, 1.00000012, -0, 0.00929417647, 0, 0.999956787)
            CFrameMon = CFrame.new(-13352.4473, 427.587158, -7932.17041, -0.819147706, 0, 0.57358259, 0, 1, -0, -0.57358259, 0, -0.819147706)
        elseif Lv == 1850 or Lv <= 1899 or SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate
            Ms = "Mythological Pirate [Lv. 1850]"
            NameQuest = "DeepForestIsland"
            QuestLv = 2
            NameMon = "Mythological Pirate"
            CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            CFrameMon = CFrame.new(-13511.0742, 583.562378, -6985.37207, -0.0595272593, 0, 0.998226762, 0, 1.00000012, -0, -0.998226762, 0, -0.0595272593)
        elseif Lv == 1900 or Lv <= 1924 or SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate
            Ms = "Jungle Pirate [Lv. 1900]"
            NameQuest = "DeepForestIsland2"
            QuestLv = 1
            NameMon = "Jungle Pirate"
            CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameMon = CFrame.new(-12392.5342, 533.244019, -10424.4775, 0.165899426, 0, -0.986142695, -0, 1, -0, 0.986142695, 0, 0.165899426)
        elseif Lv == 1925 or Lv <= 1974 or SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate
            Ms = "Musketeer Pirate [Lv. 1925]"
            NameQuest = "DeepForestIsland2"
            QuestLv = 2
            NameMon = "Musketeer Pirate"
            CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameMon = CFrame.new(-13437.6133, 512.128174, -9721.90918, 0.999243438, 0, 0.0388938971, -0, 1.00000012, -0, -0.0388939008, 0, 0.999243319)
        elseif Lv == 1975 or Lv <= 1999 or SelectMonster == "Reborn Skeleton [Lv. 1975]" then
            Ms = "Reborn Skeleton [Lv. 1975]"
            NameQuest = "HauntedQuest1"
            QuestLv = 1
            NameMon = "Reborn Skeleton"
            CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            CFrameBring = CFrame.new(-8764.99609, 142.130615, 5972.47461, -0.911345959, -0, -0.411641449, -0, 1, -0, 0.411641508, 0, -0.91134584)
            CFrameMon = CFrame.new(-8977.54102, 212.857315, 5889.69727, -0.427730143, -0, -0.903906465, -0, 1, -0, 0.903906584, 0, -0.427730083)
        elseif Lv == 2000 or Lv <= 2024 or SelectMonster == "Living Zombie [Lv. 2000]" then
            Ms = "Living Zombie [Lv. 2000]"
            NameQuest = "HauntedQuest1"
            QuestLv = 2
            NameMon = "Living Zombie"
            CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            CFrameBring = CFrame.new(-10145.1943, 139.652466, 5954.82422, -0.00934296194, -0, -0.99995631, -0, 1, -0, 0.999956429, 0, -0.00934296101)
            CFrameMon = CFrame.new(-10081.1709, 237.884369, 5913.56055, -0.0154833104, 0, 0.999880135, 0, 1, -0, -0.999880135, 0, -0.0154833104)
        elseif Lv == 2025 or Lv <= 2049 or SelectMonster == "Demonic Soul [Lv. 2025]" then
            Ms = "Demonic Soul [Lv. 2025]"
            NameQuest = "HauntedQuest2"
            QuestLv = 1
            NameMon = "Demonic Soul"
            CFrameQ = CFrame.new(-9515.39551, 172.266037, 6078.89746, 0.0121199936, -9.78649624e-08, 0.999926567, 2.30358754e-08, 1, 9.75929382e-08, -0.999926567, 2.18513581e-08, 0.0121199936)
            CFrameBring = CFrame.new(-9502.69531, 172.130615, 6167.67236, -0.0866914541, 0, 0.996235132, 0, 1, -0, -0.996235251, 0, -0.0866914466)
            CFrameMon = CFrame.new(-9660.02051, 233.705048, 6206.74512, 0.809343159, 0, -0.587336183, -0, 1.00000012, -0, 0.587336183, 0, 0.809343159)
        elseif Lv == 2050 or Lv <= 2074 or SelectMonster == "Posessed Mummy [Lv. 2050]" then
            Ms = "Posessed Mummy [Lv. 2050]"
            NameQuest = "HauntedQuest2"
            QuestLv = 2
            NameMon = "Posessed Mummy"
            CFrameQ = CFrame.new(-9515.39551, 172.266037, 6078.89746, 0.0121199936, -9.78649624e-08, 0.999926567, 2.30358754e-08, 1, 9.75929382e-08, -0.999926567, 2.18513581e-08, 0.0121199936)
            CFrameBring = CFrame.new(-9578.22363, 6.18552208, 6206.6875, -0.996815562, 0, 0.0797419846, 0, 1, -0, -0.0797419846, 0, -0.996815562)
            CFrameMon = CFrame.new(-9748.05078, 70.2316055, 6163.28516, 0.0499444269, 0, -0.998751998, -0, 1, -0, 0.998751998, 0, 0.0499444269)
        elseif Lv == 2075 or Lv <= 2099 or SelectMonster == "Peanut Scout [Lv. 2075]" then
            Ms = "Peanut Scout [Lv. 2075]"
            NameQuest = "NutsIslandQuest"
            QuestLv = 1
            NameMon = "Peanut Scout"
            CFrameQ = CFrame.new(-2104.35376, 38.1299706, -10194.1592, 0.763973236, -2.14605822e-09, 0.645247936, 6.53410703e-09, 1, -4.41043602e-09, -0.645247936, 7.58557395e-09, 0.763973236)
            CFrameMon = CFrame.new(-2191.29785, 94.3451614, -10098.5498, 0.961751878, 0, -0.273922443, -0, 1.00000012, -0, 0.273922473, 0, 0.961751759)
        elseif Lv == 2100 or Lv <= 2124 or SelectMonster == "Peanut President [Lv. 2100]" then
            Ms = "Peanut President [Lv. 2100]"
            NameQuest = "NutsIslandQuest"
            QuestLv = 2
            NameMon = "Peanut President"
            CFrameQ = CFrame.new(-2104.35376, 38.1299706, -10194.1592, 0.763973236, -2.14605822e-09, 0.645247936, 6.53410703e-09, 1, -4.41043602e-09, -0.645247936, 7.58557395e-09, 0.763973236)
            CFrameMon = CFrame.new(-2269.42749, 89.7764206, -10275.584, 0.98399049, 0, 0.178221226, -0, 1.00000012, -0, -0.178221226, 0, 0.98399049)
        elseif Lv == 2125 or Lv <= 2149 or SelectMonster == "Ice Cream Chef [Lv. 2125]" then
            Ms = "Ice Cream Chef [Lv. 2125]"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 1
            NameMon = "Ice Cream Chef"
            CFrameQ = CFrame.new(-820.504211, 65.8453293, -10965.8057, 0.794263303, 2.146305e-08, -0.607573688, -2.59415933e-09, 1, 3.19345688e-08, 0.607573688, -2.37883135e-08, 0.794263303)
            CFrameMon = CFrame.new(-825.416504, 208.185318, -10989.7725, -0.834866941, 0, 0.550451756, 0, 1, -0, -0.550451756, 0, -0.834866941)
        elseif Lv >= 2125 or SelectMonster == "Ice Cream Commander [Lv. 2150]" then
            Ms = "Ice Cream Commander [Lv. 2150]"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 2
            NameMon = "Ice Cream Commander"
            CFrameQ = CFrame.new(-820.504211, 65.8453293, -10965.8057, 0.794263303, 2.146305e-08, -0.607573688, -2.59415933e-09, 1, 3.19345688e-08, 0.607573688, -2.37883135e-08, 0.794263303)
            CFrameBring = CFrame.new(-747.419495, 65.8453217, -11285.8057, 0.999131382, -3.90661867e-08, 0.0416710898, 3.77847407e-08, 1, 3.15390736e-08, -0.0416710898, -2.99371479e-08, 0.999131382)
            CFrameMon = CFrame.new(-759.286621, 228.187546, -11287.8809, 0.370576233, 0, -0.928802133, -0, 1.00000012, -0, 0.928802133, 0, 0.370576233)
        end
    end
end

function EquipWeapon(ToolSe)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(.4)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

Type = 1
spawn(function()
    while wait(.1) do
        if Type == 1 then
            Farm_Mode = CFrame.new(0, Y, 15)
        elseif Type == 2 then
            Farm_Mode = CFrame.new(0, Y, 15)
        end
    end
end)

spawn(function()
    while wait(.1) do
        Type = 1
        wait(5)
        Type = 2
        wait(5)
    end
end)

spawn(function()
    while wait() do
        if Auto_Farm then
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                MagnetActive = false
				CheckLevel()
				TP(CFrameQ)
				if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
					wait(1.1)
					CheckLevel()
					if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
					else
						TP(CFrameQ)
					end
				end
            elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                pcall(function()
                    CheckLevel()
                    Simulation()
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == Ms and v:FindFirstChild("Humanoid") then
                                if v.Humanoid.Health > 0 then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                                            if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                                    EquipWeapon(SelectToolWeapon)
                                                    FastAttack()
                                                    Click()
                                                    Simulation()
                                                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                                    v.HumanoidRootPart.CanCollide = false
                                                    HitBoxPlr()
                                                    PosMon = v.HumanoidRootPart.CFrame
                                                    MagnetActive = true
                                                    WalkOnWater = false
                                            else
                                                MagnetActive = false
                                                WalkOnWater = true
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                            end
                                        else
                                            MagnetActive = false
                                            WalkOnWater = true
                                            Modstween = toTarget(CFrameMon.Position, CFrameMon)
                                            if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                                                if Modstween then
                                                    Modstween:Stop()
                                                end
                                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                                CheckLevel()
                                            end
                                        end
                                    until not v.Parent or v.Humanoid.Health <= 0 or Auto_Farm == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end
                    else
                        MagnetActive = false
                        WalkOnWater = true
						CheckLevel()
						TP(CFrameMon)
                    end
                end)
            end
    end
end
end)

function Click()
    if Alive() then
        if not getgenv().Clicked then
            getgenv().Clicked = true
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
            wait()
            getgenv().Clicked = false
        end
    end
end
    
    if SelectToolWeapon then
    else
        SelectToolWeapon = ""
    end

    spawn(function()
        while wait() do
            if _G.AutoSaber then
                if game.Players.localPlayer.Data.Level.Value < 200 then
                else
                    Auto_Farm = false
                    if game.Workspace.Map.Jungle.Final.Part.CanCollide == false then
                        if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    repeat wait()
                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                            EquipWeapon(SelectToolWeapon)
                                            FastAttack()
                                            Click()
                                            Simulation()
                                    until not AutoSaber or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            TP(CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912))
                        end
                    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") and game.Players.localPlayer.Data.Level.Value >= 200 then
                        EquipWeapon("Relic")
                        wait(0.5)
                        TP(CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912))
                    else
                        if Workspace.Map.Jungle.QuestPlates.Door.CanCollide == false then
                            if game.Workspace.Map.Desert.Burn.Part.CanCollide == false then
                                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") == 0 then
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                                        if game.Workspace.Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
                                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                                if AutoSaber and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
                                                    repeat
                                                        pcall(function() wait() 
                                                            TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                                                EquipWeapon(SelectToolWeapon)
                                                                FastAttack()
                                                                Click()
                                                                Simulation()
                                                        end)
                                                    until not AutoSaber or not v.Parent or v.Humanoid.Health <= 0
                                                end
                                            end
                                        else
                                            TP(CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.928248107))
                                        end
                                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
                                            EquipWeapon("Relic")
                                            wait(0.5)
                                            TP(CFrame.new(-1405.41956, 29.8519993, 5.62435055))
                                        else
                                            TP2(CFrame.new(-910.979736, 13.7520342, 4078.14624, 0.00685182028, -1.53155766e-09, -0.999976516, 9.15205245e-09, 1, -1.46888401e-09, 0.999976516, -9.14177267e-09, 0.00685182028))
                                            wait(.5)
                                            local args = {
                                                [1] = "ProQuestProgress",
                                                [2] = "RichSon"
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                    else
                                        TP2(CFrame.new(-910.979736, 13.7520342, 4078.14624))
                                        local args = {
                                            [1] = "ProQuestProgress",
                                            [2] = "RichSon"
                                        }
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    end
                                else
                                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
                                        EquipWeapon("Cup")
                                        if game.Players.LocalPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest") then
                                                TP(CFrame.new(1397.229, 37.3480148, -1320.85217, -0.11285457, 2.01368788e-08, 0.993611455, 1.91641178e-07, 1, 1.50028845e-09, -0.993611455, 1.90586206e-07, -0.11285457))
                                        else
                                            TP(CFrame.new(1458.54285, 88.2521744, -1390.34912, -0.00596274994, 1.13679788e-09, -0.999982238, 7.28181793e-10, 1, 1.132476e-09, 0.999982238, -7.21416205e-10, -0.00596274994))
                                            wait(0.5)
                                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                                                local args = {
                                                    [1] = "ProQuestProgress",
                                                    [2] = "SickMan"
                                                }
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                            end
                                        end
                                    else
                                        TP(game.Workspace.Map.Desert.Cup.CFrame)
                                        -- firetouchinterest(game.Workspace.Map.Desert.Cup.TouchInterest,game.Players.LocalPlayer.Character.Head, 1)
                                    end
                                end
                            else
                                if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                                    EquipWeapon("Torch")
                                    TP(CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915))
                                else
                                    TP(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))
                                end
                            end
                        else
                            for i,v in pairs(Workspace.Map.Jungle.QuestPlates:GetChildren()) do
                                if v:IsA("Model") then wait()
                                    if v.Button.BrickColor ~= BrickColor.new("Camo") then
                                        repeat wait()
                                            TP(v.Button.CFrame)
                                        until not AutoSaber or v.Button.BrickColor == BrickColor.new("Camo")
                                    end
                                end
                            end    
                        end
                    end
                    Auto_Farm = true
                end 
            end
        end
    end)

    local JancokRaimuNdasLah = Instance.new("Part")
    JancokRaimuNdasLah.Name = "JancokRaimuNdasLah"
    JancokRaimuNdasLah.Parent = game.Workspace
    JancokRaimuNdasLah.Anchored = true
    JancokRaimuNdasLah.Transparency = 0.950
    JancokRaimuNdasLah.Size = Vector3.new(20,0,20)
    JancokRaimuNdasLah.CFrame = CFrame.new(1000000000,100000000,1000000)

    spawn(function()
        game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
            if SafeMode or PlayerHunt or KillPlayer or AutoRainbow or AutoCitizen or AutoFarmBoss or FarmAllBoss or Elite or AutoThird or AutoBartilo or AutoRengoku or _G.Auto_Bone or AutoEcto or AutoFarmObservation or Auto_Farm or FarmMasteryGun or FarmMasteryFruit or EliteHunter or _G.Auto_indra_Hop or _G.Auto_Dark_Dagger_Hop or _G.AutoDonSwan_Hop or _G.Pole_Hop or Core or noclip or AutoEvoRace or TPChest or NextIsland or RaidSuperhuman or _G.AutoRaid or AutoFarmBoss or SelectFarm or Clip or HolyTorch or AutoFarmSelectMonster or AutoLowRaid or _G.Auto_Candy or _G.Buddy or _G.AutoSaber then
                if not game:GetService("Workspace"):FindFirstChild("JancokRaimuNdasLah") then
                    local JancokRaimuNdasLah = Instance.new("Part")
                    JancokRaimuNdasLah.Name = "JancokRaimuNdasLah"
                    JancokRaimuNdasLah.Parent = game.Workspace
                    JancokRaimuNdasLah.Anchored = true
                    JancokRaimuNdasLah.Transparency = 1
                    JancokRaimuNdasLah.Size = Vector3.new(20,0,20)
                elseif game:GetService("Workspace"):FindFirstChild("JancokRaimuNdasLah") then
                    game.Workspace["JancokRaimuNdasLah"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.6, 0)
                end
              else
                if game:GetService("Workspace"):FindFirstChild("JancokRaimuNdasLah") then
                    game.Workspace["JancokRaimuNdasLah"].Anchored = false
                    game.Workspace["JancokRaimuNdasLah"].Transparency = 1
                end
            end
         end)
        end)
    end)

    spawn(function()
        game:GetService("RunService").Stepped:Connect(function()
            if SafeMode or PlayerHunt or KillPlayer or AutoRainbow or AutoCitizen or AutoFarmBoss or FarmAllBoss or Elite or AutoThird or AutoBartilo or AutoRengoku or _G.Auto_Bone or AutoEcto or AutoFarmObservation or Auto_Farm or FarmMasteryGun or FarmMasteryFruit or EliteHunter or _G.Auto_indra_Hop or _G.Auto_Dark_Dagger_Hop or _G.AutoDonSwan_Hop or _G.Pole_Hop or Core or noclip or AutoEvoRace or TPChest or NextIsland or RaidSuperhuman or _G.AutoRaid or AutoFarmBoss or SelectFarm or Clip or HolyTorch or AutoFarmSelectMonster or AutoLowRaid or _G.Auto_Candy or _G.Buddy or _G.AutoSaber then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)

    spawn(function()
        pcall(function()
            while wait(.1) do
                if AutoSetSpawn and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                end
            end
        end)
    end)

    spawn(function()
        while wait() do
            pcall(function()
                CheckLevel()
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if Auto_Farm and MagnetActive and Magnet then
                        if v.Name == Ms and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if v.Name == "Factory Staff [Lv. 800]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Monkey [Lv. 14]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Chief Petty Officer [Lv. 120]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Raider [Lv. 700]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Mercenary [Lv. 725]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Marine Lieutenant [Lv. 875]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation()  
                                end
                            elseif v.Name == "Marine Captain [Lv. 900]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Magma Ninja [Lv. 1175]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Ship Deckhand [Lv. 1250]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Ship Engineer [Lv. 1275]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Ship Steward [Lv. 1300]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Ship Officer [Lv. 1325]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Pirate Millionaire [Lv. 1500]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                    Simulation() 
                                end
                            elseif v.Name == "Pistol Billionaire [Lv. 1525]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == "Dragon Crew Warrior [Lv. 1575]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == "Fishman Captain [Lv. 1800]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == "Mythological Pirate [Lv. 1850]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation()  
                                end
                            elseif v.Name == "Jungle Pirate [Lv. 1900]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == "Musketeer Pirate [Lv. 1925]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation()  
                                end
                            elseif v.Name == "Peanut Scout [Lv. 2075]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == "Peanut President [Lv. 2100]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == "Ice Cream Chef [Lv. 2125]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == "Ice Cream Commander [Lv. 2150]" then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = PosMon
                                     Simulation() 
                                end
                            elseif v.Name == Ms then
                                if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 300 then
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.Transparency = 1
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.CFrame = CFrameBring
                                     Simulation() 
                                end
                            end
                        end
                    elseif FarmMasteryFruit and MasteryBFMagnetActive and MasteryMagnet then
                        if v.Name == "Monkey [Lv. 14]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Factory Staff [Lv. 800]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Chief Petty Officer [Lv. 120]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Raider [Lv. 700]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Mercenary [Lv. 725]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Marine Lieutenant [Lv. 875]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Marine Captain [Lv. 900]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Magma Ninja [Lv. 1175]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Deckhand [Lv. 1250]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Engineer [Lv. 1275]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Steward [Lv. 1300]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Officer [Lv. 1325]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Pirate Millionaire [Lv. 1500]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Pistol Billionaire [Lv. 1525]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Dragon Crew Warrior [Lv. 1575]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Fishman Captain [Lv. 1800]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Mythological Pirate [Lv. 1850]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation()  
                            end
                        elseif v.Name == "Jungle Pirate [Lv. 1900]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Musketeer Pirate [Lv. 1925]" then
                            if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation()  
                            end
                        elseif v.Name == "Peanut Scout [Lv. 2075]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Peanut President [Lv. 2100]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation() 
                            end
                        elseif v.Name == "Ice Cream Chef [Lv. 2125]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation()  
                            end
                        elseif v.Name == "Ice Cream Commander [Lv. 2150]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                 Simulation()  
                            end
                        elseif v.Name == Ms then
                            if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = CFrameBring
                                 Simulation() 
                            end
                        end
                    elseif FarmMasteryGun and MasteryGunMagnetActive and MasteryMagnet then
                        if v.Name == "Monkey [Lv. 14]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                 Simulation() 
                            end
                        elseif v.Name == "Factory Staff [Lv. 800]" then
                            if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 300 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                 Simulation() 
                            end
                        elseif v.Name == Ms then
                            if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                 Simulation() 
                            end
                        end
                    elseif AutoBartilo and MagnetBatilo and Magnet then
                        if v.Name == "Swan Pirate [Lv. 775]" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonBartilo
                             Simulation() 
                        end
                    elseif AutoRengoku and RengokuMagnet and Magnet then
                        if (v.Name == "Snow Lurker [Lv. 1375]" or v.Name == "Arctic Warrior [Lv. 1350]") and (v.HumanoidRootPart.Position - PosMonRengoku.Position).Magnitude <= 350 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonRengoku
                             Simulation() 
                        end
                    elseif _G.Auto_Bone and BoneMagnet and Magnet then
                        if (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and (v.HumanoidRootPart.Position - MainMonBone.Position).Magnitude <= 300 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = MainMonBone
                             Simulation() 
                        end
                    elseif _G.Auto_Candy and CandyMagnet and Magnet then
                        if (v.Name == "Peanut Scout [Lv. 2075]" or v.Name == "Peanut President [Lv. 2100]" or v.Name == "Ice Cream Chef [Lv. 2125]" or v.Name == "Ice Cream Commander [Lv. 2150]") and (v.HumanoidRootPart.Position - MainMonCandy.Position).Magnitude <= 300 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = MainMonCandy
                             Simulation() 
                        end
                    elseif AutoEcto and EctoplasMagnet and Magnet then
                        if string.find(v.Name, "Ship") and (v.HumanoidRootPart.Position - PosMonEctoplas.Position).Magnitude <= 350 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonEctoplas
                             Simulation() 
                        end
                    elseif AutoEvoRace and EvoMagnet and Magnet then
                        if v.Name == "Zombie [Lv. 950]" and (v.HumanoidRootPart.Position - PosMonZombie.Position).Magnitude <= 350 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonZombie
                             Simulation() 
                        end
                    elseif AutoCitizen and CitizenMagnet and Magnet then
                        if v.Name == "Forest Pirate [Lv. 1825]" and (v.HumanoidRootPart.Position - PosMonCitizen.Position).Magnitude <= 350 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = PosMonZombie
                             Simulation() 
                        end
                    elseif AutoFarmSelectMonster and AutoFarmSelectMonsterMagnet and Magnet then
                        if v.Name == "Factory Staff [Lv. 800]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Monkey [Lv. 14]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Chief Petty Officer [Lv. 120]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Raider [Lv. 700]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Mercenary [Lv. 725]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Marine Lieutenant [Lv. 875]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Marine Captain [Lv. 900]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Magma Ninja [Lv. 1175]" then
                            if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Deckhand [Lv. 1250]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Engineer [Lv. 1275]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Steward [Lv. 1300]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Ship Officer [Lv. 1325]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Pirate Millionaire [Lv. 1500]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Pistol Billionaire [Lv. 1525]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Dragon Crew Warrior [Lv. 1575]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Fishman Captain [Lv. 1800]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Mythological Pirate [Lv. 1850]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation()  
                            end
                        elseif v.Name == "Jungle Pirate [Lv. 1900]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Musketeer Pirate [Lv. 1925]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation()  
                            end
                        elseif v.Name == "Peanut Scout [Lv. 2075]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Peanut President [Lv. 2100]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Ice Cream Chef [Lv. 2125]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation() 
                            end
                        elseif v.Name == "Ice Cream Commander [Lv. 2150]" then
                            if (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 350 then
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Transparency = 1
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v.HumanoidRootPart.CFrame = PosMonSelectMonster
                                 Simulation()  
                            end
                        elseif v.Name == Ms and (v.HumanoidRootPart.Position - PosMonSelectMonster.Position).Magnitude <= 300 then
                            v.Head.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.Transparency = 1
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.CFrame = CFrameBring
                             Simulation() 
                        end
                    end
               end
          end)
        end
    end)
