local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetClassicPetAchievements()

    -- Child Achievements Family Battler of Eastern Kingdoms
    local ACMChilds_FamilyBattlerOfEasternKingdoms = KAF_Cat(Utilities:GetAchievementName(61040))
        :Ids{
            61029, -- Aquatic Battler of Eastern Kingdoms
            61030, -- Beast Battler of Eastern Kingdoms
            61031, -- Critter Battler of Eastern Kingdoms
            61032, -- Dragonkin Battler of Eastern Kingdoms
            61033, -- Elemental Battler of Eastern Kingdoms
            61034, -- Flying Battler of Eastern Kingdoms
            61035, -- Humanoid Battler of Eastern Kingdoms
            61036, -- Magic Battler of Eastern Kingdoms
            61037, -- Mechanical Battler of Eastern Kingdoms
            61028, -- Undead Battler of Eastern Kingdoms
        }

    -- Child Achievements Family Battler of Kalimdor
    local ACMChilds_FamilyBattlerOfKalimdor = KAF_Cat(Utilities:GetAchievementName(61051))
        :Ids{
            61041, -- Aquatic Battler of Kalimdor
            61042, -- Beast Battler of Kalimdor
            61043, -- Critter Battler of Kalimdor
            61044, -- Dragonkin Battler of Kalimdor
            61045, -- Elemental Battler of Kalimdor
            61046, -- Flying Battler of Kalimdor
            61047, -- Humanoid Battler of Kalimdor
            61048, -- Magic Battler of Kalimdor
            61049, -- Mechanical Battler of Kalimdor
            61050, -- Undead Battler of Kalimdor
        }

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffZone = {
        6602, -- Taming Kalimdor
        6603, -- Taming Eastern Kindoms
    }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME0) -- Classic

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_FamilyBattlerOfEasternKingdoms)
        ACMListFlat:Insert(ACMChilds_FamilyBattlerOfKalimdor)
    end

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat:Ids(ACMList_AdditionalPetStuffZone)
    end

    ACMListFlat:Ids{
        11765, -- Pet Battle Challenge: Wailing Caverns
        13269, -- Pet Battle Challenge: Gnomeregan
        13627, -- Pet Battle Challenge: Stratholme
        13766, -- Malowned
        61040, -- Family Battler of Eastern Kingdoms
        61051, -- Family Battler of Kalimdor
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Pet Battle Dungeons
    local ACMList_PetBattleDungeons = KAF_Cat(_G.BATTLE_PET_SOURCE_5 .. " " .. _G.DUNGEONS) -- Pet Battle Dungeons
        :Ids{
            11765, -- Pet Battle Challenge: Wailing Caverns
            13269, -- Pet Battle Challenge: Gnomeregan
            13627, -- Pet Battle Challenge: Stratholme
            13766, -- Malowned
        }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_FamilyBattlerOfEasternKingdoms)
        ACMList_PetBattles:Insert(ACMChilds_FamilyBattlerOfKalimdor)
    end

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattles:Ids(ACMList_AdditionalPetStuffZone)
    end

    ACMList_PetBattles:Ids{
        61040, -- Family Battler of Eastern Kingdoms
        61051, -- Family Battler of Kalimdor
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME0) -- Classic
        :Insert(ACMList_PetBattleDungeons)
        :Insert(ACMList_PetBattles)

    return ACMList
end
