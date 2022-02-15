

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
    

	function DiscordLib:Notification(titletext, desctext, btntext)
		local NotificationHolderMain = Instance.new("Frame")
		local NotificationHolderMainCorner = Instance.new("UICorner")
		local Notification = Instance.new("Frame")
		local NotificationCorner = Instance.new("UICorner")
		local UnderBar = Instance.new("Frame")
		local UnderBarCorner = Instance.new("UICorner")
		local UnderBarFrame = Instance.new("Frame")
		local Text1 = Instance.new("TextLabel")
		local Text2 = Instance.new("TextLabel")
		local AlrightBtn = Instance.new("TextButton")
		local AlrightCorner = Instance.new("UICorner")

		NotificationHolderMain.Name = "NotificationHolderMain"
		NotificationHolderMain.Parent = MainFrame
		NotificationHolderMain.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		NotificationHolderMain.BackgroundTransparency = 1
		NotificationHolderMain.BorderSizePixel = 0
		NotificationHolderMain.Position = UDim2.new(0, -1, 0.0460000017, 0)
		NotificationHolderMain.Size = UDim2.new(0, 676, 0, 374)
		TweenService:Create(
			NotificationHolderMain,
			TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0.1}
		):Play()

		NotificationHolderMainCorner.CornerRadius = UDim.new(0, 7)
		NotificationHolderMainCorner.Name = "NotificationHolderMainCorner"
		NotificationHolderMainCorner.Parent = NotificationHolderMain

		Notification.Name = "Notification"
		Notification.Parent = NotificationHolderMain
		Notification.AnchorPoint = Vector2.new(0.5, 0.5)
		Notification.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
		Notification.ClipsDescendants = true
		Notification.Position = UDim2.new(0.524819076, 0, 0.469270051, 0)
		Notification.Size = UDim2.new(0, -43, 0, 0)
		Notification.BackgroundTransparency = 1

		Notification:TweenSize(UDim2.new(0, 346, 0, 176), Enum.EasingDirection.Out, Enum.EasingStyle.Back, .2, true)

		TweenService:Create(
			Notification,
			TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundTransparency = 0}
		):Play()

		NotificationCorner.CornerRadius = UDim.new(0, 5)
		NotificationCorner.Name = "NotificationCorner"
		NotificationCorner.Parent = Notification

		UnderBar.Name = "UnderBar"
		UnderBar.Parent = Notification
		UnderBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		UnderBar.Position = UDim2.new(-0.000297061284, 0, 0.945048928, 0)
		UnderBar.Size = UDim2.new(0, 346, 0, 10)

		UnderBarCorner.CornerRadius = UDim.new(0, 5)
		UnderBarCorner.Name = "UnderBarCorner"
		UnderBarCorner.Parent = UnderBar

		UnderBarFrame.Name = "UnderBarFrame"
		UnderBarFrame.Parent = UnderBar
		UnderBarFrame.BackgroundColor3 = Color3.fromRGB(14,14,14)
		UnderBarFrame.BorderSizePixel = 0
		UnderBarFrame.Position = UDim2.new(-0.000297061284, 0, -3.76068449, 0)
		UnderBarFrame.Size = UDim2.new(0, 346, 0, 40)

		Text1.Name = "Text1"
		Text1.Parent = Notification
		Text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text1.BackgroundTransparency = 1.000
		Text1.Position = UDim2.new(-0.000594122568, 0, 0.0202020202, 0)
		Text1.Size = UDim2.new(0, 346, 0, 68)
		Text1.Font = Enum.Font.GothamSemibold
		Text1.Text = titletext
		Text1.TextColor3 = Color3.fromRGB(255,255,255)
		Text1.TextSize = 20.000

		Text2.Name = "Text2"
		Text2.Parent = Notification
		Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text2.BackgroundTransparency = 1.000
		Text2.Position = UDim2.new(0.106342293, 0, 0.317724228, 0)
		Text2.Size = UDim2.new(0, 272, 0, 63)
		Text2.Font = Enum.Font.Gotham
		Text2.Text = desctext
		Text2.TextColor3 = Color3.fromRGB(255,255,255)
		Text2.TextSize = 14.000
		Text2.TextWrapped = true

		AlrightBtn.Name = "AlrightBtn"
		AlrightBtn.Parent = Notification
		AlrightBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		AlrightBtn.Position = UDim2.new(0.0332369953, 0, 0.789141417, 0)
		AlrightBtn.Size = UDim2.new(0, 322, 0, 27)
		AlrightBtn.Font = Enum.Font.Gotham
		AlrightBtn.Text = btntext
		AlrightBtn.TextColor3 = Color3.fromRGB(23, 23, 23)
		AlrightBtn.TextSize = 13.000
		AlrightBtn.AutoButtonColor = false

		AlrightCorner.CornerRadius = UDim.new(0, 4)
		AlrightCorner.Name = "AlrightCorner"
		AlrightCorner.Parent = AlrightBtn

		AlrightBtn.MouseButton1Click:Connect(function()
			TweenService:Create(
				NotificationHolderMain,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			Notification:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
			TweenService:Create(
				Notification,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}
			):Play()
			wait()
			NotificationHolderMain:Destroy()
		end)

		AlrightBtn.MouseEnter:Connect(function()
			TweenService:Create(
				AlrightBtn,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(23, 23, 23), TextColor3 = Color3.fromRGB(255,255,255)}
			):Play()
		end)

		AlrightBtn.MouseLeave:Connect(function()
			TweenService:Create(
				AlrightBtn,
				TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundColor3 = Color3.fromRGB(255,255,255), TextColor3 = Color3.fromRGB(23, 23, 23)}
			):Play()
		end)
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


