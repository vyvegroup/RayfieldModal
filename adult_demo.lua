--[[
	
	Rayfield Modal Adult - Demo Script
	⚠️ 18+ VERSION - Rayfield Style UI
	
]]--

print("=== Rayfield Modal Adult Demo ===")
print("Loading library...")

-- Load Library
local success, RayfieldModal = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/adult_source.lua"))()
end)

if not success or not RayfieldModal then
    warn("Failed to load RayfieldModal!")
    return
end

print("✓ Library loaded successfully!")

-- Check executor capabilities
print("\n--- Executor Capabilities ---")
print("writefile:", writefile ~= nil)
print("readfile:", readfile ~= nil)
print("getcustomasset:", getcustomasset ~= nil)
print("getsynasset:", getsynasset ~= nil)
print("makefolder:", makefolder ~= nil)
print("isfolder:", isfolder ~= nil)
print("gethui:", gethui ~= nil)
print("-----------------------------\n")

-- Preload themes
print("[*] Preloading theme images...")
RayfieldModal:PreloadThemes()

task.wait(1)

-- Test 1: PinkPassion Theme
print("[1] Testing PinkPassion Theme...")
RayfieldModal:SetTheme("PinkPassion")

RayfieldModal:Notify({
    Title = "Pink Passion Theme",
    Content = "This is the Pink Passion theme with NSFW background. Check if image appears!",
    Duration = 5
})

task.wait(6)

-- Test 2: MidnightDesires Theme
print("[2] Testing MidnightDesires Theme...")
RayfieldModal:SetTheme("MidnightDesires")

RayfieldModal:Confirm({
    Title = "Midnight Desires",
    Content = "This is the Midnight Desires theme. Do you see the background image?",
    YesText = "Yes, I see it!",
    NoText = "No image :(",
    Callback = function(result)
        if result then
            print("[2] User can see the image!")
        else
            print("[2] User cannot see the image - need to check executor")
        end
    end
})

task.wait(6)

-- Test 3: Console with Image Background
print("[3] Testing Console modal...")
RayfieldModal:SetTheme("PinkPassion")

RayfieldModal:Console({
    Title = "Script Console",
    Content = [[-- RayfieldModal Adult Edition
-- Rayfield Style UI

local RayfieldModal = loadstring(game:HttpGet("URL"))()

-- Available Themes:
-- PinkPassion - Pink aesthetic
-- MidnightDesires - Dark purple
-- DarkSeduction - Warm orange
-- OceanFantasy - Cool cyan
-- PurpleHaze - Mystical purple

-- Set theme
RayfieldModal:SetTheme("PinkPassion")

-- Or custom image URL
RayfieldModal:SetCustomImage("YOUR_IMAGE_URL")]],
    Language = "lua",
    Width = 500,
    Height = 350
})

task.wait(7)

-- Test 4: Image Preview (Direct Image Show)
print("[4] Testing direct image preview...")
RayfieldModal:ShowImage({
    Title = "Direct Image Preview",
    ImageURL = "https://api-cdn.rule34.xxx/images/2198/20c7a55d5d03d0143ad13effebb9bb7e.jpeg",
    Width = 500,
    Height = 500,
    Duration = 5
})

task.wait(6)

-- Test 5: Different Themes
print("[5] Testing all themes...")

local themes = {"DarkSeduction", "OceanFantasy", "PurpleHaze"}

for _, themeName in ipairs(themes) do
    RayfieldModal:SetTheme(themeName)
    
    RayfieldModal:Notify({
        Title = themeName,
        Content = "Testing " .. themeName .. " theme. Check for background image!",
        Duration = 2
    })
    
    task.wait(3)
end

-- Final
RayfieldModal:SetTheme("PinkPassion")

RayfieldModal:Notify({
    Title = "Demo Complete!",
    Content = "If you see background images, everything works! If not, your executor may not support getcustomasset.",
    Duration = 6
})

print("=== Demo Complete ===")
print("\nIf images are not showing:")
print("1. Check if your executor supports 'getcustomasset'")
print("2. Check if 'writefile' works")
print("3. Some executors need 'getsynasset' instead")
