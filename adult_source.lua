--[[
	
	Rayfield Modal Library - ADULT VERSION
	Matching Original Rayfield UI Style
	
	⚠️ 18+ VERSION - Adult Themes with External Image Assets
	
]]--

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

-- ============================================
-- RAYFIELD STYLE THEME (From Original Rayfield)
-- ============================================
local Theme = {
	TextColor = Color3.fromRGB(240, 240, 240),
	Background = Color3.fromRGB(25, 25, 25),
	Topbar = Color3.fromRGB(34, 34, 34),
	Shadow = Color3.fromRGB(20, 20, 20),
	NotificationBackground = Color3.fromRGB(20, 20, 20),
	ElementBackground = Color3.fromRGB(35, 35, 35),
	ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
	ElementStroke = Color3.fromRGB(50, 50, 50),
	Accent = Color3.fromRGB(0, 146, 214),
	SliderBackground = Color3.fromRGB(50, 138, 220),
	ToggleEnabled = Color3.fromRGB(0, 146, 214),
	InputBackground = Color3.fromRGB(30, 30, 30),
	InputStroke = Color3.fromRGB(65, 65, 65),
}

-- ============================================
-- IMAGE LOADER - MULTIPLE METHODS
-- ============================================
local ImageCache = {}
local LoadedImages = {}

-- Method 1: getcustomasset (best for most executors)
local function loadImageMethod1(url, name)
	local success, result = pcall(function()
		local content = game:HttpGet(url)
		if content and #content > 0 then
			local filename = "RayfieldModal_" .. name .. ".jpg"
			if writefile then
				writefile(filename, content)
			end
			if getcustomasset then
				return getcustomasset(filename)
			end
		end
		return nil
	end)
	return success and result or nil
end

-- Method 2: Direct asset loading (some executors)
local function loadImageMethod2(url, name)
	local success, result = pcall(function()
		local content = game:HttpGet(url)
		if content and #content > 0 then
			local filename = "RayfieldModal_" .. name .. ".png"
			if writefile then
				writefile(filename, content)
			end
			if getsynasset then
				return getsynasset(filename)
			end
		end
		return nil
	end)
	return success and result or nil
end

-- Method 3: Custom asset with folder
local function loadImageMethod3(url, name)
	local success, result = pcall(function()
		local content = game:HttpGet(url)
		if content and #content > 0 then
			local folder = "RayfieldModal"
			local filename = folder .. "/" .. name .. ".jpg"
			
			if isfolder and not isfolder(folder) then
				if makefolder then makefolder(folder) end
			end
			
			if writefile then
				writefile(filename, content)
			end
			
			if getcustomasset then
				return getcustomasset(filename)
			end
		end
		return nil
	end)
	return success and result or nil
end

-- Main Image Loader with all fallbacks
local function LoadImageFromURL(url, name)
	if not url or url == "" then return nil end
	
	-- Check cache
	if ImageCache[url] then
		return ImageCache[url]
	end
	
	local asset = nil
	
	-- Try all methods
	asset = loadImageMethod1(url, name)
	if asset and asset ~= "" then
		ImageCache[url] = asset
		LoadedImages[name] = asset
		return asset
	end
	
	asset = loadImageMethod2(url, name)
	if asset and asset ~= "" then
		ImageCache[url] = asset
		LoadedImages[name] = asset
		return asset
	end
	
	asset = loadImageMethod3(url, name)
	if asset and asset ~= "" then
		ImageCache[url] = asset
		LoadedImages[name] = asset
		return asset
	end
	
	return nil
end

-- ============================================
-- ADULT THEMES
-- ============================================
local AdultThemes = {
	PinkPassion = {
		Name = "Pink Passion",
		ImageURL = "https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg",
		Accent = Color3.fromRGB(255, 105, 180),
	},
	MidnightDesires = {
		Name = "Midnight Desires",
		ImageURL = "https://rule34.porn/media/2024/06/Naked-Girl-by-Nat-the-LichOriginal.webp",
		Accent = Color3.fromRGB(147, 112, 219),
	},
	DarkSeduction = {
		Name = "Dark Seduction",
		ImageURL = "https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg",
		Accent = Color3.fromRGB(255, 69, 0),
	},
	OceanFantasy = {
		Name = "Ocean Fantasy",
		ImageURL = "https://rule34.porn/media/2024/06/Naked-Girl-by-Nat-the-LichOriginal.webp",
		Accent = Color3.fromRGB(0, 206, 209),
	},
	PurpleHaze = {
		Name = "Purple Haze",
		ImageURL = "https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg",
		Accent = Color3.fromRGB(186, 85, 211),
	},
	Custom = {
		Name = "Custom",
		ImageURL = "",
		Accent = Color3.fromRGB(0, 146, 214),
	},
}

