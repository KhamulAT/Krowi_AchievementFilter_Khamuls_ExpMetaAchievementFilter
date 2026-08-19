local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetWotLKMountAchievements()

    -- Child Achievements Glory of the Hero
    local ACMChilds_GloryOfTheHero = KAF_Cat(Utilities:GetAchievementName(2136))
        :Ids{
            1919, -- On The Rocks
            2150, -- Split Personality
            2036, -- Intense Cold
            2037, -- Chaos Theory
            1296, -- Watch Him Die
            1297, -- Hadronox Denied
            1860, -- Gotta Go!
            1862, -- Volazj's Quick Demise
            2038, -- Respect Your Elders
            2056, -- Volunteer Work
            2151, -- Consumption Junction
            2039, -- Better Off Dred
            2057, -- Oh Novos!
            1816, -- Defenseless
            1865, -- Lockdown!
            2041, -- Dehydration
            2153, -- A Void Dance
            1864, -- What the Eck?
            2040, -- Less-rabi
            2058, -- Snakes. Why'd It Have To Be Snakes?
            1866, -- Good Grief
            2154, -- Brann Spankin' New
            2155, -- Abuse the Ooze
            1867, -- Timely Death
            1834, -- Lightning Struck
            2042, -- Shaatter Reistant
            1817, -- The Culling of Time
            1872, -- Zombiefest!
            2043, -- The Incredible Hulk
            1873, -- Lodi Dodi We Loves the Skadi!
            2156, -- My Girl Loves to Skadi All the Time
            2157, -- King's Bane
            1871, -- Experienced Drake Rider
            1868, -- Make It Count
            2044, -- Ruby Voio
            2045, -- Emerald Void
            2046 -- Amber Void
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME2) -- Wrath of the Lich King

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_GloryOfTheHero)
    end

    ACMListFlat:Ids{
        2136, -- Glory of the Hero
        4156, -- A Tribute to Immortality
        12401, -- Glory of the Ulduar Raider
        4602, -- Glory of the Icecrown Raider (10 player)
        4603, -- Glory of the Icecrown Raider (25 player)
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons
    local ACMList_Dungeons = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15272)) -- Dungeons

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons:Insert(ACMChilds_GloryOfTheHero)
    end

    ACMList_Dungeons:Ids{
        2136, -- Glory of the Hero
    }

    -- Raids->Trial of the Crusader
    local ACMList_RaidsTrialOfTheCrusader = KAF_Cat(Utilities:GetDungeonNameByLFGDungeonID(246)) -- Trial of the Crusader
        :Ids{
            4156 -- A Tribute to Immortality
        }

    local ACMList_Raids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15271)) -- Raids
        :Insert(ACMList_RaidsTrialOfTheCrusader)
        :Ids{
            12401, -- Glory of the Ulduar Raider
            4602, -- Glory of the Icecrown Raider (10 player)
            4603, -- Glory of the Icecrown Raider (25 player)
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME2) -- Wrath of the Lich King
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_Raids)

    return ACMList
end
