local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTBCPetAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME1, -- The Burning Crusade
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            8293, -- Raiding with Leashes II: Attunement Edition
            9824 -- Raiding with Leashes III: Drinkin' From the Sunwell
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end
    -- Raids
    local ACMList_Raids = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
           8293, -- Raiding with Leashes II: Attunement Edition
            9824 -- Raiding with Leashes III: Drinkin' From the Sunwell
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME1, -- The Burning Crusade
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Raids
    }

    return ACMList
end