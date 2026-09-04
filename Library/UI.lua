-- Library/UI.lua - Complete menu system with Goku Black theme
-- Features: PR Nextgen layout with Goku Black style

local UI = {}
UI.__index = UI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- State
local isOpen = false
local elements = {}
local tabs = {}

-- Goku Black Theme Colors (Preserved)
local theme = {
    background = Color3.fromRGB(8, 8, 8),        -- Pure black
    main = Color3.fromRGB(15, 15, 15),           -- Slightly lighter black
    accent = Color3.fromRGB(255, 20, 147),       -- Hot pink
    accentDark = Color3.fromRGB(180, 10, 100),   -- Dark pink
    accentGlow = Color3.fromRGB(255, 0, 128),    -- Pink glow
    font = Color3.fromRGB(255, 255, 255),        -- White
    fontDim = Color3.fromRGB(180, 180, 180),     -- Dim white
    outline = Color3.fromRGB(60, 60, 60),        -- Dark gray
    pinkGradient1 = Color3.fromRGB(255, 20, 147),
    pinkGradient2 = Color3.fromRGB(200, 0, 100),
}

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ObliteratedUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.Parent = game:GetService("CoreGui")

-- Goku Black Background Image
local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Name = "BackgroundImage"
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.Position = UDim2.new(0, 0, 0, 0)
backgroundImage.BackgroundTransparency = 1
backgroundImage.Image = "rbxassetid://15468933003"
backgroundImage.ImageTransparency = 0.88
backgroundImage.ScaleType = Enum.ScaleType.Crop
backgroundImage.Parent = screenGui

-- Main window frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -375, 0.5, -375)
mainFrame.Size = UDim2.new(0, 750, 0, 750)
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Outer glow (pink aura)
local glowFrame = Instance.new("Frame")
glowFrame.Name = "GlowFrame"
glowFrame.BackgroundColor3 = theme.accent
glowFrame.BackgroundTransparency = 0.92
glowFrame.BorderSizePixel = 0
glowFrame.Position = UDim2.new(-0.02, 0, -0.02, 0)
glowFrame.Size = UDim2.new(1.04, 0, 1.04, 0)
glowFrame.Parent = mainFrame

-- Inner frame
local innerFrame = Instance.new("Frame")
innerFrame.Name = "InnerFrame"
innerFrame.BackgroundColor3 = theme.background
innerFrame.BorderColor3 = theme.accent
innerFrame.BorderMode = Enum.BorderMode.Inset
innerFrame.Position = UDim2.new(0.005, 0, 0.005, 0)
innerFrame.Size = UDim2.new(0.99, 0, 0.99, 0)
innerFrame.Parent = mainFrame

-- Top accent bar
local accentBar = Instance.new("Frame")
accentBar.Name = "AccentBar"
accentBar.BackgroundColor3 = theme.accent
accentBar.BorderSizePixel = 0
accentBar.Size = UDim2.new(1, 0, 0, 3)
accentBar.Parent = innerFrame

-- Title bar
local titleFrame = Instance.new("Frame")
titleFrame.Name = "TitleFrame"
titleFrame.BackgroundColor3 = theme.main
titleFrame.BorderSizePixel = 0
titleFrame.Size = UDim2.new(1, 0, 0, 38)
titleFrame.Parent = innerFrame

local titleGlow = Instance.new("Frame")
titleGlow.Name = "TitleGlow"
titleGlow.BackgroundColor3 = theme.accent
titleGlow.BackgroundTransparency = 0.95
titleGlow.BorderSizePixel = 0
titleGlow.Size = UDim2.new(1, 0, 1, 0)
titleGlow.Parent = titleFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.BackgroundTransparency = 1
titleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
titleLabel.Text = "⚔ OBLITERATED ⚔"
titleLabel.TextColor3 = theme.accent
titleLabel.TextSize = 24
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Parent = titleFrame

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
subtitleLabel.Text = "✦ PR Nextgen ✦ Goku Black Edition ✦"
subtitleLabel.TextColor3 = theme.fontDim
subtitleLabel.TextSize = 12
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Right
subtitleLabel.Position = UDim2.new(0, 0, 0, 2)
subtitleLabel.Size = UDim2.new(1, -10, 1, 0)
subtitleLabel.Parent = titleFrame

