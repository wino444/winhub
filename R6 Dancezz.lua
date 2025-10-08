-- gObl00x Notification
game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "gOb scripts";
	Text = "LOL Time to Exploit!";
	Icon = "rbxtHumanoidb://type=Asset&id=126389658690593&w=150&h=150"})
Duration = 15;
-- MusicFolder
if isfolder and not isfolder("Epik Musics") then
  makefolder("Epik Musics")
end
--//==============================================================================================//--
--||		EPIK R6 DANCEZZZ CREATED BY gObl00x // NEW ANIMATOR6D
--|| Ya sorry, I'll not make all these animations or the ones from the previous version to CFrames
--\\===========================================================================================//--

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local Backpack = Player.Backpack
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Mouse = Player:GetMouse()
IT = Instance.new
V3 = Vector3.new
CF = CFrame.new
RAD = math.rad

--// CAMERA FOLLOWS HEAD (Without changing CameraSubject) \\--
local RunService = game:GetService('RunService')

local PlayerMouse = Player:GetMouse()
local Camera = workspace.CurrentCamera
local Humanoid = Character:WaitForChild('Humanoid')
local IsR6 = (Humanoid.RigType == Enum.HumanoidRigType.R6)
local Head = Character:WaitForChild('Head')
local Torso = if IsR6
	then Character:WaitForChild('Torso')
	else Character:WaitForChild('UpperTorso')
local Neck = if IsR6
	then Torso:WaitForChild('Neck')
	else Head:WaitForChild('Neck')
local Waist = if IsR6 then nil else Torso:WaitForChild('Waist')

local NeckOriginC0 = Neck.C0
local WaistOriginC0 = if Waist then Waist.C0 else nil

local AllowedStates = {
	Enum.HumanoidStateType.Running,
	Enum.HumanoidStateType.Climbing,
	Enum.HumanoidStateType.Swimming,
	Enum.HumanoidStateType.Freefall,
	Enum.HumanoidStateType.Seated,
}

local find = table.find
local atan = math.atan
local atan2 = math.atan2

RunService.RenderStepped:Connect(function(deltaTime: number)
	local function Alpha(n)
		return math.clamp(n * deltaTime * 60, 0, 1)
	end
	Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp(
		(RootPart.CFrame * CF(0, 1.5, 0)):PointToObjectSpace(Head.Position),
		Alpha(0.15)
	)
	if IsAllowedState then
		local HeadPosition = Head.Position
		if Neck then
			local MousePos = PlayerMouse.Hit.Position
			local TranslationVector = (HeadPosition - MousePos).Unit
			local Pitch = atan(TranslationVector.Y)
			local Yaw = TranslationVector:Cross(Torso.CFrame.LookVector).Y
			local Roll = atan(Yaw)

			local NeckCFrame
			if IsR6 then
				NeckCFrame = CFrame.Angles(Pitch, 0, Yaw)
			else
				NeckCFrame = CFrame.Angles(-Pitch * 0.5, Yaw, -Roll * 0.5)
				local waistCFrame = CFrame.Angles(-Pitch * 0.5, Yaw * 0.5, 0)
				Waist.C0 = Waist.C0:Lerp(
					WaistOriginC0 * waistCFrame,
					updatesPerSecond * deltaTime
				)
			end
			Neck.C0 = Neck.C0:Lerp(
				NeckOriginC0 * NeckCFrame,
				updatesPerSecond * deltaTime
			)
		end
	end
end)
--------------------------

----- GLOBAL CACHE -------
local EffectFolder = Character:FindFirstChild("EffectFolder")
if not EffectFolder then
	EffectFolder = IT("Folder")
	EffectFolder.Name = "EffectFolder"
	EffectFolder.Parent = Character
end
-- Effects Cache
mesh = IT("SpecialMesh")
mesh.MeshId = "rbxassetid://1439035575"
mesh.TextureId = "rbxassetid://1439035619"
mesh.Scale = V3(1, 1, 1.5)
mesh.Offset = V3(0, -0.4, 0)
mesh.Parent = EffectFolder

