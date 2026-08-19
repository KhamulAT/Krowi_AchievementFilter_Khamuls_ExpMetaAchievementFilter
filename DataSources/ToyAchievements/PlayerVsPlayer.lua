local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetPlayerVsPlayerToyAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        Utilities:GetAchievementCategoryNameByCategoryID(21), -- Player vs. Player
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12894, -- Honor Level 10
            12902, -- Honor Level 30
            12905, -- Honor Level 60
            12908, -- Honor Level 90
            12912, -- Honor Level 175
            19304, -- Legend: Dragonflight Season 3
            19500, -- Legend: Dragonflight Season 4
            40233, -- Strategist: The War Within Season 1
            40395, -- Legend: The War Within Season 1
            40792, -- Solo Shuffle Medic: The War Within
            41358, -- Legend: The War Within Season 2
            41363, -- Strategist: The War Within Season 2
            42023, -- Legend: The War Within Season 3
            42024, -- Strategist: The War Within Season 3
            61190, -- Legend: Midnight Season 1
            61194, -- Strategist: Midnight Season 1
            61199, -- Solo Shuffle Medic: Midnight
            61200, -- Battleground Blitz Medic: Midnight
            62932, -- Legend: Midnight Season 2
            62950, -- Strategist: Midnight Season 2
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Honor
    local ACMList_Honor = {
        Utilities:GetAchievementCategoryNameByCategoryID(15266), -- Honor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12894, -- Honor Level 10
            12902, -- Honor Level 30
            12905, -- Honor Level 60
            12908, -- Honor Level 90
            12912, -- Honor Level 175
        }
    }

    -- Dragonflight
    local ACMList_Dragonflight = {
        _G.EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            19304, -- Legend: Dragonflight Season 3
            19500, -- Legend: Dragonflight Season 4
        }
    }

    -- The War Within
    local ACMList_TheWarWithin = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40233, -- Strategist: The War Within Season 1
            40395, -- Legend: The War Within Season 1
            40792, -- Solo Shuffle Medic: The War Within
            41358, -- Legend: The War Within Season 2
            41363, -- Strategist: The War Within Season 2
            42023, -- Legend: The War Within Season 3
            42024, -- Strategist: The War Within Season 3
        }
    }

    -- Midnight
    local ACMList_Midnight = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61190, -- Legend: Midnight Season 1
            61194, -- Strategist: Midnight Season 1
            61199, -- Solo Shuffle Medic: Midnight
            61200, -- Battleground Blitz Medic: Midnight
            62932, -- Legend: Midnight Season 2
            62950, -- Strategist: Midnight Season 2
        }
    }

    local ACMList = {
        Utilities:GetAchievementCategoryNameByCategoryID(21), -- Player vs. Player
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Honor,
        ACMList_Dragonflight,
        ACMList_TheWarWithin,
        ACMList_Midnight
    }

    return ACMList
end
