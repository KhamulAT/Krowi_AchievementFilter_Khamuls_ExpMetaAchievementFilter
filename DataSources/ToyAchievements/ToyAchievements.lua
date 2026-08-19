local ADDON_NAME = ...
local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Data = Addon:GetModule("Data")

local TARGET_CATEGORY_ID = 971 -- Specials tab root

---@type KAF_DataSource
local Source = {
  Name = "ToyAchievements",
  Items = {},
}

-- V2: a single injection into the Specials tab holding one named collection.
local function BuildInjection(L)
  local injection = KrowiAF.NewInjection(TARGET_CATEGORY_ID)

  injection:Insert(
    KAF_CatPlain(L["Khamul's Toy Box"])
      :Insert(GetCrossExpansionToyAchievements())
      :Insert(GetClassicToyAchievements())
      :Insert(GetWotLKToyAchievements())
      :Insert(GetMoPToyAchievements())
      :Insert(GetWoDToyAchievements())
      :Insert(GetLegionToyAchievements())
      :Insert(GetBfaToyAchievements())
      :Insert(GetSLToyAchievements())
      :Insert(GetDFToyAchievements())
      :Insert(GetTWWToyAchievements())
      :Insert(GetMNToyAchievements())
      :Insert(GetPlayerVsPlayerToyAchievements())
  )

  return injection
end

function Source:Init(ctx)
  self.Items = BuildInjection(ctx.L)
end

function Source:Rebuild()
  self.Items = BuildInjection(self.ctx.L)
end

function Source:GetItems()
  return self.Items
end

Data:RegisterSource(Source)
