local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTBCPetAchievements()

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattles = {
        6604, -- Taming Outland
    }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME1) -- The Burning Crusade
        :Ids{
            8293, -- Raiding with Leashes II: Attunement Edition
            9824, -- Raiding with Leashes III: Drinkin' From the Sunwell
            62460 -- Family Battler of Outland
        }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat:Ids(ACMList_AdditionalPetStuffPetBattles)
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Raids
    local ACMList_Raids = KAF_Cat(_G.RAIDS) -- Raids
        :Ids{
            8293, -- Raiding with Leashes II: Attunement Edition
            9824 -- Raiding with Leashes III: Drinkin' From the Sunwell
        }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles
        :Ids{
            62460, -- Family Battler of Outland
        }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattles:Ids(ACMList_AdditionalPetStuffPetBattles)
    end

    local ACMList = KAF_Cat(_G.EXPANSION_NAME1) -- The Burning Crusade
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_Raids)

    return ACMList
end