-- Tab container
local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.BackgroundTransparency = 1
tabContainer.Position = UDim2.new(0, 8, 0, 42)
tabContainer.Size = UDim2.new(1, -16, 1, -50)
tabContainer.Parent = innerFrame

local tabArea = Instance.new("Frame")
tabArea.Name = "TabArea"
tabArea.BackgroundColor3 = theme.main
tabArea.BorderColor3 = theme.outline
tabArea.BorderMode = Enum.BorderMode.Inset
tabArea.Size = UDim2.new(1, 0, 0, 30)
tabArea.Parent = tabContainer

local tabList = Instance.new("UIListLayout")
tabList.FillDirection = Enum.FillDirection.Horizontal
tabList.Padding = UDim.new(0, 2)
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Parent = tabArea

local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.BackgroundColor3 = theme.main
contentArea.BorderColor3 = theme.outline
contentArea.BorderMode = Enum.BorderMode.Inset
contentArea.Position = UDim2.new(0, 0, 0, 34)
contentArea.Size = UDim2.new(1, 0, 1, -34)
contentArea.Parent = tabContainer

-- ===== UI Helper Functions =====

function UI:createTab(name)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = theme.background
    btn.BorderColor3 = theme.accent
    btn.BorderMode = Enum.BorderMode.Inset
    btn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    btn.Text = " " .. name .. " "
    btn.TextColor3 = theme.font
    btn.TextSize = 13
    btn.Size = UDim2.new(0, 95, 1, 0)
    btn.Parent = tabArea
    
    btn.MouseEnter:Connect(function()
        btn.TextColor3 = theme.accent
    end)
    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= theme.accent then
            btn.TextColor3 = theme.font
        end
    end)
    
    local content = Instance.new("ScrollingFrame")
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Size = UDim2.new(1, 0, 1, 0)
    content.Visible = false
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.ScrollBarThickness = 3
    content.Parent = contentArea
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.FillDirection = Enum.FillDirection.Vertical
    contentLayout.Padding = UDim.new(0, 4)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content
    
    local groups = {}
    
    local function addGroupbox(title)
        local groupFrame = Instance.new("Frame")
        groupFrame.BackgroundColor3 = theme.background
        groupFrame.BorderColor3 = theme.outline
        groupFrame.BorderMode = Enum.BorderMode.Inset
        groupFrame.Size = UDim2.new(1, 0, 0, 0)
        groupFrame.Parent = content
        
        local groupInner = Instance.new("Frame")
        groupInner.BackgroundColor3 = theme.background
        groupInner.Size = UDim2.new(1, -2, 1, -2)
        groupInner.Position = UDim2.new(0, 1, 0, 1)
        groupInner.Parent = groupFrame
        
        local groupHeader = Instance.new("Frame")
        groupHeader.BackgroundColor3 = theme.accent
        groupHeader.BorderSizePixel = 0
        groupHeader.Size = UDim2.new(1, 0, 0, 2)
        groupHeader.Parent = groupInner
        
        local groupTitle = Instance.new("TextLabel")
        groupTitle.BackgroundTransparency = 1
        groupTitle.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
        groupTitle.Text = title
        groupTitle.TextColor3 = theme.accent
        groupTitle.TextSize = 13
        groupTitle.TextXAlignment = Enum.TextXAlignment.Left
        groupTitle.Position = UDim2.new(0, 4, 0, 4)
        groupTitle.Size = UDim2.new(1, 0, 0, 18)
        groupTitle.Parent = groupInner
        
        local groupContent = Instance.new("Frame")
        groupContent.BackgroundTransparency = 1
        groupContent.Position = UDim2.new(0, 4, 0, 24)
        groupContent.Size = UDim2.new(1, -4, 1, -24)
        groupContent.Parent = groupInner
        
        local groupLayout = Instance.new("UIListLayout")
        groupLayout.FillDirection = Enum.FillDirection.Vertical
        groupLayout.Padding = UDim.new(0, 2)
        groupLayout.SortOrder = Enum.SortOrder.LayoutOrder
        groupLayout.Parent = groupContent
        
        local function resize()
            local height = 28
            for _, child in ipairs(groupContent:GetChildren()) do
                if child:IsA("Frame") and child.BackgroundTransparency ~= 1 then
                    height = height + child.Size.Y.Offset + 2
                end
            end
            groupFrame.Size = UDim2.new(1, 0, 0, height)
        end
        
        local group = {
            frame = groupFrame,
            content = groupContent,
            layout = groupLayout,
            elements = {},
            addToggle = function(text, default, cb)
                local toggle = UI:createToggle(text, groupContent, cb)
                if default ~= nil then toggle:setValue(default) end
                table.insert(group.elements, toggle)
                resize()
                return toggle
            end,
            addSlider = function(text, min, max, default, suffix, cb)
                local slider = UI:createSlider(text, groupContent, min, max, default, suffix, cb)
                table.insert(group.elements, slider)
                resize()
                return slider
            end,
            addDropdown = function(text, options, default, cb)
                local dropdown = UI:createDropdown(text, groupContent, options, default, cb)
                table.insert(group.elements, dropdown)
                resize()
                return dropdown
            end,
            addColorPicker = function(text, default, cb)
                local picker = UI:createColorPicker(text, groupContent, default, cb)
                table.insert(group.elements, picker)
                resize()
                return picker
            end,
            addLabel = function(text)
                local label = UI:createLabel(text, groupContent)
                table.insert(group.elements, {type = "label", value = label})
                resize()
                return label
            end,
            addButton = function(text, func)
                local btn = UI:createButton(text, groupContent, func)
                table.insert(group.elements, btn)
                resize()
                return btn
            end,
            addDivider = function()
                UI:createDivider(groupContent)
                resize()
            end,
            addBlank = function(size)
                local blank = Instance.new("Frame")
                blank.BackgroundTransparency = 1
                blank.Size = UDim2.new(1, 0, 0, size or 5)
                blank.Parent = groupContent
                resize()
                return blank
            end,
        }
        
        return group
    end
    
    btn.MouseButton1Click:Connect(function()
        for _, tab in ipairs(tabs) do
            tab.content.Visible = false
            tab.btn.BackgroundColor3 = theme.background
            tab.btn.TextColor3 = theme.font
        end
        content.Visible = true
        btn.BackgroundColor3 = theme.accent
        btn.TextColor3 = theme.background
    end)
    
    local tab = {
        btn = btn,
        content = content,
        layout = contentLayout,
        addGroupbox = addGroupbox,
        addLeftGroupbox = addGroupbox,
        addRightGroupbox = addGroupbox,
        addDynamicGroupbox = addGroupbox,
        addTabbox = function(info)
            return {
                addTab = function(name)
                    return {
                        addGroupbox = addGroupbox,
                        addLeftGroupbox = function(title) return addGroupbox(title) end,
                        addRightGroupbox = function(title) return addGroupbox(title) end,
                    }
                end
            }
        end,
        addDynamicTabbox = function(info)
            return {
                addTab = function(name)
                    return {
                        addGroupbox = addGroupbox,
                        addLeftGroupbox = function(title) return addGroupbox(title) end,
                        addRightGroupbox = function(title) return addGroupbox(title) end,
                    }
                end
            }
        end,
    }
    
    table.insert(tabs, tab)
    return tab
