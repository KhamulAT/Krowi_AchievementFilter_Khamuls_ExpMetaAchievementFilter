local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMNPetAchievements()

    -- Child Achievements Midnight Dungeon Hero
    local ACMChilds_MidnightDungeonHero = {
        Utilities:GetAchievementName(61567),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61642, -- Heroic: Den of Nalorakk
            61213, -- Heroic: Magisters' Terrace
            61644, -- Heroic: Maisara Caverns
            41961, -- Heroic: Murder  Row
            61646, -- Heroic: Nexus-Point Xenas
            61648, -- Heroic: The Blinding Vale
            61509, -- Heroic: Voidscar Arena
            41288, -- Heroic: Windrunner Spire
            62882, -- Showdown Success: Naigtal
            62880, -- Showdown Success: Val
            63349, -- Ultradon  Carnage
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_MidnightDungeonHero
    end

    ACMListFlat[#ACMListFlat+1] = {
        61567, -- Midnight Dungeon Hero
        61091, -- Midnight Safari
        62492, -- The Coiled Isle Safari
        63633, -- A Stack of Snacks
        63609, -- No Egg Scramble
        61960, -- Treasures of Eversong Woods
        62518, -- Cosmic Exterminator
        62776, -- Abyss Anglers: All Blue Angler
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
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_MidnightDungeonHero
    end

    ACMList_Dungeons[#ACMList_Dungeons+1] = {
        61567, -- Midnight Dungeon Hero
    }

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(2395), -- Eversong Woods
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                61960, -- Treasures of Eversong Woods
            }
        },
        {
            Utilities:GetZoneNameByMapID(2512), -- The Coiled Isle
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                63633, -- A Stack of Snacks
            }
        }
    }

    -- Raids
    local ACMList_Raids = {
        Utilities:GetAchievementCategoryNameByCategoryID(15271), -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            63609, -- No Egg Scramble
        }
    }

    -- PetBattles
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61091, -- Midnight Safari
            62492, -- The Coiled Isle Safari
        }
    }

    -- Void Assaults
    local ACMList_VoidAssaults = {
        Utilities:GetAchievementCategoryNameByCategoryID(15610),  -- Void Assaults
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            62882, -- Showdown Success: Naigtal
            62880, -- Showdown Success: Val
            63349, -- Ultradon  Carnage
            62518, -- Cosmic Exterminator
        }
    }

    -- Abyss Anglers
    local ACMList_AbyssAnglers = {
        L["Abyss Anglers"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            62776, -- Abyss Anglers: All Blue Angler
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Dungeons,
        ACMList_Raids,
        ACMList_PetBattles,
        ACMList_VoidAssaults,
        ACMList_AbyssAnglers
    }

    return ACMList
end