--[[
	
	Rayfield Modal Library - ADULT VERSION
	Extension for Rayfield Interface Suite
	
	⚠️ 18+ VERSION - Adult Themes with External Image Assets
	
	Features:
	- Modal Notifications with custom image themes
	- Console/Code Display
	- Yes/No Confirmation Dialogs
	- Custom Prompts with Input
	- NSFW Theme Support (Images from URL)
	- Image Caching System
	- Non-blocking UI
	
]]--

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- ============================================
-- IMAGE LOADER SYSTEM
-- ============================================
local ImageCache = {}

local function LoadImageFromURL(url, cacheName)
	-- Check cache first
	if ImageCache[url] then
		return ImageCache[url]
	end
	
	-- Try to load from URL
	local fileName = "RayfieldModal_" .. (cacheName or "cache") .. ".jpg"
	local success, content = pcall(function() 
		return game:HttpGet(url) 
	end)
	
	if success and content and #content > 0 then
		-- Write to file if executor supports it
		if writefile then
			pcall(function()
				writefile(fileName, content)
			end)
		end
		
		-- Get custom asset
		local asset = ""
		if getcustomasset then
			local assetSuccess, assetResult = pcall(function()
				return getcustomasset(fileName)
			end)
			if assetSuccess then
				asset = assetResult
			end
		end
		
		-- Cache the result
		ImageCache[url] = asset
		return asset
	end
	
	return ""
end

-- ============================================
-- ADULT THEMES CONFIGURATION
-- ============================================
local AdultThemes = {
	-- Theme: Pink Passion
	PinkPassion = {
		Name = "Pink Passion",
		ImageURL = "https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg",
		TextColor = Color3.fromRGB(255, 255, 255),
		TextStrokeColor = Color3.fromRGB(0, 0, 0),
		TextStrokeTransparency = 0.3,
		Accent = Color3.fromRGB(255, 105, 180),
		AccentHover = Color3.fromRGB(255, 182, 193),
		ButtonBackground = Color3.fromRGB(30, 30, 30),
		ButtonBackgroundHover = Color3.fromRGB(50, 50, 50),
		OverlayColor = Color3.fromRGB(0, 0, 0),
		OverlayTransparency = 0.6,
		GlowColor = Color3.fromRGB(255, 105, 180),
	},
	
	-- Theme: Midnight Desires
	MidnightDesires = {
		Name = "Midnight Desires",
		ImageURL = "https://rule34.porn/media/2024/06/Naked-Girl-by-Nat-the-LichOriginal.webp",
		TextColor = Color3.fromRGB(255, 255, 255),
		TextStrokeColor = Color3.fromRGB(0, 0, 0),
		TextStrokeTransparency = 0.3,
		Accent = Color3.fromRGB(147, 112, 219),
		AccentHover = Color3.fromRGB(186, 85, 211),
		ButtonBackground = Color3.fromRGB(25, 25, 35),
		ButtonBackgroundHover = Color3.fromRGB(45, 45, 55),
		OverlayColor = Color3.fromRGB(10, 10, 20),
		OverlayTransparency = 0.5,
		GlowColor = Color3.fromRGB(147, 112, 219),
	},
	
	-- Theme: Dark Seduction
	DarkSeduction = {
		Name = "Dark Seduction",
		ImageURL = "https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg",
		TextColor = Color3.fromRGB(255, 215, 0),
		TextStrokeColor = Color3.fromRGB(0, 0, 0),
		TextStrokeTransparency = 0.4,
		Accent = Color3.fromRGB(255, 69, 0),
		AccentHover = Color3.fromRGB(255, 140, 0),
		ButtonBackground = Color3.fromRGB(20, 10, 10),
		ButtonBackgroundHover = Color3.fromRGB(40, 20, 20),
		OverlayColor = Color3.fromRGB(10, 5, 5),
		OverlayTransparency = 0.6,
		GlowColor = Color3.fromRGB(255, 69, 0),
	},
	
	-- Theme: Ocean Fantasy
	OceanFantasy = {
		Name = "Ocean Fantasy",
		ImageURL = "https://rule34.porn/media/2024/06/Naked-Girl-by-Nat-the-LichOriginal.webp",
		TextColor = Color3.fromRGB(173, 216, 230),
		TextStrokeColor = Color3.fromRGB(0, 20, 40),
		TextStrokeTransparency = 0.4,
		Accent = Color3.fromRGB(0, 206, 209),
		AccentHover = Color3.fromRGB(64, 224, 208),
		ButtonBackground = Color3.fromRGB(10, 30, 40),
		ButtonBackgroundHover = Color3.fromRGB(20, 50, 60),
		OverlayColor = Color3.fromRGB(0, 20, 40),
		OverlayTransparency = 0.5,
		GlowColor = Color3.fromRGB(0, 206, 209),
	},
	
	-- Theme: Purple Haze
	PurpleHaze = {
		Name = "Purple Haze",
		ImageURL = "https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg",
		TextColor = Color3.fromRGB(255, 255, 255),
		TextStrokeColor = Color3.fromRGB(75, 0, 130),
		TextStrokeTransparency = 0.3,
		Accent = Color3.fromRGB(186, 85, 211),
		AccentHover = Color3.fromRGB(218, 112, 214),
		ButtonBackground = Color3.fromRGB(30, 10, 40),
		ButtonBackgroundHover = ColorColor3.fromRGB(50, 20, 60),
		OverlayColor = Color3.fromRGB(20, 0, 30),
		OverlayTransparency = 0.55,
		GlowColor = Color3.fromRGB(186, 85, 211),
	},
	
	-- Theme: Custom (User Provided URL)
	Custom = {
		Name = "Custom",
		ImageURL = "", -- User sets this
		TextColor = Color3.fromRGB(255, 255, 255),
		TextStrokeColor = Color3.fromRGB(0, 0, 0),
		TextStrokeTransparency = 0.3,
		Accent = Color3.fromRGB(0, 146, 214),
		AccentHover = Color3.fromRGB(0, 170, 255),
		ButtonBackground = Color3.fromRGB(30, 30, 30),
		ButtonBackgroundHover = Color3.fromRGB(50, 50, 50),
		OverlayColor = Color3.fromRGB(0, 0, 0),
		OverlayTransparency = 0.6,
		GlowColor = Color3.fromRGB(0, 146, 214),
	},
}