end

-- CREATE TOGGLE
function UI:createToggle(text, parent, callback)
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 25)
    frame.Parent = parent
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleFrame.BorderColor3 = theme.outline
    toggleFrame.Size = UDim2.new(0, 20, 0, 20)
    toggleFrame.Parent = frame
    
    local toggleInner = Instance.new("Frame")
    toggleInner.BackgroundColor3 = theme.main
    toggleInner.BorderColor3 = theme.outline
    toggleInner.BorderMode = Enum.BorderMode.Inset
    toggleInner.Size = UDim2.new(1, 0, 1, 0)
    toggleInner.Parent = toggleFrame
    
    local toggleFill = Instance.new("Frame")
    toggleFill.BackgroundColor3 = theme.accent
    toggleFill.BorderColor3 = theme.accent
    toggleFill.Size = UDim2.new(0, 0, 1, 0)
    toggleFill.Parent = toggleInner
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    label.Text = text
    label.TextColor3 = theme.font
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.new(0, 25, 0, 0)
    label.Size = UDim2.new(1, -25, 1, 0)
    label.Parent = frame
    
    local state = false
    
    local function update()
        if state then
            toggleFill.Size = UDim2.new(1, 0, 1, 0)
            toggleInner.BackgroundColor3 = theme.accent
            toggleInner.BorderColor3 = theme.accent
        else
            toggleFill.Size = UDim2.new(0, 0, 1, 0)
            toggleInner.BackgroundColor3 = theme.main
            toggleInner.BorderColor3 = theme.outline
        end
    end
    
    local function setState(newState)
        state = newState
        update()
        if callback then callback(state) end
    end
    
    toggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            setState(not state)
        end
    end)
    
    return {
        setValue = setState,
        getValue = function() return state end,
        toggle = function() setState(not state) end,
    }
