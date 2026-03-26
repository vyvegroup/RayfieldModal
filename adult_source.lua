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
	- Full Error Handling with pcall
	
]]--

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

-- ============================================
-- SAFE FUNCTION WRAPPERS
-- ============================================
local SafeFunctions = {}

-- Safe writefile
function SafeFunctions.writefile(filename, content)
	local success, err = pcall(function()
		if writefile then
			writefile(filename, content)
			return true
		end
		return false
	end)
	return success
end

-- Safe readfile
function SafeFunctions.readfile(filename)
	local success, result = pcall(function()
		if readfile then
			return readfile(filename)
		end
		return nil
	end)
	if success then return result else return nil end
end

-- Safe getcustomasset
function SafeFunctions.getcustomasset(filename)
	local success, result = pcall(function()
		if getcustomasset then
			return getcustomasset(filename)
		end
		return ""
	end)
	if success then return result else return "" end
end

-- Safe HttpGet
function SafeFunctions.httpGet(url)
	local success, result = pcall(function()
		return game:HttpGet(url)
	end)
	if success then 
		return result 
	else 
		return nil, result 
	end
end

-- Safe gethui
function SafeFunctions.gethui()
	local success, result = pcall(function()
		if gethui then
			return gethui()
		end
		return nil
	end)
	if success then return result else return nil end
end

-- Safe syn.protect_gui
function SafeFunctions.protectGui(gui)
	local success = pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(gui)
		end
	end)
	return success
end

-- ============================================
-- IMAGE LOADER SYSTEM
-- ============================================
local ImageCache = {}

local function LoadImageFromURL(url, cacheName)
	-- Check cache first
	if ImageCache[url] then
		return ImageCache[url]
	end
	
	-- Generate filename
	local fileName = "RayfieldModal_" .. (cacheName or "cache") .. ".jpg"
	
	-- Try to load from URL
	local content, err = SafeFunctions.httpGet(url)
	
	if content and #content > 0 then
		-- Write to file
		SafeFunctions.writefile(fileName, content)
		
		-- Get custom asset
		local asset = SafeFunctions.getcustomasset(fileName)
		
		-- Cache the result
		if asset and asset ~= "" then
			ImageCache[url] = asset
		end
		
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
		ButtonBackgroundHover = Color3.fromRGB(50, 20, 60),
		OverlayColor = Color3.fromRGB(20, 0, 30),
		OverlayTransparency = 0.55,
		GlowColor = Color3.fromRGB(186, 85, 211),
	},
	
	-- Theme: Custom (User Provided URL)
	Custom = {
		Name = "Custom",
		ImageURL = "",
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
	local success, obj = pcall(function()
		local o = Instance.new(instance)
		for prop, value in pairs(properties) do
			pcall(function()
				o[prop] = value
			end)
		end
		return o
	end)
	return success and obj or nil
end

local function Tween(obj, props, duration, style, direction)
	if not obj then return nil end
	
	local success, tween = pcall(function()
		local tweenInfo = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out)
		local t = TweenService:Create(obj, tweenInfo, props)
		t:Play()
		return t
	end)
	return success and tween or nil
end

local function GetScreenGui()
	local screenGui
	
	-- Try gethui first
	local hui = SafeFunctions.gethui()
	if hui then
		screenGui = hui:FindFirstChild("RayfieldModalAdultUI")
		if not screenGui then
			screenGui = Create("ScreenGui", {
				Name = "RayfieldModalAdultUI",
				IgnoreGuiInset = true,
				ResetOnSpawn = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				DisplayOrder = 1000
			})
			if screenGui then
				screenGui.Parent = hui
			end
		end
	else
		-- Try syn.protect_gui
		screenGui = CoreGui:FindFirstChild("RayfieldModalAdultUI")
		if not screenGui then
			screenGui = Create("ScreenGui", {
				Name = "RayfieldModalAdultUI",
				IgnoreGuiInset = true,
				ResetOnSpawn = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				DisplayOrder = 1000
			})
			if screenGui then
				SafeFunctions.protectGui(screenGui)
				screenGui.Parent = CoreGui
			end
		end
	end
	
	return screenGui
end

-- ============================================
-- THEME MANAGEMENT
-- ============================================
function RayfieldModalAdult:SetTheme(themeName, customImageURL)
	local success, err = pcall(function()
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
	end)
	
	if not success then
		warn("RayfieldModal: Error setting theme: " .. tostring(err))
	end
end

function RayfieldModalAdult:SetCustomImage(imageURL)
	self:SetTheme("Custom", imageURL)
