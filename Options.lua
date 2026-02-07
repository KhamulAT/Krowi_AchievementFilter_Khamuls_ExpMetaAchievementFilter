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
      metaAchievements = {
        type = "group",
        inline = true,
        name = "TT | Mount Meta Achievements Settings",
        order = 1,
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
        }
      },
      decorAchievements = {
        type = "group",
        inline = true,
        name = "TT | Decoration Achievements Settings",
        order = 1,
        args = {
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
        }
      },
      campsiteAchievements = {
        type = "group",
        inline = true,
        name = "TT | Warband Campsite Achievements Settings",
        order = 3,
        args = {
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
        }
      },
      petAchievements = {
        type = "group",
        inline = true,
        name = "TT | Pet Achievements Settings",
        order = 4,
        args = {
          petAchievementsEnabled = {
            type = "toggle",
            name = L["Show List for Achievements with battle pets as reward"],
            desc = L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"],
            width = "full",
            order = 1,
            get = function()
              return KhamulsAchievementFilter.db.profile.petAchievementsEnabled
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.petAchievementsEnabled = value
            end,
          },
          flattenStructure = {
            type = "toggle",
            name = "TT | Flatten list structure",
            desc = "TT | The generated lists depth will be flatten and all achievements will be displayed in the expansions category",
            width = "full",
            order = 2,
            get = function()
              return KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure = value
            end
          },
          includeChildAchievements = {
            type = "toggle",
            name = "TT | Include Child Achievements",
            desc = "TT | If an Achievement has other Achievements as requirement, they will be shown in an extra category.",
            width = "full",
            order = 3,
            get = function()
              return KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements = value
            end
          }
        }
      },
      krowiStatus = {
        type = "description",
        order = 5,
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