-- Music Cache
local Music1 = IT("Sound", EffectFolder)
Music1.Name = "Smug"
local Music2 = IT("Sound", EffectFolder)
Music2.Name = "Hakari"
local Music3 = IT("Sound", EffectFolder)
Music3.Name = "Rat Dance"
local Music4 = IT("Sound", EffectFolder)
Music4.Name = "Kazotsky Kick"
local Music5 = IT("Sound", EffectFolder)
Music5.Name = "Boppin"
local Music6 = IT("Sound", EffectFolder)
Music6.Name = "Moongazer"
local Music7 = IT("Sound", EffectFolder)
Music7.Name = "Mannrobics"
local Music8 = IT("Sound", EffectFolder)
Music8.Name = "Reanimated"
local Music9 = IT("Sound", EffectFolder)
Music9.Name = "Goopie"
local Music10 = IT("Sound", EffectFolder)
Music10.Name = "Fresh"
local Music11 = IT("Sound", EffectFolder)
Music11.Name = "Sequencia de Vapor"
local Music12 = IT("Sound", EffectFolder)
Music12.Name = "Mr.WMD Boombox"
local Music13 = IT("Sound", EffectFolder)
Music13.Name = "Take The L"
local Music14 = IT("Sound", EffectFolder)
Music14.Name = "Secret"
local Music15 = IT("Sound", EffectFolder)
Music15.Name = "Caramelldansen"
local Music16 = IT("Sound", EffectFolder)
Music16.Name = "Spooky Month"
local Music17 = IT("Sound", EffectFolder)
Music17.Name = "Boogie Down"
--------------------------

  --_/ STARTING \__--

-- // Smug Tool Dance \\ --
local tool1 = IT("Tool", Backpack)
tool1.Name = "Smug"
tool1.RequiresHandle = false
--
if not isfile("Epik Musics/Dancing.mp3") then
       writefile("Epik Musics/Dancing.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Dancing.mp3"))
end
--
tool1.Equipped:Connect(function()
    if Character then
    Humanoid.WalkSpeed = 10
       getgenv().Animator6D(6512463532, 1, true)
-- Music
Music1.Parent = Character
Music1.SoundId = getcustomasset("Epik Musics/Dancing.mp3")
Music1.Looped = true
Music1:Play()
end
end)

tool1.Unequipped:Connect(function()
if Music1.Parent == Character and Music1.Playing then
    getgenv().Animator6DStop()
    Humanoid.WalkSpeed = 16
       Music1:Stop()
       Music1.Parent = EffectFolder
    end
    print("Dance 1 and music stopped")
end)

-- // Hakari Tool Dance \\ --
local tool2 = IT("Tool", Backpack)
tool2.Name = "Hakari"
tool2.RequiresHandle = false
--
if not isfile("Epik Musics/hakari.mp3") then
       writefile("Epik Musics/hakari.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Hakari.mp3"))
end
--
local CachedEffects = {}
tool2.Equipped:Connect(function()
    if Character then
       getgenv().Animator6D(17147170140, 1, true)
-- Aura
local EffectModel = game:GetObjects("rbxassetid://17286931410")[1]
for _, limb in ipairs(Character:GetChildren()) do
	if limb:IsA("BasePart") then
for _, obj in ipairs(EffectModel:GetDescendants()) do
	if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
		local Aura = obj:Clone()
		Aura.Parent = limb
		table.insert(CachedEffects, Aura)
		   end
		end
	end
end
EffectModel:Destroy()
-- Music
Music2.Parent = Character
Music2.SoundId = getcustomasset("Epik Musics/Hakari.mp3")
Music2.Looped = true
Music2:Play()
end
end)

tool2.Unequipped:Connect(function()
    if Music2.Parent == Character and Music2.Playing then
    getgenv().Animator6DStop()
       Music2:Stop()
       Music2.Parent = EffectFolder
    end
    for _, Aura in pairs(CachedEffects) do
           Aura:Destroy()
		end
    local CachedEffects = {}
    print("Dance 2 and music stopped")
end)