local AllArea = {
   --Misc
   ['VIP'] = {'VIP'};
   --Spawn
   ['Town'] = {'Town', 'Town FRONT'}; ['Forest'] = {'Forest', 'Forest FRONT'}; ['Beach'] = {'Beach', 'Beach FRONT'}; ['Mine'] = {'Mine', 'Mine FRONT'}; ['Winter'] = {'Winter', 'Winter FRONT'}; ['Glacier'] = {'Glacier', 'Glacier Lake'}; ['Desert'] = {'Desert', 'Desert FRONT'}; ['Volcano'] = {'Volcano', 'Volcano FRONT'};
   -- Fantasy init
   ['Enchanted Forest'] = {'Enchanted Forest', 'Enchanted Forest FRONT'}; ['Ancient'] = {'Ancient'}; ['Samurai'] = {'Samurai', 'Samurai FRONT'}; ['Candy'] = {'Candy'}; ['Haunted'] = {'Haunted', 'Haunted FRONT'}; ['Hell'] = {'Hell'}; ['Heaven'] = {'Heaven'};
   -- Tech
   ['Ice Tech'] = {'Ice Tech'}; ['Tech City'] = {'Tech City'; 'Tech City FRONT'}; ['Dark Tech'] = {'Dark Tech'; 'Dark Tech FRONT'}; ['Steampunk'] = {'Steampunk'; 'Steampunk FRONT'}, ['Alien Forest'] = {"Alien Forest"; "Alien Forest FRONT"}, ['Alien Lab'] = {"Alien Forest"; "Alien Lab FRONT"}, ['Glitch'] = {"Glitch"; "Glitch FRONT"};
}

local Chests = {
    -- Spawn
    "Magma Chest",
    -- Fantasy
    "Enchanted Chest", "Hell Chest", "Haunted Chest", "Angel Chest", "Grand Heaven Chest",
    -- Tech
    "Giant Tech Chest"; "Giant Steampunk Chest"; "Giant Alien Chest"; "Giant Hacker Chest",
    -- Axolotl
    "Giant Ocean Chest";
    }   

    local GameLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("Library"))
    local Network = GameLibrary.Network
    local Run_Service = game:GetService("RunService")
    local rs = Run_Service.RenderStepped
    local CurrencyOrder = {"Rainbow Coins", "Tech Coins", "Fantasy Coins", "Coins", "Diamonds"}

    local Library = require(game:GetService("ReplicatedStorage").Framework.Library)
    local IDToName = {}
    local NameToID = {}
    for i,v in pairs(Library.Directory.Pets ) do
     IDToName[i] = v.name
     NameToID[v.name] = i
    end       


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

  function GetPets() 
    local MyPets = {}
    for i,v in pairs(Library.Save.Get().Pets) do
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

