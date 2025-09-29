-- นี่คือ ui.lua (Library ที่โหลดจาก URL: https://raw.githubusercontent.com/wino444/winhub/main/ui.lua)
local Library = {} -- coded this while jamming shinitai chan - jack @ 10:06AM PST, 3/24/2021 (took me 3 hrs 22 seconds (i had to recode it))
Library.flags = {}

local TweenService = game:GetService'TweenService'
local UDim2_new, Color3_new = UDim2.new, Color3.fromRGB

function Library:Create(Class, Properties)
    Properties = Properties or {}

    local Obj = Instance.new(Class)

    for K, V in next, Properties do
        local Success, _ = pcall(function()
            local I = Obj[K]
        end)

        if Success then
            Obj[K] = V;
        end
    end

    return Obj
end

local UI = Library:Create('ScreenGui', {
    Name = 'UI',
    Parent = game:GetService'CoreGui',
    ResetOnSpawn = false
})

local Colors = {
    Main = Color3_new(100, 100, 100),
    MainBorder = Color3_new(80, 80, 80),
    Mid = Color3_new(60, 60, 60),
    Border = Color3_new(40, 40, 40)
}

local AddSection = function(UI, Parameters, SectionFrame)
    local Section = Library:Create('Frame', {
        Name = 'Section',
        BackgroundColor3 = Colors.MainBorder,
        BorderColor3 = Colors.Border,
        Parent = SectionFrame
    }); local Main = Library:Create('ScrollingFrame', {
        Parent = Section,
        Name = 'Main',
        BorderSizePixel = 0,
        BackgroundColor3 = Colors.MainBorder,
        Position = UDim2_new(0, 0, 0.06, 0),
        Size = UDim2_new(1, 0, 0.94, 0),
        ClipsDescendants = true,
        BottomImage = 'http://www.roblox.com/asset/?id=58757773',
        MidImage = 'http://www.roblox.com/asset/?id=58757773',
        TopImage = 'http://www.roblox.com/asset/?id=58757773',
        ScrollBarImageColor3 = Color3_new(117, 117, 117),
        ScrollBarThickness = 5,
        CanvasSize = UDim2.new(0, 0, 2, 0)  -- เพิ่มเพื่อเลื่อนได้
    }); Library:Create('UIListLayout', {
        Parent = Main,
        SortOrder = Enum.SortOrder.LayoutOrder
    }); Library:Create('TextLabel', {
        Parent = Section,
        Name = 'Text',
        TextSize = 14,
        TextColor3 = Color3_new(255, 255, 255),
        Font = Enum.Font.Code,
        BackgroundColor3 = Colors.MainBorder,
        BorderSizePixel = 0,
        Position = UDim2_new(0.075, 0, -0.03, 0),
        Size = UDim2_new(0, (9 * Parameters.SectionText:len()), 0, 15),
        Text = Parameters.SectionText
    })

    for Type, Info in next, Parameters do
        if Type:match('Toggle') then
            local Toggle = Library:Create('Frame', {
                Parent = Main,
                Name = Type,
                Size = UDim2_new(1, 0, 0.069, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
            }); Library:Create('ImageButton', {
                Parent = Toggle,
                Name = 'Button',
                BackgroundColor3 = Colors.Mid,
                BorderColor3 = Colors.Border,
                BorderSizePixel = 1,
                Size = UDim2_new(0.12, 0, 0.8, 0),
                Position = UDim2_new(0.04, 0, 0.1, 0),
                Text = '',
                TextSize = 14,
                ImageColor3 = Color3.fromRGB(255, 255, 255),
                ImageTransparency = (Info[2] and 0) or 1,
                Image = 'http://www.roblox.com/asset/?id=4776914445',
                ScaleType = Enum.ScaleType.Fit,
            }); Library:Create('TextLabel', {
                Parent = Toggle,
                Name = 'Label',
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2_new(0.2, 0, 0.1, 0),
                Size = UDim2_new(0.7, 0, 0.8, 0),
                Text = Info[1] or 'Toggle',
                Font = Enum.Font.Code,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Color3_new(255, 255, 255)
            })
            
            local Flag = Info[3]
            Library.flags[Flag] = Info[2]
            
            Toggle.Button.MouseButton1Click:Connect(function()
                Library.flags[Flag] = not Library.flags[Flag]
                local Bool = Library.flags[Flag]
                
                Toggle.Button.ImageTransparency = (Bool and 0) or 1

                Info[4](Bool)
            end)
        elseif Type:match('Box') then
            local Box = Library:Create('Frame', {
                BackgroundTransparency = 1,
                Parent = Main,
                Name = Type,
                Size = UDim2_new(1, 0, 0.11, 0)
            }); Library:Create('TextLabel', {
                BackgroundTransparency = 1,
                Parent = Box,
                Size = UDim2_new(0.9, 0, 0.3, 0),
                Position = UDim2_new(0.06, 0, 0.1, 0),
                Font = Enum.Font.Code,
                Text = Info[1],
                TextColor3 = Color3_new(255, 255, 255),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            }); Library:Create('TextBox', {
                Font = Enum.Font.Code,
                Text = '',
                PlaceholderText = 'Input',
                PlaceholderColor3 = Color3_new(178, 178, 178),
                TextColor3 = Color3_new(255, 255, 255),
                TextSize = 14,
                BackgroundTransparency = 0,
                BackgroundColor3 = Colors.Mid,
                BorderColor3 = Colors.Border,
                BorderSizePixel = 1,
                Position = UDim2_new(0.04, 0, 0.44, 0),
                Size = UDim2_new(0.9, 0, 0.43, 0),
                Parent = Box
            })
            
            Box.TextBox.FocusLost:Connect(function()
                Info[2](Box.TextBox.Text)
            end)
        elseif Type:match('Button') then
            local Button = Library:Create('Frame', {
                Name = Type,
                Size = UDim2_new(1, 0, 0.069, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Parent = Main
            }); Library:Create('TextButton', {
                Parent = Button,
                BackgroundColor3 = Colors.Mid,
                BorderColor3 = Colors.Border,
                Position = UDim2_new(0.04, 0, 0.1, 0),
                Size = UDim2_new(0.9, 0, 0.8, 0),
                Font = Enum.Font.Code,
                Text = Info[1],
                TextSize = 14,
                TextColor3 = Color3_new(255, 255, 255)
            })
            
            Button.TextButton.MouseButton1Click:Connect(Info[2])
        end
    end

    return Section
end

Library.Notify = {}
local Notify = Library.Notify
Notify.Notifications = {}

function Notify:new(Title, Text, Time)
    Title = Title or 'Notification'; Text = Text or 'Blacks in the premice!'; Time = Time or 5;

    local Notification = {}

    local Object = Library:Create('TextButton', {
        Name = 'Notification',
        BackgroundColor3 = Colors.MainBorder,
        BorderColor3 = Colors.Border,
        BackgroundTransparency = 0,
        BorderSizePixel = 2,
        Position = UDim2_new(1.5, -270, 1, -104),
        Size = UDim2_new(0, 270, 0, 80),
        Text = ''
    }); Library:Create('Frame', {
        Name = 'Topbar',
        Position = UDim2_new(0, 0, 0, 0),
        Size = UDim2_new(1, 0, 0.3, 0),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3_new(255, 255, 255),
        Parent = Object
    }); Library:Create('UIGradient', {
        Parent = Object.Topbar,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3_new(129, 129, 129)),
            ColorSequenceKeypoint.new(0.128, Color3_new(40, 40, 40)),
            ColorSequenceKeypoint.new(1, Color3_new(20, 20, 20))
        }),
        Rotation = 90
    }); Library:Create('TextLabel', {
        BackgroundTransparency = 1,
        Position = UDim2_new(0, 0, 0, 0),
        Size = UDim2_new(1, 0, 0.8, 0),
        Font = Enum.Font.Code,
        Text = ' ' .. Title,
        TextColor3 = Color3_new(255, 255, 255),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Name = 'Title',
        Parent = Object.Topbar
    }); Library:Create('TextLabel', {
        Text = Text,
        TextColor3 = Color3_new(255, 255, 255),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextSize = 15,
        Font = Enum.Font.Code,
        BackgroundTransparency = 1,
        Position = UDim2_new(0.026, 0, 0.299, 0),
        Size = UDim2_new(0.98, 0, 0.7, 0),
        Parent = Object
    })

    Notification.Object = Object

    function Notification:Close()
        return TweenService:Create(Object, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
            Position = UDim2.new(1.3, 0, Object.Position.Y.Scale, 0)
        }):Play()
    end

    Object.MouseButton1Click:Connect(function()
        Notification:Close()
    end)

    Object.Parent = UI

    table.insert(Notify.Notifications, Notification)

    for I, FoundNotification in next, Notify.Notifications do
        if FoundNotification ~= Notification then
            TweenService:Create(FoundNotification.Object, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
                Position = UDim2_new(1, -270, 1, (-104 - (90 * (#Notify.Notifications - I))))
            }):Play()
        end
    end

    TweenService:Create(Object, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
        Position = UDim2_new(1, -270, 1, -104)
    }):Play()

    coroutine.wrap(function()
        wait(Time)

        if Notification then
            Notification:Close()

            local Obj = Notification.Object

            table.remove(Notify.Notifications, table.find(Notify.Notifications, Notification))

            wait(0.5)

            Obj:Destroy()
        end
    end)()

    return Notification
end

function Library:new(Parameters)
    Parameters = Parameters or {
        Name = 'TOUx1 HUB',
        Tab = {
            Text = 'หน้าหลัก',
            Section1 = {
                SectionText = 'Home',
                -- Add your home content as elements
            },
            Section2 = {
                SectionText = 'ผู้เล่น',
                -- Add player content
            },
            Section3 = {
                SectionText = 'Script',
                -- Add script content
            },
            Section4 = {
                SectionText = 'script ui',
                -- Add script ui content
            }
        }
    }

    local Background = self:Create('Frame', {
        Name = 'Background',
        Size = UDim2_new(0, 500, 0, 300),
        Position = UDim2_new(0.5, -250, 0.5, -150),
        BackgroundColor3 = Colors.Main,
        BorderColor3 = Colors.MainBorder,
        BorderSizePixel = 2,
        Active = true,
        Selectable = true,
        Draggable = true,
        Parent = UI
    })

    local Topbar = self:Create('Frame', {
        Parent = Background,
        Name = 'Topbar',
        BackgroundColor3 = Color3_new(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2_new(0, 0, 0, 0),
        Size = UDim2_new(1, 0, 0, 40)
    }); self:Create('UIGradient', {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Colors.MainBorder),
            ColorSequenceKeypoint.new(0.356, Colors.MainBorder),
            ColorSequenceKeypoint.new(1, Colors.Main)
        }),
        Rotation = 90,
        Parent = Topbar
    }); self:Create('TextLabel', {
        Parent = Topbar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2_new(0, 200, 0, 40),
        Position = UDim2_new(0.018, 0, 0, 0),
        Font = Enum.Font.GothamBold,
        Text = Parameters.Name,
        TextColor3 = Color3_new(255, 255, 255),
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local TabHolder = self:Create('Frame', {
        Parent = Background,
        Name = 'TabHolder',
        BackgroundTransparency = 1,
        Position = UDim2_new(0, 0, 0, 40),
        Size = UDim2_new(1, 0, 0, 40)
    }); self:Create('UIListLayout', {
        Parent = TabHolder,
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local ContentHolder = self:Create('Frame', {
        Parent = Background,
        Name = 'ContentHolder',
        BackgroundTransparency = 1,
        Position = UDim2_new(0, 0, 0, 80),
        Size = UDim2_new(1, 0, 1, -80)
    })

    local Tabs = {}
    local Sections = Parameters.Tab
    for i = 1, 4 do
        local TabButton = self:Create('TextButton', {
            Parent = TabHolder,
            Size = UDim2_new(0.25, 0, 1, 0),
            BackgroundColor3 = Colors.Mid,
            BorderColor3 = Colors.Border,
            Text = Sections['Section'..i].SectionText,
            Font = Enum.Font.Gotham,
            TextSize = 18,
            TextColor3 = Color3_new(255, 255, 255)
        })
        local SectionFrame = self:Create('Frame', {
            Parent = ContentHolder,
            Size = UDim2_new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = (i == 1)
        })
        AddSection(UI, Sections['Section'..i], SectionFrame)
        Tabs[i] = {Button = TabButton, Frame = SectionFrame}

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in Tabs do
                tab.Frame.Visible = false
            end
            SectionFrame.Visible = true
        end)
    end

    local Close = self:Create('TextButton', {
        Parent = Topbar,
        Size = UDim2_new(0, 30, 0, 30),
        Position = UDim2_new(1, -40, 0, 5),
        BackgroundColor3 = Color3.fromRGB(255,0,0),
        Text = 'X',
        TextColor3 = Color3_new(255, 255, 255),
        TextSize = 20
    })
    Close.MouseButton1Click:Connect(function()
        UI:Destroy()
    end)

    -- Integrate minimize from HUB
    local MinimizeFrame = self:Create('Frame', {
        Size = UDim2_new(0, 50, 0, 50),
        Position = UDim2_new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Active = true,
        Parent = UI,
        Visible = false
    })
    local OpenButton = self:Create('ImageButton', {
        Size = UDim2_new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://106575147804507",
        Parent = MinimizeFrame
    })
    OpenButton.MouseButton1Click:Connect(function()
        MinimizeFrame.Visible = false
        Background.Visible = true
    end)
    local MinButton = self:Create('TextButton', {
        Parent = Topbar,
        Size = UDim2_new(0, 30, 0, 30),
        Position = UDim2_new(1, -80, 0, 5),
        BackgroundColor3 = Color3.fromRGB(255,165,0),
        Text = '-',
        TextColor3 = Color3_new(255, 255, 255),
        TextSize = 20
    })
    MinButton.MouseButton1Click:Connect(function()
        Background.Visible = false
        MinimizeFrame.Visible = true
    end)

    return UI
end

return Library
