local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingSL()
    local ACMList = { 
        EXPANSION_NAME8,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            Tooltip = Utilities:HousingUtilitiesReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:HousingUtilitiesGetAchievementName(20501)})
        },
        {
            20501
        }

    }

    return ACMList
end