-- ============================================
-- RAYFIELD MODAL ADULT LIBRARY
-- ============================================
local RayfieldModalAdult = {
	Themes = AdultThemes,
	CurrentTheme = nil,
	CurrentImageAsset = "",
	ModalCount = 0,
	ImageLoaded = false,
}

-- Set default theme
RayfieldModalAdult.CurrentTheme = AdultThemes.PinkPassion

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================
local function Create(instance, properties)
	local obj = Instance.new(instance)
	for prop, value in pairs(properties) do
		obj[prop] = value
	end
	return obj
end

local function Tween(obj, props, duration, style, direction)
	local tweenInfo = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out)
	local tween = TweenService:Create(obj, tweenInfo, props)
	tween:Play()
	return tween
end

local function GetScreenGui()
	local screenGui
	
	if gethui then
		screenGui = gethui():FindFirstChild("RayfieldModalAdultUI")
		if not screenGui then
			screenGui = Create("ScreenGui", {
				Name = "RayfieldModalAdultUI",
				IgnoreGuiInset = true,
				ResetOnSpawn = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				DisplayOrder = 1000
			})
			screenGui.Parent = gethui()
		end
	elseif syn and syn.protect_gui then
		screenGui = CoreGui:FindFirstChild("RayfieldModalAdultUI")
		if not screenGui then
			screenGui = Create("ScreenGui", {
				Name = "RayfieldModalAdultUI",
				IgnoreGuiInset = true,
				ResetOnSpawn = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				DisplayOrder = 1000
			})
			syn.protect_gui(screenGui)
			screenGui.Parent = CoreGui
		end
	else
		screenGui = CoreGui:FindFirstChild("RayfieldModalAdultUI")
		if not screenGui then
			screenGui = Create("ScreenGui", {
				Name = "RayfieldModalAdultUI",
				IgnoreGuiInset = true,
				ResetOnSpawn = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				DisplayOrder = 1000
			})
			screenGui.Parent = CoreGui
		end
	end
	
	return screenGui
end

-- ============================================
-- THEME MANAGEMENT
-- ============================================
function RayfieldModalAdult:SetTheme(themeName, customImageURL)
	if self.Themes[themeName] then
		self.CurrentTheme = self.Themes[themeName]
		
		-- Handle custom theme
		if themeName == "Custom" and customImageURL then
			self.CurrentTheme.ImageURL = customImageURL
		end
		
		-- Load the theme image
		if self.CurrentTheme.ImageURL and self.CurrentTheme.ImageURL ~= "" then
			self.CurrentImageAsset = LoadImageFromURL(self.CurrentTheme.ImageURL, themeName)
			self.ImageLoaded = self.CurrentImageAsset ~= ""
		else
			self.ImageLoaded = false
			self.CurrentImageAsset = ""
		end
	end
end

function RayfieldModalAdult:SetCustomImage(imageURL)
	self:SetTheme("Custom", imageURL)
end

function RayfieldModalAdult:PreloadThemes()
	-- Preload all theme images
	for themeName, theme in pairs(self.Themes) do
		if theme.ImageURL and theme.ImageURL ~= "" then
			task.spawn(function()
				LoadImageFromURL(theme.ImageURL, themeName)
			end)
		end
	end
end

