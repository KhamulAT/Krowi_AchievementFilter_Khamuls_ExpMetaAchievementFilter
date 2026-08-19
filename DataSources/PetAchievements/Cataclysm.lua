local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCataPetAchievements()

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattles = {
        7525, -- Taming Cataclysm
    }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME3) -- Cataclysm
        :Ids{
            5860, -- The 'Unbeatable?' Pterodactyl: BEATEN.
            5449, -- Rock Lover
            11856, -- Pet Battle Challenge: Deadmines
            12079, -- Raiding with Leashes V: Cuteaclysm
            62461, -- Family Battler of Cataclysm
        }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat:Ids(ACMList_AdditionalPetStuffPetBattles)
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Mount Hyjal & Deepholm -> Quests
    local ACMList_Zones_MountHyjalDeepholm_Quests = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones_MountHyjalDeepholm_Quests, Utilities:GetZoneNameByMapID(198)) -- Mount Hyjal
        :Ids{
            5860 -- The 'Unbeatable?' Pterodactyl: BEATEN.
        }

    KAF_Sub(ACMList_Zones_MountHyjalDeepholm_Quests, Utilities:GetZoneNameByMapID(207)) -- Deepholm
        :Ids{
            5449, -- Rock Lover
        }

    -- Pet Battle Dungeons
    local ACMList_PetBattleDungeons = KAF_Cat(_G.BATTLE_PET_SOURCE_5 .. " " .. _G.DUNGEONS) -- Pet Battle Dungeons
        :Ids{
            11856, -- Pet Battle Challenge: Deadmines
        }

    -- Raids
    local ACMList_Raids = KAF_Cat(_G.RAIDS) -- Raids
        :Ids{
            12079, -- Raiding with Leashes V: Cuteaclysm
        }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles
        :Ids{
            62461, -- Family Battler of Cataclysm
        }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattles:Ids(ACMList_AdditionalPetStuffPetBattles)
    end

    local ACMList = KAF_Cat(_G.EXPANSION_NAME3) -- Cataclysm
        :Insert(ACMList_Zones_MountHyjalDeepholm_Quests)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_PetBattleDungeons)
        :Insert(ACMList_Raids)

    return ACMList
end
