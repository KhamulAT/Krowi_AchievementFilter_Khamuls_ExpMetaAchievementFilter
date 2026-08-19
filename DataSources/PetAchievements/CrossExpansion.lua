local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCrossExpansionPetAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(L["Cross-Expansion"])
        :Ids{
            4478, -- Looking for Multitudes
            7934, -- Raiding with Leashes
            17736, -- The Gift of Cheese
            7521, -- Time to Open a Pet Store
            1250, -- Shop Smart, Shop Pet...Smart
            2516, -- Lil' Game Hunter
            5876, -- Petting Zoo
            5877, -- Menagerie
            5875, -- Littlest Pet Shop
            7500, -- Going to Need More Leashes
            7501, -- That's a Lot of Pet Food
            9643, -- So. Many. Pets.
            12992, -- Pet Emporium
            12958, -- Master of Minions
            15641, -- Many More Mini Minions
            15642, -- Proven Pet Parent
            15643, -- What Can I Say? They Love Me.
            15644, -- Good Things Come in Small Packages
            6556, -- Going to Need More Traps
            8300, -- Brutal Pet Brawler
            6582, -- Pro Pet Mob
            12996, -- Toybox Tycoon,
            9983, -- That's Wwhack!
            18644, -- Community Rumor Mill
            3478, -- Pilgrim
        }

    -- Zones->AdditionalPetStuff
    local ACMList_AdditionalPetStuffZone = {
        8348, -- The Longest Day
    }

    -- PetBattles->Collect->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattleCollect = {
        6556, -- Going to Need More Traps
    }

    -- PetBattles->Battle->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattleBattle = {
        7499, -- Taming the World
    }

    -- PetBattles->Level->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattleLevel = {
        7433, -- Newbie
        6566, -- Just a Pup
        6581, -- Pro Pet Crew
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat:Ids(ACMList_AdditionalPetStuffZone)
        ACMListFlat:Ids(ACMList_AdditionalPetStuffPetBattleCollect)
        ACMListFlat:Ids(ACMList_AdditionalPetStuffPetBattleBattle)
        ACMListFlat:Ids(ACMList_AdditionalPetStuffPetBattleLevel)
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons & Raids
    local ACMList_DungeonsAndRaids = KAF_Cat(_G.DUNGEONS .. " & " .. _G.RAIDS)
        :Ids{
            4478, -- Looking for Multitudes
            7934, -- Raiding with Leashes
        }

    -- Professions -> Cooking
    local ACMList_Professions_Cooking = KAF_Cat(_G.TRADE_SKILLS)

    KAF_Sub(ACMList_Professions_Cooking, _G.PROFESSIONS_COOKING)
        :Ids{
            17736 -- The Gift of Cheese
        }

    -- PetBattles->Collect
    local ACMList_PetBattlesCollect = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15118)) -- Collect
        :Ids{
            7521, -- Time to Open a Pet Store
            1250, -- Shop Smart, Shop Pet...Smart
            2516, -- Lil' Game Hunter
            5876, -- Petting Zoo
            5877, -- Menagerie
            5875, -- Littlest Pet Shop
            7500, -- Going to Need More Leashes
            7501, -- That's a Lot of Pet Food
            9643, -- So. Many. Pets.
            12992, -- Pet Emporium
            12958, -- Master of Minions
            15641, -- Many More Mini Minions
            15642, -- Proven Pet Parent
            15643, -- What Can I Say? They Love Me.
            15644, -- Good Things Come in Small Packages
        }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattlesCollect:Ids(ACMList_AdditionalPetStuffPetBattleCollect)
    end

    -- PetBattles->Battle
    local ACMList_PetBattlesBattle = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15119)) -- Battle
        :Ids{
            8300 -- Brutal Pet Brawler
        }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattlesBattle:Ids(ACMList_AdditionalPetStuffPetBattleBattle)
    end

    -- PetBattles->Level
    local ACMList_PetBattlesLevel = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15120)) -- Level
        :Ids{
            6582
        }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattlesLevel:Ids(ACMList_AdditionalPetStuffPetBattleLevel)
    end

    -- PetBattles -> Collect, Battle, Level
    local ACMList_PetBattles_CollectBattleLevel = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles
        :Insert(ACMList_PetBattlesCollect)
        :Insert(ACMList_PetBattlesBattle)
        :Insert(ACMList_PetBattlesLevel)

    -- Collections
    local ACMList_Collections = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15246)) -- Collections
        :Ids{
            12996 -- Toybox Tycoon
        }

    -- Darkmoon Faire
    local ACMList_DarkmoonFaire = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15101)) -- Darkmoon Faire
        :Ids{
            9983, -- That's Whack!
        }

    -- World Events
    local ACMList_WorldEvents = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(155)) -- World Events
        :Ids{
            3478, -- Pilgrim
        }

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_Zones:Ids(ACMList_AdditionalPetStuffZone)
    end

    ACMList_Zones:Ids{
        18644, -- Community Rumor Mill
    }

    local ACMList = KAF_Cat(L["Cross-Expansion"])
        :Insert(ACMList_Collections)
        :Insert(ACMList_DarkmoonFaire)
        :Insert(ACMList_WorldEvents)
        :Insert(ACMList_DungeonsAndRaids)
        :Insert(ACMList_PetBattles_CollectBattleLevel)
        :Insert(ACMList_Professions_Cooking)
        :Insert(ACMList_Zones)

    return ACMList
end