-- ============================================
-- MAIN LIBRARY
-- ============================================
local RayfieldModalAdult = {
	Themes = AdultThemes,
	CurrentTheme = AdultThemes.PinkPassion,
	CurrentImageAsset = nil,
	ModalCount = 0,
}

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================
local function Create(instance, properties)
	local obj = Instance.new(instance)
	for prop, value in pairs(properties) do
		pcall(function() obj[prop] = value end)
	end
	return obj
end

local function Tween(obj, props, duration, style, direction)
	pcall(function()
		local tweenInfo = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out)
		local tween = TweenService:Create(obj, tweenInfo, props)
		tween:Play()
	end)
end

local function GetScreenGui()
	local screenGui
	
	-- Try gethui first
	pcall(function()
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
		end
	end)
	
	-- Fallback to CoreGui
	if not screenGui then
		pcall(function()
			screenGui = CoreGui:FindFirstChild("RayfieldModalAdultUI")
			if not screenGui then
				screenGui = Create("ScreenGui", {
					Name = "RayfieldModalAdultUI",
					IgnoreGuiInset = true,
					ResetOnSpawn = false,
					ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
					DisplayOrder = 1000
				})
				-- Try syn.protect_gui
				pcall(function()
					if syn and syn.protect_gui then
						syn.protect_gui(screenGui)
					end
				end)
				screenGui.Parent = CoreGui
			end
		end)
	end
	
	return screenGui
end

-- ============================================
-- THEME MANAGEMENT
-- ============================================
function RayfieldModalAdult:SetTheme(themeName, customURL)
	pcall(function()
		if self.Themes[themeName] then
			self.CurrentTheme = self.Themes[themeName]
			
			if themeName == "Custom" and customURL then
				self.CurrentTheme.ImageURL = customURL
			end
			
			-- Update accent color
			if self.CurrentTheme.Accent then
				Theme.Accent = self.CurrentTheme.Accent
			end
			
			-- Load image
			if self.CurrentTheme.ImageURL and self.CurrentTheme.ImageURL ~= "" then
				self.CurrentImageAsset = LoadImageFromURL(self.CurrentTheme.ImageURL, themeName)
			else
				self.CurrentImageAsset = nil
			end
		end
	end)
end

function RayfieldModalAdult:SetCustomImage(url)
	self:SetTheme("Custom", url)
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
-- CREATE OVERLAY - RAYFIELD STYLE
-- ============================================
local function CreateOverlay(parent)
	local overlay = Create("Frame", {
		Name = "Overlay",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 1,
		Active = false,
		Parent = parent
	})
	
	Tween(overlay, {BackgroundTransparency = 0.5}, 0.3)
	
	return overlay
end

