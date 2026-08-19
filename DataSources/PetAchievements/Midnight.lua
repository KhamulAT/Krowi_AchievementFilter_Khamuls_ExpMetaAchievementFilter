local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMNPetAchievements()

    -- Child Achievements Midnight Dungeon Hero
    local ACMChilds_MidnightDungeonHero = KAF_Cat(Utilities:GetAchievementName(61567))
        :Ids{
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

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_MidnightDungeonHero)
    end

    ACMListFlat:Ids{
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
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS) -- Dungeons

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons:Insert(ACMChilds_MidnightDungeonHero)
    end

    ACMList_Dungeons:Ids{
        61567, -- Midnight Dungeon Hero
    }

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2395)) -- Eversong Woods
        :Ids{
            61960, -- Treasures of Eversong Woods
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2512)) -- The Coiled Isle
        :Ids{
            63633, -- A Stack of Snacks
        }

    -- Raids
    local ACMList_Raids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15271)) -- Raids
        :Ids{
            63609, -- No Egg Scramble
        }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles
        :Ids{
            61091, -- Midnight Safari
            62492, -- The Coiled Isle Safari
        }

    -- Void Assaults
    local ACMList_VoidAssaults = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15610)) -- Void Assaults
        :Ids{
            62882, -- Showdown Success: Naigtal
            62880, -- Showdown Success: Val
            63349, -- Ultradon  Carnage
            62518, -- Cosmic Exterminator
        }

    -- Abyss Anglers
    local ACMList_AbyssAnglers = KAF_Cat(L["Abyss Anglers"])
        :Ids{
            62776, -- Abyss Anglers: All Blue Angler
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight
        :Insert(ACMList_Zones)
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_Raids)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_VoidAssaults)
        :Insert(ACMList_AbyssAnglers)

    return ACMList
end
