local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetSLPetAchievements()

    -- Child Achievements Family Exorcist
    local ACMChilds_FamilyExorcist = KAF_Cat(Utilities:GetAchievementName(14879))
        :Ids{
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

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattle = {
        14625, -- Battle in the Shadowlands
    }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME8) -- Shadowlands

    local ACMList_Accessoiries = {
            15508, -- Fashion of the First Ones
    }

    -- NOTE: the V1 version guarded an includeChildAchievements block here that appended
    -- ACMChilds_FamilyBattler / ACMChilds_TeamAquashock / ACMChilds_ReekingOfVisions --
    -- none of which are ever defined in this file, so it always appended nil and did
    -- nothing. Behaviour is preserved (no child group in the flat list); the variable
    -- that was presumably intended is ACMChilds_FamilyExorcist.

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat:Ids(ACMList_AdditionalPetStuffPetBattle)
    end

    ACMListFlat:Ids{
        14879, -- Family Exorcist
        14881, -- Abhorrent Adversaries of the Afterlife
        15004, -- A Sly Fox
        15079, -- Many, Many Things
        14469, -- Twisting Corridors: Layer 2
        15251, -- The Jailer's Gauntlet: Layer 1
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat:Ids(ACMList_Accessoiries)
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Pet Battle
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_FamilyExorcist)
    end

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattles:Ids(ACMList_AdditionalPetStuffPetBattle)
    end

    ACMList_PetBattles:Ids{
        14879, -- Family Exorcist
        14881, -- Abhorrent Adversaries of the Afterlife
        15004, -- A Sly Fox
    }

    local ACMList_Thorghast = KAF_Cat(Utilities:GetDungeonNameByLFGDungeonID(1963))
        :Ids{
            15079, -- Many, Many Things
            14469, -- Twisting Corridors: Layer 2
            15251, -- The Jailer's Gauntlet: Layer 1
        }

    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(1970)) -- Zereth Mortis
        :Ids{
            15508, -- Fashion of the First Ones
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME8) -- Shadowlands
        :Insert(ACMList_Zones)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_Thorghast)

    return ACMList
end
