local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetClassicToyAchievements()

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

    -- Child Achievements Old World Family Battler
    local ACMChilds_OldWorldFamilyBattler = KAF_Cat(Utilities:GetAchievementName(61094))
        :Insert(ACMChilds_FamilyBattlerOfEasternKingdoms)
        :Insert(ACMChilds_FamilyBattlerOfKalimdor)
        :Ids{
            61040, -- Family Battler of Eastern Kingdoms
            61051, -- Family Battler of Kalimdor
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME0) -- Classic

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_OldWorldFamilyBattler)
    end

    ACMListFlat:Ids{
        14020, -- Pet Battle Challenge: Blackrock Depths
        61094, -- Old World Family Battler
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_PetBattleDungeonsBlackrockDepths = KAF_Cat(Utilities:GetZoneNameByMapID(242)) -- Blackrock Depths
        :Ids{
            14020, -- Pet Battle Challenge: Blackrock Depths
        }

    -- Pet Battle Dungeons
    local ACMList_PetBattleDungeons = KAF_Cat(_G.BATTLE_PET_SOURCE_5 .. " " .. _G.DUNGEONS) -- Pet Battle Dungeons
        :Insert(ACMList_PetBattleDungeonsBlackrockDepths)

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_OldWorldFamilyBattler)
    end

    ACMList_PetBattles:Ids{
        61094, -- Old World Family Battler
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME0) -- Classic
        :Insert(ACMList_PetBattleDungeons)
        :Insert(ACMList_PetBattles)

    return ACMList
end
