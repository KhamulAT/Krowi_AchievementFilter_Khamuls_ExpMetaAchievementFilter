local ADDON_NAME = ...

local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceEvent-3.0", "AceConsole-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local defaults = {
  profile = {
    metaAchievementsEnabled = true,
    decorAchievementsEnabled = true,
    decorAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true
    },
    campsiteAchievementsEnabled = true,
    campsiteAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true
    },
    mountAchievementsEnabled = true,
    mountAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true,
      includePetRelatedStuff = true,
    },
    petAchievementsEnabled = true,
    petAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true,
      includePetRelatedStuff = true,
    },
    toyAchievementsEnabled = true,
    toyAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true
    }
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
  self.db = LibStub("AceDB-3.0"):New("Khamuls_ExpMetaAchievementFilter_Settings", defaults, true)
  -- Initialize AceConfig
  if self.InitOptions then
    self:InitOptions()
  end

  self:RegisterEvent("PLAYER_LOGIN", "OnPlayerLogin")
end

function KhamulsAchievementFilter:OnEnable()
  -- Get modules explicitly and fail fast with a clear error.
  local Utilities = self:GetModule("Utilities", true)
  if not Utilities then
    self:Print("ERROR: Module 'Utilities' is missing. Check your .toc load order and file paths.")
    return
  end
  self.Utilities = Utilities

  local Data = self:GetModule("Data", true)
  if not Data then
    self:Print("ERROR: Module 'Data' is missing. Check your .toc load order and file paths.")
    return
  end
  self.Data = Data
end

-- Each source builds a V2 injection (KrowiAF.NewInjection). Register() enqueues it
-- in KrowiAF.CategoryData for KrowiAF.CreateCategories to pick up, so this has to
-- run before that -- PLAYER_LOGIN is early enough. Registering is additive, so the
-- guard keeps a repeated call from duplicating the collection.
local registered = {}
function KhamulsAchievementFilter:RegisterSourceCategories(sourceName)
  if registered[sourceName] then
    return
  end

  local source = self.Data:GetSource(sourceName)
  if not source then
    self:Print("ERROR: Data source '" .. tostring(sourceName) .. "' is not registered.")
    return
  end

  local injection = source:GetItems()
  if not injection or not injection.Register then
    self:Print("ERROR: Data source '" .. tostring(sourceName) .. "' did not build a V2 injection.")
    return
  end

  injection:Register()
  registered[sourceName] = true
end

function KhamulsAchievementFilter:OnPlayerLogin()
  if not self:IsKrowiAFAvailable() then
    self:Print("Krowi's Achievement Filter Addon not loaded!")
    return
  end

  local Data = self:GetModule("Data", true)
  if Data and Data.InitSources then
      Data:InitSources()
  end

  local profile = self.db.profile
  local sources = {
    {profile.metaAchievementsEnabled, "MetaAchievements"},
    {profile.decorAchievementsEnabled, "DecorAchievements"},
    {profile.campsiteAchievementsEnabled, "CampsiteAchievements"},
    {profile.petAchievementsEnabled, "PetAchievements"},
    {profile.toyAchievementsEnabled, "ToyAchievements"},
    {profile.mountAchievementsEnabled, "MountAchievements"},
  }

  for _, entry in ipairs(sources) do
    if entry[1] then
      self:RegisterSourceCategories(entry[2])
    end
  end
end
