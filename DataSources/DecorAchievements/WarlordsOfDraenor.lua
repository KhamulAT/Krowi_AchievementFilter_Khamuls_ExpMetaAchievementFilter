local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingWoD()

    local ACM_WoD_TradeSkills_Archaeology = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(15071),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            9415
        }
    }

    local ACM_WoD_TradeSkills = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(169),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_WoD_TradeSkills_Archaeology
    }

    local ACMList = {
        EXPANSION_NAME5,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_WoD_TradeSkills
    }

    return ACMList
end