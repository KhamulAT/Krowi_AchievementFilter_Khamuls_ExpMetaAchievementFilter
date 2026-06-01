local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetClassicMountAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME0, -- Classic
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9550 -- Boldly, You Sought the Power of Ragnaros
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons & Raids -> Molten Core
    local ACMList_DungeonsAndRaidsMoltenCore = {
        Utilities:GetZoneNameByMapID(232),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9550 -- Boldly, You Sought the Power of Ragnaros
        }
    }

    -- Dungeons & Raids
    local ACMList_DungeonsAndRaids = {
        Utilities:GetAchievementCategoryNameByCategoryID(168), -- Dungeons & Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_DungeonsAndRaidsMoltenCore
    }

    local ACMList = {
        _G.EXPANSION_NAME0, -- Classic
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_DungeonsAndRaids
    }

    return ACMList
end