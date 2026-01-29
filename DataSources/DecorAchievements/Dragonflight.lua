local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingDF()


    local ACM_DF_Zones_TheAzureSpan_Quests = {
        Utilities:GetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            17773
        }
    }

    local ACM_DF_Zones_TheAzureSpan = {
        Utilities:GetZoneNameByMapID(2024),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_DF_Zones_TheAzureSpan_Quests
    }

    local ACM_DF_Zones_Thaldraszus_Quests = {
        Utilities:GetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            19507
        }
    }

    local ACM_DF_Zones_Thaldraszus = {
        Utilities:GetZoneNameByMapID(2025),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_DF_Zones_Thaldraszus_Quests
    }

    local ACM_DF_Zones_TheForbiddenReach_Exploration = {
        Utilities:GetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            17529
        }
    }

    local ACM_DF_Zones_TheForbiddenReach = {
        Utilities:GetZoneNameByMapID(2151),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_DF_Zones_TheForbiddenReach_Exploration
    }

    local ACM_DF_Zones = {
        ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_DF_Zones_TheAzureSpan,
        ACM_DF_Zones_Thaldraszus,
        ACM_DF_Zones_TheForbiddenReach
    }

    local ACMList = { 
        EXPANSION_NAME9,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_DF_Zones,
        {
            19458
        }

    }

    return ACMList
end