-- ============================================
-- CREATE MODAL BASE - RAYFIELD STYLE
-- ============================================
local function CreateModalBase(parent, title, width, height, imageAsset)
	local modal = Create("Frame", {
		Name = "Modal",
		Size = UDim2.new(0, width, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		ZIndex = 10,
		Parent = parent
	})
	
	-- Corner radius (Rayfield style)
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = modal
	})
	
	-- Stroke (Rayfield style)
	Create("UIStroke", {
		Color = Theme.ElementStroke,
		Thickness = 1,
		Parent = modal
	})
	
	-- Shadow (Rayfield style)
	local shadow = Create("ImageLabel", {
		Name = "Shadow",
		Size = UDim2.new(1, 30, 1, 30),
		Position = UDim2.new(0, -15, 0, -15),
		BackgroundTransparency = 1,
		Image = "rbxassetid://6014261993",
		ImageColor3 = Theme.Shadow,
		ImageTransparency = 0.82,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
		ZIndex = 9,
		Parent = modal
	})
	
	-- Background Image (if available)
	local bgImage = nil
	if imageAsset and imageAsset ~= "" then
		bgImage = Create("ImageLabel", {
			Name = "BackgroundImage",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Image = imageAsset,
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = 0.4,
			ZIndex = 11,
			Parent = modal
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = bgImage})
		
		-- Dark overlay for text readability
		local darkOverlay = Create("Frame", {
			Name = "DarkOverlay",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			ZIndex = 12,
			Parent = modal
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = darkOverlay})
	end
	
	-- Topbar (Rayfield style)
	local topbar = Create("Frame", {
		Name = "Topbar",
		Size = UDim2.new(1, 0, 0, 45),
		BackgroundColor3 = Theme.Topbar,
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = modal
	})
	
	Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = topbar})
	
	-- Fix bottom corners of topbar
	Create("Frame", {
		Name = "CornerFix",
		Size = UDim2.new(1, 0, 0, 15),
		Position = UDim2.new(0, 0, 1, -5),
		BackgroundColor3 = Theme.Topbar,
		BorderSizePixel = 0,
		ZIndex = 14,
		Parent = topbar
	})
	
	-- Title (Rayfield style)
	local titleLabel = Create("TextLabel", {
		Name = "Title",
		Size = UDim2.new(1, -50, 1, 0),
		Position = UDim2.new(0, 15, 0, 0),
		BackgroundTransparency = 1,
		Text = title or "Modal",
		TextColor3 = Theme.TextColor,
		TextSize = 16,
		Font = Enum.Font.GothamSemibold,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 16,
		Parent = topbar
	})
	
	-- Close button (Rayfield style)
	local closeBtn = Create("TextButton", {
		Name = "Close",
		Size = UDim2.new(0, 30, 0, 30),
		Position = UDim2.new(1, -38, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 16,
		Parent = topbar
	})
	
	local closeIcon = Create("ImageLabel", {
		Name = "Icon",
		Size = UDim2.new(0, 16, 0, 16),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3926305904",
		ImageRectSize = Vector2.new(48, 48),
		ImageRectOffset = Vector2.new(288, 288),
		ImageColor3 = Theme.TextColor,
		ImageTransparency = 0.3,
		ZIndex = 17,
		Parent = closeBtn
	})
	
	-- Initial state
	shadow.ImageTransparency = 1
	titleLabel.TextTransparency = 1
	closeBtn.Visible = false
	modal.BackgroundTransparency = 1
	topbar.BackgroundTransparency = 1
	if bgImage then bgImage.ImageTransparency = 1 end
	
	task.wait()
	
	-- Animate in (Rayfield style)
	Tween(modal, {BackgroundTransparency = 0}, 0.2)
	Tween(topbar, {BackgroundTransparency = 0}, 0.2)
	Tween(titleLabel, {TextTransparency = 0}, 0.2)
	Tween(shadow, {ImageTransparency = 0.82}, 0.3)
	Tween(modal, {Size = UDim2.new(0, width, 0, height)}, 0.3, Enum.EasingStyle.Back)
	if bgImage then Tween(bgImage, {ImageTransparency = 0.4}, 0.3) end
	
	task.wait(0.15)
	closeBtn.Visible = true
	
	return modal, topbar, titleLabel, closeBtn, shadow, bgImage
end

-- ============================================
-- NOTIFY - RAYFIELD STYLE
-- ============================================
function RayfieldModalAdult:Notify(data)
	pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		self.ModalCount = self.ModalCount + 1
		local width = 380
		local height = 140
		
		local overlay = CreateOverlay(screenGui)
		local modal, topbar, titleLabel, closeBtn, shadow, bgImage = CreateModalBase(screenGui, data.Title or "Notification", width, height, self.CurrentImageAsset)
		
		-- Content container
		local content = Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, -30, 1, -60),
			Position = UDim2.new(0, 15, 0, 50),
			BackgroundTransparency = 1,
			ZIndex = 15,
			Parent = modal
		})
		
		-- Icon (Rayfield style)
		local iconSize = 0
		if data.Image then
			local icon = Create("ImageLabel", {
				Name = "Icon",
				Size = UDim2.new(0, 40, 0, 40),
				Position = UDim2.new(0, 0, 0, 10),
				BackgroundTransparency = 1,
				Image = type(data.Image) == "number" and "rbxassetid://" .. data.Image or data.Image,
				ImageColor3 = Theme.Accent,
				ZIndex = 16,
				Parent = content
			})
			iconSize = 50
		end
		
		-- Description (Rayfield style)
		local descLabel = Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, -iconSize - 10, 1, -20),
			Position = UDim2.new(0, iconSize, 0, 10),
			BackgroundTransparency = 1,
			Text = data.Content or "",
			TextColor3 = Theme.TextColor,
			TextSize = 14,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			ZIndex = 16,
			Parent = content
		})
		descLabel.TextTransparency = 1
		Tween(descLabel, {TextTransparency = 0}, 0.2)
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			Tween(topbar, {BackgroundTransparency = 1}, 0.2)
			Tween(shadow, {ImageTransparency = 1}, 0.15)
			Tween(descLabel, {TextTransparency = 1}, 0.15)
			Tween(titleLabel, {TextTransparency = 1}, 0.15)
			if bgImage then Tween(bgImage, {ImageTransparency = 1}, 0.15) end
			
			task.wait(0.25)
			modal:Destroy()
			overlay:Destroy()
		end
		
		closeBtn.MouseButton1Click:Connect(closeModal)
		
		-- Auto close
		task.spawn(function()
			task.wait(data.Duration or 4)
			if modal and modal.Parent then
				closeModal()
			end
		end)
	end)