end

function RayfieldModalAdult:PreloadThemes()
	pcall(function()
		for themeName, theme in pairs(self.Themes) do
			if theme.ImageURL and theme.ImageURL ~= "" then
				task.spawn(function()
					LoadImageFromURL(theme.ImageURL, themeName)
				end)
			end
		end
	end)
end

-- ============================================
-- CREATE OVERLAY WITH BACKGROUND IMAGE
-- ============================================
local function CreateOverlay(parent, theme, imageAsset)
	if not parent then return nil end
	
	-- Main overlay container (non-blocking)
	local overlay = Create("Frame", {
		Name = "Overlay",
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = theme.OverlayColor,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 1,
		Active = false,
		Parent = parent
	})
	
	if not overlay then return nil end
	
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
		
		if bgImage then
			Create("UICorner", {CornerRadius = UDim.new(0, 0), Parent = bgImage})
		end
		
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
	if not parent then return nil end
	
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
		Active = true,
		Parent = parent
	})
	
	if not modal then return nil end
	
	-- Corner radius
	Create("UICorner", {CornerRadius = UDim.new(0, 20), Parent = modal})
	
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
		
		if bgImage then
			Create("UICorner", {CornerRadius = UDim.new(0, 20), Parent = bgImage})
		end
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
	
	if darkOverlay then
		Create("UICorner", {CornerRadius = UDim.new(0, 20), Parent = darkOverlay})
	end
	
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
	
	if topbar then
		Create("UICorner", {CornerRadius = UDim.new(0, 20), Parent = topbar})
		
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
	end
	
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
	
	if titleLabel and theme.TextStrokeTransparency then
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
	
	if closeBtn then
		Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = closeBtn})
		
		Create("ImageLabel", {
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
	end
	
	-- Initial animation state
	if modal then
		modal.Size = UDim2.new(0, width or 400, 0, 0)
		modal.BackgroundTransparency = 1
	end
	if topbar then topbar.BackgroundTransparency = 1 end
	if titleLabel then titleLabel.TextTransparency = 1 end
	if closeBtn then closeBtn.Visible = false end
	if glow then glow.ImageTransparency = 1 end
	if stroke then stroke.Transparency = 1 end
	
	task.wait()
	
	-- Animate in
	Tween(modal, {BackgroundTransparency = 0}, 0.2)
	Tween(topbar, {BackgroundTransparency = 0.5}, 0.2)
	Tween(titleLabel, {TextTransparency = 0}, 0.2)
	Tween(glow, {ImageTransparency = 0.5}, 0.4)
	Tween(stroke, {Transparency = 0}, 0.3)
	Tween(modal, {Size = UDim2.new(0, width or 400, 0, height or 200)}, 0.4, Enum.EasingStyle.Back)
	
	task.wait(0.15)
	if closeBtn then closeBtn.Visible = true end
	
	return modal, topbar, titleLabel, closeBtn, glow, stroke
end

-- ============================================
-- NOTIFY - MODAL NOTIFICATION
-- ============================================
function RayfieldModalAdult:Notify(data)
	local success, err = pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		local theme = self.CurrentTheme
		self.ModalCount = self.ModalCount + 1
		
		local width = 420
		local height = 180
		
		local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
		if not overlay then return end
		
		local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Notification", width, height, theme, self.CurrentImageAsset)
		if not modal then
			overlay:Destroy()
			return
		end
		
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
			if icon then iconSize = 60 end
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
		
		if descLabel then
			descLabel.TextTransparency = 1
			Create("UIStroke", {
				Color = theme.TextStrokeColor,
				Thickness = 1.5,
				Transparency = theme.TextStrokeTransparency,
				Parent = descLabel
			})
			Tween(descLabel, {TextTransparency = 0}, 0.2)
		end
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			if topbar then Tween(topbar, {BackgroundTransparency = 1}, 0.2) end
			if glow then Tween(glow, {ImageTransparency = 1}, 0.2) end
			if descLabel then Tween(descLabel, {TextTransparency = 1}, 0.15) end
			if titleLabel then Tween(titleLabel, {TextTransparency = 1}, 0.15) end
			
			task.wait(0.3)
			if modal then modal:Destroy() end
			if overlay then overlay:Destroy() end
		end
		
		if closeBtn then
			closeBtn.MouseButton1Click:Connect(closeModal)
		end
		
		-- Auto close
		task.spawn(function()
			local duration = data.Duration or 5
			task.wait(duration)
			if modal and modal.Parent then
				closeModal()
			end
		end)
		
		return modal
	end)
	
	if not success then
		warn("RayfieldModal Notify Error: " .. tostring(err))
	end
end

-- ============================================
-- CONFIRM - YES/NO DIALOG
-- ============================================
function RayfieldModalAdult:Confirm(data)
	local success, err = pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		local theme = self.CurrentTheme
		self.ModalCount = self.ModalCount + 1
		
		local width = 420
		local height = 200
		
		local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
		if not overlay then return end
		
		local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Confirm", width, height, theme, self.CurrentImageAsset)
		if not modal then
			overlay:Destroy()
			return
		end
		
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
		
		if descLabel then
			descLabel.TextTransparency = 1
			Create("UIStroke", {
				Color = theme.TextStrokeColor,
				Thickness = 1.5,
				Transparency = theme.TextStrokeTransparency,
				Parent = descLabel
			})
			Tween(descLabel, {TextTransparency = 0}, 0.2)
		end
		
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
		
		if noBtn then
			Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = noBtn})
			Create("UIStroke", {Color = Color3.fromRGB(100, 100, 100), Thickness = 1, Transparency = 0.5, Parent = noBtn})
		end
		
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
		
		if yesBtn then
			Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = yesBtn})
		end
		
		-- Hover effects
		if noBtn then
			noBtn.MouseEnter:Connect(function() Tween(noBtn, {BackgroundTransparency = 0.1}, 0.15) end)
			noBtn.MouseLeave:Connect(function() Tween(noBtn, {BackgroundTransparency = 0.3}, 0.15) end)
		end
		if yesBtn then
			yesBtn.MouseEnter:Connect(function() Tween(yesBtn, {BackgroundColor3 = theme.AccentHover}, 0.15) end)
			yesBtn.MouseLeave:Connect(function() Tween(yesBtn, {BackgroundColor3 = theme.Accent}, 0.15) end)
		end
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			if glow then Tween(glow, {ImageTransparency = 1}, 0.2) end
			if descLabel then Tween(descLabel, {TextTransparency = 1}, 0.15) end
			if titleLabel then Tween(titleLabel, {TextTransparency = 1}, 0.15) end
			
			task.wait(0.3)
			if modal then modal:Destroy() end
			if overlay then overlay:Destroy() end
		end
		
		-- Button callbacks
		if noBtn then
			noBtn.MouseButton1Click:Connect(function()
				closeModal()
				if data.Callback then pcall(data.Callback, false) end
			end)
		end
		
		if yesBtn then
			yesBtn.MouseButton1Click:Connect(function()
				closeModal()
				if data.Callback then pcall(data.Callback, true) end
			end)
		end
		
		if closeBtn then
			closeBtn.MouseButton1Click:Connect(function()
				closeModal()
				if data.Callback then pcall(data.Callback, false) end
			end)
		end
		
		return modal
	end)
	
	if not success then
		warn("RayfieldModal Confirm Error: " .. tostring(err))
	end