-- ============================================
-- CREATE OVERLAY WITH BACKGROUND IMAGE
-- ============================================
local function CreateOverlay(parent, theme, imageAsset)
	-- Main overlay container (non-blocking)
	local overlay = Create("Frame", {
		Name = "Overlay",
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = theme.OverlayColor,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 1,
		Active = false, -- IMPORTANT: Does NOT block clicks
		Parent = parent
	})
	
	-- Background image (if available)
	if imageAsset and imageAsset ~= "" then
		local bgImage = Create("ImageLabel", {
			Name = "BackgroundImage",
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
			Image = imageAsset,
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = 1,
			ZIndex = 2,
			Active = false,
			Parent = overlay
		})
		
		-- Dark overlay on top of image
		local darkOverlay = Create("Frame", {
			Name = "DarkOverlay",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = theme.OverlayColor,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 3,
			Active = false,
			Parent = overlay
		})
		
		-- Animate background
		Tween(bgImage, {ImageTransparency = 0.2}, 0.5)
		Tween(darkOverlay, {BackgroundTransparency = theme.OverlayTransparency}, 0.5)
	else
		Tween(overlay, {BackgroundTransparency = theme.OverlayTransparency}, 0.3)
	end
	
	return overlay
end

-- ============================================
-- CREATE MODAL BASE WITH IMAGE BACKGROUND
-- ============================================
local function CreateModalBase(parent, title, width, height, theme, imageAsset)
	-- Main modal container
	local modal = Create("Frame", {
		Name = "Modal_" .. tostring(RayfieldModalAdult.ModalCount),
		Size = UDim2.new(0, width or 400, 0, height or 200),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		BorderColor3 = Color3.fromRGB(50, 50, 50),
		BorderSizePixel = 0,
		ZIndex = 10,
		Active = true, -- Modal itself is interactive
		Parent = parent
	})
	
	-- Corner radius
	Create("UICorner", {
		CornerRadius = UDim.new(0, 20),
		Parent = modal
	})
	
	-- Background image (if available)
	if imageAsset and imageAsset ~= "" then
		local bgImage = Create("ImageLabel", {
			Name = "ModalBackground",
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
			Image = imageAsset,
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = 0.3,
			ZIndex = 11,
			Parent = modal
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 20),
			Parent = bgImage
		end)
	end
	
	-- Dark overlay for readability
	local darkOverlay = Create("Frame", {
		Name = "DarkOverlay",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = modal
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 20),
		Parent = darkOverlay
	})
	
	-- Glow effect
	local glow = Create("ImageLabel", {
		Name = "Glow",
		Size = UDim2.new(1.1, 0, 1.1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://6014261993",
		ImageColor3 = theme.GlowColor,
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
		ZIndex = 9,
		Parent = modal
	})
	
	-- Border stroke
	local stroke = Create("UIStroke", {
		Color = theme.Accent,
		Thickness = 2,
		Transparency = 1,
		Parent = modal
	})
	
	-- Top bar
	local topbar = Create("Frame", {
		Name = "Topbar",
		Size = UDim2.new(1, 0, 0, 50),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = modal
	})
	
	-- Top bar corner fix
	Create("Frame", {
		Name = "CornerFix",
		Size = UDim2.new(1, 0, 0, 20),
		Position = UDim2.new(0, 0, 1, -8),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = topbar
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 20),
		Parent = topbar
	})
	
	-- Title
	local titleLabel = Create("TextLabel", {
		Name = "Title",
		Size = UDim2.new(1, -60, 1, 0),
		Position = UDim2.new(0, 20, 0, 0),
		BackgroundTransparency = 1,
		Text = title or "Modal",
		TextColor3 = theme.TextColor,
		TextSize = 18,
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 16,
		Parent = topbar
	})
	
	-- Text stroke for readability
	if theme.TextStrokeTransparency then
		Create("UIStroke", {
			Color = theme.TextStrokeColor,
			Thickness = 2,
			Transparency = theme.TextStrokeTransparency,
			Parent = titleLabel
		})
	end
	
	-- Close button
	local closeBtn = Create("TextButton", {
		Name = "Close",
		Size = UDim2.new(0, 35, 0, 35),
		Position = UDim2.new(1, -42, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 70, 70),
		BackgroundTransparency = 0.3,
		Text = "",
		ZIndex = 16,
		Parent = topbar
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = closeBtn
	})
	
	local closeIcon = Create("ImageLabel", {
		Name = "Icon",
		Size = UDim2.new(0, 18, 0, 18),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectSize = Vector2.new(48, 48),
		ImageRectOffset = Vector2.new(288, 288),
		ImageColor3 = Color3.new(1, 1, 1),
		ZIndex = 17,
		Parent = closeBtn
	})
	
	-- Initial animation state
	modal.Size = UDim2.new(0, width or 400, 0, 0)
	modal.BackgroundTransparency = 1
	topbar.BackgroundTransparency = 1
	titleLabel.TextTransparency = 1
	closeBtn.Visible = false
	glow.ImageTransparency = 1
	stroke.Transparency = 1
	
	task.wait()
	
	-- Animate in
	Tween(modal, {BackgroundTransparency = 0}, 0.2)
	Tween(topbar, {BackgroundTransparency = 0.5}, 0.2)
	Tween(titleLabel, {TextTransparency = 0}, 0.2)
	Tween(glow, {ImageTransparency = 0.5}, 0.4)
	Tween(stroke, {Transparency = 0}, 0.3)
	Tween(modal, {Size = UDim2.new(0, width or 400, 0, height or 200)}, 0.4, Enum.EasingStyle.Back)
	
	task.wait(0.15)
	closeBtn.Visible = true
	
	return modal, topbar, titleLabel, closeBtn, glow, stroke
