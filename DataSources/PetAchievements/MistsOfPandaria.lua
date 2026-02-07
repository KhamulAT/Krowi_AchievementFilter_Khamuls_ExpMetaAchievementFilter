local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMoPPetAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME4, -- Mists of Pandaria
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            6402, -- Ling-Ting's Herbal Journey
            13469, -- Raiding with Leashes VI: Pets of Pandaria
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons
    local ACMList_Dungeons = {
        _G.DUNGEONS, -- Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(469),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                6402
            }
        }
    }

    -- PetBattles
    local ACMList_Raids = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13469, -- Raiding with Leashes VI: Pets of Pandaria
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME4, -- Mists of Pandaria
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Dungeons,
        ACMList_Raids
    }

    return ACMList
end