function GetMyPets()
local returntable = {}
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets:GetChildren()) do
if v.ClassName == 'TextButton' and v.Equipped.Visible then
   table.insert(returntable, v.Name)
end
end
return returntable
end

function GetCoins(area)
    local returntable = {}
    local ListCoins = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
    for i,v in pairs(ListCoins) do
        if string.lower(v.a) == string.lower(area) then
            table.insert(returntable, i)
        end
    end
    return returntable
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

local window = DiscordLib:Window("Pet Simulator X")
local serv = window:Server("SAZA HUB", "")
local AF2 = serv:Channel("Main", "http://www.roblox.com/asset/?id=173616340")
local AF = serv:Channel("AutoFarm", "http://www.roblox.com/asset/?id=6022668945")
local AF3 = serv:Channel("Misc", "http://www.roblox.com/asset/?id=4814044817")
local AF4 = serv:Channel("Egg", "http://www.roblox.com/asset/?id=6396462860")
local AF5 = serv:Channel("Pets")
local AF6 = serv:Channel("GUi", "http://www.roblox.com/asset/?id=3805250049")

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
        DiscordLib:Notification("SazaSystem:","Link Discord Has Coppied", "Alright")
          setclipboard("https://discord.gg/jhnvcjge2h")
     end)

     function destroyguis()
        game:GetService("CoreGui")["SazaUi"]:Destroy()
        game:GetService("CoreGui")["SAZAHUB"]:Destroy()
        game:GetService("CoreGui")["Discord"]:Destroy()
       end

     AF2:Button("Delete Gui", function()
        destroyguis()
     end)

	 AF2:Label("Anti AFK Always On")
	
	 AF2:Seperator()
	 AF2:Label(" Owner: Zaaa 愛#1688, Saskai#2799")

     Time = AF:Label2("")

     function UpdateTime()
         local GameTime = math.floor(workspace.DistributedGameTime+0.5)
         local Hour = math.floor(GameTime/(60^2))%24
         local Minute = math.floor(GameTime/(60^1))%60
         local Second = math.floor(GameTime/(60^0))%60
         Time:Refresh("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
     end
     
     spawn(function()
         while true do
             UpdateTime()
             wait()
         end
     end)
     
     Client = AF:Label2("")
     
     function UpdateClient()
         local RunService = game:GetService("RunService")
         RunService.RenderStepped:Connect(function(step)
         local Fps = workspace:GetRealPhysicsFPS()
         Client:Refresh(math.floor(1/step).." fps")
         end)
     end
     
     spawn(function()
         while true do
             UpdateClient()
             wait()
         end
     end)
    AF:Seperator()

    AF:Label("Collect")
    if _G.MyConnection then _G.MyConnection:Disconnect() end
    _G.MyConnection = game.Workspace.__THINGS.Orbs.ChildAdded:Connect(function(Orb)
       game.Workspace.__THINGS.__REMOTES["claim orbs"]:FireServer({{Orb.Name}})
    end)
      
      getgenv().CollectLOttbag = false
      
      AF:Toggle("Collect Lootbags", false, function(CollectLB)
          CollectLOttbag = CollectLB
          
          while task.wait(.5) do
              if CollectLOttbag then
                  for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
                      if v:IsA('MeshPart') then
                      v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                      end
                      end
              end
              end
          end)

   AF:Seperator()
    AF:Label("ChestFarm")
    getgenv().selectchest=""
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
        
        if getgenv().autoChests and getgenv().selectchest == "" then
            DiscordLib:Notification("SazaSystem:", "Select Chest First", "Alright")
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

AF:Toggle("Prioritize Gem", false ,function(vu)
    _G.farmgem = vu
    while wait() do
        if _G.farmgem then
            for i,v in next, GetMyPets() do
            pcall(function() FarmCoin(getGemid(), v) end)
       end
    end
end
end)
AF:Seperator()
AF:Label("Axolotl Ocean")

AF:Toggle("Axolotl Ocean", false, function(t)
    getgenv().Start = t
    getgenv().Area = 'Axolotl Ocean'

    while getgenv().Start do
        local cointhiny = GetCoins(getgenv().Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do        
           pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
    end
end)

AF:Toggle("Axolotl Deep Ocean", false, function(t)
getgenv().Start = t
getgenv().Area = 'Axolotl Deep Ocean'

while getgenv().Start do
    local cointhiny = GetCoins(getgenv().Area)
    local pethingy = GetMyPets()
    for i = 1, #cointhiny do        
       pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
    end
end
end)

AF:Label("Tech")

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
    getgenv().Area = "Glitch"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF:Toggle("Alien Forest", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Alien Forest"

        while getgenv().Start do
                local cointhiny = GetCoins(getgenv().Area)
                local pethingy = GetMyPets()
                for i = 1, #cointhiny do        
                   pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
      end
end)

AF:Toggle("Alien Lab", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Alien Lab"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)


AF:Toggle("Steampunk", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Steampunk"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)


AF:Toggle("Dark Tech", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Dark Tech"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF:Toggle("Tech City", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Tech City"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)


AF:Label("Fantasy")

AF:Toggle("Enchanted Forest", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Enchanted Forest"

    while getgenv().Start do
        local cointhiny = GetCoins(getgenv().Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
     end
end)

AF:Toggle("Ancient Island", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Ancient Island"

    while getgenv().Start do
        local cointhiny = GetCoins(getgenv().Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
     end
end)

AF:Toggle("Samurai Island", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Samurai Island"

    while getgenv().Start do
        local cointhiny = GetCoins(getgenv().Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
     end
end)


AF:Toggle("Candy Island", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Candy Island"

    while getgenv().Start do
        local cointhiny = GetCoins(Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
    end
end)


AF:Toggle("Haunted Island", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Haunted Island"

    while getgenv().Start do
        local cointhiny = GetCoins(getgenv().Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
    end
end)

AF:Toggle("Hell Island", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Hell Island"

    while getgenv().Start do
        local cointhiny = GetCoins(getgenv().Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
    end
end)

AF:Toggle("Heaven Island", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Heaven Island"

    while getgenv().Start do
        local cointhiny = GetCoins(getgenv().Area)
        local pethingy = GetMyPets()
        for i = 1, #cointhiny do
            pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
        end
     end
end)



AF:Label("Spawn")

AF:Toggle("Town", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Town"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF:Toggle("Forest", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Forest"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)


AF:Toggle("Beach", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Beach"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF:Toggle("Mine", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Mine"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF:Toggle("Glacier", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Glacier"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF:Toggle("Desert", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Desert"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF:Toggle("Volcano", false, function(t)
    getgenv().Start = t
    getgenv().Area = "Volcano"

    while getgenv().Start do
            local cointhiny = GetCoins(getgenv().Area)
            local pethingy = GetMyPets()
            for i = 1, #cointhiny do        
               pcall(function() FarmCoin(cointhiny[i], pethingy[i%#pethingy+1]) end)
            end
        end
end)

AF3:Button("Unlock Gamepasses",function()
   local player = game:GetService("Players").LocalPlayer;
   local dick = player.PlayerScripts.Scripts.GUIs.Inventory
   for i,v in pairs(getreg()) do
   if typeof(v)=="table" then
     if v.Owns and typeof(v.Owns)=="function" then
        v.Owns = function()
           return true
        end
     end
   end
   end   
end)
AF3:Seperator()

AF3:Label("AutoRewards")
	
AF3:Toggle("Auto Rewards RANK", false, function(autorewards)

 if autorewards == true then
    _G.AutoRewards1 = true
 elseif autorewards == false then
    _G.AutoRewards1 = false
 end
 
 while task.wait() and _G.AutoRewards1 do
    workspace.__THINGS.__REMOTES["redeem rank rewards"]:InvokeServer({})			
 end
end)

AF3:Toggle("Auto Rewards VIP", false, function(autorewards3)

 if autorewards3 == true then
    _G.AutoRewards2 = true
 elseif autorewards3 == false then
    _G.AutoRewards2 = false
 end
 
 while task.wait() and _G.AutoRewards2 do
    workspace.__THINGS.__REMOTES["redeem vip rewards"]:InvokeServer({})		
 end
end)
AF3:Seperator()
AF3:Label("Boost")

AF3:Toggle("Boost 3X Damage", false, function(autotripledamage)
   if autotripledamage == true then
      _G.TripleDamage1 = true
   elseif autotripledamage == false  then
      _G.TripleDamage1 = false
      end
   
   
   while wait(5) do
     if _G.TripleDamage1 then 
      if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Triple Damage") then
         workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Triple Damage"})
      end
     end
   end
   end)
   
   AF3:Toggle("Boost 3X Coins", false, function(autotriplecoins)
   
   if autotriplecoins == true then
      _G.TripleCoins1 = true
   elseif autotriplecoins == false then
      _G.TripleCoins1 = false
      end
   
   while wait(5) do
      if _G.TripleCoins1 then
         if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Triple Coins") then
            workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Triple Coins"})
      end
     end
   end
   end)

   AF3:Toggle("Boost Super Lucky", false, function(autotripledamage)
      if autotripledamage == true then
         _G.SuperLucky = true
      elseif autotripledamage == false  then
         _G.SuperLucky = false
         end
      
      
      while wait(5) do
        if _G.SuperLucky then 
         if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Super Lucky") then
            workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Super Lucky"})
         end
        end
      end
      end)
      
      AF3:Toggle("Boost Ultra Lucky", false, function(autotriplecoins)
      
      if autotriplecoins == true then
         _G.UltraLucky = true
      elseif autotriplecoins == false then
         _G.UltraLucky = false
         end
      
      while wait(5) do
         if _G.UltraLucky then
            if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Ultra Lucky") then
               workspace.__THINGS.__REMOTES["activate boost"]:FireServer({[1] = "Ultra Lucky"})
         end
        end
      end
      end)

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

AF3:Seperator()

    AF3:Label("Hoverboard")
    AF3:Label("[G] To use Hoverboard")
    getgenv().Enabledboard = nil
    AF3:Dropdown("Hoverboard Skin", {"Original", "VIP", "Sleigh", "Flame", "Bling", "Blue Flying Carpet", "Red Flying Carpet", "Rainbow", "Cat"}, function(vu)
        getgenv().Hoverboard = vu
        end)
        AF3:Toggle("Enable Hoverboard", false ,function(bool)
        getgenv().Enabledboard = bool
        if bool then
            Toggle()
        elseif not bool then
            Remove(v1.LocalPlayer);
        end
       end)

      AF3:Seperator()
      AF3:Label("Merchant")

      local Lib = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
      while not Lib.Loaded do
          game:GetService("RunService").Heartbeat:Wait()
      end

      MerchantCheck = AF3:Label2("Merchant:")
      function CheckMerchant()
      if (Lib.Network.Invoke("get merchant items")["Level 3"]) then
          MerchantCheck:Refresh("Has Spawn")
      else
          MerchantCheck:Refresh("Not Spawn")
      end
  end

  spawn(function()
      while true do
          CheckMerchant()
          wait()
      end
  end)

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

 
local pathToScript = game.Players.LocalPlayer.PlayerScripts.Scripts.Game['Open Eggs']

local EggData = {} 
for i,v in pairs(game.ReplicatedStorage.Game.Eggs:GetChildren()) do 
    for i2,v2 in pairs(v:GetChildren()) do 
        table.insert(EggData, v2.Name)
    end 
end

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


AF4:Button("Remove Egg animation", function()
    for i,v in pairs(getgc(true)) do
        if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
            v.OpenEgg = function()
                return
            end
        end
    end
end)

local EnchantsList = {
    'Magnet',
    'Royalty',
    'Glittering',
    'Rainbow Coins',
    'Tech Coins',
    'Fantasy Coins',
    'Coins',
    'Teamwork',
    'Diamonds',
    'Strength',
    'Chests',
    'Presents',
    'Agility',
    'Charm'
}

local EnchantLevel = {1, 2, 3, 4, 5}

AF5:Label("Enchant")

           AF5:Dropdown("Select Enhants", EnchantsList, function(v)
               _G.SelectEnch = v
           end)
           AF5:Dropdown("Select Level", EnchantLevel, function(v)
              _G.SelectLv = v
           end)

           AF5:Toggle("Enchant Enable", false ,function(v)
            if v == true then
                _G.Stop = false
            elseif v == false then
                _G.Stop = true
            end  -- Set to "true" if you want the auto enchant stop.
            _G.BankIndex = 1 -- Bank index: 1 = your own bank / 2 - 5 = Banks you're invited to
            _G.AutoWithdraw = false -- will auto withdraw 25b gems or how much gems you have left if you dont have gems left.
            _G.Wanted = { -- Wanted enchants.
            [_G.SelectEnch] = _G.SelectLv,
            }
local Library, Blacklist, BUID, BankInfo, Functions
do--//Init
    repeat
        wait(.1)
    until game:IsLoaded() and game:GetService('Players').LocalPlayer ~= nil and game:GetService('Players').LocalPlayer:FindFirstChild('__LOADED')
    Library     = require(game:GetService('ReplicatedStorage').Framework:FindFirstChild('Library'))
    Functions   = Library.Functions
    Blacklist   = {}
    BUID        = Library.Network.Invoke('Get my Banks')[_G.BankIndex].BUID
    BankInfo    = Library.Network.Invoke('Get Bank', BUID)
end

do --//Checks&Functions
    table.foreach(Library.Directory.Pets, function(i, v)
        if v.rarity == "Mythical" or v.rarity == "Exclusive" then
            Blacklist[tostring(i)] = v.rarity
        end
    end)
    function GetPetInfo(uid)
        for i, v in pairs(Library.Save.Get().Pets) do
            if v.uid == uid then
                return v
            end
        end
    end
    function PetToValidTable(petpowers)
        local temptable = {}
        if petpowers then
            table.foreach(petpowers, function(i, powers)
                temptable[powers[1]] = powers[2]
            end)
        end
        return temptable
    end
end
do--//AutoEnch
    for i, v in pairs(Library.Save.Get().Pets) do
        if v.e and not Blacklist[v.id] and _G.Stop ~= true then
            local HasPower = false
            local startTime = tick()
            spawn(function()
                repeat
                    if not Library.Functions.CompareTable(_G.Wanted, PetToValidTable(GetPetInfo(v.uid).powers)) and not HasPower and not _G.Stop then
                        Library.Network.Invoke("Enchant Pet", v.uid)
                    else
                        local printwith = rconsolewarn or warn
                        DiscordLib:Notification('SazaSystem','Pet has Wanted: '.._G.SelectEnch..' Lv: '.._G.SelectLv.. '\nPlease ReEnable Again if u want Continue Enchanting Pets', "Alright!")
                        HasPower = true
                    end
                    if Library.Save.Get().Diamonds < 500000 and _G.Stop ~= true and _G.AutoWithdraw then
                        Library.Network.Invoke('Bank withdraw', BUID, (function()
                            if (1000000000000 - BankInfo.Storage.Currency.Diamonds) > 25000000000 then
                                return (25000000000 - Library.Save.Get().Diamonds)
                            else
                                return (1000000000000 - BankInfo.Storage.Currency.Diamonds)
                            end
                        end))
                    end
                    task.wait()
                until HasPower == true or _G.Stop
            end)
        end
    end
end            
end)   

AF5:Seperator()

 AF5:Label("RB/GOLD")
 getgenv().CountCombineFunc1 = 0

 AF5:Dropdown("Select pet Amount", {0,1,2,3,4,5,6}, function(countcombinefunc)
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

 local AF8 = serv:Channel("Local Player")
 
 AF8:Slider("WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed,500,30,function(Value)
     
    local Player = game:GetService('Players').LocalPlayer
    local Humanoid = Player.Character:FindFirstChildOfClass('Humanoid')
    Humanoid.WalkSpeed = Value
    wait(0.1)
 end)
 AF8:Slider("Jump Power",game.Players.LocalPlayer.Character.Humanoid.JumpPower,1000,50,function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
 end)
 AF8:Slider("Gravity",game.Workspace.Gravity,1000,0,function(Value)
    game.Workspace.Gravity = Value
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

	
     warn("Anti AFK : Work")
     local vu = game:GetService("VirtualUser")
     game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
     end)


return DiscordLib
