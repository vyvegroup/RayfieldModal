--[[
	
	Rayfield Modal Adult - Demo Script
	⚠️ 18+ VERSION
	
	Load with:
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/adult_demo.lua"))()
	
]]--

print("=== Rayfield Modal Adult Demo Started ===")

-- Load RayfieldModal Adult Library
local RayfieldModal = loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/adult_source.lua"))()

-- ============================================
-- PRELOAD ALL THEMES (Recommended)
-- ============================================
print("[*] Preloading theme images...")
RayfieldModal:PreloadThemes()

task.wait(1)

-- ============================================
-- DEMO 1: PINK PASSION THEME
-- ============================================
print("[1] Testing PinkPassion Theme...")
RayfieldModal:SetTheme("PinkPassion")

RayfieldModal:Notify({
	Title = "Welcome to Adult Version!",
	Content = "This is RayfieldModal Adult Edition with beautiful background themes. Enjoy the premium experience!",
	Duration = 5
})

task.wait(6)

-- ============================================
-- DEMO 2: MIDNIGHT DESIRES THEME
-- ============================================
print("[2] Testing MidnightDesires Theme...")
RayfieldModal:SetTheme("MidnightDesires")

RayfieldModal:Confirm({
	Title = "Enable Premium Features?",
	Content = "Would you like to unlock all premium features? This includes custom themes, priority support, and exclusive content.",
	YesText = "Unlock",
	NoText = "Maybe Later",
	Callback = function(result)
		if result then
			print("[2] User enabled premium features")
			RayfieldModal:Notify({
				Title = "Premium Activated!",
				Content = "All features are now unlocked. Thank you for your support!",
				Duration = 4
			})
		end
	end
})

task.wait(6)

-- ============================================
-- DEMO 3: CONSOLE WITH IMAGE BACKGROUND
-- ============================================
print("[3] Testing Console modal...")
RayfieldModal:SetTheme("PinkPassion")

RayfieldModal:Console({
	Title = "Script Output",
	Content = [[-- RayfieldModal Adult Edition
-- Premium Script Template

local RayfieldModal = loadstring(game:HttpGet("URL"))()

-- Set your favorite theme
RayfieldModal:SetTheme("PinkPassion")
-- Or: SetTheme("MidnightDesires")
-- Or: SetTheme("DarkSeduction")

-- Premium Features:
-- ✓ Custom Image Backgrounds
-- ✓ Non-blocking UI
-- ✓ Smooth Animations
-- ✓ Theme Caching
-- ✓ Multiple Themes

-- Example Usage:
RayfieldModal:Notify({
    Title = "Premium Notice",
    Content = "Welcome to the premium experience!",
    Duration = 5
})

print("Script loaded successfully!")]],
	Language = "lua",
	Width = 520,
	Height = 400
})

task.wait(8)

-- ============================================
-- DEMO 4: INPUT PROMPT
-- ============================================
print("[4] Testing Prompt modal...")
RayfieldModal:SetTheme("MidnightDesires")

RayfieldModal:Prompt({
	Title = "Enter Settings",
	Content = "Enter your preferred value (1-100):",
	Placeholder = "Enter number...",
	Default = "69",
	Callback = function(text)
		if text and text ~= "" then
			print("[4] User entered:", text)
			RayfieldModal:Notify({
				Title = "Settings Saved",
				Content = "Your value has been set to: " .. text,
				Duration = 3
			})
		end
	end
})

task.wait(7)

-- ============================================
-- DEMO 5: ALERT DIALOG
-- ============================================
print("[5] Testing Alert modal...")
RayfieldModal:SetTheme("DarkSeduction")

RayfieldModal:Alert({
	Title = "Important Notice",
	Content = "This is the Adult Edition of RayfieldModal. All themes feature premium background images loaded from external sources.",
	ButtonText = "I Understand",
	Callback = function()
		print("[5] Alert dismissed")
	end
})

task.wait(5)

-- ============================================
-- DEMO 6: LOADING DIALOG
-- ============================================
print("[6] Testing Loading modal...")
RayfieldModal:SetTheme("PinkPassion")

local loading = RayfieldModal:Loading({
	Title = "Processing",
	Content = "Initializing premium features..."
})

task.wait(1)
loading:Update("Loading custom themes...")
task.wait(1)
loading:Update("Applying background images...")
task.wait(1)
loading:Update("Almost ready...")
task.wait(0.5)
loading:Close()

print("[6] Loading complete!")

task.wait(1)

-- ============================================
-- DEMO 7: THEME SHOWCASE
-- ============================================
print("[7] Showcasing all themes...")

local themes = {
	{ name = "PinkPassion", desc = "Beautiful pink aesthetic" },
	{ name = "MidnightDesires", desc = "Dark and mysterious" },
	{ name = "DarkSeduction", desc = "Warm and intense" },
	{ name = "OceanFantasy", desc = "Cool and refreshing" },
	{ name = "PurpleHaze", desc = "Mystical purple vibes" }
}

for i, theme in ipairs(themes) do
	RayfieldModal:SetTheme(theme.name)
	
	RayfieldModal:Notify({
		Title = theme.name,
		Content = theme.desc .. " - Theme " .. i .. "/" .. #themes,
		Duration = 2.5
	})
	
	task.wait(3.5)
end

-- ============================================
-- DEMO 8: CUSTOM IMAGE THEME
-- ============================================
print("[8] Testing Custom Image Theme...")

RayfieldModal:SetCustomImage("https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg")

RayfieldModal:Confirm({
	Title = "Custom Theme Loaded!",
	Content = "This modal uses a custom image URL as the background. You can set any image URL as your theme!",
	YesText = "Awesome!",
	NoText = "Close",
	Callback = function(result)
		if result then
			print("[8] User approved custom theme")
		end
	end
})

task.wait(5)

-- ============================================
-- DEMO 9: FULLSCREEN IMAGE PREVIEW
-- ============================================
print("[9] Testing Image Preview...")

RayfieldModal:ShowImage({
	Title = "Premium Artwork",
	ImageURL = "https://rule34.porn/media/2024/06/Naked-Girl-by-Nat-the-LichOriginal.webp",
	Width = 550,
	Height = 550,
	Duration = 6
})

task.wait(7)

-- ============================================
-- DEMO COMPLETE
-- ============================================
RayfieldModal:SetTheme("PinkPassion")

RayfieldModal:Notify({
	Title = "Demo Complete!",
	Content = "Thank you for trying RayfieldModal Adult Edition! All themes and features are now available for your scripts.",
	Duration = 6
})

print("=== Rayfield Modal Adult Demo Complete ===")
print("Available Themes:")
print("  - PinkPassion")
print("  - MidnightDesires")
print("  - DarkSeduction")
print("  - OceanFantasy")
print("  - PurpleHaze")
print("  - Custom (use SetCustomImage)")
