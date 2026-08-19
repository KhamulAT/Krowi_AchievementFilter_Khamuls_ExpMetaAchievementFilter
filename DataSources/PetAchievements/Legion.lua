local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetLegionPetAchievements()

    -- Child Achievements Family Familiar
    local ACMChilds_FamilyFamiliar = KAF_Cat(Utilities:GetAchievementName(9696))
        :Ids{
            9686, -- Aquatic Acquiescence
            9687, -- Best of the Beasts
            9688, -- Mousing Around
            9689, -- Dragons!
            9690, -- DRagnaros, Watch and Learn
            9691, -- Flock Together
            9692, -- Murlocs, Harpies, and Wolvar, Oh My!
            9693, -- Master of Magic
            9694, -- Roboteer
            9695, -- The Lil' Necromancer
        }

    -- Child Achievements Family Fighter
    local ACMChilds_FamilyFighter = KAF_Cat(Utilities:GetAchievementName(12100))
        :Ids{
            12089, -- Aquatic Assault
            12091, -- Beast Blitz
            12092, -- Critical Critters
            12093, -- Draconic Destruction
            12094, -- Elemental Excalation
            12095, -- Fierce Fliers
            12096, -- Humanoid Havoc
            12097, -- Magical Mayhem
            12098, -- Mechanical Melee
            12099, -- Unstoppable Undead
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME6) -- Legion

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_FamilyFamiliar)
        ACMListFlat:Insert(ACMChilds_FamilyFighter)
    end

    ACMListFlat:Ids{
        12431, -- Post Haste
        10412, -- Poor Unfortunate Souls
        11233, -- Broken Isles Safari
        9696, -- Family Familiar
        12100, -- Family Fighter
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Dalaran -> Quests
    local ACMList_Zones_Dalaran_Quests = KAF_Cat(_G.ZONE)

    KAF_Sub(ACMList_Zones_Dalaran_Quests, Utilities:GetZoneNameByMapID(627))
        :Ids{
            12431, -- Post Haste
        }

    -- Dungeons -> Maw of Souls
    local ACMList_Dungeons_MawOfSouls = KAF_Cat(_G.DUNGEONS)

    KAF_Sub(ACMList_Dungeons_MawOfSouls, Utilities:GetDungeonNameByLFGDungeonID(1191))
        :Ids{
            10412, -- Poor Unfortunate Souls
        }

    -- Pet Battle
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219))

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_FamilyFamiliar)
        ACMList_PetBattles:Insert(ACMChilds_FamilyFighter)
    end

    ACMList_PetBattles:Ids{
        11233, -- Broken Isles Safari
        9696, -- Family Familiar
        12100, -- Family Fighter
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME6) -- Legion
        :Insert(ACMList_Zones_Dalaran_Quests)
        :Insert(ACMList_Dungeons_MawOfSouls)
        :Insert(ACMList_PetBattles)

    return ACMList
end