end

-- ============================================
-- CONFIRM - RAYFIELD STYLE
-- ============================================
function RayfieldModalAdult:Confirm(data)
	pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		self.ModalCount = self.ModalCount + 1
		local width = 380
		local height = 160
		
		local overlay = CreateOverlay(screenGui)
		local modal, topbar, titleLabel, closeBtn, shadow, bgImage = CreateModalBase(screenGui, data.Title or "Confirm", width, height, self.CurrentImageAsset)
		
		-- Content
		local content = Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, -30, 1, -105),
			Position = UDim2.new(0, 15, 0, 50),
			BackgroundTransparency = 1,
			ZIndex = 15,
			Parent = modal
		})
		
		-- Description
		local descLabel = Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = data.Content or "Are you sure?",
			TextColor3 = Theme.TextColor,
			TextSize = 14,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			ZIndex = 16,
			Parent = content
		})
		descLabel.TextTransparency = 1
		Tween(descLabel, {TextTransparency = 0}, 0.2)
		
		-- Buttons container
		local btnContainer = Create("Frame", {
			Name = "Buttons",
			Size = UDim2.new(1, -30, 0, 36),
			Position = UDim2.new(0, 15, 1, -50),
			BackgroundTransparency = 1,
			ZIndex = 15,
			Parent = modal
		})
		
		-- No button (Rayfield style)
		local noBtn = Create("TextButton", {
			Name = "No",
			Size = UDim2.new(0.5, -5, 1, 0),
			BackgroundColor3 = Theme.ElementBackground,
			BorderSizePixel = 0,
			Text = data.NoText or "No",
			TextColor3 = Theme.TextColor,
			TextSize = 13,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = btnContainer
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = noBtn})
		Create("UIStroke", {Color = Theme.ElementStroke, Thickness = 1, Parent = noBtn})
		
		-- Yes button (Rayfield style)
		local yesBtn = Create("TextButton", {
			Name = "Yes",
			Size = UDim2.new(0.5, -5, 1, 0),
			Position = UDim2.new(0.5, 5, 0, 0),
			BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0,
			Text = data.YesText or "Yes",
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 13,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = btnContainer
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = yesBtn})
		
		-- Hover effects
		noBtn.MouseEnter:Connect(function() Tween(noBtn, {BackgroundColor3 = Theme.ElementBackgroundHover}, 0.15) end)
		noBtn.MouseLeave:Connect(function() Tween(noBtn, {BackgroundColor3 = Theme.ElementBackground}, 0.15) end)
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			Tween(topbar, {BackgroundTransparency = 1}, 0.2)
			Tween(shadow, {ImageTransparency = 1}, 0.15)
			Tween(descLabel, {TextTransparency = 1}, 0.15)
			Tween(titleLabel, {TextTransparency = 1}, 0.15)
			if bgImage then Tween(bgImage, {ImageTransparency = 1}, 0.15) end
			
			task.wait(0.25)
			modal:Destroy()
			overlay:Destroy()
		end
		
		noBtn.MouseButton1Click:Connect(function()
			closeModal()
			if data.Callback then pcall(data.Callback, false) end
		end)
		
		yesBtn.MouseButton1Click:Connect(function()
			closeModal()
			if data.Callback then pcall(data.Callback, true) end
		end)
		
		closeBtn.MouseButton1Click:Connect(function()
			closeModal()
			if data.Callback then pcall(data.Callback, false) end
		end)
	end)
end