end

-- CREATE SLIDER
function UI:createSlider(text, parent, min, max, default, suffix, callback)
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 35)
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    label.Text = text .. ": " .. tostring(default) .. (suffix or "")
    label.TextColor3 = theme.font
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, 0, 0, 18)
    label.Parent = frame
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    sliderFrame.BorderColor3 = theme.outline
    sliderFrame.Position = UDim2.new(0, 0, 0, 20)
    sliderFrame.Size = UDim2.new(1, 0, 0, 12)
    sliderFrame.Parent = frame
    
    local sliderInner = Instance.new("Frame")
    sliderInner.BackgroundColor3 = theme.main
    sliderInner.BorderColor3 = theme.outline
    sliderInner.BorderMode = Enum.BorderMode.Inset
    sliderInner.Size = UDim2.new(1, 0, 1, 0)
    sliderInner.Parent = sliderFrame
    
    local fill = Instance.new("Frame")
    fill.BackgroundColor3 = theme.accent
    fill.BorderColor3 = theme.accent
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.Parent = sliderInner
    
    local value = default
    
    local function update(newValue)
        value = math.clamp(newValue, min, max)
        local percent = (value - min) / (max - min)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. ": " .. string.format("%.1f", value) .. (suffix or "")
        if callback then callback(value) end
    end
    
    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                local mouse = Players.LocalPlayer:GetMouse()
                local pos = (mouse.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X
                local newValue = min + (max - min) * math.clamp(pos, 0, 1)
                update(newValue)
                task.wait()
            end
        end
    end)
    
    update(default)
    
    return {
        setValue = update,
        getValue = function() return value end,
    }
end

-- CREATE DROPDOWN
function UI:createDropdown(text, parent, options, default, callback)
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    label.Text = text
    label.TextColor3 = theme.font
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Parent = frame
    
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    dropdownFrame.BorderColor3 = theme.outline
    dropdownFrame.Position = UDim2.new(0.4, 5, 0, 0)
    dropdownFrame.Size = UDim2.new(0.6, -5, 1, 0)
    dropdownFrame.Parent = frame
    
    local dropdownInner = Instance.new("Frame")
    dropdownInner.BackgroundColor3 = theme.main
    dropdownInner.BorderColor3 = theme.outline
    dropdownInner.BorderMode = Enum.BorderMode.Inset
    dropdownInner.Size = UDim2.new(1, 0, 1, 0)
    dropdownInner.Parent = dropdownFrame
    
    local selectedLabel = Instance.new("TextLabel")
    selectedLabel.BackgroundTransparency = 1
    selectedLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    selectedLabel.Text = default or options[1] or ""
    selectedLabel.TextColor3 = theme.font
    selectedLabel.TextSize = 12
    selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    selectedLabel.Position = UDim2.new(0, 5, 0, 0)
    selectedLabel.Size = UDim2.new(1, -5, 1, 0)
    selectedLabel.Parent = dropdownInner
    
    local arrow = Instance.new("TextLabel")
    arrow.BackgroundTransparency = 1
    arrow.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    arrow.Text = "▼"
    arrow.TextColor3 = theme.fontDim
    arrow.TextSize = 10
    arrow.TextXAlignment = Enum.TextXAlignment.Right
    arrow.Position = UDim2.new(0, 0, 0, 0)
    arrow.Size = UDim2.new(1, -5, 1, 0)
    arrow.Parent = dropdownInner
    
    local isOpen = false
    local dropdownList = Instance.new("Frame")
    dropdownList.BackgroundColor3 = theme.background
    dropdownList.BorderColor3 = theme.outline
    dropdownList.BorderMode = Enum.BorderMode.Inset
    dropdownList.Size = UDim2.new(1, 0, 0, 0)
    dropdownList.Visible = false
    dropdownList.Parent = dropdownFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = dropdownList
    
    local currentValue = default or options[1]
    
    local function updateList()
        for _, child in ipairs(dropdownList:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        
        local height = 0
        for _, option in ipairs(options) do
            local btn = Instance.new("TextButton")
            btn.BackgroundColor3 = theme.main
            btn.BorderColor3 = theme.outline
            btn.BorderMode = Enum.BorderMode.Inset
            btn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
            btn.Text = option
            btn.TextColor3 = theme.font
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Size = UDim2.new(1, 0, 0, 18)
            btn.Parent = dropdownList
            
            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = theme.accent
                btn.TextColor3 = theme.background
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = theme.main
                btn.TextColor3 = theme.font
            end)
            
            btn.MouseButton1Click:Connect(function()
                currentValue = option
                selectedLabel.Text = option
                dropdownList.Visible = false
                isOpen = false
                arrow.Text = "▼"
                if callback then callback(option) end
            end)
            
            height = height + 18
        end
        
        dropdownList.Size = UDim2.new(1, 0, 0, height)
    end
    
    dropdownFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isOpen = not isOpen
            dropdownList.Visible = isOpen
            arrow.Text = isOpen and "▲" or "▼"
            if isOpen then updateList() end
        end
    end)
    
    return {
        setValue = function(val) 
            currentValue = val
            selectedLabel.Text = val
            if callback then callback(val) end
        end,
        getValue = function() return currentValue end,
        setValues = function(newOptions)
            options = newOptions
            if currentValue and table.find(options, currentValue) == nil then
                currentValue = options[1]
                selectedLabel.Text = currentValue
            end
        end,
    }
