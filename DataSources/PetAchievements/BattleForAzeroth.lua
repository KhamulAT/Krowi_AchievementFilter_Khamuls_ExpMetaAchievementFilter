local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetBfaPetAchievements()

    -- Child Achievements Family Battler
    local ACMChilds_FamilyBattler = KAF_Cat(Utilities:GetAchievementName(13279))
        :Ids{
            13280, -- Hobbyist Aquarist
            13270, -- Best Mode
            13271, -- Critters With Huge Teeth
            13272, -- Dragons Make Everything Better
            13273, -- Element of Success
            13274, -- Fun With Flying
            13281, -- Human Resources
            13275, -- Magician's Secrets
            13277, -- Machine Learning
            13278 -- Not Quite Dead Yet
        }

    -- Child Achievements Team Aquashock
    local ACMChilds_TeamAquashock = KAF_Cat(Utilities:GetAchievementName(13695))
        :Ids{
            13694, -- Nazjatari Safari
            13693, -- Mecha-Safari
            13626, -- Nautical Nuisances of Nazjatar
            13625 -- Mighty Minions of Mechagon
        }

    -- Child Achievements Reeking of Visions
    local ACMChilds_ReekingOfVisions = KAF_Cat(Utilities:GetAchievementName(14143))
        :Ids{
            14065, -- The Even More Horrific Vision of Ogrimmar
            14064 -- The Even More Horrific Vision of Stormwind
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME7) -- Battle for Azeroth

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_FamilyBattler)
        ACMListFlat:Insert(ACMChilds_TeamAquashock)
        ACMListFlat:Insert(ACMChilds_ReekingOfVisions)
    end

    ACMListFlat:Ids{
        13062, -- Let's Bee Friends
        12723, -- How to Keep a Mummy
        12930, -- Battle Safari
        13279, -- Family Battler
        13695, -- Team Aquashock
        14143 -- Reeking of Visions
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Stormsong Valley -> Quests
    local ACMList_Zones_StormsongValley_Quests = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones_StormsongValley_Quests, Utilities:GetZoneNameByMapID(942))
        :Ids{
            13062 -- Let's Bee Friends
        }

    -- Dungeons -> Kings'Rest
    local ACMList_Dungeons_KingsRest = KAF_Cat(_G.DUNGEONS) -- Dungeons

    KAF_Sub(ACMList_Dungeons_KingsRest, Utilities:GetDungeonNameByLFGDungeonID(1785))
        :Ids{
            12723 -- How to Keep a Mummy
        }

    -- Pet Battle
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_FamilyBattler)
        ACMList_PetBattles:Insert(ACMChilds_TeamAquashock)
    end

    ACMList_PetBattles:Ids{
        12930, -- Battle Safari
        13279, -- Family Battler
        13695, -- Team Aquashock
    }

    local ACMList_VisionsOfNZoth = KAF_Cat(_G.SPLASH_BATTLEFORAZEROTH_8_3_0_FEATURE1_TITLE)

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_VisionsOfNZoth:Insert(ACMChilds_ReekingOfVisions)
    end

    ACMList_VisionsOfNZoth:Ids{
        14143 -- Reeking of Visions
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME7) -- Battle for Azeroth
        :Insert(ACMList_Zones_StormsongValley_Quests)
        :Insert(ACMList_Dungeons_KingsRest)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_VisionsOfNZoth)

    return ACMList
end
