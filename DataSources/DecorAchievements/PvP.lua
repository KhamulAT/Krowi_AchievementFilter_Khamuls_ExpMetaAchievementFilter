local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingPvP()

    local factionSpecificAchievements = {
        { -- Alliance
            5213, -- Soaring Spirits
            5226, -- Cloud Nine
            5229, --  Drag a Maw
            5219, -- I'm in the White Lodge
            5221, -- Fire, Walk With Me
            5231, -- Double Jeopardy
        },
        { -- Horde
            5214, -- Soaring Spirits
            5227, -- Cloud Nine
            5228, -- Wild Hammering
            5220, -- I'm in the Black Lodge
            5222, -- Fire, Walk With Me
            5552, -- Double Jeopardy
        }
    }

    -- Child Achievements Master of Temple of Kotmogu
    local ACMChilds_MasterOfTempleOfKotmogu = KAF_Cat(Utilities:GetAchievementName(6981))
        :Ids{
            6882, -- Temple of Kotmogu Veteran
            6947, -- Four Square
            6950, -- Powerball
            6970, -- Blackout
            6973, -- Can't Stop Won't Stop
            6971, -- I've Got the Power
            6972, -- What is Best in Life?
            6980, -- Temple of Kotmogu All-Star
        }

    -- Child Achievements Master of Twin Peaks
    local ACMChilds_MasterOfTwinPeaks = KAF_Cat(Utilities:GetAchievementName(5223))
        :Ids{
            5209, -- Twin Peaks Veteran
            5210, -- Two-Timer
            5211, -- Top Defender
            Utilities:AchievementShowDecider(5213, 5214, factionSpecificAchievements, "completedBeforeFaction"), -- Soaring Spirits
            5215, -- Twin Peaks Perfection
            5216, -- Peak Speed
            Utilities:AchievementShowDecider(5226, 5227, factionSpecificAchievements, "completedBeforeFaction"), -- Cloud Nine
            Utilities:AchievementShowDecider(5229, 5228, factionSpecificAchievements, "completedBeforeFaction"), -- Drag a Maw/Wild Hammering
            Utilities:AchievementShowDecider(5216, 5220, factionSpecificAchievements, "completedBeforeFaction"), -- I'm in the White Lodge/I'm in the Black Lodge
            Utilities:AchievementShowDecider(5221, 5222, factionSpecificAchievements, "completedBeforeFaction"), -- Fire, Walk With Me
            5230, -- Twin Peaks Mountaineer
            Utilities:AchievementShowDecider(5231, 5552, factionSpecificAchievements, "completedBeforeFaction"), -- Double Jeopardy
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15279)) -- Player vs. Player

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_MasterOfTempleOfKotmogu)
        ACMListFlat:Insert(ACMChilds_MasterOfTwinPeaks)
    end

    ACMListFlat:Ids{
        61683, -- Entering Battle
        61684, -- Progressing in Battle
        61685, -- Proficient in Battle
        61686, -- Expert in Battle
        61687, -- Champion in Battle
        61688, -- Master in Battle
        229, -- The Grim Reaper
        231, -- Wrecking Ball
        1157, -- Duel-icious
        167, -- Warsong Gulch Veteran
        200, -- Persistent Defender
        158, -- Me and the Cappin' Makin' It Happen
        1153, -- Overly Defense
        212, -- Storm Capper
        213, -- Stormtrooper
        221, -- Alterac Grave Robber
        222, -- Tower Defense
        5245, -- Battle for Gilneas Victory
        5223, -- Master of Twin Peaks
        6981, -- Master of Temple of Kotmogu
        40210, -- Deephaul Ravine Victory
        40612, -- Sprinting in the Ravine
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Warsong Gulch
    local ACMList_WarsongGulch = KAF_CatChain(Utilities:GetZoneNameByMapID(92)) -- Warsong Gulch
        :Ids{
            167, -- Warsong Gulch Veteran
            200 -- Persistent Defender
        }

    -- Arathi Basin
    local ACMList_ArathiBasin = KAF_CatChain(Utilities:GetZoneNameByMapID(93)) -- Arathi Basin
        :Ids{
            158, -- Me and the Cappin' Makin' It Happe
            1153 -- Overly Defense
        }

    -- Eye of the Storm
    local ACMList_EyeOfTheStorm = KAF_CatChain(Utilities:GetZoneNameByMapID(112)) -- Eye of the Storm
        :Ids{
            212, -- Storm Capper
            213 -- Stormtrooper
        }

    -- Alterac Valley
    local ACMList_AlteracValley = KAF_CatChain(Utilities:GetZoneNameByMapID(91)) -- Alterac Valley
        :Ids{
            221, -- Alterac Grave Robber
            222 -- Tower Defense
        }

    local ACMList_BattleForGilneas = KAF_CatChain(Utilities:GetZoneNameByMapID(275)) -- Battle for Gilneas
        :Ids{
            5245, -- Battle for Gilneas Victory
        }

    -- Twin Peaks
    local ACMList_TwinPeaks = KAF_CatChain(Utilities:GetZoneNameByMapID(206)) -- Twin Peaks

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_TwinPeaks:Insert(ACMChilds_MasterOfTwinPeaks)
    end

    ACMList_TwinPeaks:Ids{
        5223, -- Master of Twin Peaks
    }

    -- Temple of Kotmogu
    local ACMList_TempleOfKotmogu = KAF_CatChain(Utilities:GetZoneNameByMapID(417)) -- Temple of Kotmogu

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_TempleOfKotmogu:Insert(ACMChilds_MasterOfTempleOfKotmogu)
    end

    ACMList_TempleOfKotmogu:Ids{
        6981 -- Master of the Temple of Kotmogu
    }

    -- Deephaul Ravine
    local ACMList_DeephaulRavine = KAF_CatChain(Utilities:GetZoneNameByMapID(2345)) -- Deephaul Ravine
        :Ids{
            40210, -- Deephaul Ravine Victory
            40612 -- Sprinting in the Ravine
        }

    local ACMList = KAF_CatChain(Utilities:GetAchievementCategoryNameByCategoryID(15279)) -- Player vs. Player
        :Insert(ACMList_WarsongGulch)
        :Insert(ACMList_ArathiBasin)
        :Insert(ACMList_EyeOfTheStorm)
        :Insert(ACMList_AlteracValley)
        :Insert(ACMList_BattleForGilneas)
        :Insert(ACMList_TwinPeaks)
        :Insert(ACMList_TempleOfKotmogu)
        :Insert(ACMList_DeephaulRavine)
        :Ids{
            61683, -- Entering Battle
            61684, -- Progressing in Battle
            61685, -- Proficient in Battle
            61686, -- Expert in Battle
            61687, -- Champion in Battle
            61688, -- Master in Battle
            229, -- The Grim Reaper
            231, -- Wrecking Ball
            1157 -- Duel-icious
        }

    return ACMList
end
