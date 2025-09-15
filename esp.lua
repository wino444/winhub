
--Settings--
local ESP = {
    Enabled = false,
    Boxes = true,
    BoxShift = CFrame.new(0, -1.5, 0),
    BoxSize = Vector3.new(4, 6, 0),
    Color = Color3.fromRGB(255, 170, 0),
    FaceCamera = false,
    Names = true,
    TeamColor = true,
    Thickness = 2,
    AttachShift = 1,  -- สำหรับ Tracer: 1 = ล่างหน้าจอ, 0.5 = กลางหน้าจอ
    TeamMates = true,
    Players = true,
    Tracers = true,
    HealthBars = true,  -- แสดง Health Bar
    MaxDistance = 500,  -- ระยะสูงสุดสำหรับ Culling
    UseMaxDistance = true,  -- ใหม่! ควบคุมการใช้งาน MaxDistance
    AutoRemove = true,  -- ลบ ESP อัตโนมัติเมื่อวัตถุหาย
    Objects = setmetatable({}, {__mode = "kv"}),
    Overrides = {},
    Highlighted = nil,
    HighlightColor = Color3.fromRGB(255, 0, 0)  -- สีสำหรับ Highlight
}

--Declarations--
local cam = workspace.CurrentCamera
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()

local V3new = Vector3.new
local WorldToViewportPoint = cam.WorldToViewportPoint
local math_random = math.random  -- สำหรับ Obfuscation

--Functions--
local function Draw(obj, props)
    local new = Drawing.new(obj)
    
    props = props or {}
    for i, v in pairs(props) do
        new[i] = v
    end
    -- Obfuscation: สุ่มชื่อเพื่อเลี่ยง Anti-Cheat
    new.Name = "UI_" .. tostring(math_random(1000, 9999))
    return new
end

function ESP:GetTeam(p)
    local ov = self.Overrides.GetTeam
    if ov then
        return ov(p)
    end
    
    return p and p.Team
end

function ESP:IsTeamMate(p)
    local ov = self.Overrides.IsTeamMate
    if ov then
        return ov(p)
    end
    
    return self:GetTeam(p) == self:GetTeam(plr)
end

function ESP:GetColor(obj)
    local ov = self.Overrides.GetColor
    if ov then
        return ov(obj)
    end
    local p = self:GetPlrFromChar(obj)
    return p and self.TeamColor and p.Team and p.Team.TeamColor.Color or self.Color
end

function ESP:GetPlrFromChar(char)
    local ov = self.Overrides.GetPlrFromChar
    if ov then
        return ov(char)
    end
    
    return plrs:GetPlayerFromCharacter(char)
end

function ESP:Toggle(bool)
    self.Enabled = bool
    if bool then
        -- แจ้งเตือนถ้าตั้งค่าผิด
        if not self.Players and not self.Boxes and not self.Names and not self.Tracers and not self.HealthBars then
            warn("⚠️ ESP Enabled แต่ไม่มีฟีเจอร์ไหนเปิดใช้งาน! ตรวจสอบการตั้งค่า 🚨")
        end
    end
    if not bool then
        for i, v in pairs(self.Objects) do
            if v.Type == "Box" then
                if v.Temporary then
                    v:Remove()
                else
                    for i, v in pairs(v.Components) do
                        v.Visible = false
                    end
                end
            end
        end
    end
end

function ESP:GetBox(obj)
    return self.Objects[obj]
end

function ESP:AddObjectListener(parent, options)
    local function NewListener(c)
        if type(options.Type) == "string" and c:IsA(options.Type) or options.Type == nil then
            if type(options.Name) == "string" and c.Name == options.Name or options.Name == nil then
                if not options.Validator or options.Validator(c) then
                    local box = ESP:Add(c, {
                        PrimaryPart = type(options.PrimaryPart) == "string" and c:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(c),
                        Color = type(options.Color) == "function" and options.Color(c) or options.Color,
                        ColorDynamic = options.ColorDynamic,
                        Name = type(options.CustomName) == "function" and options.CustomName(c) or options.CustomName,
                        IsEnabled = options.IsEnabled,
                        RenderInNil = options.RenderInNil
                    })
                    if options.OnAdded then
                        coroutine.wrap(options.OnAdded)(box)
                    end
                end
            end
        end
    end

    if options.Recursive then
        parent.DescendantAdded:Connect(NewListener)
        for i, v in pairs(parent:GetDescendants()) do
            coroutine.wrap(NewListener)(v)
        end
    else
        parent.ChildAdded:Connect(NewListener)
        for i, v in pairs(parent:GetChildren()) do
            coroutine.wrap(NewListener)(v)
        end
    end
end

local boxBase = {}
boxBase.__index = boxBase

function boxBase:Remove()
    ESP.Objects[self.Object] = nil
    for i, v in pairs(self.Components) do
        v.Visible = false
        v:Remove()
        self.Components[i] = nil
    end
end

