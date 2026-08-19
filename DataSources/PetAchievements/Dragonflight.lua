local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetDFPetAchievements()

    -- Child Achievements Family Battler of the Dragon Isles
    local ACMChilds_FamilyBattlerOfTheDragonIsles = KAF_Cat(Utilities:GetAchievementName(16512))
        :Ids{
            16501, -- Aquatic Battler of the Dragon Isles
            16503, -- Beast Battler of the Dragon Isles
            16504, -- Critter Battler of the Dragon Isles
            16505, -- Dragonkin Battler of the Dragon Isles
            16506, -- Elemental Battler of the Dragon Isles
            16507, -- Flying Battler of the Dragon Isles
            16508, -- Humanoid Battler of the Dragon Isles
            16509, -- Magic Battler of the Dragon Isles
            16510, -- Mechanical Battler of the Dragon Isles
            16511, -- Undead Battler of the Dragon Isles
        }

    -- Child Achievements Family Battler of Zaralek Cavern
    local ACMChilds_FamilyBattlerOfZaralekCavern = KAF_Cat(Utilities:GetAchievementName(17934))
        :Ids{
            17881, -- Aquatic Battler of Zaralek Cavern
            17882, -- Beast Battler of Zaralek Cavern
            17883, -- Critter Battler of Zaralek Cavern
            17890, -- Dragonkin Battler of Zaralek Cavern
            17904, -- Elemental Battler of Zaralek Cavern
            17905, -- Flying Battler of Zaralek Cavern
            17915, -- Humanoid Battler of Zaralek Cavern
            17916, -- Magic Battler of Zaralek Cavern
            17917, -- Mechanical Battler of Zaralek Cavern
            17918, -- Undead Battler of Zaralek Cavern
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME9) -- Dragonflight

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_FamilyBattlerOfTheDragonIsles)
        ACMListFlat:Insert(ACMChilds_FamilyBattlerOfZaralekCavern)
    end

    ACMListFlat:Ids{
        18384, -- Whelp, There It Is
        17741, -- Slow and Steady Wins the Race
        19293, -- Friends In Feathers
        19792, -- Just One More Thing
        19793, -- Finally At Rest
        19089, -- Don't Let the Doe hit You The Way Out
        16512, -- Family Battler of the Dragon Isles
        17934, -- Family Battler of Zaralek Cavern
        15940, -- Dragon Racing Completitionist: Silver
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zone
    local ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream, Utilities:GetZoneNameByMapID(2112)) -- Valdrakken
        :Ids{
            18384, -- Whelp, There It Is
        }

    KAF_Sub(ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream, Utilities:GetZoneNameByMapID(2133)) -- Zaralek Cavern
        :Ids{
            17741, -- Slow and Steady Wins the Race
        }

    KAF_Sub(ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream, Utilities:GetZoneNameByMapID(2200)) -- Emerald Dream
        :Ids{
            19293, -- Friends In Feathers
        }

    ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream:Ids{
        19792, -- Just One More Thing
        19793, -- Finally At Rest
    }

    -- Raids
    local ACMList_Raids_Amirdrassil = KAF_Cat(_G.RAIDS) -- Raids

    KAF_Sub(ACMList_Raids_Amirdrassil, Utilities:GetDungeonNameByLFGDungeonID(2502))
        :Ids{
            19089, -- Don't Let the Doe hit You The Way Out
        }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_FamilyBattlerOfTheDragonIsles)
        ACMList_PetBattles:Insert(ACMChilds_FamilyBattlerOfZaralekCavern)
    end

    ACMList_PetBattles:Ids{
        16512, -- Family Battler of the Dragon Isles
        17934, -- Family Battler of Zaralek Cavern
    }

    -- Dragonriding Races
    local ACMList_DragonridingRaces = KAF_Cat(_G.MOUNT_JOURNAL_FILTER_DRAGONRIDING) -- Skyriding
        :Ids{
            15940, -- Dragon Racing Completitionist: Silver
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME9) -- Dragonflight
        :Insert(ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream)
        :Insert(ACMList_Raids_Amirdrassil)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_DragonridingRaces)

    return ACMList
end