end

-- ============================================
-- NOTIFY - MODAL NOTIFICATION
-- ============================================
function RayfieldModalAdult:Notify(data)
	local screenGui = GetScreenGui()
	local theme = self.CurrentTheme
	self.ModalCount = self.ModalCount + 1
	
	local width = 420
	local height = 180
	
	local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
	local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Notification", width, height, theme, self.CurrentImageAsset)
	
	-- Content container
	local contentFrame = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -40, 1, -70),
		Position = UDim2.new(0, 20, 0, 55),
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = modal
	})
	
	-- Optional icon
	local iconSize = 0
	if data.Image then
		local icon = Create("ImageLabel", {
			Name = "Icon",
			Size = UDim2.new(0, 50, 0, 50),
			Position = UDim2.new(0, 0, 0, 10),
			BackgroundTransparency = 1,
			Image = typeof(data.Image) == "number" and "rbxassetid://" .. data.Image or data.Image,
			ImageColor3 = theme.Accent,
			ZIndex = 16,
			Parent = contentFrame
		})
		iconSize = 60
	end
	
	-- Description
	local descLabel = Create("TextLabel", {
		Name = "Description",
		Size = UDim2.new(1, -iconSize - 10, 1, -20),
		Position = UDim2.new(0, iconSize, 0, 10),
		BackgroundTransparency = 1,
		Text = data.Content or "",
		TextColor3 = theme.TextColor,
		TextSize = 15,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		ZIndex = 16,
		Parent = contentFrame
	})
	descLabel.TextTransparency = 1
	
	-- Text stroke
	Create("UIStroke", {
		Color = theme.TextStrokeColor,
		Thickness = 1.5,
		Transparency = theme.TextStrokeTransparency,
		Parent = descLabel
	})
	
	Tween(descLabel, {TextTransparency = 0}, 0.2)
	
	-- Close function
	local function closeModal()
		Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
		Tween(overlay, {BackgroundTransparency = 1}, 0.2)
		Tween(modal, {BackgroundTransparency = 1}, 0.2)
		Tween(topbar, {BackgroundTransparency = 1}, 0.2)
		Tween(glow, {ImageTransparency = 1}, 0.2)
		Tween(descLabel, {TextTransparency = 1}, 0.15)
		Tween(titleLabel, {TextTransparency = 1}, 0.15)
		
		task.wait(0.3)
		modal:Destroy()
		overlay:Destroy()
	end
	
	closeBtn.MouseButton1Click:Connect(closeModal)
	
	-- Auto close
	task.spawn(function()
		local duration = data.Duration or 5
		task.wait(duration)
		if modal and modal.Parent then
			closeModal()
		end
	end)
	
	return modal
end

