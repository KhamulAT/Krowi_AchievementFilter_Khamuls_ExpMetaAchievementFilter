-- Modules/DataSources/MetaAchievements.lua
-- A data source object (NOT an AceModule).

local ADDON_NAME = ...
local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Data = Addon:GetModule("Data")

---@type KAF_DataSource
local Source = {
  Name = "MetaAchievements",
  Items = {},
}

function Source:Init(ctx)
  -- ctx.Utilities, ctx.L, ctx.Addon are available
  self.Items = {
    971,
    {
        ctx.L["Khamul's Meta-Expansion Achievement List"],
        GetBfAList(),
        GetSLList(),
        GetDFList(),
        GetTWWList(),
        {
            GetBfAAchievementId(),
            GetSLAchievementId(),
            GetDFAchievementId(),
            GetTWWAchievementId()
        }
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
