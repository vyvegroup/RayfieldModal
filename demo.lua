--[[
	
	Rayfield Modal Demo Script
	Showcasing all modal types
	
	Load with:
	loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/demo.lua"))()
	
]]--

-- Load RayfieldModal Library
local RayfieldModal = loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/source.lua"))()

print("=== Rayfield Modal Demo Started ===")

-- Set theme (available: Default, Ocean, AmberGlow, Light, Amethyst, DarkBlue)
RayfieldModal:SetTheme("Default")

task.wait(1)

-- ============================================
-- DEMO 1: Notify - Modal Notification
-- ============================================
print("[1] Showing Notify modal...")
RayfieldModal:Notify({
	Title = "Welcome to RayfieldModal!",
	Content = "This is a centered modal notification. It will auto-close in 5 seconds. Click outside or the X button to close manually.",
	Duration = 5,
	Image = "rbxassetid://3926305904"
})

task.wait(6)

-- ============================================
-- DEMO 2: Confirm - Yes/No Dialog
-- ============================================
print("[2] Showing Confirm modal...")
RayfieldModal:Confirm({
	Title = "Enable Feature?",
	Content = "Do you want to enable Auto Farm? This will automatically collect resources in the game.",
	YesText = "Enable",
	NoText = "Cancel",
	Callback = function(result)
		if result then
			print("[2] User clicked YES - Feature enabled")
			RayfieldModal:Notify({
				Title = "Feature Enabled",
				Content = "Auto Farm has been successfully enabled!",
				Duration = 3
			})
		else
			print("[2] User clicked NO - Feature not enabled")
		end
	end
})

task.wait(5)

-- ============================================
-- DEMO 3: Console - Code Display
-- ============================================
print("[3] Showing Console modal...")
RayfieldModal:Console({
	Title = "Script Output",
	Content = [[-- RayfieldModal Example Script
-- Version 1.0.0

local RayfieldModal = loadstring(game:HttpGet("URL"))()

-- Set theme
RayfieldModal:SetTheme("Default")

-- Show notification
RayfieldModal:Notify({
    Title = "Hello!",
    Content = "Welcome to RayfieldModal",
    Duration = 5
})

-- Confirm dialog
RayfieldModal:Confirm({
    Title = "Confirm",
    Content = "Are you sure?",
    Callback = function(result)
        if result then
            print("Confirmed!")
        end
    end
})

-- Console output
RayfieldModal:Console({
    Title = "Results",
    Content = "Script executed successfully!",
    Language = "lua"
})

-- Input prompt
RayfieldModal:Prompt({
    Title = "Enter Name",
    Placeholder = "Your name...",
    Callback = function(text)
        print("Hello, " .. tostring(text))
    end
})]],
	Language = "lua",
	Width = 520,
	Height = 380
})

task.wait(7)

-- ============================================
-- DEMO 4: Prompt - Input Dialog
-- ============================================
print("[4] Showing Prompt modal...")
RayfieldModal:Prompt({
	Title = "Enter Settings",
	Content = "Please enter your preferred speed value (1-100):",
	Placeholder = "Enter number...",
	Default = "50",
	Callback = function(text)
		if text and text ~= "" then
			print("[4] User entered:", text)
			RayfieldModal:Notify({
				Title = "Settings Saved",
				Content = "Speed value set to: " .. text,
				Duration = 3
			})
		else
			print("[4] User cancelled or entered nothing")
		end
	end
})

task.wait(7)

-- ============================================
-- DEMO 5: Alert - Simple Dialog
-- ============================================
print("[5] Showing Alert modal...")
RayfieldModal:Alert({
	Title = "Important Notice",
	Content = "This script has been updated to version 2.0! Check the changelog for new features and improvements.",
	ButtonText = "Got it!",
	Callback = function()
		print("[5] Alert dismissed")
	end
})

task.wait(5)

-- ============================================
-- DEMO 6: Loading - Progress Dialog
-- ============================================
print("[6] Showing Loading modal...")
local loading = RayfieldModal:Loading({
	Title = "Initializing",
	Content = "Starting up..."
})

task.wait(1)
loading:Update("Loading configuration...")
task.wait(1)
loading:Update("Connecting to server...")
task.wait(1)
loading:Update("Downloading assets...")
task.wait(1)
loading:Update("Almost ready...")
task.wait(0.5)
loading:Close()

print("[6] Loading complete!")

task.wait(1)

-- ============================================
-- DEMO 7: Theme Showcase
-- ============================================
print("[7] Showing theme examples...")

local themes = {"Ocean", "AmberGlow", "Light", "Amethyst", "DarkBlue"}

for i, themeName in ipairs(themes) do
	RayfieldModal:SetTheme(themeName)
	RayfieldModal:Notify({
		Title = themeName .. " Theme",
		Content = "This is how the " .. themeName .. " theme looks. It has unique colors and styling.",
		Duration = 2
	})
	task.wait(3)
end

-- Reset to Default theme
RayfieldModal:SetTheme("Default")

-- ============================================
-- DEMO 8: Interactive Demo
-- ============================================
print("[8] Interactive demo...")
RayfieldModal:Confirm({
	Title = "Try More Features?",
	Content = "Would you like to see the console output of this demo?",
	YesText = "Show Console",
	NoText = "Finish",
	Callback = function(result)
		if result then
			RayfieldModal:Console({
				Title = "Demo Output Log",
				Content = [[=== RayfieldModal Demo Log ===

[1] Notify modal - SUCCESS
    - Displayed centered notification
    - Auto-closed after duration

[2] Confirm modal - SUCCESS
    - Yes/No dialog displayed
    - Callback function executed

[3] Console modal - SUCCESS
    - Code display with syntax highlighting
    - Copy button functional
    - Scrollable content

[4] Prompt modal - SUCCESS
    - Input field captured user text
    - Callback returned entered value

[5] Alert modal - SUCCESS
    - Simple OK dialog
    - Dismissed on button click

[6] Loading modal - SUCCESS
    - Progress updates displayed
    - Close method worked correctly

[7] Theme showcase - SUCCESS
    - Ocean theme applied
    - AmberGlow theme applied
    - Light theme applied
    - Amethyst theme applied
    - DarkBlue theme applied

[8] Interactive demo - SUCCESS
    - User engagement captured
    - Final console output displayed

=== All Demos Complete! ===]],
				Language = "text",
				Width = 450,
				Height = 400
			})
		end
	end
})

task.wait(3)

-- Final notification
RayfieldModal:Notify({
	Title = "Demo Complete!",
	Content = "Thank you for trying RayfieldModal! Check out the documentation for more features.",
	Duration = 5
})

print("=== Rayfield Modal Demo Complete ===")
