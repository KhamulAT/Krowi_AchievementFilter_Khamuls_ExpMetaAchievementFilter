local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)

function KhamulsAchievementFilter:InitOptions()
  local AceConfig = LibStub("AceConfig-3.0")
  local AceConfigDialog = LibStub("AceConfigDialog-3.0")

  local options = {
    type = "group",
    name = ADDON_NAME,
    args = {
      enabled = {
        type = "toggle",
        name = "Enabled",
        desc = "Enable/disable this extension behavior.",
        width = "full",
        get = function()
          return KhamulsAchievementFilter.db.profile.enabled
        end,
        set = function(_, value)
          KhamulsAchievementFilter.db.profile.enabled = value
        end,
      },
      krowiStatus = {
        type = "description",
        name = function()
          if KhamulsAchievementFilter:IsKrowiAFAvailable() then
            return "KrowiAF status: detected"
          end
          return "KrowiAF status: not detected"
        end,
        width = "full",
      },
    },
  }

  AceConfig:RegisterOptionsTable(ADDON_NAME, options)

  self.optionsFrame = AceConfigDialog:AddToBlizOptions(ADDON_NAME, ADDON_NAME)
end
