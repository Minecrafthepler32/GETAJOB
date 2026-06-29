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
      method = "GET",
      Headers = {
        ["Cache-Control"] = "no-cache, no-store, must-revalidate",
        ["Pragma"] = "no-cache",
        ["Expires"] = "0"
      }
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

-- Build tagOrder dynamically from Tags.json keys
local tagOrder = {}
for tagName, _ in pairs(tagConfig) do
  table.insert(tagOrder, tagName)
end

-- Sort to maintain consistency (optional, remove if you want insertion order)
table.sort(tagOrder)

local playerToTag = {}
for _, tag in ipairs(tagOrder) do
  local tagData = tagConfig[tag]
  if tagData then
    -- Handle both array and object formats
    local users = type(tagData) == "table" and (tagData.users or tagData) or {}
    if type(users) == "table" then
      for _, user in ipairs(users) do
        if user and type(user) == "string" and user:len() > 0 then
          local userLower = user:lower()
          if not playerToTag[userLower] then
            playerToTag[userLower] = tag
          end
        end
      end
    end
  end
end

-- Build RankData from Tags.json metadata
local RankData = {}
for _, tagName in ipairs(tagOrder) do
  local tagData = tagConfig[tagName]
  if tagData and tagData.meta then
    local meta = tagData.meta
    -- Convert RGB array to Color3
    local function arrayToColor(arr)
      if arr and type(arr) == "table" then
        return Color3.fromRGB(arr[1] or 0, arr[2] or 0, arr[3] or 0)
      end
      return Color3.fromRGB(20, 20, 20)
    end

    RankData[tagName] = {
      primary = arrayToColor(meta.primary),
      AnimateName = meta.AnimateName or false,
      JumpLetters = meta.JumpLetters or false,
      GlitchName = meta.GlitchName or false,
      UseImage = meta.image and true or false,
      iconSize = meta.iconSize or 32,
      accent = arrayToColor(meta.accent),
      textColor = arrayToColor(meta.textColor),
      emoji = meta.emoji or "",
      image = meta.image or "",
      bgImage = meta.bgImage or "",
      displayName = meta.displayName,
      noBorder = meta.noBorder or false
    }
  end
end

-- Keep the rest of the script unchanged
-- (All CONFIG, attachTagToHead, and other functions remain the same)

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

-- ============ ADD REST OF ORIGINAL nametags.lua BELOW THIS LINE ============
-- (Keep all the attachTagToHead, playerAdded, background loops, etc. from line 101 onwards)
-- The only change is that RankData is now built from Tags.json metadata above