-- ============================================
-- CONSOLE - RAYFIELD STYLE
-- ============================================
function RayfieldModalAdult:Console(data)
	pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		self.ModalCount = self.ModalCount + 1
		local width = data.Width or 550
		local height = data.Height or 400
		
		local overlay = CreateOverlay(screenGui)
		local modal, topbar, titleLabel, closeBtn, shadow, bgImage = CreateModalBase(screenGui, data.Title or "Console", width, height, self.CurrentImageAsset)
		
		-- Console container (Rayfield style)
		local consoleFrame = Create("Frame", {
			Name = "ConsoleFrame",
			Size = UDim2.new(1, -20, 1, -60),
			Position = UDim2.new(0, 10, 0, 50),
			BackgroundColor3 = Color3.fromRGB(18, 18, 18),
			BorderSizePixel = 0,
			ZIndex = 15,
			Parent = modal
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = consoleFrame})
		Create("UIStroke", {Color = Theme.ElementStroke, Thickness = 1, Parent = consoleFrame})
		
		-- Scrolling frame
		local scrollingFrame = Create("ScrollingFrame", {
			Name = "ScrollingFrame",
			Size = UDim2.new(1, -10, 1, -50),
			Position = UDim2.new(0, 5, 0, 5),
			BackgroundTransparency = 1,
			ScrollBarThickness = 6,
			ScrollBarImageColor3 = Theme.Accent,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ZIndex = 16,
			Parent = consoleFrame
		})
		
		-- Code text
		local codeText = Create("TextLabel", {
			Name = "Code",
			Size = UDim2.new(1, -10, 1, 0),
			Position = UDim2.new(0, 5, 0, 5),
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
				Size = UDim2.new(0, 60, 0, 22),
				Position = UDim2.new(1, -70, 0, 8),
				BackgroundColor3 = Theme.Accent,
				BorderSizePixel = 0,
				ZIndex = 18,
				Parent = modal
			})
			Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = langBadge})
			Create("TextLabel", {
				Name = "Lang",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = string.upper(data.Language),
				TextColor3 = Color3.new(1, 1, 1),
				TextSize = 10,
				Font = Enum.Font.GothamBold,
				ZIndex = 19,
				Parent = langBadge
			})
		end
		
		-- Copy button (Rayfield style)
		local copyBtn = Create("TextButton", {
			Name = "Copy",
			Size = UDim2.new(0, 80, 0, 28),
			Position = UDim2.new(0, 10, 1, -38),
			BackgroundColor3 = Theme.ElementBackground,
			BorderSizePixel = 0,
			Text = "Copy",
			TextColor3 = Theme.TextColor,
			TextSize = 12,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = modal
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = copyBtn})
		Create("UIStroke", {Color = Theme.ElementStroke, Thickness = 1, Parent = copyBtn})
		
		-- Close button (Rayfield style)
		local closeBtnBottom = Create("TextButton", {
			Name = "CloseBtn",
			Size = UDim2.new(0, 80, 0, 28),
			Position = UDim2.new(1, -90, 1, -38),
			BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0,
			Text = "Close",
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 12,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = modal
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = closeBtnBottom})
		
		Tween(codeText, {TextTransparency = 0}, 0.2)
		
		-- Copy function
		copyBtn.MouseButton1Click:Connect(function()
			if setclipboard then
				pcall(function()
					setclipboard(data.Content or "")
					copyBtn.Text = "Copied!"
					copyBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
					task.wait(1)
					copyBtn.Text = "Copy"
					copyBtn.BackgroundColor3 = Theme.ElementBackground
				end)
			end
		end)
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			Tween(shadow, {ImageTransparency = 1}, 0.15)
			Tween(codeText, {TextTransparency = 1}, 0.15)
			Tween(titleLabel, {TextTransparency = 1}, 0.15)
			if bgImage then Tween(bgImage, {ImageTransparency = 1}, 0.15) end
			
			task.wait(0.25)
			modal:Destroy()
			overlay:Destroy()
		end
		
		closeBtnBottom.MouseButton1Click:Connect(closeModal)
		closeBtn.MouseButton1Click:Connect(closeModal)
	end)
end

