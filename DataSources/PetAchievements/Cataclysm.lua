local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCataPetAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME3, -- Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            5860, -- The 'Unbeatable?' Pterodactyl: BEATEN.
            5449, -- Rock Lover
            11856, -- Pet Battle Challenge: Deadmines
            12079, -- Raiding with Leashes V: Cuteaclysm
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Mount Hyjal & Deepholm -> Quests
    local ACMList_Zones_MountHyjalDeepholm_Quests = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(198), -- Mount Hyjal
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                5860 -- The 'Unbeatable?' Pterodactyl: BEATEN.
            }
            
        },
        {
            Utilities:GetZoneNameByMapID(207), -- Deepholm
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                5449, -- Rock Lover
            }
        }
    }

    -- Pet Battle Dungeons
    local ACMList_PetBattleDungeons = {
        _G.BATTLE_PET_SOURCE_5 .. " " .. _G.DUNGEONS, -- Pet Battle Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            11856, -- Pet Battle Challenge: Deadmines
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
            12079, -- Raiding with Leashes V: Cuteaclysm
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME3, -- Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_MountHyjalDeepholm_Quests,
        ACMList_PetBattleDungeons,
        ACMList_Raids
    }

    return ACMList
end