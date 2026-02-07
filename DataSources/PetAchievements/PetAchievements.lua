-- Modules/DataSources/MetaAchievements.lua
-- A data source object (NOT an AceModule).

local ADDON_NAME = ...
local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Data = Addon:GetModule("Data")

---@type KAF_DataSource
local Source = {
  Name = "PetAchievements",
  Items = {},
}

function Source:Init(ctx)
  -- ctx.Utilities, ctx.L, ctx.Addon are available
  self.Items = {
    971,
    {
        ctx.L["Khamul's Battle Pet Achievement List"],
        GetCrossExpansionPetAchievements(),
        GetClassicPetAchievements(),
        GetTBCPetAchievements(),
        GetWotLKPetAchievements(),
        GetCataPetAchievements(),
        GetMoPPetAchievements(),
        GetWoDPetAchievements(),
        GetLegionPetAchievements(),
        GetBfaPetAchievements(),
        GetSLPetAchievements(),
        GetDFPetAchievements(),
        GetTWWPetAchievements(),
        GetMNPetAchievements()
    }
  }
end

function Source:Rebuild()
  -- Example rebuild logic
  -- self.ctx.Utilities:SomeHelper()
  -- local text = self.ctx.L["SOME_KEY"]
end

function Source:GetItems()
  return self.Items
end

Data:RegisterSource(Source)