-- ============================================
-- CONFIRM - YES/NO DIALOG
-- ============================================
function RayfieldModalAdult:Confirm(data)
	local screenGui = GetScreenGui()
	local theme = self.CurrentTheme
	self.ModalCount = self.ModalCount + 1
	
	local width = 420
	local height = 200
	
	local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
	local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Confirm", width, height, theme, self.CurrentImageAsset)
	
	-- Content
	local contentFrame = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -40, 1, -120),
		Position = UDim2.new(0, 20, 0, 55),
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = modal
	})
	
	-- Description
	local descLabel = Create("TextLabel", {
		Name = "Description",
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		Text = data.Content or "Are you sure?",
		TextColor3 = theme.TextColor,
		TextSize = 15,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		ZIndex = 16,
		Parent = contentFrame
	})
	descLabel.TextTransparency = 1
	
	Create("UIStroke", {
		Color = theme.TextStrokeColor,
		Thickness = 1.5,
		Transparency = theme.TextStrokeTransparency,
		Parent = descLabel
	})
	
	Tween(descLabel, {TextTransparency = 0}, 0.2)
	
	-- Buttons container
	local btnContainer = Create("Frame", {
		Name = "Buttons",
		Size = UDim2.new(1, -40, 0, 45),
		Position = UDim2.new(0, 20, 1, -60),
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = modal
	})
	
	-- No button
	local noBtn = Create("TextButton", {
		Name = "No",
		Size = UDim2.new(0.5, -8, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = theme.ButtonBackground,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Text = data.NoText or "No",
		TextColor3 = theme.TextColor,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		ZIndex = 16,
		Parent = btnContainer
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = noBtn
	})
	
	Create("UIStroke", {
		Color = Color3.fromRGB(100, 100, 100),
		Thickness = 1,
		Transparency = 0.5,
		Parent = noBtn
	})
	
	-- Yes button
	local yesBtn = Create("TextButton", {
		Name = "Yes",
		Size = UDim2.new(0.5, -8, 1, 0),
		Position = UDim2.new(0.5, 8, 0, 0),
		BackgroundColor3 = theme.Accent,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		Text = data.YesText or "Yes",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		ZIndex = 16,
		Parent = btnContainer
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = yesBtn
	})
	
	-- Hover effects
	noBtn.MouseEnter:Connect(function() Tween(noBtn, {BackgroundTransparency = 0.1}, 0.15) end)
	noBtn.MouseLeave:Connect(function() Tween(noBtn, {BackgroundTransparency = 0.3}, 0.15) end)
	yesBtn.MouseEnter:Connect(function() Tween(yesBtn, {BackgroundColor3 = theme.AccentHover}, 0.15) end)
	yesBtn.MouseLeave:Connect(function() Tween(yesBtn, {BackgroundColor3 = theme.Accent}, 0.15) end)
	
	-- Close function
	local function closeModal()
		Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
		Tween(overlay, {BackgroundTransparency = 1}, 0.2)
		Tween(modal, {BackgroundTransparency = 1}, 0.2)
		Tween(glow, {ImageTransparency = 1}, 0.2)
		Tween(descLabel, {TextTransparency = 1}, 0.15)
		Tween(titleLabel, {TextTransparency = 1}, 0.15)
		
		task.wait(0.3)
		modal:Destroy()
		overlay:Destroy()
	end
	
	-- Button callbacks
	noBtn.MouseButton1Click:Connect(function()
		closeModal()
		if data.Callback then data.Callback(false) end
	end)
	
	yesBtn.MouseButton1Click:Connect(function()
		closeModal()
		if data.Callback then data.Callback(true) end
	end)
	
	closeBtn.MouseButton1Click:Connect(function()
		closeModal()
		if data.Callback then data.Callback(false) end
	end)
	
	return modal
end

-- ============================================
-- CONSOLE - CODE DISPLAY
-- ============================================
function RayfieldModalAdult:Console(data)
	local screenGui = GetScreenGui()
	local theme = self.CurrentTheme
	self.ModalCount = self.ModalCount + 1
	
	local width = data.Width or 550
	local height = data.Height or 400
	
	local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
	local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Console", width, height, theme, self.CurrentImageAsset)
	
	-- Console container
	local consoleFrame = Create("Frame", {
		Name = "ConsoleFrame",
		Size = UDim2.new(1, -30, 1, -70),
		Position = UDim2.new(0, 15, 0, 55),
		BackgroundColor3 = Color3.fromRGB(10, 10, 10),
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = modal
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = consoleFrame
	})
	
	Create("UIStroke", {
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.5,
		Parent = consoleFrame
	})
	
	-- Scrolling frame
	local scrollingFrame = Create("ScrollingFrame", {
		Name = "ScrollingFrame",
		Size = UDim2.new(1, -10, 1, -50),
		Position = UDim2.new(0, 5, 0, 5),
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = theme.Accent,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ZIndex = 16,
		Parent = consoleFrame
	})
	
	-- Code text
	local codeText = Create("TextLabel", {
		Name = "Code",
		Size = UDim2.new(1, -10, 1, 0),
		Position = UDim2.new(0, 8, 0, 8),
		BackgroundTransparency = 1,
		Text = data.Content or "",
		TextColor3 = Color3.fromRGB(230, 230, 230),
		TextSize = 13,
		Font = Enum.Font.Code,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		ZIndex = 17,
		Parent = scrollingFrame
	})
	codeText.TextTransparency = 1
	
	-- Language badge
	if data.Language then
		local langBadge = Create("Frame", {
			Name = "LangBadge",
			Size = UDim2.new(0, 70, 0, 25),
			Position = UDim2.new(1, -85, 0, 8),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.2,
			BorderSizePixel = 0,
			ZIndex = 18,
			Parent = modal
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 6),
			Parent = langBadge
		})
		
		Create("TextLabel", {
			Name = "Lang",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = string.upper(data.Language),
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 11,
			Font = Enum.Font.GothamBold,
			ZIndex = 19,
			Parent = langBadge
		})
	end
	
	-- Copy button
	local copyBtn = Create("TextButton", {
		Name = "Copy",
		Size = UDim2.new(0, 90, 0, 32),
		Position = UDim2.new(0, 15, 1, -42),
		BackgroundColor3 = theme.ButtonBackground,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Text = "📋 Copy",
		TextColor3 = theme.TextColor,
		TextSize = 12,
		Font = Enum.Font.GothamSemibold,
		ZIndex = 16,
		Parent = modal
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = copyBtn
	})
	
	-- Close button
	local closeBtnBottom = Create("TextButton", {
		Name = "CloseBtn",
		Size = UDim2.new(0, 90, 0, 32),
		Position = UDim2.new(1, -105, 1, -42),
		BackgroundColor3 = theme.Accent,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		Text = "Close",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 12,
		Font = Enum.Font.GothamSemibold,
		ZIndex = 16,
		Parent = modal
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = closeBtnBottom
	})
	
	Tween(codeText, {TextTransparency = 0}, 0.2)
	
	-- Calculate scroll size
	local textBounds = game:GetService("TextService"):GetTextSize(
		data.Content or "",
		13,
		Enum.Font.Code,
		Vector2.new(scrollingFrame.AbsoluteSize.X, math.huge)
	)
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 20)
	
	-- Copy function
	copyBtn.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard(data.Content or "")
			copyBtn.Text = "✓ Copied!"
			copyBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
			task.wait(1)
			copyBtn.Text = "📋 Copy"
			copyBtn.BackgroundColor3 = theme.ButtonBackground
		end
	end)
	
	-- Close function
	local function closeModal()
		Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
		Tween(overlay, {BackgroundTransparency = 1}, 0.2)
		Tween(modal, {BackgroundTransparency = 1}, 0.2)
		Tween(glow, {ImageTransparency = 1}, 0.2)
		Tween(codeText, {TextTransparency = 1}, 0.15)
		Tween(titleLabel, {TextTransparency = 1}, 0.15)
		
		task.wait(0.3)
		modal:Destroy()
		overlay:Destroy()
	end
	
	closeBtnBottom.MouseButton1Click:Connect(closeModal)
	closeBtn.MouseButton1Click:Connect(closeModal)
	
	return modal