-- ============================================
-- PROMPT - RAYFIELD STYLE
-- ============================================
function RayfieldModalAdult:Prompt(data)
	pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		self.ModalCount = self.ModalCount + 1
		local width = 380
		local height = 175
		
		local overlay = CreateOverlay(screenGui)
		local modal, topbar, titleLabel, closeBtn, shadow, bgImage = CreateModalBase(screenGui, data.Title or "Input", width, height, self.CurrentImageAsset)
		
		-- Content
		local content = Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, -30, 1, -105),
			Position = UDim2.new(0, 15, 0, 50),
			BackgroundTransparency = 1,
			ZIndex = 15,
			Parent = modal
		})
		
		-- Description
		local yOffset = 0
		if data.Content then
			local descLabel = Create("TextLabel", {
				Name = "Description",
				Size = UDim2.new(1, 0, 0, 20),
				BackgroundTransparency = 1,
				Text = data.Content,
				TextColor3 = Theme.TextColor,
				TextSize = 13,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true,
				ZIndex = 16,
				Parent = content
			})
			descLabel.TextTransparency = 1
			Tween(descLabel, {TextTransparency = 0}, 0.2)
			yOffset = 28
		end
		
		-- Input box (Rayfield style)
		local inputBox = Create("TextBox", {
			Name = "Input",
			Size = UDim2.new(1, 0, 0, 38),
			Position = UDim2.new(0, 0, 0, yOffset),
			BackgroundColor3 = Theme.InputBackground,
			BorderSizePixel = 0,
			Text = data.Default or "",
			PlaceholderText = data.Placeholder or "Enter text...",
			PlaceholderColor3 = Color3.fromRGB(178, 178, 178),
			TextColor3 = Theme.TextColor,
			TextSize = 14,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 16,
			Parent = content
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = inputBox})
		Create("UIStroke", {Color = Theme.InputStroke, Thickness = 1, Parent = inputBox})
		Create("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = inputBox})
		
		-- Buttons container
		local btnContainer = Create("Frame", {
			Name = "Buttons",
			Size = UDim2.new(1, -30, 0, 36),
			Position = UDim2.new(0, 15, 1, -50),
			BackgroundTransparency = 1,
			ZIndex = 15,
			Parent = modal
		})
		
		-- Cancel button (Rayfield style)
		local cancelBtn = Create("TextButton", {
			Name = "Cancel",
			Size = UDim2.new(0.5, -5, 1, 0),
			BackgroundColor3 = Theme.ElementBackground,
			BorderSizePixel = 0,
			Text = "Cancel",
			TextColor3 = Theme.TextColor,
			TextSize = 13,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = btnContainer
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = cancelBtn})
		Create("UIStroke", {Color = Theme.ElementStroke, Thickness = 1, Parent = cancelBtn})
		
		-- Confirm button (Rayfield style)
		local confirmBtn = Create("TextButton", {
			Name = "Confirm",
			Size = UDim2.new(0.5, -5, 1, 0),
			Position = UDim2.new(0.5, 5, 0, 0),
			BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0,
			Text = "Confirm",
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 13,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = btnContainer
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = confirmBtn})
		
		-- Hover effects
		cancelBtn.MouseEnter:Connect(function() Tween(cancelBtn, {BackgroundColor3 = Theme.ElementBackgroundHover}, 0.15) end)
		cancelBtn.MouseLeave:Connect(function() Tween(cancelBtn, {BackgroundColor3 = Theme.ElementBackground}, 0.15) end)
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			Tween(shadow, {ImageTransparency = 1}, 0.15)
			Tween(titleLabel, {TextTransparency = 1}, 0.15)
			if bgImage then Tween(bgImage, {ImageTransparency = 1}, 0.15) end
			
			task.wait(0.25)
			modal:Destroy()
			overlay:Destroy()
		end
		
		cancelBtn.MouseButton1Click:Connect(function()
			closeModal()
			if data.Callback then pcall(data.Callback, nil) end
		end)
		
		confirmBtn.MouseButton1Click:Connect(function()
			closeModal()
			if data.Callback then pcall(data.Callback, inputBox.Text) end
		end)
		
		closeBtn.MouseButton1Click:Connect(function()
			closeModal()
			if data.Callback then pcall(data.Callback, nil) end
		end)
		
		-- Enter key
		inputBox.FocusLost:Connect(function(enterPressed)
			if enterPressed then
				closeModal()
				if data.Callback then pcall(data.Callback, inputBox.Text) end
			end
		end)
		
		-- Auto focus
		task.wait(0.2)
		inputBox:CaptureFocus()
	end)
end

