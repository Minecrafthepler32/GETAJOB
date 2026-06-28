local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local crequest = syn and syn.request or request or fluxus and fluxus.request or http and http.request or http_request or sentinel and sentinel.request  or http_request or http.request or http and http.request or http_request or (crypt and crypt.request) or request or (SENTINEL_LOADED and request) or (syn and syn.request)  or (typeof(request) == "function" and request) or (typeof(http) == "table" and http.request)
local JSON_URL = "https://raw.githubusercontent.com/Minecrafthepler32/GETAJOB/refs/heads/main/Tags.json"
local MAX_RETRIES = 3

local function fetchJson(url2, maxRetries)
  local retries = 0
  local tagConfig = {}
  while retries < maxRetries do
    local success, result = pcall(function()
    return crequest({
      Url = url2,
      method = "GET"
    })
    end)
    if success then
      local decodeSuccess, decoded = pcall(function()
      return HttpService:JSONDecode(result.Body)
      end)
      if decodeSuccess then
        return true, decoded
      end
    end
    retries = retries + 1
    if retries < maxRetries then
      local delay = 2 ^ (retries - 1)
      task.wait(delay)
    end
  end
  return false, tagConfig
end

-- Initialize tagConfig and playerToTag
local success, tagConfig = fetchJson(JSON_URL, MAX_RETRIES)
if not success then
end


local tagOrder = {
  "OWNER",
  "HEAD STAFF",
  "STAFF",
  "HELPER",
  "LUA",
  "LYRICAL TOP 1",
  "CONTENT CREATOR",
  "UNICORN",
  "TRIAL SUPPORT",
  "X1 CLAN",
  "BOOSTER",
  "AAVOX",
  "POSSESSIVE",
  "BLAZE",
  "LS_CORTISOL",
}


local playerToTag = {}
for _, tag in ipairs(tagOrder) do
  local users = tagConfig[tag]
  if users then
    for _, user in ipairs(users) do
      local userLower = user:lower()
      if not playerToTag[userLower] then
        playerToTag[userLower] = tag
      end
    end
  end
end

local function containsIgnoreCase(tbl, name)
  if not name then return false end
  name = name:lower()
  for _, v in ipairs(tbl) do
    if v:lower() == name then
      return true
    end
  end
  return false
end

local CONFIG = {
  TAG_SIZE = UDim2.new(0, 0, 0, 50),
  TAG_OFFSET = Vector3.new(0, 2.0, 0),
  MAX_DISTANCE = 200000,
  DISTANCE_THRESHOLD = 50,
  HYSTERESIS = 5,
  CORNER_RADIUS = UDim.new(0, 14),
  PARTICLE_COUNT = 100,
  PARTICLE_SPEED = 1,
  GLOW_INTENSITY = 0.3,
  TELEPORT_DISTANCE = 5,
  TELEPORT_HEIGHT = 0.5,
}