end

-- ============================================
-- PROMPT - INPUT DIALOG
-- ============================================
function RayfieldModalAdult:Prompt(data)
	local screenGui = GetScreenGui()
	local theme = self.CurrentTheme
	self.ModalCount = self.ModalCount + 1
	
	local width = 420
	local height = 220
	
	local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
	local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Input", width, height, theme, self.CurrentImageAsset)
	
	-- Content
	local contentFrame = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -40, 1, -120),
		Position = UDim2.new(0, 20, 0, 55),
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = modal
	})
	
	-- Optional description
	local yOffset = 0
	if data.Content then
		local descLabel = Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, 0, 0, 25),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
			Text = data.Content,
			TextColor3 = theme.TextColor,
			TextSize = 13,
			Font = Enum.Font.GothamMedium,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			ZIndex = 16,
			Parent = contentFrame
		})
		descLabel.TextTransparency = 1
		
		Create("UIStroke", {
			Color = theme.TextStrokeColor,
			Thickness = 1,
			Transparency = theme.TextStrokeTransparency,
			Parent = descLabel
		})
		
		Tween(descLabel, {TextTransparency = 0}, 0.2)
		yOffset = 30
	end
	
	-- Input box
	local inputBox = Create("TextBox", {
		Name = "Input",
		Size = UDim2.new(1, 0, 0, 45),
		Position = UDim2.new(0, 0, 0, yOffset),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Text = data.Default or "",
		PlaceholderText = data.Placeholder or "Enter text...",
		PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
		TextColor3 = theme.TextColor,
		TextSize = 15,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 16,
		Parent = contentFrame
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = inputBox
	})
	
	Create("UIStroke", {
		Color = theme.Accent,
		Thickness = 1.5,
		Transparency = 0.3,
		Parent = inputBox
	})
	
	Create("UIPadding", {
		PaddingLeft = UDim.new(0, 15),
		PaddingRight = UDim.new(0, 15),
		Parent = inputBox
	})
	
	-- Buttons container
	local btnContainer = Create("Frame", {
		Name = "Buttons",
		Size = UDim2.new(1, -40, 0, 45),
		Position = UDim2.new(0, 20, 1, -60),
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = modal
	})
	
	-- Cancel button
	local cancelBtn = Create("TextButton", {
		Name = "Cancel",
		Size = UDim2.new(0.5, -8, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = theme.ButtonBackground,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Text = "Cancel",
		TextColor3 = theme.TextColor,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		ZIndex = 16,
		Parent = btnContainer
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = cancelBtn
	})
	
	-- Confirm button
	local confirmBtn = Create("TextButton", {
		Name = "Confirm",
		Size = UDim2.new(0.5, -8, 1, 0),
		Position = UDim2.new(0.5, 8, 0, 0),
		BackgroundColor3 = theme.Accent,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		Text = "Confirm",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		ZIndex = 16,
		Parent = btnContainer
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = confirmBtn
	})
	
	-- Hover effects
	cancelBtn.MouseEnter:Connect(function() Tween(cancelBtn, {BackgroundTransparency = 0.1}, 0.15) end)
	cancelBtn.MouseLeave:Connect(function() Tween(cancelBtn, {BackgroundTransparency = 0.3}, 0.15) end)
	confirmBtn.MouseEnter:Connect(function() Tween(confirmBtn, {BackgroundColor3 = theme.AccentHover}, 0.15) end)
	confirmBtn.MouseLeave:Connect(function() Tween(confirmBtn, {BackgroundColor3 = theme.Accent}, 0.15) end)
	
	-- Close function
	local function closeModal()
		Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
		Tween(overlay, {BackgroundTransparency = 1}, 0.2)
		Tween(modal, {BackgroundTransparency = 1}, 0.2)
		Tween(glow, {ImageTransparency = 1}, 0.2)
		Tween(titleLabel, {TextTransparency = 1}, 0.15)
		
		task.wait(0.3)
		modal:Destroy()
		overlay:Destroy()
	end
	
	-- Button callbacks
	cancelBtn.MouseButton1Click:Connect(function()
		closeModal()
		if data.Callback then data.Callback(nil) end
	end)
	
	confirmBtn.MouseButton1Click:Connect(function()
		closeModal()
		if data.Callback then data.Callback(inputBox.Text) end
	end)
	
	closeBtn.MouseButton1Click:Connect(function()
		closeModal()
		if data.Callback then data.Callback(nil) end
	end)
	
	-- Enter key to confirm
	inputBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			closeModal()
			if data.Callback then data.Callback(inputBox.Text) end
		end
	end)
	
	-- Auto focus
	task.wait(0.25)
	inputBox:CaptureFocus()
	
	return modal
