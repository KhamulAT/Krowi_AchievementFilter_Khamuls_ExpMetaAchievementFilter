local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWPetAchievements()

    -- Child Achievements Family Battler of Khaz Algar
    local ACMChilds_FamilyBattlerOfKhazAlgar = KAF_Cat(Utilities:GetAchievementName(40980))
        :Ids{
            40154, -- Aquatic Battler of Khaz Algar
            40155, -- Beast Battler of Khaz Algar
            40156, -- Critter Battler of Khaz Algar
            40157, -- Dragonkin Battler of Khaz Algar
            40158, -- Elemental Battler of Khaz Algar
            40161, -- Flying Battler of Khaz Algar
            40162, -- Humanoid Battler of Khaz Algar
            40163, -- Magic Battler of Khaz Algar
            40164, -- Mechanical Battler of Khaz Algar
            40165, -- Undead Battler of Khaz Algar
        }

    -- Child Achievements Family Battler of Undermine
    local ACMChilds_FamilyBattlerOfUndermine = KAF_Cat(Utilities:GetAchievementName(41551))
        :Ids{
            41542, -- Aquatic Battler of Undermine
            41543, -- Beast Battler of Undermine
            41541, -- Critter Battler of Undermine
            41544, -- Dragonkin Battler of Undermine
            41545, -- Elemental Battler of Undermine
            41546, -- Flying Battler of Undermine
            41547, -- Humanoid Battler of Undermine
            41548, -- Magic Battler of Undermine
            41549, -- Mechanical Battler of Undermine
            41550, -- Undead Battler of Undermine
        }

    -- Child Achievements Reeking of Visions
    local ACMChilds_ReekingOfVisions = KAF_Cat(Utilities:GetAchievementName(41928))
        :Ids{
            41876, -- The Even More Horrific Vision of Ogrimmar
            41854 -- The Even More Horrific Vision of Stormwind
        }

    -- Child Achievements War Within Dungeon Hero
    local ACMChilds_WarWithinDungeonHero = KAF_Cat(Utilities:GetAchievementName(61565))
        :Ids{
            40374, -- Heroic: Ara-Kara, City of Echoes
            40363, -- Heroic: Cinderbrew Meadery
            40377, -- Heroic: City of Threads
            40428, -- Heroic: Darkflame Cleft
            40592, -- Heroic: Priory of the Sacred Flame
            40601, -- Heroic: The Dawnbreaker
            40637, -- Heroic: The Rookery
            40644, -- Heroic: The Stonevault
            41340, -- Heroic: Operation: Floodgate
            42781, -- Heroic: Eco-Dome Al'dani
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME10) -- The War Within

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_FamilyBattlerOfKhazAlgar)
        ACMListFlat:Insert(ACMChilds_FamilyBattlerOfUndermine)
        ACMListFlat:Insert(ACMChilds_WarWithinDungeonHero)
        ACMListFlat:Insert(ACMChilds_ReekingOfVisions)
    end

    ACMListFlat:Ids{
        40869, -- Worm Theory
        41349, -- In with the Cartels
        41979, -- Bounty Seeker
        61565, -- War Within Dungeon Hero
        40194, -- Khaz Algar Safari
        40980, -- Family Battler of Khaz Algar
        41092, -- Undermine Safari
        41551, -- Family Battler of Undermine
        41928, -- Reeking of Visions
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Pet Battle Dungeons
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2255)) -- Azj-Kahet
        :Ids{
            40869, -- Worm Theory
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2346)) -- Undermine
        :Ids{
            41349, -- In with the Cartels
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2371)) -- K'aresh
        :Ids{
            41979, -- Bounty Seeker
        }

    -- Dungeons
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS) -- Dungeons

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons:Insert(ACMChilds_WarWithinDungeonHero)
    end

    ACMList_Dungeons:Ids{
        61565, -- War Within Dungeon Hero
    }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_FamilyBattlerOfKhazAlgar)
        ACMList_PetBattles:Insert(ACMChilds_FamilyBattlerOfUndermine)
    end

    ACMList_PetBattles:Ids{
        40194, -- Khaz Algar Safari
        40980, -- Family Battler of Khaz Algar
        41092, -- Undermine Safari
        41551, -- Family Battler of Undermine
    }

    local ACMList_VisionsOfNZoth = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15546)) -- Visions of N'Zoth Revisited

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_VisionsOfNZoth:Insert(ACMChilds_ReekingOfVisions)
    end

    ACMList_VisionsOfNZoth:Ids{
        41928, -- Reeking of Visions
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME10) -- The War Within
        :Insert(ACMList_Zones)
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_VisionsOfNZoth)

    return ACMList
end