local RankData = {
  ["OWNER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    iconSize = 42,
    accent = Color3.fromRGB(255, 255, 255),
    textColor = Color3.fromRGB(0, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=128634152988614",
    bgImage = "http://www.roblox.com/asset/?id=137782422455419"
  },
  ["HEAD STAFF"] = {
    primary = Color3.fromRGB(40, 0, 0),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=106870651652993"
  },
  ["STAFF"] = {
    primary = Color3.fromRGB(20, 5, 40),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(136, 8, 245),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=136550682719041"
  },
  ["HELPER"] = {
    primary = Color3.fromRGB(0, 60, 10),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(0, 255, 17),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=81973257981596",
    displayName = "SUPPORT"
  },
  ["CONTENT CREATOR"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = true,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=125307718842922"
  },
  ["LUA"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(241, 196, 15),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=125279982901185"
  },
  ["LYRICAL TOP 1"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(241, 196, 15),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=120047190610839"
  },
  ["UNICORN"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(244, 127, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=78358017581010"
  },
  ["TRIAL SUPPORT"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(184, 216, 190),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=136941951960092"
  },
  ["X1 CLAN"] = {
    primary = Color3.fromRGB(5, 5, 30),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(80, 80, 255),
    emoji = "",
    image = ""
  },
  ["BOOSTER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(244, 127, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=117161675744244"
  },
  ["AAVOX"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    iconSize = 42,
    accent = Color3.fromRGB(255, 255, 255),
    textColor = Color3.fromRGB(255, 255, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=75863367002079",
    bgImage = "http://www.roblox.com/asset/?id=75863367002079"
  },
  ["POSSESSIVE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    iconSize = 42,
    accent = Color3.fromRGB(255, 0, 0),
    textColor = Color3.fromRGB(255, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=127768024083075",
    bgImage = "http://www.roblox.com/asset/?id=110094788133802"
  },
  ["BLAZE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    iconSize = 42,
    accent = Color3.fromRGB(0, 0, 0),
    textColor = Color3.fromRGB(255, 255, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=132678005842294",
    bgImage = "http://www.roblox.com/asset/?id=90737239054488"
  },
  ["LS_CORTISOL"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    iconSize = 42,
    accent = Color3.fromRGB(0, 0, 139),
    textColor = Color3.fromRGB(0, 120, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=80458187674158",
    bgImage = "http://www.roblox.com/asset/?id=94082715671696"
  },
  ["Xnoctis"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = ColorSequence.new{
      ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 230)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    },
    emoji = "",
    image = "http://www.roblox.com/asset/?id=94120267834005"
  },
}


local ChatWhitelist = {}

local function modifyString(randomText)
  local modified = ""
  for char in randomText:gmatch(".") do
    if char ~= " " then
      modified = modified .. char
    end
  end
  return modified
end

local message = "imusing-AKADMIN!"
local modifiedMessage = modifyString(message)



local function createParticles(tag, parent, accentColor)
  local TweenService = game:GetService("TweenService")

  for i = 1, CONFIG.PARTICLE_COUNT do
    local particle = Instance.new("Frame")
    particle.Name = "Particle_" .. i
    particle.Size = UDim2.new(0, math.random(1, 6), 0, math.random(1, 6))
    particle.Position = UDim2.new(math.random(), math.random(-10, 10), 1 + math.random() * 0.5, 0)
    particle.BackgroundTransparency = math.random(0, 0.4)
    particle.BorderSizePixel = 0
    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(1, 10)
    pCorner.Parent = particle
    -- ✅ Add the gradient if accentColor is a ColorSequence
    if typeof(accentColor) == "ColorSequence" then
      local gradient = Instance.new("UIGradient")
      gradient.Color = accentColor
      gradient.Rotation = math.random(0, 360) -- Optional: randomize direction
      gradient.Parent = particle
    elseif typeof(accentColor) == "Color3" then
      -- If it's a single color, apply it directly
      particle.BackgroundColor3 = accentColor
    end

    particle.Parent = parent
    spawn(function()
    while tag and tag.Parent do
      local startX = math.random()
      local startOffsetX = math.random(-10, 10)
      particle.Position = UDim2.new(startX, startOffsetX, 1 + math.random() * 0.5, 0)
      particle.Size = UDim2.new(0, math.random(1, 6), 0, math.random(1, 6))
      particle.BackgroundTransparency = math.random(0, 0.4)
      local duration = math.random(10, 40) / (CONFIG.PARTICLE_SPEED * 10)
      local endX = startX + (math.random() - 0.5) * 0.3
      local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
      local tween = TweenService:Create(particle, tweenInfo, {
        Position = UDim2.new(endX, startOffsetX, -0.5, math.random(-20, 20)),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
      })
      tween:Play()
      task.wait(duration)
    end
    end)
  end
end

local teleportDebounce = false
local function teleportToPlayer(targetPlayer)
  if teleportDebounce then return end
  teleportDebounce = true
  local localPlayer = Players.LocalPlayer
  local character = localPlayer.Character
  local targetCharacter = targetPlayer.Character
  if not (character and targetCharacter) then teleportDebounce = false return end
  local humanoid = character:FindFirstChild("Humanoid")
  local hrp = character:FindFirstChild("HumanoidRootPart")
  local targetHRP = targetCharacter:FindFirstChild("UpperTorso") or targetCharacter:FindFirstChild("HumanoidRootPart")
  if not (humanoid and hrp and targetHRP) then teleportDebounce = false return end
  local targetCFrame = targetHRP.CFrame
  local teleportPosition = targetCFrame.Position - (targetCFrame.LookVector * CONFIG.TELEPORT_DISTANCE)
  teleportPosition = teleportPosition + Vector3.new(0, CONFIG.TELEPORT_HEIGHT, 0)
  local particlepart = Instance.new("Part", workspace)
  particlepart.Transparency = 1
  particlepart.Anchored = true
  particlepart.CanCollide = false
  particlepart.Position = hrp.Position
  local transmitter1 = Instance.new("ParticleEmitter")
  transmitter1.Texture = "http://www.roblox.com/asset/?id=89296104222585"
  transmitter1.Size = NumberSequence.new(4)
  transmitter1.Lifetime = NumberRange.new(0.15, 0.15)
  transmitter1.Rate = 100
  transmitter1.TimeScale = 0.25
  transmitter1.VelocityInheritance = 1
  transmitter1.Drag = 5
  transmitter1.Parent = particlepart
  local particlepart2 = Instance.new("Part", workspace)
  particlepart2.Transparency = 1
  particlepart2.Anchored = true
  particlepart2.CanCollide = false
  particlepart2.Position = teleportPosition
  local transmitter2 = Instance.new("ParticleEmitter")
  transmitter2.Texture = "http://www.roblox.com/asset/?id=89296104222585"
  transmitter2.Size = NumberSequence.new(4)
  transmitter2.Lifetime = NumberRange.new(0.15, 0.15)
  transmitter2.Rate = 100
  transmitter2.TimeScale = 0.25
  transmitter2.VelocityInheritance = 1
  transmitter2.Drag = 5
  transmitter2.Parent = particlepart2
  local fadeTime = 0.1
  local tweenInfo = TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
  local meshParts = {}
  local originalTransparency = {}
  for _, part in ipairs(character:GetDescendants()) do
    if part:IsA("MeshPart") or part:IsA("Part") then
      -- Skip parts inside Accessories (e.g. Korblox leg replacement)
      local isAccessory = false
      local ancestor = part.Parent
      while ancestor and ancestor ~= character do
        if ancestor:IsA("Accessory") then
          isAccessory = true
          break
        end
        ancestor = ancestor.Parent
      end
      if not isAccessory then
        table.insert(meshParts, part)
        originalTransparency[part] = part.Transparency
      end
    end
  end
  for _, part in ipairs(meshParts) do
    if part.Name == "HumanoidRootPart" then continue end
    local tween = TweenService:Create(part, tweenInfo, {Transparency = 1})
    tween:Play()
  end
  task.wait(fadeTime)
  hrp.CFrame = CFrame.new(teleportPosition, targetHRP.Position)
  local teleportSound = Instance.new("Sound")
  teleportSound.SoundId = "rbxassetid://140492333775342"
  teleportSound.Parent = hrp
  teleportSound.Volume = 0.5
  teleportSound:Play()
  for _, part in ipairs(meshParts) do
    if part.Name == "HumanoidRootPart" then continue end
    local origTrans = originalTransparency[part] or 0
    local tween = TweenService:Create(part, tweenInfo, {Transparency = origTrans})
    tween:Play()
  end
  game.Debris:AddItem(teleportSound, 2)
  game.Debris:AddItem(particlepart, 1)
  game.Debris:AddItem(particlepart2, 1)
  task.wait(fadeTime + 0.2)
  teleportDebounce = false
end

local function getTextWidth(text, font, textSize)
  local size = TextService:GetTextSize(text, textSize, font, Vector2.new(2000, CONFIG.TAG_SIZE.Y.Offset))
  return math.ceil(size.X)
end

local function attachTagToHead(character, player, rankText)
  local head = character:FindFirstChild("Head")
  if not head then return end
  local humanoid = character:FindFirstChildOfClass("Humanoid")
  if humanoid then
    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
  end
  for _, child in ipairs(head:GetChildren()) do
    if child.Name == "RankTag" then
      child:Destroy()
    end
  end
  local rankData = RankData[rankText] or { primary = Color3.fromRGB(20, 20, 20), AnimateName = false, JumpLetters = false, GlitchName = false, accent = Color3.fromRGB(114, 47, 55), emoji = "", image = "" }
  local displayRankText = rankData.displayName or rankText
  if rankText == "Xnoctis" then
    displayRankText = string.upper(displayRankText)
  end
  local tag = Instance.new("BillboardGui")
  tag.Name = "RankTag"
  tag.Adornee = head
  tag.Size = CONFIG.TAG_SIZE
  tag.StudsOffset = CONFIG.TAG_OFFSET
  tag.AlwaysOnTop = true
  tag.MaxDistance = CONFIG.MAX_DISTANCE
  tag.LightInfluence = 0
  tag.ResetOnSpawn = false
  tag.Active = true
  -- Utility: Detect if it's a ColorSequence
  local function isColorSequence(value)
    return typeof(value) == "ColorSequence"
  end

  -- Background image layer (below everything, for ranks that use bgImage)
  if rankData.bgImage and rankData.bgImage ~= "" then
    local bgImage = Instance.new("ImageLabel")
    bgImage.Name = "BgImage"
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.Position = UDim2.new(0, 0, 0, 0)
    bgImage.BackgroundTransparency = 1
    bgImage.Image = rankData.bgImage
    bgImage.ScaleType = Enum.ScaleType.Stretch
    bgImage.ZIndex = 0
    bgImage.Parent = tag
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = CONFIG.CORNER_RADIUS
    bgCorner.Parent = bgImage
  end

  -- Main container (tag background)
  local container = Instance.new("Frame")
  container.Name = "TagContainer"
  container.Size = UDim2.new(1, 0, 1, 0)
  container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  container.BackgroundTransparency = (rankData.bgImage and rankData.bgImage ~= "") and 1 or 0
  container.BorderSizePixel = 0
  container.ClipsDescendants = false
  container.ZIndex = 1
  container.Parent = tag

  local containerCorner = Instance.new("UICorner")
  containerCorner.CornerRadius = CONFIG.CORNER_RADIUS
  containerCorner.Parent = container

  -- Border: OWNER gets thickness 2, everyone else 1.5; Xnoctis has no border
  local isOwner = rankText == "OWNER" or rankText == "AAVOX" or rankText == "POSSESSIVE" or rankText == "BLAZE"
  local borderThickness = isOwner and 2 or 1.5
  local border = Instance.new("UIStroke")
  border.Color = typeof(rankData.accent) == "Color3" and rankData.accent or Color3.fromRGB(35, 35, 35)
  border.Thickness = borderThickness
  border.Transparency = (rankText == "Xnoctis") and 1 or 0
  border.Parent = container

  local clickButton = Instance.new("TextButton")
  clickButton.Name = "ClickButton"
  clickButton.Size = UDim2.new(1, 0, 1, 0)
  clickButton.BackgroundTransparency = 1
  clickButton.Text = ""
  clickButton.ZIndex = 10
  clickButton.AutoButtonColor = false
  clickButton.Active = true
  clickButton.Parent = container
  if player ~= Players.LocalPlayer then
    clickButton.MouseButton1Click:Connect(function()
    teleportToPlayer(player)
    end)
  end

  local iconSize = rankData.iconSize or 30
  local emojiLabel
  local pfpImage = nil
  local pfpCorner = nil
  if rankData.UseImage and rankData.image ~= "" then
    emojiLabel = Instance.new("ImageLabel")
    emojiLabel.Name = "EmojiLabel"
    emojiLabel.Size = UDim2.new(0, iconSize, 0, iconSize)
    emojiLabel.Position = UDim2.new(0, 8, 0.5, -iconSize/2)
    emojiLabel.BackgroundTransparency = 1
    emojiLabel.Image = rankData.image
    emojiLabel.ScaleType = Enum.ScaleType.Crop
    emojiLabel.ZIndex = 5
    emojiLabel.Parent = container
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 7)
    iconCorner.Parent = emojiLabel
    pfpImage = emojiLabel
    pfpCorner = iconCorner
  else
    emojiLabel = Instance.new("TextLabel")
    emojiLabel.Name = "EmojiLabel"
    emojiLabel.Size = UDim2.new(0, 30, 0, 30)
    emojiLabel.Position = UDim2.new(0, 8, 0.5, -15)
    emojiLabel.BackgroundTransparency = 1
    emojiLabel.Text = rankData.emoji
    emojiLabel.TextSize = 22
    emojiLabel.Font = Enum.Font.GothamBold
    emojiLabel.TextColor3 = Color3.new(1, 1, 1)
    emojiLabel.ZIndex = 5
    emojiLabel.Parent = container
  end
  local displayNameLabel = Instance.new("TextLabel")
  displayNameLabel.Name = "DisplayNameLabel"
  displayNameLabel.BackgroundTransparency = 1
  -- Clear any existing gradients from displayNameLabel
  for _, child in ipairs(displayNameLabel:GetChildren()) do
    if child:IsA("UIGradient") then
      child:Destroy()
    end
  end
  local fullDisplayName = player.DisplayName or player.Name
  displayNameLabel.Text = "@" .. fullDisplayName
  displayNameLabel.TextSize = 10
  displayNameLabel.Font = Enum.Font.GothamBold
  displayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
  displayNameLabel.ZIndex = 5

  displayNameLabel.TextColor3 = (rankText == "Xnoctis") and Color3.fromRGB(160, 160, 160) or (rankData.textColor or Color3.new(1, 1, 1))
  displayNameLabel.RichText = false

  local rankLabel = Instance.new("TextLabel")
  rankLabel.Name = "RankLabel"
  rankLabel.BackgroundTransparency = 1
  rankLabel.Text = displayRankText
  rankLabel.TextSize = 14
  rankLabel.Font = Enum.Font.GothamBold
  rankLabel.TextXAlignment = Enum.TextXAlignment.Left
  rankLabel.ZIndex = 5

  -- Clear any existing gradients from rankLabel
  for _, child in ipairs(rankLabel:GetChildren()) do
    if child:IsA("UIGradient") then
      child:Destroy()
    end
  end

  rankLabel.TextColor3 = rankData.textColor or Color3.new(1, 1, 1)

  spawn(function()
  while tag and tag.Parent do
    if rankData.AnimateName then
      local name = displayRankText
      local blinkCount = 5
      local typingDelay = 0.1
      local blinkDelay = 0.5
      for i = 1, #name do
        rankLabel.Text = string.sub(name, 1, i) .. "|"
        wait(typingDelay)
      end
      for i = 1, blinkCount do
        rankLabel.Text = name .. "|"
        wait(blinkDelay)
        rankLabel.Text = name
        wait(blinkDelay)
      end
      for i = #name, 1, -1 do
        rankLabel.Text = string.sub(name, 1, i) .. "|"
        wait(typingDelay)
      end
      for i = 1, blinkCount do
        rankLabel.Text = "|"
        wait(blinkDelay)
        rankLabel.Text = ""
        wait(blinkDelay)
      end
    elseif rankData.JumpLetters then
      local text = displayRankText
      local jumpDuration = 0.2
      local pauseDuration = 0.5
      local jumpIterations = 3
      for iteration = 1, jumpIterations do
        for i = 1, #text do
          local before = string.sub(text, 1, i-1)
          local current = string.sub(text, i, i)
          local after = string.sub(text, i+1)
          rankLabel.Text = before .. string.lower(current) .. after
          wait(jumpDuration)
          rankLabel.Text = text
          wait(jumpDuration)
        end
        wait(pauseDuration)
      end
    elseif rankData.GlitchName then
      local text = displayRankText
      local glitchDuration = 0.05
      local normalDuration = 0.3
      local glitchCycles = 5
      local glitchIntensity = 3
      local glitchChars = {"@", "#", "$", "%", "&", "!"}
      for cycle = 1, glitchCycles do
        rankLabel.Text = text
        wait(normalDuration)
        for artifact = 1, glitchIntensity do
          local glitchedText = ""
          for i = 1, #text do
            if math.random() < 0.3 then
              local randomChoice = math.random(1, 10)
              if randomChoice <= 7 then
                glitchedText = glitchedText .. glitchChars[math.random(1, #glitchChars)]
              elseif randomChoice <= 9 then
                local char = string.sub(text, i, i)
                if char == string.upper(char) then
                  glitchedText = glitchedText .. string.lower(char)
                else
                  glitchedText = glitchedText .. string.upper(char)
                end
              else
                glitchedText = glitchedText .. " "
              end
            else
              glitchedText = glitchedText .. string.sub(text, i, i)
            end
          end
          if math.random() < 0.3 then
            local spaces = string.rep(" ", math.random(1, 3))
            glitchedText = spaces .. glitchedText
          end
          if math.random() < 0.3 then
            local extraGlitch = ""
            for i = 1, math.random(1, 3) do
              extraGlitch = extraGlitch .. glitchChars[math.random(1, #glitchChars)]
            end
            glitchedText = glitchedText .. extraGlitch
          end
          rankLabel.Text = glitchedText
          wait(glitchDuration)
        end
        rankLabel.Text = text
        wait(normalDuration * 2)
      end
      rankLabel.Text = text
      wait(normalDuration * 3)
    else
      rankLabel.Text = displayRankText
      wait(1)
    end
  end
  end)
  local sidePadding = 24
  local emojiWidth = 36
  local emojiLabelWidth = iconSize
  local emojiLeftPadding = 8
  local rankWidthActual = getTextWidth(rankLabel.Text, rankLabel.Font, rankLabel.TextSize)
  local displayNameWidthActual = getTextWidth("@" .. fullDisplayName, displayNameLabel.Font, displayNameLabel.TextSize)
  local maxTextWidth = math.max(rankWidthActual, displayNameWidthActual)
  local totalWidth = emojiLeftPadding + emojiLabelWidth + sidePadding + maxTextWidth + sidePadding
  tag.Size = UDim2.new(0, totalWidth, 0, CONFIG.TAG_SIZE.Y.Offset)
  container.Size = UDim2.new(1, 0, 1, 0)
  emojiLabel.Position = UDim2.new(0, emojiLeftPadding, 0.5, -iconSize/2)
  emojiLabel.Size = UDim2.new(0, iconSize, 0, iconSize)
  local textBlockXOffset = emojiLeftPadding + emojiLabelWidth + sidePadding
  rankLabel.Position = UDim2.new(0, textBlockXOffset, 0, 9)
  rankLabel.Size = UDim2.new(0, rankWidthActual, 0, 16)
  rankLabel.Parent = container
  displayNameLabel.Position = UDim2.new(0, textBlockXOffset, 0, 25)
  displayNameLabel.Size = UDim2.new(0, displayNameWidthActual, 0, 16)
  displayNameLabel.Parent = container
  local isMinimized = false
  local FULL_SIZE = UDim2.new(0, totalWidth, 0, CONFIG.TAG_SIZE.Y.Offset)
  local MINI_SIZE = UDim2.new(0, 40, 0, 40)
  local MINI_OFFSET = Vector3.new(0, 1.0, 0)
  local activeTween = true
  spawn(function()
  while activeTween and tag and tag.Parent do
    if character and head and head.Parent and Players.LocalPlayer and Players.LocalPlayer.Character then
      local localHead = Players.LocalPlayer.Character:FindFirstChild("Head")
      if localHead then
        local distance = (head.Position - localHead.Position).Magnitude
        if distance > (CONFIG.DISTANCE_THRESHOLD + CONFIG.HYSTERESIS) and not isMinimized then
          isMinimized = true
          rankLabel.TextTransparency = 1
          displayNameLabel.TextTransparency = 1
          TweenService:Create(tag, TweenInfo.new(0.5), { Size = MINI_SIZE, StudsOffset = MINI_OFFSET }):Play()
          if isOwner and pfpImage then
            container.BackgroundTransparency = 1
            -- Match pfp corner to container corner so image rounds itself flush to border
            if pfpCorner then pfpCorner.CornerRadius = UDim.new(0, 10) end
            TweenService:Create(pfpImage, TweenInfo.new(0.5), { Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 1, 0) }):Play()
            TweenService:Create(containerCorner, TweenInfo.new(0.5), { CornerRadius = UDim.new(0, 10) }):Play()
          else
            TweenService:Create(emojiLabel, TweenInfo.new(0.5), { Position = UDim2.new(0.5, -15, 0.5, -15), Size = UDim2.new(0, 30, 0, 30)}):Play()
            TweenService:Create(containerCorner, TweenInfo.new(0.5), { CornerRadius = UDim.new(0, 10) }):Play()
          end
          border.Color = typeof(rankData.accent) == "Color3" and rankData.accent or Color3.fromRGB(35, 35, 35)
          border.Thickness = borderThickness
          if rankText ~= "Xnoctis" then border.Transparency = 0 end
        elseif distance < (CONFIG.DISTANCE_THRESHOLD - CONFIG.HYSTERESIS) and isMinimized then
          isMinimized = false
          TweenService:Create(tag, TweenInfo.new(0.5), { Size = FULL_SIZE, StudsOffset = CONFIG.TAG_OFFSET }):Play()
          if isOwner and pfpImage then
            container.BackgroundTransparency = (rankData.bgImage and rankData.bgImage ~= "") and 1 or 0
            container.ClipsDescendants = false
            if pfpCorner then pfpCorner.CornerRadius = UDim.new(0, 7) end
            TweenService:Create(pfpImage, TweenInfo.new(0.5), { Position = UDim2.new(0, emojiLeftPadding, 0.5, -iconSize/2), Size = UDim2.new(0, iconSize, 0, iconSize)}):Play()
          else
            TweenService:Create(emojiLabel, TweenInfo.new(0.5), { Position = UDim2.new(0, emojiLeftPadding, 0.5, -iconSize/2), Size = UDim2.new(0, iconSize, 0, iconSize)}):Play()
          end
          TweenService:Create(containerCorner, TweenInfo.new(0.5), { CornerRadius = CONFIG.CORNER_RADIUS }):Play()
          task.delay(0.25, function()
            if tag and tag.Parent then
              TweenService:Create(rankLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
              TweenService:Create(displayNameLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
            end
          end)
        end
      end
    else
      activeTween = false
    end
    task.wait(0.2)
  end
  end)
  tag.AncestryChanged:Connect(function(_, parent)
  if not parent then
    activeTween = false
  end
  end)
  Players.PlayerRemoving:Connect(function(removedPlayer)
  if removedPlayer == player then
    if tag and tag.Parent then
      tag:Destroy()
    end
    activeTween = false
  end
  end)
  tag.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
  return tag
end

local localPlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local chatConnections = {}
local ChatWhitelist = {}

local SUPABASE_URL = "https://mrrivrbhfkpiygoamnzb.supabase.co"
local SUPABASE_KEY = "sb_publishable_dVYRE5xvmiK1vBJL_rdLAA_RYHDR50R"

-- Attach tag to a player's head and reconnect on respawn
-- Always reads from playerToTag live so re-executing the script picks up new tags
local charConns = {}
local function attachTagAndConnect(player, rankText)
  attachTagToHead(player.Character, player, rankText)
  -- Disconnect old connection so re-executing doesn't stack
  if charConns[player] then charConns[player]:Disconnect() end
  charConns[player] = player.CharacterAdded:Connect(function(character)
    local liveTag = playerToTag[player.Name:lower()]
    if liveTag then
      attachTagToHead(character, player, liveTag)
    end
  end)
end

-- Destroy any existing tag for a player
local function clearTag(player)
  local localGui = Players.LocalPlayer:WaitForChild("PlayerGui")
  if player.Character and player.Character:FindFirstChild("Head") then
    local head = player.Character.Head
    for _, child in ipairs(head:GetChildren()) do
      if child:IsA("BillboardGui") and child.Name == "RankTag" then child:Destroy() end
    end
    for _, gui in ipairs(localGui:GetChildren()) do
      if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Adornee == head then gui:Destroy() end
    end
  end
end

-- Apply the correct tag to a player based on playerToTag
local function applyTag(player)
  if not player or not player:IsDescendantOf(Players) then return end
  local tag = playerToTag[player.Name:lower()]
  clearTag(player)
  if tag then
    attachTagAndConnect(player, tag)
  end
end

-- Fetch GitHub JSON, build playerToTag, then apply to all players
local function loadTagsAndApply()
  local url = JSON_URL .. "?nocache=" .. tostring(os.time()) .. tostring(math.random(1,999999))
  local success, loaded = fetchJson(url, MAX_RETRIES)

  -- Reset only GitHub-sourced tags (keep Supabase/Xnoctis entries)
  for k, v in pairs(playerToTag) do
    if v ~= "Xnoctis" then playerToTag[k] = nil end
  end

  if success then
    -- Lowercase all keys for safe matching
    local loadedLower = {}
    for k, v in pairs(loaded) do loadedLower[k:lower()] = v end

    local userPriority = {}
    for i, tag in ipairs(tagOrder) do
      local users = loadedLower[tag:lower()]
      if users then
        for _, user in ipairs(users) do
          local uLower = user:lower()
          if not userPriority[uLower] or i < userPriority[uLower] then
            userPriority[uLower] = i
            playerToTag[uLower] = tag
          end
        end
      end
    end
  end

  -- Apply to all current players
  for _, plr in ipairs(Players:GetPlayers()) do
    task.spawn(applyTag, plr)
  end

  jsonFetchDone = true
end

-- On execute: fetch GitHub first, then fallback to Supabase for anyone not in GitHub
task.spawn(function()
  -- Step 1: fetch GitHub tags
  loadTagsAndApply()

  -- Step 2: register self on Supabase and fetch Supabase users
  pcall(function()
    crequest({
      Url = SUPABASE_URL .. "/rest/v1/Users",
      Method = "POST",
      Headers = {
        ["Content-Type"] = "application/json",
        ["apikey"] = SUPABASE_KEY,
        ["Authorization"] = "Bearer " .. SUPABASE_KEY,
        ["Prefer"] = "resolution=ignore-duplicates"
      },
      Body = HttpService:JSONEncode({ username = Players.LocalPlayer.Name })
    })
  end)

  pcall(function()
    local res = crequest({
      Url = SUPABASE_URL .. "/rest/v1/Users?select=username",
      Method = "GET",
      Headers = {
        ["apikey"] = SUPABASE_KEY,
        ["Authorization"] = "Bearer " .. SUPABASE_KEY
      }
    })
    local ok, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
    if ok and data then
      for _, row in ipairs(data) do
        local u = row.username
        if u then
          local uLower = u:lower()
          -- Only give Xnoctis tag if not already assigned from GitHub
          if not playerToTag[uLower] then
            playerToTag[uLower] = "Xnoctis"
            -- Apply to player if they are in game
            for _, plr in ipairs(Players:GetPlayers()) do
              if plr.Name:lower() == uLower then
                task.spawn(applyTag, plr)
              end
            end
          end
        end
      end
    end
  end)
end)

-- New players joining after script runs
Players.PlayerAdded:Connect(function(player)
  repeat task.wait(0.1) until jsonFetchDone
  task.spawn(applyTag, player)
end)

-- Cleanup on leave
Players.PlayerRemoving:Connect(function(player)
  if chatConnections[player] then
    chatConnections[player]:Disconnect()
    chatConnections[player] = nil
  end
  clearTag(player)
end)

-- Background loop: fix any missing tags every 2s
local localPlayerGui2 = Players.LocalPlayer:WaitForChild("PlayerGui")
spawn(function()
  repeat task.wait(0.1) until jsonFetchDone
  while task.wait(2) do
    local validHeads = {}
    for _, player in ipairs(Players:GetPlayers()) do
      if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        table.insert(validHeads, head)
        local tag = playerToTag[player.Name:lower()]
        local hasTag = false
        for _, gui in ipairs(localPlayerGui2:GetChildren()) do
          if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Adornee == head then
            hasTag = true break
          end
        end
        if tag and not hasTag then task.spawn(applyTag, player) end
        if not tag and hasTag then clearTag(player) end
      end
    end
    -- Clean orphaned tags
    for _, gui in ipairs(localPlayerGui2:GetChildren()) do
      if gui:IsA("BillboardGui") and gui.Name == "RankTag" then
        if not gui.Adornee or not gui.Adornee:IsDescendantOf(workspace) or not table.find(validHeads, gui.Adornee) then
          gui:Destroy()
        end
      end
    end
  end
end)
