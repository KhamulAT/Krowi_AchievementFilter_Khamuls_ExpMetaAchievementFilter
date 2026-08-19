local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMoPPetAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME4) -- Mists of Pandaria

    -- Zone->AdditionalPetStuff
    local ACMList_AdditionalPetStuffZone = {
        8080, -- Fabled Pandaren Tamer
        7936, -- Pandaren Spirit Tamer
    }

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattles = {
        6606, -- Taming Pandaria
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat:Ids(ACMList_AdditionalPetStuffZone)
        ACMListFlat:Ids(ACMList_AdditionalPetStuffPetBattles)
    end

    ACMListFlat:Ids{
        6402, -- Ling-Ting's Herbal Journey
        13469, -- Raiding with Leashes VI: Pets of Pandaria
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS) -- Dungeons

    KAF_Sub(ACMList_Dungeons, Utilities:GetDungeonNameByLFGDungeonID(469))
        :Ids{
            6402
        }

    -- Raids
    local ACMList_Raids = KAF_Cat(_G.RAIDS) -- Raids
        :Ids{
            13469, -- Raiding with Leashes VI: Pets of Pandaria
        }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattles:Ids(ACMList_AdditionalPetStuffPetBattles)
    end

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_Zones:Ids(ACMList_AdditionalPetStuffZone)
    end

    local ACMList = KAF_Cat(_G.EXPANSION_NAME4) -- Mists of Pandaria
        :Insert(ACMList_Zones)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_Raids)

    return ACMList
end