end

-- ============================================
-- ALERT - SIMPLE DIALOG
-- ============================================
function RayfieldModalAdult:Alert(data)
	local screenGui = GetScreenGui()
	local theme = self.CurrentTheme
	self.ModalCount = self.ModalCount + 1
	
	local width = 420
	local height = 180
	
	local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
	local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Alert", width, height, theme, self.CurrentImageAsset)
	
	-- Content
	local contentFrame = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -40, 1, -100),
		Position = UDim2.new(0, 20, 0, 55),
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = modal
	})
	
	-- Description
	local descLabel = Create("TextLabel", {
		Name = "Description",
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		Text = data.Content or "",
		TextColor3 = theme.TextColor,
		TextSize = 15,
		Font = Enum.Font.GothamMedium,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		ZIndex = 16,
		Parent = contentFrame
	})
	descLabel.TextTransparency = 1
	
	Create("UIStroke", {
		Color = theme.TextStrokeColor,
		Thickness = 1.5,
		Transparency = theme.TextStrokeTransparency,
		Parent = descLabel
	})
	
	Tween(descLabel, {TextTransparency = 0}, 0.2)
	
	-- OK button
	local okBtn = Create("TextButton", {
		Name = "OK",
		Size = UDim2.new(0, 140, 0, 40),
		Position = UDim2.new(0.5, -70, 1, -55),
		BackgroundColor3 = theme.Accent,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		Text = data.ButtonText or "OK",
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		ZIndex = 16,
		Parent = modal
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 10),
		Parent = okBtn
	})
	
	okBtn.MouseEnter:Connect(function() Tween(okBtn, {BackgroundColor3 = theme.AccentHover}, 0.15) end)
	okBtn.MouseLeave:Connect(function() Tween(okBtn, {BackgroundColor3 = theme.Accent}, 0.15) end)
	
	-- Close function
	local function closeModal()
		Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
		Tween(overlay, {BackgroundTransparency = 1}, 0.2)
		Tween(modal, {BackgroundTransparency = 1}, 0.2)
		Tween(glow, {ImageTransparency = 1}, 0.2)
		Tween(descLabel, {TextTransparency = 1}, 0.15)
		Tween(titleLabel, {TextTransparency = 1}, 0.15)
		
		task.wait(0.3)
		modal:Destroy()
		overlay:Destroy()
		
		if data.Callback then data.Callback() end
	end
	
	okBtn.MouseButton1Click:Connect(closeModal)
	closeBtn.MouseButton1Click:Connect(closeModal)
	
	return modal
end