end

-- ============================================
-- CONSOLE - CODE DISPLAY
-- ============================================
function RayfieldModalAdult:Console(data)
	local success, err = pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		local theme = self.CurrentTheme
		self.ModalCount = self.ModalCount + 1
		
		local width = data.Width or 550
		local height = data.Height or 400
		
		local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
		if not overlay then return end
		
		local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Console", width, height, theme, self.CurrentImageAsset)
		if not modal then
			overlay:Destroy()
			return
		end
		
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
		
		if consoleFrame then
			Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = consoleFrame})
			Create("UIStroke", {Color = theme.Accent, Thickness = 1, Transparency = 0.5, Parent = consoleFrame})
		end
		
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
		
		if codeText then
			codeText.TextTransparency = 1
		end
		
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
			
			if langBadge then
				Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = langBadge})
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
		end
		
		-- Copy button
		local copyBtn = Create("TextButton", {
			Name = "Copy",
			Size = UDim2.new(0, 90, 0, 32),
			Position = UDim2.new(0, 15, 1, -42),
			BackgroundColor3 = theme.ButtonBackground,
			BackgroundTransparency = 0.3,
			BorderSizePixel = 0,
			Text = "Copy",
			TextColor3 = theme.TextColor,
			TextSize = 12,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = modal
		})
		
		if copyBtn then
			Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = copyBtn})
		end
		
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
		
		if closeBtnBottom then
			Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = closeBtnBottom})
		end
		
		Tween(codeText, {TextTransparency = 0}, 0.2)
		
		-- Copy function
		if copyBtn then
			copyBtn.MouseButton1Click:Connect(function()
				if setclipboard then
					pcall(function()
						setclipboard(data.Content or "")
						copyBtn.Text = "Copied!"
						copyBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
						task.wait(1)
						copyBtn.Text = "Copy"
						copyBtn.BackgroundColor3 = theme.ButtonBackground
					end)
				end
			end)
		end
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			if glow then Tween(glow, {ImageTransparency = 1}, 0.2) end
			if codeText then Tween(codeText, {TextTransparency = 1}, 0.15) end
			if titleLabel then Tween(titleLabel, {TextTransparency = 1}, 0.15) end
			
			task.wait(0.3)
			if modal then modal:Destroy() end
			if overlay then overlay:Destroy() end
		end
		
		if closeBtnBottom then
			closeBtnBottom.MouseButton1Click:Connect(closeModal)
		end
		if closeBtn then
			closeBtn.MouseButton1Click:Connect(closeModal)
		end
		
		return modal
	end)
	
	if not success then
		warn("RayfieldModal Console Error: " .. tostring(err))
	end