function boxBase:Update()
    if not self.PrimaryPart then
        return self:Remove()
    end

    -- Culling: ข้ามอัปเดตถ้าระยะไกลเกิน MaxDistance (ถ้าเปิดใช้งาน)
    local distance = (cam.CFrame.p - self.PrimaryPart.Position).Magnitude
    if ESP.UseMaxDistance and distance > ESP.MaxDistance then
        for i, v in pairs(self.Components) do
            v.Visible = false
        end
        return
    end

    local color
    if ESP.Highlighted == self.Object then
        color = ESP.HighlightColor
    else
        color = self.Color or self.ColorDynamic and self:ColorDynamic() or ESP:GetColor(self.Object) or ESP.Color
    end

    local allow = true
    if ESP.Overrides.UpdateAllow and not ESP.Overrides.UpdateAllow(self) then
        allow = false
    end
    if self.Player and not ESP.TeamMates and ESP:IsTeamMate(self.Player) then
        allow = false
    end
    if self.Player and not ESP.Players then
        allow = false
    end
    if self.IsEnabled and (type(self.IsEnabled) == "string" and not ESP[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
        allow = false
    end
    if not workspace:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
        allow = false
    end

    if not allow then
        for i, v in pairs(self.Components) do
            v.Visible = false
        end
        return
    end

    --calculations--
    local cf = self.PrimaryPart.CFrame
    if ESP.FaceCamera then
        cf = CFrame.new(cf.p, cam.CFrame.p)
    end
    local size = self.Size
    local locs = {
        TopLeft = cf * ESP.BoxShift * CFrame.new(size.X / 2, size.Y / 2, 0),
        TopRight = cf * ESP.BoxShift * CFrame.new(-size.X / 2, size.Y / 2, 0),
        BottomLeft = cf * ESP.BoxShift * CFrame.new(size.X / 2, -size.Y / 2, 0),
        BottomRight = cf * ESP.BoxShift * CFrame.new(-size.X / 2, -size.Y / 2, 0),
        TagPos = cf * ESP.BoxShift * CFrame.new(0, size.Y / 2, 0),
        Torso = cf * ESP.BoxShift,
        HealthPos = cf * ESP.BoxShift * CFrame.new(-size.X / 2 - 1, size.Y / 2, 0)  -- ตำแหน่งสำหรับ Health Bar
    }

    if ESP.Boxes then
        local TopLeft, Vis1 = WorldToViewportPoint(cam, locs.TopLeft.p)
        local TopRight, Vis2 = WorldToViewportPoint(cam, locs.TopRight.p)
        local BottomLeft, Vis3 = WorldToViewportPoint(cam, locs.BottomLeft.p)
        local BottomRight, Vis4 = WorldToViewportPoint(cam, locs.BottomRight.p)

        if self.Components.Quad then
            if Vis1 or Vis2 or Vis3 or Vis4 then
                self.Components.Quad.Visible = true
                self.Components.Quad.PointA = Vector2.new(TopRight.X, TopRight.Y)
                self.Components.Quad.PointB = Vector2.new(TopLeft.X, TopLeft.Y)
                self.Components.Quad.PointC = Vector2.new(BottomLeft.X, BottomLeft.Y)
                self.Components.Quad.PointD = Vector2.new(BottomRight.X, BottomRight.Y)
                self.Components.Quad.Color = color
            else
                self.Components.Quad.Visible = false
            end
        end
    else
        self.Components.Quad.Visible = false
    end

    if ESP.Names then
        local TagPos, Vis5 = WorldToViewportPoint(cam, locs.TagPos.p)
        
        if Vis5 then
            self.Components.Name.Visible = true
            self.Components.Name.Position = Vector2.new(TagPos.X, TagPos.Y)
            self.Components.Name.Text = self.Name
            self.Components.Name.Color = color
            
            self.Components.Distance.Visible = true
            self.Components.Distance.Position = Vector2.new(TagPos.X, TagPos.Y + 14)
            self.Components.Distance.Text = math.floor(distance) .. "m away"
            self.Components.Distance.Color = color
        else
            self.Components.Name.Visible = false
            self.Components.Distance.Visible = false
        end
    else
        self.Components.Name.Visible = false
        self.Components.Distance.Visible = false
    end
    
    if ESP.Tracers then
        local TorsoPos, Vis6 = WorldToViewportPoint(cam, locs.Torso.p)

        if Vis6 then
            self.Components.Tracer.Visible = true
            self.Components.Tracer.From = Vector2.new(TorsoPos.X, TorsoPos.Y)
            self.Components.Tracer.To = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / ESP.AttachShift)
            self.Components.Tracer.Color = color
        else
            self.Components.Tracer.Visible = false
        end
    else
        self.Components.Tracer.Visible = false
    end

    -- Health Bar
    if ESP.HealthBars and self.Object:FindFirstChildOfClass("Humanoid") then
        local hum = self.Object:FindFirstChildOfClass("Humanoid")
        local HealthPos, Vis7 = WorldToViewportPoint(cam, locs.HealthPos.p)
        
        if Vis7 then
            local healthPercent = hum.Health / hum.MaxHealth
            self.Components.HealthBar.Visible = true
            self.Components.HealthBar.PointA = Vector2.new(HealthPos.X, HealthPos.Y)
            self.Components.HealthBar.PointB = Vector2.new(HealthPos.X, HealthPos.Y - (size.Y * 20 * healthPercent))
            self.Components.HealthBar.PointC = Vector2.new(HealthPos.X + 5, HealthPos.Y - (size.Y * 20 * healthPercent))
            self.Components.HealthBar.PointD = Vector2.new(HealthPos.X + 5, HealthPos.Y)
            self.Components.HealthBar.Color = Color3.fromHSV(healthPercent / 3, 1, 1)
            self.Components.HealthText.Visible = true
            self.Components.HealthText.Position = Vector2.new(HealthPos.X + 2.5, HealthPos.Y - (size.Y * 10))
            self.Components.HealthText.Text = math.floor(hum.Health) .. "/" .. hum.MaxHealth
            self.Components.HealthText.Color = color
        else
            self.Components.HealthBar.Visible = false
            self.Components.HealthText.Visible = false
        end
    else
        self.Components.HealthBar.Visible = false
        self.Components.HealthText.Visible = false
    end
end

function ESP:Add(obj, options)
    if not obj.Parent and not options.RenderInNil then
        return warn(obj, "has no parent")
    end

    local box = setmetatable({
        Name = options.Name or obj.Name,
        Type = "Box",
        Color = options.Color,
        Size = options.Size or ESP.BoxSize,
        Object = obj,
        Player = options.Player or plrs:GetPlayerFromCharacter(obj),
        PrimaryPart = options.PrimaryPart or (obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or (obj:IsA("BasePart") and obj)),
        Components = {},
        IsEnabled = options.IsEnabled,
        Temporary = options.Temporary,
        ColorDynamic = options.ColorDynamic,
        RenderInNil = options.RenderInNil
    }, boxBase)

    if ESP:GetBox(obj) then
        ESP:GetBox(obj):Remove()
    end

    box.Components["Quad"] = Draw("Quad", {
        Thickness = ESP.Thickness,
        Color = box.Color,
        Transparency = 1,
        Filled = false,
        Visible = ESP.Enabled and ESP.Boxes
    })
    box.Components["Name"] = Draw("Text", {
        Text = box.Name,
        Color = box.Color,
        Center = true,
        Outline = true,
        Size = 19,
        Visible = ESP.Enabled and ESP.Names
    })
    box.Components["Distance"] = Draw("Text", {
        Color = box.Color,
        Center = true,
        Outline = true,
        Size = 19,
        Visible = ESP.Enabled and ESP.Names
    })
    box.Components["Tracer"] = Draw("Line", {
        Thickness = ESP.Thickness,
        Color = box.Color,
        Transparency = 1,
        Visible = ESP.Enabled and ESP.Tracers
    })
    box.Components["HealthBar"] = Draw("Quad", {
        Thickness = 1,
        Transparency = 1,
        Filled = true,
        Visible = false
    })
    box.Components["HealthText"] = Draw("Text", {
        Color = box.Color,
        Center = true,
        Outline = true,
        Size = 14,
        Visible = false
    })

    ESP.Objects[obj] = box
    
    obj.AncestryChanged:Connect(function(_, parent)
        if parent == nil and ESP.AutoRemove then
            box:Remove()
        end
    end)
    obj:GetPropertyChangedSignal("Parent"):Connect(function()
        if obj.Parent == nil and ESP.AutoRemove then
            box:Remove()
        end
    end)

    local hum = obj:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Died:Connect(function()
            if ESP.AutoRemove then
                box:Remove()
            end
        end)
    end

    return box
end

local function CharAdded(char)
    local p = plrs:GetPlayerFromCharacter(char)
    local timeout = 5
    local startTime = tick()
    while not char:FindFirstChild("HumanoidRootPart") and tick() - startTime < timeout do
        task.wait(0.1)
    end
    if char:FindFirstChild("HumanoidRootPart") then
        ESP:Add(char, {
            Name = p.Name,
            Player = p,
            PrimaryPart = char.HumanoidRootPart
        })
    else
        warn("⚠️ Failed to find HumanoidRootPart for " .. p.Name .. " after timeout!")
    end
end

local function PlayerAdded(p)
    p.CharacterAdded:Connect(CharAdded)
    if p.Character then
        coroutine.wrap(CharAdded)(p.Character)
    end
end

plrs.PlayerAdded:Connect(PlayerAdded)
for i, v in pairs(plrs:GetPlayers()) do
    if v ~= plr then
        PlayerAdded(v)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    cam = workspace.CurrentCamera
    if not ESP.Enabled then return end
    for i, v in pairs(ESP.Objects) do
        if v.Update then
            local s, e = pcall(v.Update, v)
            if not s then
                warn("[ESP Error] 🚨 ", e, v.Object:GetFullName())
            end
        end
    end
end)

return ESP
