# Rayfield Modal Library

<p align="center">
  <b>A beautiful modal UI library for Roblox - Notifications, Console, Confirm Dialogs & more!</b>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#api-reference">API Reference</a> •
  <a href="#themes">Themes</a>
</p>

---

## Features

- 🎨 **Modal Notifications** - Center-screen notifications with auto-close
- 💻 **Console Display** - Show code/output with copy functionality
- ✅ **Confirm Dialogs** - Yes/No dialogs with callbacks
- 📝 **Input Prompts** - Get user input with validation
- ⚠️ **Alert Dialogs** - Simple OK dialogs
- ⏳ **Loading Dialogs** - Progress indicators with updates
- 🎭 **6 Beautiful Themes** - Default, Ocean, AmberGlow, Light, Amethyst, DarkBlue
- 📱 **Mobile Support** - Works on all devices
- 🔧 **loadstring Ready** - Easy to use with `game:HttpGet`

---

## Installation

### Quick Start

```lua
local RayfieldModal = loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/source.lua"))()
```

### Run Demo

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/demo.lua"))()
```

---

## Usage

### Set Theme

```lua
-- Available themes: Default, Ocean, AmberGlow, Light, Amethyst, DarkBlue
RayfieldModal:SetTheme("Ocean")
```

### Notify

```lua
RayfieldModal:Notify({
    Title = "Success!",
    Content = "Operation completed successfully.",
    Duration = 5,
    Image = "rbxassetid://3926305904"
})
```

### Confirm (Yes/No)

```lua
RayfieldModal:Confirm({
    Title = "Delete File?",
    Content = "This action cannot be undone.",
    YesText = "Delete",
    NoText = "Cancel",
    Callback = function(result)
        if result then
            print("User confirmed!")
        else
            print("User cancelled!")
        end
    end
})
```

### Console/Code Display

```lua
RayfieldModal:Console({
    Title = "Script Output",
    Content = "print('Hello World!')",
    Language = "lua",
    Width = 500,
    Height = 350
})
```

### Input Prompt

```lua
RayfieldModal:Prompt({
    Title = "Enter Name",
    Content = "Please enter your name:",
    Placeholder = "Your name...",
    Default = "",
    Callback = function(text)
        if text then
            print("User entered:", text)
        end
    end
})
```

### Alert

```lua
RayfieldModal:Alert({
    Title = "Notice",
    Content = "This is an important message!",
    ButtonText = "Got it!",
    Callback = function()
        print("Alert dismissed")
    end
})
```

### Loading

```lua
local loading = RayfieldModal:Loading({
    Title = "Loading",
    Content = "Initializing..."
})

-- Update progress
loading:Update("Loading assets...")
task.wait(1)
loading:Update("Almost done...")
task.wait(1)

-- Close when done
loading:Close()
```

---

## API Reference

### Notify

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| Title | string | No | "Notification" | Modal title |
| Content | string | No | "" | Message content |
| Duration | number | No | 4 | Auto-close time (seconds) |
| Image | string/number | No | nil | Icon (rbxassetid or number) |

### Confirm

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| Title | string | No | "Confirm" | Modal title |
| Content | string | No | "Are you sure?" | Question text |
| YesText | string | No | "Yes" | Yes button text |
| NoText | string | No | "No" | No button text |
| Callback | function | No | nil | `function(result: boolean)` |

### Console

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| Title | string | No | "Console" | Modal title |
| Content | string | No | "" | Code/text content |
| Language | string | No | nil | Language badge (lua, python, etc.) |
| Width | number | No | 550 | Modal width |
| Height | number | No | 400 | Modal height |

### Prompt

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| Title | string | No | "Input" | Modal title |
| Content | string | No | nil | Description text |
| Placeholder | string | No | "Enter text..." | Input placeholder |
| Default | string | No | "" | Default input value |
| Callback | function | No | nil | `function(text: string\|nil)` |

### Alert

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| Title | string | No | "Alert" | Modal title |
| Content | string | No | "" | Alert message |
| ButtonText | string | No | "OK" | Button text |
| Callback | function | No | nil | `function()` |

### Loading

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| Title | string | No | "Loading" | Modal title |
| Content | string | No | "Please wait..." | Status text |

**Methods:**
- `loading:Update(text)` - Update status text
- `loading:Close()` - Close the loading modal

---

## Themes

| Theme | Description |
|-------|-------------|
| **Default** | Dark theme with blue accent |
| **Ocean** | Teal/cyan color scheme |
| **AmberGlow** | Warm orange/amber colors |
| **Light** | Light theme for bright environments |
| **Amethyst** | Purple color scheme |
| **DarkBlue** | Deep blue theme |

---

## Example Script

```lua
-- Load library
local RayfieldModal = loadstring(game:HttpGet("https://raw.githubusercontent.com/vyvegroup/RayfieldModal/main/source.lua"))()

-- Set theme
RayfieldModal:SetTheme("Default")

-- Ask user confirmation
RayfieldModal:Confirm({
    Title = "Enable Auto Farm?",
    Content = "Do you want to enable automatic resource collection?",
    YesText = "Enable",
    NoText = "Cancel",
    Callback = function(result)
        if result then
            -- Show loading
            local loading = RayfieldModal:Loading({
                Title = "Initializing",
                Content = "Setting up auto farm..."
            })
            
            task.wait(2)
            loading:Update("Loading configuration...")
            task.wait(1)
            loading:Close()
            
            -- Show success
            RayfieldModal:Notify({
                Title = "Auto Farm Enabled!",
                Content = "Script is now running automatically.",
                Duration = 5
            })
        end
    end
})
```

---

## Credits

- UI Design inspired by [Rayfield Interface Suite](https://github.com/SiriusSoftwareLtd/Rayfield) by Sirius
- Developed as an extension for Rayfield

## License

MIT License - Free to use and modify