-- // Rat Dance Tool Dance \\ --
local tool3 = IT("Tool", Backpack)
tool3.Name = "Rat Dance"
tool3.RequiresHandle = false
--
if not isfile("Epik Musics/rat.mp3") then
       writefile("Epik Musics/rat.mp3", game:HttpGet("https://github.com/Nitro-GT/music/raw/refs/heads/main/rat.mp3"))
end
--
tool3.Equipped:Connect(function()
    if Character then
       getgenv().Animator6D(117971041844492, 1, true)
-- Music
Music3.Parent = Character
Music3.SoundId = getcustomasset("Epik Musics/rat.mp3")
Music3.Looped = true
Music3:Play()
end
end)

tool3.Unequipped:Connect(function()
    if Music3.Parent == Character and Music3.Playing then
    getgenv().Animator6DStop()
       Music3:Stop()
       Music3.Parent = EffectFolder
    end
    print("Dance 3 and music stopped")
end)


-- // Kazotsky Kick Tool Dance \\ --
local tool4 = IT("Tool", Backpack)
tool4.Name = "Kazotsky Kick"
tool4.RequiresHandle = false
--
if not isfile("Epik Musics/Kazotsky Kick.mp3") then
       writefile("Epik Musics/Kazotsky Kick.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Kazotsky%20Kick.mp3"))
end
local KazotskyKick= game:GetObjects("rbxassetid://8903870018")[1].AnimSaves["Kazotsky Kick"]
--
tool4.Equipped:Connect(function()
    if Character then
        Humanoid.WalkSpeed = 6
       getgenv().Animator6D(KazotskyKick, 1, true)
-- Music
Music4.Parent = Character
Music4.SoundId = getcustomasset("Epik Musics/Kazotsky Kick.mp3")
Music4.Looped = true
Music4:Play()
end
end)

tool4.Unequipped:Connect(function()
if Music4.Parent == Character and Music4.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
       Music4:Stop()
       Music4.Parent = EffectFolder
    end
    print("Dance 4 and music stopped")
end)


-- // Boppin Tool Dance \\ --
local tool5 = IT("Tool", Backpack)
tool5.Name = "Boppin"
tool5.RequiresHandle = false
--
if not isfile("Epik Musics/Boppin.mp3") then
       writefile("Epik Musics/Boppin.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Boppin.mp3"))
end
--
tool5.Equipped:Connect(function()
    if Character then
       getgenv().Animator6D(15710560047, 1, true)
-- Music
Music5.Parent = Character
Music5.SoundId = getcustomasset("Epik Musics/Boppin.mp3")
Music5.Looped = true
Music5:Play()
end
end)

tool5.Unequipped:Connect(function()
if Music5.Parent == Character and Music5.Playing then
    getgenv().Animator6DStop()
       Music5:Stop()
       Music5.Parent = EffectFolder
    end
    print("Dance 5 and music stopped")
end)


-- // Moongazer Tool Dance \\ --
local tool6 = IT("Tool", Backpack)
tool6.Name = "Moongazer"
tool6.RequiresHandle = false
--
if not isfile("Epik Musics/Moongazer.mp3") then
       writefile("Epik Musics/Moongazer.mp3", game:HttpGet("https://github.com/Nitro-GT/music/raw/refs/heads/main/Moongazer.mp3"))
end
--
tool6.Equipped:Connect(function()
    if Character then
       getgenv().Animator6D(80947480089411, 1, true)
-- Music
Music6.Parent = Character
Music6.SoundId = getcustomasset("Epik Musics/Moongazer.mp3")
Music6.Looped = true
Music6:Play()
end
end)

tool6.Unequipped:Connect(function()
if Music6.Parent == Character and Music6.Playing then
    getgenv().Animator6DStop()
       Music6:Stop()
       Music6.Parent = EffectFolder
    end
    print("Dance 6 and music stopped")
end)