end

-- CREATE BUTTON
function UI:createButton(text, parent, callback)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = theme.main
    btn.BorderColor3 = theme.accent
    btn.BorderMode = Enum.BorderMode.Inset
    btn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    btn.Text = text
    btn.TextColor3 = theme.font
    btn.TextSize = 13
    btn.Size = UDim2.new(1, 0, 0, 20)
    btn.Parent = parent
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = theme.accent
        btn.TextColor3 = theme.background
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = theme.main
        btn.TextColor3 = theme.font
    end)
    
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return btn
end

-- CREATE COLOR PICKER
function UI:createColorPicker(text, parent, defaultColor, callback)
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 25)
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    label.Text = text
    label.TextColor3 = theme.font
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Parent = frame
    
    local colorFrame = Instance.new("Frame")
    colorFrame.BackgroundColor3 = defaultColor or Color3.fromRGB(255, 255, 255)
    colorFrame.BorderColor3 = theme.outline
    colorFrame.BorderMode = Enum.BorderMode.Inset
    colorFrame.Position = UDim2.new(0.7, 5, 0, 0)
    colorFrame.Size = UDim2.new(0.25, 0, 1, 0)
    colorFrame.Parent = frame
    
    local currentColor = defaultColor or Color3.fromRGB(255, 255, 255)
    
    colorFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local colors = {
                Color3.fromRGB(255, 20, 147),  -- Hot pink
                Color3.fromRGB(255, 255, 255), -- White
                Color3.fromRGB(255, 0, 0),     -- Red
                Color3.fromRGB(0, 255, 0),     -- Green
                Color3.fromRGB(0, 0, 255),     -- Blue
                Color3.fromRGB(255, 255, 0),   -- Yellow
                Color3.fromRGB(255, 0, 255),   -- Magenta
                Color3.fromRGB(0, 255, 255),   -- Cyan
            }
            local idx = 1
            for i, c in ipairs(colors) do
                if c == currentColor then idx = i + 1 break end
            end
            if idx > #colors then idx = 1 end
            currentColor = colors[idx]
            colorFrame.BackgroundColor3 = currentColor
            if callback then callback(currentColor) end
        end
    end)
    
    return {
        setValue = function(color) 
            currentColor = color
            colorFrame.BackgroundColor3 = color
            if callback then callback(color) end
        end,
        getValue = function() return currentColor end,
    }
end

-- CREATE LABEL
function UI:createLabel(text, parent)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    label.Text = text
    label.TextColor3 = theme.font
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Parent = parent
    return label
end

-- CREATE DIVIDER
function UI:createDivider(parent)
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = theme.outline
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, 0, 0, 1)
    frame.Parent = parent
end

