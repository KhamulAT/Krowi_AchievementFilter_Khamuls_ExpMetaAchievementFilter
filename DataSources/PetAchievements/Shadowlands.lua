local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetSLPetAchievements()

    -- Child Achievements Family Exorcist
    local ACMChilds_FamilyExorcist = {
        Utilities:GetAchievementName(14879),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14868, -- Aquatic Apparitions
            14869, -- Beast Busters
            14870, -- Creepy Critters
            14871, -- Deathly Dragonkin
            14872, -- Earie Elementals
            14873, -- Flickering Fliers
            14874, -- Haunted Humanoids
            14875, -- Mummified Magics
            14876, -- Macabre Mechanicals
            14877 -- Unholy Undead
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME8, -- Shadowlands
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattler
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TeamAquashock
        ACMListFlat[#ACMListFlat+1] = ACMChilds_ReekingOfVisions
    end

    ACMListFlat[#ACMListFlat + 1] = {
        14879, -- Family Exorcist
        14881, -- Abhorrent Adversaries of the Afterlife
        15004, -- A Sly Fox
        15079, -- Many, Many Things
        14469, -- Twisting Corridors: Layer 2
        15251, -- The Jailer's Gauntlet: Layer 1
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Pet Battle
    local ACMList_PetBattles = {
        _G.SHOW_PET_BATTLES_ON_MAP_TEXT, -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyExorcist
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        14879, -- Family Exorcist
        14881, -- Abhorrent Adversaries of the Afterlife
        15004, -- A Sly Fox
    }

    ACMList_Thorghast = {
        Utilities:GetDungeonNameByLFGDungeonID(1963),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            15079, -- Many, Many Things
            14469, -- Twisting Corridors: Layer 2
            15251, -- The Jailer's Gauntlet: Layer 1
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME8, -- Shadowlands
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_PetBattles,
        ACMList_Thorghast
    }

    return ACMList
end