-- // Mannrobics Tool Dance \\ --
local tool7 = IT("Tool", Backpack)
tool7.Name = "Mannrobics"
tool7.RequiresHandle = false
--
if not isfile("Epik Musics/Mannrobics.mp3") then
       writefile("Epik Musics/Mannrobics.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Mannrobics.mp3"))
end
--
tool7.Equipped:Connect(function()
    if Character then
       getgenv().Animator6D(3678753938, 1, true)
-- Music
Music7.Parent = Character
Music7.SoundId = getcustomasset("Epik Musics/Mannrobics.mp3")
Music7.Looped = true
Music7:Play()
end
end)

tool7.Unequipped:Connect(function()
if Music7.Parent == Character and Music7.Playing then
    getgenv().Animator6DStop()
       Music7:Stop()
       Music7.Parent = EffectFolder
    end
    print("Dance 7 and music stopped")
end)


-- // Reanimated Tool Dance \\ --
local tool8 = IT("Tool", Backpack)
tool8.Name = "Reanimated"
tool8.RequiresHandle = false
--
if not isfile("Epik Musics/Reanimated.mp3") then
       writefile("Epik Musics/Reanimated.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Reanimated.mp3"))
end
local Reanimated = game:GetObjects("rbxassetid://9382474754")[1].AnimSaves:FindFirstChild("Reanimated")
--
tool8.Equipped:Connect(function()
    if Character then
       getgenv().Animator6D(Reanimated, 1, true)
-- Music
Music8.Parent = Character
Music8.SoundId = getcustomasset("Epik Musics/Reanimated.mp3")
Music8.Looped = true
Music8:Play()
end
end)

tool8.Unequipped:Connect(function()
if Music8.Parent == Character and Music8.Playing then
    getgenv().Animator6DStop()
       Music8:Stop()
       Music8.Parent = EffectFolder
    end
    print("Dance 8 and music stopped")
end)


-- // Goopie Tool Dance \\ --
local tool9 = IT("Tool", Backpack)
tool9.Name = "Goopie"
tool9.RequiresHandle = false
--
if not isfile("Epik Musics/Goopie.mp3") then
       writefile("Epik Musics/Goopie.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Goopie.mp3"))
end
--
tool9.Equipped:Connect(function()
    if Character then
       getgenv().Animator6D(13096880262, 1, true)
-- Music
Music9.Parent = Character
Music9.SoundId = getcustomasset("Epik Musics/Goopie.mp3")
Music9.Looped = true
Music9:Play()
end
end)

tool9.Unequipped:Connect(function()
if Music9.Parent == Character and Music9.Playing then
    getgenv().Animator6DStop()
       Music9:Stop()
       Music9.Parent = EffectFolder
    end
    print("Dance 9 and music stopped")
end)


-- // Fresh Tool Dance \\ --
local tool10 = IT("Tool", Backpack)
tool10.Name = "Fresh"
tool10.RequiresHandle = false
--
if not isfile("Epik Musics/Fresh.mp3") then
       writefile("Epik Musics/Fresh.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Fresh.mp3"))
end
local Fresh = game:GetObjects("rbxassetid://93309532260574")[1].Emotes.AnimSaves["Fresh"]
--
tool10.Equipped:Connect(function()
    if Character then
         Humanoid.WalkSpeed = 5
       getgenv().Animator6D(Fresh, 1, true)
-- Music
Music10.Parent = Character
Music10.SoundId = getcustomasset("Epik Musics/Fresh.mp3")
Music10.Looped = true
Music10:Play()
end
end)

tool10.Unequipped:Connect(function()
if Music10.Parent == Character and Music10.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
       Music10:Stop()
       Music10.Parent = EffectFolder
    end
    print("Dance 10 and music stopped")
end)


-- // SequênciaDeVapor Tool Dance \\ --
local tool11 = IT("Tool", Backpack)
tool11.Name = "SequênciaDeVapor"
tool11.RequiresHandle = false
--
if not isfile("Epik Musics/SequenciaDeVapor.mp3") then
       writefile("Epik Musics/SequenciaDeVapor.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/SequenciaDeVapor.mp3"))
