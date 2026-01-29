local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function KhamulsAchievementFilter:InitOptions()
  local AceConfig = LibStub("AceConfig-3.0")
  local AceConfigDialog = LibStub("AceConfigDialog-3.0")

  local options = {
    type = "group",
    name = L["Khamuls Achievement Lists for Krowi's Achievement Filter"],
    args = {
      metaAchievementsEnabled = {
        type = "toggle",
        name = L["Show List for Expansion Meta Achievements"],
        desc = L["If enabled, a list with all achievements required for expansion meta achievements will be shown"],
        width = "full",
        order = 1,
        get = function()
          return KhamulsAchievementFilter.db.profile.metaAchievementsEnabled
        end,
        set = function(_, value)
          KhamulsAchievementFilter.db.profile.metaAchievementsEnabled = value
        end,
      },
      decorAchievementsEnabled = {
        type = "toggle",
        name = L["Show List for Achievements with decors as reward"],
        desc = L["If enabled, a list with all achievements, which have a decor as reward, will be shown"],
        width = "full",
        order = 2,
        get = function()
          return KhamulsAchievementFilter.db.profile.decorAchievementsEnabled
        end,
        set = function(_, value)
          KhamulsAchievementFilter.db.profile.decorAchievementsEnabled = value
        end,
      },
      campsiteAchievementsEnabled = {
        type = "toggle",
        name = L["Show List for Achievements with warband campsites as reward"],
        desc = L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"],
        width = "full",
        order = 2,
        get = function()
          return KhamulsAchievementFilter.db.profile.campsiteAchievementsEnabled
        end,
        set = function(_, value)
          KhamulsAchievementFilter.db.profile.campsiteAchievementsEnabled = value
        end,
      },
      krowiStatus = {
        type = "description",
        order = 3,
        name = function()
          if KhamulsAchievementFilter:IsKrowiAFAvailable() then
            return L["Krowi AchievementFilter status: "] .. L["detected"]
          end
          return L["Krowi AchievementFilter status: "] .. L["not detected"]
        end,
        width = "full",
      },
    },
  }

  AceConfig:RegisterOptionsTable(ADDON_NAME, options)

  self.optionsFrame = AceConfigDialog:AddToBlizOptions(ADDON_NAME, L["Khamuls Achievement Lists for Krowi's Achievement Filter"])
end