-- ============================================
-- ALERT - RAYFIELD STYLE
-- ============================================
function RayfieldModalAdult:Alert(data)
	pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		self.ModalCount = self.ModalCount + 1
		local width = 380
		local height = 160
		
		local overlay = CreateOverlay(screenGui)
		local modal, topbar, titleLabel, closeBtn, shadow, bgImage = CreateModalBase(screenGui, data.Title or "Alert", width, height, self.CurrentImageAsset)
		
		-- Content
		local content = Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, -30, 1, -100),
			Position = UDim2.new(0, 15, 0, 50),
			BackgroundTransparency = 1,
			ZIndex = 15,
			Parent = modal
		})
		
		-- Description
		local descLabel = Create("TextLabel", {
			Name = "Description",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = data.Content or "",
			TextColor3 = Theme.TextColor,
			TextSize = 14,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			ZIndex = 16,
			Parent = content
		})
		descLabel.TextTransparency = 1
		Tween(descLabel, {TextTransparency = 0}, 0.2)
		
		-- OK button (Rayfield style)
		local okBtn = Create("TextButton", {
			Name = "OK",
			Size = UDim2.new(0, 120, 0, 36),
			Position = UDim2.new(0.5, -60, 1, -50),
			BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0,
			Text = data.ButtonText or "OK",
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 13,
			Font = Enum.Font.GothamSemibold,
			ZIndex = 16,
			Parent = modal
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = okBtn})
		
		-- Close function
		local function closeModal()
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			Tween(shadow, {ImageTransparency = 1}, 0.15)
			Tween(descLabel, {TextTransparency = 1}, 0.15)
			Tween(titleLabel, {TextTransparency = 1}, 0.15)
			if bgImage then Tween(bgImage, {ImageTransparency = 1}, 0.15) end
			
			task.wait(0.25)
			modal:Destroy()
			overlay:Destroy()
			if data.Callback then pcall(data.Callback) end
		end
		
		okBtn.MouseButton1Click:Connect(closeModal)
		closeBtn.MouseButton1Click:Connect(closeModal)
	end)
end

-- ============================================
-- LOADING - RAYFIELD STYLE
-- ============================================
function RayfieldModalAdult:Loading(data)
	local result = {Update = function() end, Close = function() end}
	
	pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		self.ModalCount = self.ModalCount + 1
		local width = 300
		local height = 130
		
		local overlay = CreateOverlay(screenGui)
		local modal, topbar, titleLabel, closeBtn, shadow, bgImage = CreateModalBase(screenGui, data.Title or "Loading", width, height, self.CurrentImageAsset)
		closeBtn.Visible = false
		
		-- Content
		local content = Create("Frame", {
			Name = "Content",
			Size = UDim2.new(1, -30, 1, -60),
			Position = UDim2.new(0, 15, 0, 50),
			BackgroundTransparency = 1,
			ZIndex = 15,
			Parent = modal
		})
		
		-- Spinner
		local spinner = Create("ImageLabel", {
			Name = "Spinner",
			Size = UDim2.new(0, 32, 0, 32),
			Position = UDim2.new(0.5, 0, 0, 10),
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Image = "rbxassetid://6014261993",
			ImageColor3 = Theme.Accent,
			ZIndex = 16,
			Parent = content
		})
		
		-- Status text
		local statusLabel = Create("TextLabel", {
			Name = "Status",
			Size = UDim2.new(1, 0, 0, 30),
			Position = UDim2.new(0, 0, 0, 50),
			BackgroundTransparency = 1,
			Text = data.Content or "Please wait...",
			TextColor3 = Theme.TextColor,
			TextSize = 14,
			Font = Enum.Font.Gotham,
			ZIndex = 16,
			Parent = content
		})
		statusLabel.TextTransparency = 1
		Tween(statusLabel, {TextTransparency = 0}, 0.2)
		
		-- Spinner rotation
		local rotation = 0
		local connection
		connection = RunService.Heartbeat:Connect(function()
			rotation = rotation + 5
			spinner.Rotation = rotation
		end)
		
		-- Control object
		result.Update = function(text)
			if statusLabel then statusLabel.Text = text end
		end
		
		result.Close = function()
			if connection then connection:Disconnect() end
			Tween(modal, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
			Tween(overlay, {BackgroundTransparency = 1}, 0.2)
			Tween(modal, {BackgroundTransparency = 1}, 0.2)
			Tween(shadow, {ImageTransparency = 1}, 0.15)
			Tween(statusLabel, {TextTransparency = 1}, 0.15)
			Tween(titleLabel, {TextTransparency = 1}, 0.15)
			if bgImage then Tween(bgImage, {ImageTransparency = 1}, 0.15) end
			
			task.wait(0.25)
			if modal then modal:Destroy() end
			if overlay then overlay:Destroy() end
		end
	end)
	
	return result