end
local Sequencia = game:GetObjects("rbxassetid://93309532260574")[1].Emotes.AnimSaves["Sea Santis"]
--
tool11.Equipped:Connect(function()
    if Character then
        Humanoid.WalkSpeed = 0
       getgenv().Animator6D(Sequencia, 1, true)
-- Music
Music11.Parent = Character
Music11.SoundId = getcustomasset("Epik Musics/SequenciaDeVapor.mp3")
Music11.Looped = true
Music11:Play()
end
end)

tool11.Unequipped:Connect(function()
if Music11.Parent == Character and Music11.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
       Music11:Stop()
       Music11.Parent = EffectFolder
    end
    print("Dance 11 and music stopped")
end)


-- // Mr.WMD Boombox Tool Dance \\ --
local tool12 = IT("Tool", Backpack)
tool12.Name = "Mr.WMD Boombox"
tool12.RequiresHandle = false
--
local handle = IT("Part")
handle.Name = "Handle"
handle.Size = V3(0.01, 0.01, 0.01)
handle.CanCollide = false
handle.Anchored = false
handle.Parent = tool12

local weld = IT("WeldConstraint")
handle.CFrame = Character["Right Leg"].CFrame * CF(0, -1, 0) * CFrame.Angles(0, RAD(90), 0)
handle.Parent = Character["Right Leg"]
weld.Part0 = Character["Right Leg"]
weld.Part1 = handle
weld.Parent = handle
--
if not isfile("Epik Musics/Wipe me Down.mp3") then
       writefile("Epik Musics/Wipe me Down.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Wipe%20me%20Down.mp3"))
end
local Boombox = game:GetObjects("rbxassetid://93309532260574")[1].Emotes.AnimSaves["Rapper box"]
--
tool12.Equipped:Connect(function()
    if Character and mesh.Parent == EffectFolder then
        mesh.Parent = handle
        Humanoid.WalkSpeed = 0
       getgenv().Animator6D(Boombox, 1, true)
-- Music
Music12.Parent = Character
Music12.SoundId = getcustomasset("Epik Musics/Wipe me Down.mp3")
Music12.Looped = true
Music12:Play()
end
end)

tool12.Unequipped:Connect(function()
Humanoid.WalkSpeed = 16
if Music12.Parent == Character and Music12.Playing then
    getgenv().Animator6DStop()
    Music12:Stop()
    Music12.Parent = EffectFolder
    end
     if mesh.Parent == handle then
        mesh.Parent = EffectFolder
     end
    print("Dance 12 and music stopped")
end)


-- // Take The L Tool Dance \\ --
local tool13 = IT("Tool", Backpack)
tool13.Name = "Take The L"
tool13.RequiresHandle = false
--
if not isfile("Epik Musics/L Emote.mp3") then
       writefile("Epik Musics/L Emote.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/L%20Emote.mp3"))
end
local TakeTheL= game:GetObjects("rbxassetid://8903870018")[1].AnimSaves["Take The L"]
--
tool13.Equipped:Connect(function()
    if Character then
        Humanoid.WalkSpeed = 6.5
       getgenv().Animator6D(TakeTheL, 1, true)
-- Music
Music13.Parent = Character
Music13.SoundId = getcustomasset("Epik Musics/L Emote.mp3")
Music13.Looped = true
Music13:Play()
end
end)

tool13.Unequipped:Connect(function()
if Music13.Parent == Character and Music13.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
       Music13:Stop()
       Music13.Parent = EffectFolder
    end
    print("Dance 13 and music stopped")
end)


-- // It's a Secret Tool Dance \\ --
local tool14 = IT("Tool", Backpack)
tool14.Name = "It's a Secret"
tool14.RequiresHandle = false
--
if not isfile("Epik Musics/secret.mp3") then
       writefile("Epik Musics/secret.mp3", game:HttpGet("https://github.com/Nitro-GT/music/raw/refs/heads/main/secret.mp3"))