-- ===== BUILD UI WITH ALL FEATURES =====

function UI:BuildUI()
    -- Main Tab
    local mainTab = UI:createTab("Main")
    local mainGroup = mainTab:addGroupbox("Main")
    mainGroup:addToggle("Auto Sprint", false)
    mainGroup:addToggle("Auto Wisp", false)
    mainGroup:addToggle("Auto Fish", false)
    mainGroup:addBlank(5)
    mainGroup:addLabel("━ Auto Root ━")
    mainGroup:addToggle("Auto Loot", false)
    mainGroup:addToggle("Notify On Loot", false)
    mainGroup:addBlank(5)
    mainGroup:addLabel("━ Always Loot Items ━")
    mainGroup:addToggle("Relics", false)
    mainGroup:addToggle("Kyrsan Medallions", false)
    mainGroup:addBlank(5)
    mainGroup:addLabel("━ Notes ━")
    mainGroup:addToggle("Ministry Note Farm", false)
    mainGroup:addBlank(5)
    mainGroup:addLabel("━ Astral ━")
    mainGroup:addToggle("Moons Eyrie Farm", false)
    mainGroup:addBlank(5)
    mainGroup:addLabel("━ Bosses ━")
    mainGroup:addToggle("Auto Layer 2", false)
    mainGroup:addToggle("Auto Duke", false)
    mainGroup:addToggle("Auto Ferryman", false)
    mainGroup:addBlank(5)
    mainGroup:addLabel("━ Utility ━")
    mainGroup:addToggle("Escape Depths [WIP]", false)
    
    -- Visuals Tab
    local visualsTab = UI:createTab("Visuals")
    local visualsGroup = visualsTab:addGroupbox("Visuals")
    visualsGroup:addLabel("━ Player ESP ━")
    visualsGroup:addToggle("Player ESP", false)
    visualsGroup:addToggle("Guildmate Color", false)
    visualsGroup:addToggle("Player Healthbars", false)
    visualsGroup:addToggle("Player Names", false)
    visualsGroup:addToggle("Sanity Indicator", false)
    visualsGroup:addBlank(5)
    visualsGroup:addLabel("━ Dropped Items ━")
    visualsGroup:addToggle("Dropped Item ESP", false)
    visualsGroup:addToggle("Owl Feather ESP", false)
    visualsGroup:addToggle("Ingredient ESP", false)
    visualsGroup:addToggle("Artifact ESP", false)
    visualsGroup:addBlank(5)
    visualsGroup:addLabel("━ Other ━")
    visualsGroup:addToggle("Full Bright", false)
    visualsGroup:addToggle("Noclip Camera", false)
    visualsGroup:addToggle("Freecam", false)
    visualsGroup:addToggle("Streamer Mode", false)
    
    -- Combat Tab
    local combatTab = UI:createTab("Combat")
    local combatGroup = combatTab:addGroupbox("Combat")
    combatGroup:addLabel("━ Session ━")
    combatGroup:addDropdown("Currently set to:", {"persistent", "aggressive", "defensive"}, "persistent")
    combatGroup:addBlank(5)
    combatGroup:addLabel("━ Missions ━")
    combatGroup:addToggle("Auto Authority Missions", false)
    combatGroup:addBlank(5)
    combatGroup:addLabel("━ Saramed ━")
    combatGroup:addToggle("Auto Saramed", false)
    combatGroup:addBlank(5)
    combatGroup:addLabel("━ Auto Progression ━")
    combatGroup:addLabel("Build URL: [empty]")
    combatGroup:addBlank(5)
    combatGroup:addLabel("━ Builder ━")
    combatGroup:addToggle("Auto Progress", false)
    combatGroup:addBlank(5)
    combatGroup:addLabel("━ Resources ━")
    combatGroup:addToggle("Titus Relic Farm", false)
    combatGroup:addBlank(5)
    combatGroup:addLabel("━ Echoes ━")
    combatGroup:addToggle("Titus Echo Farm", false)
    combatGroup:addToggle("Soup Echo Farm", false)
    
    -- Automation Tab
    local autoTab = UI:createTab("Automation")
    local autoGroup = autoTab:addGroupbox("Automation")
    autoGroup:addLabel("━ Auto Parry ━")
    autoGroup:addSlider("Dont Process Players Over:", 500, 5000, 1000)
    autoGroup:addSlider("Dont Process Mobs Over:", 1000, 5000, 2000)
    autoGroup:addSlider("Task Concurrency:", 5, 50, 20)
    autoGroup:addToggle("Anti AP Breaker", false)
    autoGroup:addToggle("Debug Notifications", false)
    autoGroup:addToggle("Humanization", false)
    autoGroup:addToggle("Auto Feint", false)
    autoGroup:addBlank(5)
    autoGroup:addLabel("━ Anim Speed Changer ━")
    autoGroup:addSlider("Switch Speed", 1, 20, 5)
    autoGroup:addToggle("M1s", false)
    autoGroup:addBlank(5)
    autoGroup:addLabel("━ Silent Aim ━")
    autoGroup:addToggle("Silent Aim", false)
    autoGroup:addToggle("Safe Input", false)
    autoGroup:addToggle("Force Chime (solo)", false)
    autoGroup:addToggle("Show FOV", false)
    autoGroup:addSlider("FOV", 100, 5000, 2000)
    autoGroup:addBlank(5)
    autoGroup:addLabel("━ Mantra ━")
    autoGroup:addToggle("Mantra Rolling", false)
    autoGroup:addToggle("Mantra Slidecast", false)
    autoGroup:addToggle("Backstab Movestacker", false)
    
    -- UI Tab
    local uiTab = UI:createTab("UI")
    local uiGroup = uiTab:addGroupbox("UI")
    uiGroup:addLabel("━ General ━")
    uiGroup:addToggle("AutoDecline Squad Invites", false)
    uiGroup:addToggle("AutoDecline Guild Invites", false)
    uiGroup:addToggle("Allow Solar Enchant", false)
    uiGroup:addToggle("Use Attunements", false)
    uiGroup:addBlank(5)
    uiGroup:addLabel("━ Options ━")
    uiGroup:addToggle("AutoFight Mobs [WIP]", false)
    uiGroup:addToggle("Wipe Current", false)
    uiGroup:addToggle("Auto Chime Requeue", false)
    uiGroup:addBlank(5)
    uiGroup:addLabel("━ Create/Load ━")
    uiGroup:addButton("Create Config", function() print("Config Created!") end)
    uiGroup:addButton("Load Config", function() print("Config Loaded!") end)
    uiGroup:addBlank(5)
    uiGroup:addLabel("━ Session ━")
    uiGroup:addDropdown("Type", {"Default", "Farm", "Boss"}, "Default")
    uiGroup:addBlank(5)
    uiGroup:addLabel("━ Misc ━")
    uiGroup:addToggle("Auto Charisma Book", false)
    uiGroup:addToggle("Auto Math Textbook", false)
    uiGroup:addToggle("Auto Ragdoll Cancel", false)
    uiGroup:addToggle("Auto Golden Tongue", false)
    uiGroup:addToggle("Auto Train Agility", false)
    uiGroup:addToggle("Auto Air Counter", false)
    uiGroup:addToggle("Auto Roll Cancel", false)
    uiGroup:addToggle("Auto Flow State", false)
    uiGroup:addToggle("Auto Uppercut", false)
    uiGroup:addToggle("Auto Reinforce", false)
    uiGroup:addToggle("Auto Ardour", false)
    uiGroup:addToggle("Auto Brutus", false)
    uiGroup:addBlank(5)
    uiGroup:addLabel("━ Auto Progress ━")
    uiGroup:addToggle("Auto Builder", false)
    uiGroup:addToggle("Auto Points", false)
    
    UI:init()
end

-- ===== PUBLIC API =====

function UI:init()
    if #tabs > 0 then
        tabs[1].btn.MouseButton1Click:Fire()
    end
end

function UI:toggle()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
    if isOpen then
        mainFrame:TweenSize(UDim2.new(0, 750, 0, 750), "Out", "Quad", 0.2, true)
    end
end

function UI:destroy()
    screenGui:Destroy()
end

function UI:notify(text, duration)
    print("[Obliterated] " .. text)
end

function UI:createWindow(config)
    return {
        AddTab = function(name) return UI:createTab(name) end,
        SetWindowTitle = function(title) titleLabel.Text = title end,
    }
end

-- ===== KEYBIND =====
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        UI:toggle()
    end
end)

-- Build the UI
UI:BuildUI()

return UI