end

-- ============================================
-- PROMPT - INPUT DIALOG
-- ============================================
function RayfieldModalAdult:Prompt(data)
	local success, err = pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		local theme = self.CurrentTheme
		self.ModalCount = self.ModalCount + 1
		
		local width = 420
		local height = 220
		
		local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
		if not overlay then return end
		
		local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Input", width, height, theme, self.CurrentImageAsset)
		if not modal then
			overlay:Destroy()
			return
		end
		
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
			
			if descLabel then
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
		
		if inputBox then
			Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = inputBox})
			Create("UIStroke", {Color = theme.Accent, Thickness = 1.5, Transparency = 0.3, Parent = inputBox})
			Create("UIPadding", {PaddingLeft = UDim.new(0, 15), PaddingRight = UDim.new(0, 15), Parent = inputBox})
		end
		
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
		
		if cancelBtn then
			Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = cancelBtn})
		end
		
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
		
		if confirmBtn then
			Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = confirmBtn})
		end
		
		-- Hover effects
		if cancelBtn then
			cancelBtn.MouseEnter:Connect(function() Tween(cancelBtn, {BackgroundTransparency = 0.1}, 0.15) end)
			cancelBtn.MouseLeave:Connect(function() Tween(cancelBtn, {BackgroundTransparency = 0.3}, 0.15) end)
		end
		if confirmBtn then
			confirmBtn.MouseEnter:Connect(function() Tween(confirmBtn, {BackgroundColor3 = theme.AccentHover}, 0.15) end)
			confirmBtn.MouseLeave:Connect(function() Tween(confirmBtn, {BackgroundColor3 = theme.Accent}, 0.15) end)
		end
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			if glow then Tween(glow, {ImageTransparency = 1}, 0.2) end
			if titleLabel then Tween(titleLabel, {TextTransparency = 1}, 0.15) end
			
			task.wait(0.3)
			if modal then modal:Destroy() end
			if overlay then overlay:Destroy() end
		end
		
		-- Button callbacks
		if cancelBtn then
			cancelBtn.MouseButton1Click:Connect(function()
				closeModal()
				if data.Callback then pcall(data.Callback, nil) end
			end)
		end
		
		if confirmBtn then
			confirmBtn.MouseButton1Click:Connect(function()
				closeModal()
				if data.Callback then pcall(data.Callback, inputBox and inputBox.Text or nil) end
			end)
		end
		
		if closeBtn then
			closeBtn.MouseButton1Click:Connect(function()
				closeModal()
				if data.Callback then pcall(data.Callback, nil) end
			end)
		end
		
		-- Enter key to confirm
		if inputBox then
			inputBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					closeModal()
					if data.Callback then pcall(data.Callback, inputBox.Text) end
				end
			end)
			
			-- Auto focus
			task.wait(0.25)
			inputBox:CaptureFocus()
		end
		
		return modal
	end)
	
	if not success then
		warn("RayfieldModal Prompt Error: " .. tostring(err))
	end
end

