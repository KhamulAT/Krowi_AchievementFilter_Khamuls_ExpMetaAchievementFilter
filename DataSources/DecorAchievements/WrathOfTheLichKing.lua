local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingWotLk()

    local ACM_WotLk_SholoazarBasin = {
        Utilities:GetZoneNameByMapID(119),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            938
        }
    }

    local ACM_WotLk_Zones = {
        ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_WotLk_SholoazarBasin
    }

    local ACM_WotLk_Raids_OnyxiasLair_25Player = {
        RAID_DIFFICULTY2,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            4405
        }
    }

    local ACM_WotLk_Raids_OnyxiasLair = {
        Utilities:GetDungeonNameByLFGDungeonID(257),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_WotLk_Raids_OnyxiasLair_25Player
    }

    local ACM_WotLk_Raids = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15278),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_WotLk_Raids_OnyxiasLair
    }

    local ACMList = {
        EXPANSION_NAME2,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_WotLk_Zones,
        ACM_WotLk_Raids
    }

    return ACMList
end