end

-- ============================================
-- IMAGE PREVIEW
-- ============================================
function RayfieldModalAdult:ShowImage(data)
	pcall(function()
		local screenGui = GetScreenGui()
		if not screenGui then return end
		
		self.ModalCount = self.ModalCount + 1
		
		-- Load image
		local imageAsset = nil
		if data.ImageURL then
			imageAsset = LoadImageFromURL(data.ImageURL, "preview")
		elseif data.Image then
			imageAsset = data.Image
		end
		
		local width = data.Width or 500
		local height = data.Height or 500
		
		local overlay = CreateOverlay(screenGui)
		
		-- Container
		local container = Create("Frame", {
			Name = "ImageContainer",
			Size = UDim2.new(0, width, 0, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme.Background,
			BorderSizePixel = 0,
			ZIndex = 10,
			Parent = screenGui
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = container})
		Create("UIStroke", {Color = Theme.ElementStroke, Thickness = 1, Parent = container})
		
		-- Shadow
		local shadow = Create("ImageLabel", {
			Name = "Shadow",
			Size = UDim2.new(1, 30, 1, 30),
			Position = UDim2.new(0, -15, 0, -15),
			BackgroundTransparency = 1,
			Image = "rbxassetid://6014261993",
			ImageColor3 = Theme.Shadow,
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(49, 49, 450, 450),
			ZIndex = 9,
			Parent = container
		})
		
		-- Image
		local imageLabel = Create("ImageLabel", {
			Name = "Image",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Image = imageAsset or "",
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = 1,
			ZIndex = 11,
			Parent = container
		})
		Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = imageLabel})
		
		-- Title bar (optional)
		local titleBar = nil
		if data.Title then
			titleBar = Create("Frame", {
				Name = "TitleBar",
				Size = UDim2.new(1, 0, 0, 45),
				BackgroundColor3 = Theme.Topbar,
				BorderSizePixel = 0,
				ZIndex = 12,
				Parent = container
			})
			Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = titleBar})
			
			Create("TextLabel", {
				Name = "Title",
				Size = UDim2.new(1, -50, 1, 0),
				Position = UDim2.new(0, 15, 0, 0),
				BackgroundTransparency = 1,
				Text = data.Title,
				TextColor3 = Theme.TextColor,
				TextSize = 16,
				Font = Enum.Font.GothamSemibold,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 13,
				Parent = titleBar
			})
			
			-- Close button
			local closeBtn = Create("TextButton", {
				Name = "Close",
				Size = UDim2.new(0, 30, 0, 30),
				Position = UDim2.new(1, -38, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Text = "",
				ZIndex = 13,
				Parent = titleBar
			})
			
			Create("ImageLabel", {
				Name = "Icon",
				Size = UDim2.new(0, 16, 0, 16),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://3926305904",
				ImageRectSize = Vector2.new(48, 48),
				ImageRectOffset = Vector2.new(288, 288),
				ImageColor3 = Theme.TextColor,
				ZIndex = 14,
				Parent = closeBtn
			})
			
			closeBtn.MouseButton1Click:Connect(function()
				Tween(container, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
				Tween(overlay, {BackgroundTransparency = 1}, 0.2)
				Tween(imageLabel, {ImageTransparency = 1}, 0.15)
				Tween(shadow, {ImageTransparency = 1}, 0.15)
				
				task.wait(0.25)
				container:Destroy()
				overlay:Destroy()
			end)
		end
		
		-- Animate in
		Tween(container, {Size = UDim2.new(0, width, 0, height)}, 0.3, Enum.EasingStyle.Back)
		Tween(imageLabel, {ImageTransparency = 0}, 0.3)
		Tween(shadow, {ImageTransparency = 0.82}, 0.3)
		
		-- Auto close
		if data.Duration then
			task.spawn(function()
				task.wait(data.Duration)
				if container and container.Parent then
					Tween(container, {Size = UDim2.new(0, width, 0, 0)}, 0.2, Enum.EasingStyle.Back)
					Tween(overlay, {BackgroundTransparency = 1}, 0.2)
					Tween(imageLabel, {ImageTransparency = 1}, 0.15)
					Tween(shadow, {ImageTransparency = 1}, 0.15)
					
					task.wait(0.25)
					container:Destroy()
					overlay:Destroy()
				end
			end)
		end
	end)
end

return RayfieldModalAdult