end
local ItsASecret = game:GetObjects("rbxassetid://17767173972")[1].AnimSaves:FindFirstChild("StockDance One")
--
tool14.Equipped:Connect(function()
    if Character then
        Humanoid.WalkSpeed = 4
       getgenv().Animator6D(ItsASecret, 1, true)
-- Music
Music14.Parent = Character
Music14.SoundId = getcustomasset("Epik Musics/secret.mp3")
Music14.Looped = true
Music14:Play()
end
end)

tool14.Unequipped:Connect(function()
if Music14.Parent == Character and Music14.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
    Music14:Stop()
    Music14.Parent = EffectFolder
end
    print("Dance 14 and music stopped")
end)


-- // Caramelldansen Tool Dance \\ --
local tool15 = IT("Tool", Backpack)
tool15.Name = "Caramelldansen"
tool15.RequiresHandle = false
--
if not isfile("Epik Musics/caramell.mp3") then
       writefile("Epik Musics/caramell.mp3", game:HttpGet("https://github.com/Nitro-GT/music/raw/refs/heads/main/caramell.mp3"))
end
local caramell = game:GetObjects("rbxassetid://6929983041")[1].AnimSaves:FindFirstChild("Imported Animation Clip")
--
tool15.Equipped:Connect(function()
    if Character then
        Humanoid.WalkSpeed = 2.5
       getgenv().Animator6D(caramell, 1, true)
-- Music
Music15.Parent = Character
Music15.SoundId = getcustomasset("Epik Musics/caramell.mp3")
Music15.Looped = true
Music15:Play()
end
end)

tool15.Unequipped:Connect(function()
if Music15.Parent == Character and Music15.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
    Music15:Stop()
    Music15.Parent = EffectFolder
end
    print("Dance 15 and music stopped")
end)


-- // Spooky Month Tool Dance \\ --
local tool16 = IT("Tool", Backpack)
tool16.Name = "Spooky Month"
tool16.RequiresHandle = false
--
if not isfile("Epik Musics/Spooky Month.mp3") then
       writefile("Epik Musics/Spooky Month.mp3", game:HttpGet("https://github.com/gObl00x/Epik-Musics/raw/refs/heads/main/Spooky%20Month.mp3"))
end
local Spooky = game:GetObjects("rbxassetid://11512762330")[1].AnimSaves:FindFirstChild("Pump Idle")
--
tool16.Equipped:Connect(function()
    if Character then
        Humanoid.WalkSpeed = 2.5
       getgenv().Animator6D(Spooky, 1, true)
-- Music
Music16.Parent = Character
Music16.SoundId = getcustomasset("Epik Musics/Spooky Month.mp3")
Music16.Looped = true
Music16:Play()
end
end)

tool16.Unequipped:Connect(function()
if Music16.Parent == Character and Music16.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
    Music16:Stop()
    Music16.Parent = EffectFolder
end
    print("Dance 16 and music stopped")
end)


-- // Boogie Down Tool Dance \\ --
local tool17 = IT("Tool", Backpack)
tool17.Name = "Boogie Down"
tool17.RequiresHandle = false
local Boogie = game:GetObjects("rbxassetid://16621824519")[1].AnimSaves:FindFirstChild("Boogie Down")
--
tool17.Equipped:Connect(function()
    if Character then
        Humanoid.WalkSpeed = 1.5
       getgenv().Animator6D(Boogie, 1.1, true)
Music17.Parent = Character
Music17.SoundId = getcustomasset("Epik Musics/boogie.mp3")
Music17.Looped = true
Music17.PlaybackSpeed = 2
Music17:Play()
end
end)

tool17.Unequipped:Connect(function()
if Music17.Parent == Character and Music17.Playing then
Humanoid.WalkSpeed = 16
    getgenv().Animator6DStop()
    Music17:Stop()
    Music17.Parent = EffectFolder
end
    print("Dance 17 and music stopped")
end)