-- ============================================
-- LOADING - PROGRESS DIALOG
-- ============================================
function RayfieldModalAdult:Loading(data)
	local screenGui = GetScreenGui()
	local theme = self.CurrentTheme
	self.ModalCount = self.ModalCount + 1
	
	local width = 350
	local height = 160
	
	local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
	local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Loading", width, height, theme, self.CurrentImageAsset)
	closeBtn.Visible = false
	
	-- Content
	local contentFrame = Create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -40, 1, -70),
		Position = UDim2.new(0, 20, 0, 55),
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = modal
	})
	
	-- Spinner
	local spinner = Create("ImageLabel", {
		Name = "Spinner",
		Size = UDim2.new(0, 40, 0, 40),
		Position = UDim2.new(0.5, 0, 0, 15),
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Image = "rbxassetid://6014261993",
		ImageColor3 = theme.Accent,
		ZIndex = 16,
		Parent = contentFrame
	})
	
	-- Status text
	local statusLabel = Create("TextLabel", {
		Name = "Status",
		Size = UDim2.new(1, 0, 0, 35),
		Position = UDim2.new(0, 0, 0, 60),
		BackgroundTransparency = 1,
		Text = data.Content or "Please wait...",
		TextColor3 = theme.TextColor,
		TextSize = 14,
		Font = Enum.Font.GothamMedium,
		ZIndex = 16,
		Parent = contentFrame
	})
	statusLabel.TextTransparency = 1
	
	Create("UIStroke", {
		Color = theme.TextStrokeColor,
		Thickness = 1,
		Transparency = theme.TextStrokeTransparency,
		Parent = statusLabel
	})
	
	Tween(statusLabel, {TextTransparency = 0}, 0.2)
	
	-- Spinner rotation
	local rotation = 0
	local connection
	connection = RunService.Heartbeat:Connect(function()
		rotation = rotation + 6
		spinner.Rotation = rotation
	end)
	
	-- Control object
	local control = {}
	
	function control:Update(text)
		statusLabel.Text = text
	end
	
	function control:Close()
		connection:Disconnect()
		Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
		Tween(overlay, {BackgroundTransparency = 1}, 0.2)
		Tween(modal, {BackgroundTransparency = 1}, 0.2)
		Tween(glow, {ImageTransparency = 1}, 0.2)
		Tween(statusLabel, {TextTransparency = 1}, 0.15)
		Tween(titleLabel, {TextTransparency = 1}, 0.15)
		
		task.wait(0.3)
		modal:Destroy()
		overlay:Destroy()
	end
	
	return control
end

-- ============================================
-- IMAGE PREVIEW - SHOW FULL IMAGE
-- ============================================
function RayfieldModalAdult:ShowImage(data)
	local screenGui = GetScreenGui()
	local theme = self.CurrentTheme
	self.ModalCount = self.ModalCount + 1
	
	-- Load image from URL if provided
	local imageAsset = ""
	if data.ImageURL then
		imageAsset = LoadImageFromURL(data.ImageURL, "preview")
	elseif data.Image then
		imageAsset = data.Image
	end
	
	local width = data.Width or 500
	local height = data.Height or 500
	
	local overlay = Create("Frame", {
		Name = "Overlay",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 1,
		Active = false,
		Parent = screenGui
	})
	
	Tween(overlay, {BackgroundTransparency = 0.5}, 0.3)
	
	-- Image container
	local container = Create("Frame", {
		Name = "ImageContainer",
		Size = UDim2.new(0, width, 0, height),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(15, 15, 15),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 10,
		Parent = screenGui
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 15),
		Parent = container
	})
	
	-- Image
	local imageLabel = Create("ImageLabel", {
		Name = "Image",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Image = imageAsset,
		ScaleType = Enum.ScaleType.Crop,
		ImageTransparency = 1,
		ZIndex = 11,
		Parent = container
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 15),
		Parent = imageLabel
	})
	
	-- Title (optional)
	if data.Title then
		local titleBar = Create("Frame", {
			Name = "TitleBar",
			Size = UDim2.new(1, 0, 0, 40),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = container
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 15),
			Parent = titleBar
		})
		
		Create("TextLabel", {
			Name = "Title",
			Size = UDim2.new(1, -50, 1, 0),
			Position = UDim2.new(0, 15, 0, 0),
			BackgroundTransparency = 1,
			Text = data.Title,
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 16,
			Font = Enum.Font.GothamBold,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 13,
			Parent = titleBar
		})
		
		-- Close button
		local closeBtn = Create("TextButton", {
			Name = "Close",
			Size = UDim2.new(0, 30, 0, 30),
			Position = UDim2.new(1, -35, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 70, 70),
			BackgroundTransparency = 0.3,
			Text = "",
			ZIndex = 13,
			Parent = titleBar
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 8),
			Parent = closeBtn
		})
		
		closeBtn.MouseButton1Click:Connect(function()
			Tween(container, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(imageLabel, {ImageTransparency = 1}, 0.15)
			
			task.wait(0.3)
			container:Destroy()
			overlay:Destroy()
		end)
	end
	
	-- Animate in
	container.Size = UDim2.new(0, width, 0, 0)
	Tween(container, {Size = UDim2.new(0, width, 0, height)}, 0.4, Enum.EasingStyle.Back)
	Tween(imageLabel, {ImageTransparency = 0}, 0.3)
	
	-- Auto close
	if data.Duration then
		task.spawn(function()
			task.wait(data.Duration)
			if container and container.Parent then
				Tween(container, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
				Tween(overlay, {BackgroundTransparency = 1}, 0.2)
				Tween(imageLabel, {ImageTransparency = 1}, 0.15)
				
				task.wait(0.3)
				container:Destroy()
				overlay:Destroy()
			end
		end)
	end
	
	return container
end

return RayfieldModalAdult