-- ============================================
-- ALERT - SIMPLE DIALOG
-- ============================================
function RayfieldModalAdult:Alert(data)
	local success, err = pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		local theme = self.CurrentTheme
		self.ModalCount = self.ModalCount + 1
		
		local width = 420
		local height = 180
		
		local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
		if not overlay then return end
		
		local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Alert", width, height, theme, self.CurrentImageAsset)
		if not modal then
			overlay:Destroy()
			return
		end
		
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
		
		if descLabel then
			descLabel.TextTransparency = 1
			Create("UIStroke", {
				Color = theme.TextStrokeColor,
				Thickness = 1.5,
				Transparency = theme.TextStrokeTransparency,
				Parent = descLabel
			})
			Tween(descLabel, {TextTransparency = 0}, 0.2)
		end
		
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
		
		if okBtn then
			Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = okBtn})
			okBtn.MouseEnter:Connect(function() Tween(okBtn, {BackgroundColor3 = theme.AccentHover}, 0.15) end)
			okBtn.MouseLeave:Connect(function() Tween(okBtn, {BackgroundColor3 = theme.Accent}, 0.15) end)
		end
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			if glow then Tween(glow, {ImageTransparency = 1}, 0.2) end
			if descLabel then Tween(descLabel, {TextTransparency = 1}, 0.15) end
			if titleLabel then Tween(titleLabel, {TextTransparency = 1}, 0.15) end
			
			task.wait(0.3)
			if modal then modal:Destroy() end
			if overlay then overlay:Destroy() end
			
			if data.Callback then pcall(data.Callback) end
		end
		
		if okBtn then
			okBtn.MouseButton1Click:Connect(closeModal)
		end
		if closeBtn then
			closeBtn.MouseButton1Click:Connect(closeModal)
		end
		
		return modal
	end)
	
	if not success then
		warn("RayfieldModal Alert Error: " .. tostring(err))
	end
end

-- ============================================
-- LOADING - PROGRESS DIALOG
-- ============================================
function RayfieldModalAdult:Loading(data)
	local success, err = pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return {Update = function() end, Close = function() end} end
		
		local theme = self.CurrentTheme
		self.ModalCount = self.ModalCount + 1
		
		local width = 350
		local height = 160
		
		local overlay = CreateOverlay(screenGui, theme, self.CurrentImageAsset)
		if not overlay then return {Update = function() end, Close = function() end} end
		
		local modal, topbar, titleLabel, closeBtn, glow, stroke = CreateModalBase(screenGui, data.Title or "Loading", width, height, theme, self.CurrentImageAsset)
		if not modal then
			overlay:Destroy()
			return {Update = function() end, Close = function() end}
		end
		
		if closeBtn then closeBtn.Visible = false end
		
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
		
		if statusLabel then
			statusLabel.TextTransparency = 1
			Create("UIStroke", {
				Color = theme.TextStrokeColor,
				Thickness = 1,
				Transparency = theme.TextStrokeTransparency,
				Parent = statusLabel
			})
			Tween(statusLabel, {TextTransparency = 0}, 0.2)
		end
		
		-- Spinner rotation
		local rotation = 0
		local connection
		connection = RunService.Heartbeat:Connect(function()
			rotation = rotation + 6
			if spinner then spinner.Rotation = rotation end
		end)
		
		-- Control object
		local control = {}
		
		function control:Update(text)
			if statusLabel then statusLabel.Text = text end
		end
		
		function control:Close()
			if connection then connection:Disconnect() end
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			if glow then Tween(glow, {ImageTransparency = 1}, 0.2) end
			if statusLabel then Tween(statusLabel, {TextTransparency = 1}, 0.15) end
			if titleLabel then Tween(titleLabel, {TextTransparency = 1}, 0.15) end
			
			task.wait(0.3)
			if modal then modal:Destroy() end
			if overlay then overlay:Destroy() end
		end
		
		return control
	end)
	
	if not success then
		warn("RayfieldModal Loading Error: " .. tostring(err))
		return {Update = function() end, Close = function() end}
	end
	
	return success
end

-- ============================================
-- IMAGE PREVIEW - SHOW FULL IMAGE
-- ============================================
function RayfieldModalAdult:ShowImage(data)
	local success, err = pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
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
		
		if container then
			Create("UICorner", {CornerRadius = UDim.new(0, 15), Parent = container})
		end
		
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
		
		if imageLabel then
			Create("UICorner", {CornerRadius = UDim.new(0, 15), Parent = imageLabel})
		end
		
		-- Animate in
		if container then
			container.Size = UDim2.new(0, width, 0, 0)
			Tween(container, {Size = UDim2.new(0, width, 0, height)}, 0.4, Enum.EasingStyle.Back)
		end
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
					if container then container:Destroy() end
					if overlay then overlay:Destroy() end
				end
			end)
		end
		
		return container
	end)
	
	if not success then
		warn("RayfieldModal ShowImage Error: " .. tostring(err))
	end
end

return RayfieldModalAdult
