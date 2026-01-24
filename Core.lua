local ADDON_NAME = ...

local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceEvent-3.0", "AceConsole-3.0")

local defaults = {
  profile = {
    enabled = true,
  },
}

-- Dependency check
function KhamulsAchievementFilter:IsKrowiAFAvailable()
  if _G.KrowiAF then
    return true
  end

  return false
end

function KhamulsAchievementFilter:OnInitialize()
    -- Initialize AceDB
  self.db = LibStub("AceDB-3.0"):New("Krowi_AchievementFilter_Khamuls_ExpMetaAchievementFilter", defaults, true)

  -- Initialize AceConfig
  if self.InitOptions then
    self:InitOptions()
  end

  self:RegisterEvent("PLAYER_LOGIN", "OnPlayerLogin")
end

function KhamulsAchievementFilter:OnEnable()
  
end

function KhamulsAchievementFilter:OnPlayerLogin()
  if not self:IsKrowiAFAvailable() then
    self:Print("Krowi's Achievement Filter Addon not loaded!")
    return
  end

  if self.db.profile.enabled then
    self:Print("PLAYER_LOGIN received. KrowiAF detected. Filter extension enabled.")
  end
end
