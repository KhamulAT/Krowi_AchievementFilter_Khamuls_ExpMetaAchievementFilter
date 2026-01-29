local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingMoP()

    local ACM_MoP_Scenarios_BloodInTheSnow = {
        Utilities:GetDungeonNameByLFGDungeonID(646),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            8316
        }
    }

    local ACM_MoP_Scenarios = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15302),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_MoP_Scenarios_BloodInTheSnow
    }

    local ACMList = {
        EXPANSION_NAME4,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_MoP_Scenarios
    }

    return ACMList
end