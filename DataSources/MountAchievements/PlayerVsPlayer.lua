local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetPlayerVsPlayerMountAchievements()

    -- Child Achievements For the Horde!
    local ACMChilds_ForTheHorde = KAF_Cat(Utilities:GetAchievementName(619))
        :Ids{
            616, -- Overthrow the Council
            618 -- Puttinng Out the Light
        }

    -- Child Achievements For the Alliance!
    local ACMChilds_ForTheAlliance = KAF_Cat(Utilities:GetAchievementName(614))
        :Ids{
            613, -- Killed in Quel'Thalas
            14817 -- Opposing Orgrimmar
        }

    ------
    --- Legion Achievements
    ------

    -- Child Achievements Free For All More For Me
    local ACMChilds_Legion_FreeForAllMoreForMe = KAF_Cat(Utilities:GetAchievementName(11474))
        :Ids{
            11475, -- Mission Accomplished
            11476, -- Saddle Sore
            11477, -- Off the Top Rock
            11478 -- The Darkbrul-oh
        }

    ------
    --- The War Within Achievements
    ------

    -- Child Achievements Ruffious's Bid
    local ACMChilds_TheWarWithin_RuffioussBid = KAF_Cat(Utilities:GetAchievementName(40067))
        :Ids{
            40087, -- Unbound Battle
            40088, -- A Champion's Tour: The War Within
            40083, -- Tour of Duty: Isle of Dorn
            40084, -- Tour of Duty: The Ringing Deeps
            40084, -- Tour of Duty: Hallowfall
            40086 -- Tour of Duty: Azj-Kahet
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(21)) -- Player vs. Player

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_ForTheHorde)
        ACMListFlat:Insert(ACMChilds_ForTheAlliance)
        ACMListFlat:Insert(ACMChilds_Legion_FreeForAllMoreForMe)
        ACMListFlat:Insert(ACMChilds_TheWarWithin_RuffioussBid)
    end

    ACMListFlat:Ids{
        619, -- For the Horde!
        614, -- For the Alliance!
        11474, -- Free for All, More For Me
        40097, -- Ruffious's Bid
        12895, -- Honor Level 15
        12903, -- Honor Level 40
        12906, -- Honor Level 70
        12910, -- Honor Level 125
        12911, -- Honor Level 150
        12914, -- Honor Level 250
        12917, -- Honor Level 500
        5325, -- Veteran of the Horde
        5824, -- Veteran of the Horde II
        5326, -- Warbringer of the Horde
        5328, -- Veteran of the Alliance
        5823, -- Veteran of the Alliance II
        5329, -- Warbound Veteran of the Alliance
        2091, -- Gladiator
        -- Seasonal arena mounts (Alliance and Horde variants are both listed)
        8484, -- Grievous Combatant
        8485, -- Grievous Combatant
        8641, -- Prideful Combatant
        8642, -- Prideful Combatant
        9236, -- Primal Combatant
        9238, -- Primal Combatant
        10092, -- Wild Combatant
        10093, -- Wild Combatant
        10094, -- Warmongering Combatant
        10095, -- Warmongering Combatant
        10997, -- Vindictive Combatant
        10998, -- Vindictive Combatant
        11003, -- Fearless Combatant
        11004, -- Fearless Combatant
        11005, -- Cruel Combatant
        11008, -- Cruel Combatant
        11009, -- Ferocious Combatant
        11010, -- Ferocious Combatant
        12031, -- Fierce Combatant
        12032, -- Fierce Combatant
        12136, -- Dominant Combatant
        12137, -- Dominant Combatant
        12199, -- Demonic Combatant
        12200, -- Demonic Combatant
        12961, -- Gladiator: Battle for Azeroth Season 1
        13212, -- Gladiator: Battle for Azeroth Season 2
        13647, -- Gladiator: Battle for Azeroth Season 3
        13967, -- Gladiator: Battle for Azeroth Season 4
        14689, -- Gladiator: Shadowlands Season 1
        14972, -- Gladiator: Shadowlands Season 2
        15352, -- Gladiator: Shadowlands Season 3
        15605, -- Gladiator: Shadowlands Season 4
        15957, -- Gladiator: Dragonflight Season 1
        17740, -- Gladiator: Dragonflight Season 2
        19091, -- Gladiator: Dragonflight Season 3
        19490, -- Gladiator: Dragonflight Season 4
        40393, -- Gladiator: The War Within Season 1
        41032, -- Gladiator: The War Within Season 2
        41049, -- Gladiator: The War Within Season 3
        62930, -- Gladiator: Midnight Season 2
        62955, -- Venomous Gladiator's Goredrake
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Alliance
    local ACMList_Alliance = KAF_Cat(_G.FACTION_ALLIANCE) -- Alliance

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Alliance:Insert(ACMChilds_ForTheAlliance)
    end

    KAF_Sub(ACMList_Alliance, Utilities:GetAchievementCategoryNameByCategoryID(15092)) -- Rated Battlegrounds
        :Ids{
            5328, -- Veteran of the Alliance
            5823, -- Veteran of the Alliance II
            5329, -- Warbound Veteran of the Alliance
        }

    ACMList_Alliance:Ids{
        614 -- For the Alliance!
    }

    -- Horde
    local ACMList_Horde = KAF_Cat(_G.FACTION_HORDE) -- Horde

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Horde:Insert(ACMChilds_ForTheHorde)
    end

    KAF_Sub(ACMList_Horde, Utilities:GetAchievementCategoryNameByCategoryID(15092)) -- Rated Battlegrounds
        :Ids{
            5325, -- Veteran of the Horde
            5824, -- Veteran of the Horde II
            5326, -- Warbringer of the Horde
        }

    ACMList_Horde:Ids{
        619 -- For the Horde!
    }

    -- Honor
    local ACMList_Honor = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15266)) -- Honor
        :Ids{
            12895, -- Honor Level 15
            12903, -- Honor Level 40
            12906, -- Honor Level 70
            12910, -- Honor Level 125
            12911, -- Honor Level 150
            12914, -- Honor Level 250
            12917, -- Honor Level 500
        }

    -- Arena
    -- Both faction variants of the Combatant achievements are listed; only the one
    -- matching the character's faction can actually be earned.
    local ACMList_Arena = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(165)) -- Arena

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME4) -- Mists of Pandaria
        :Ids{
            8484, -- Grievous Combatant
            8485, -- Grievous Combatant
            8641, -- Prideful Combatant
            8642, -- Prideful Combatant
        }

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME5) -- Warlords of Draenor
        :Ids{
            9236, -- Primal Combatant
            9238, -- Primal Combatant
            10092, -- Wild Combatant
            10093, -- Wild Combatant
            10094, -- Warmongering Combatant
            10095, -- Warmongering Combatant
        }

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME6) -- Legion
        :Ids{
            10997, -- Vindictive Combatant
            10998, -- Vindictive Combatant
            11003, -- Fearless Combatant
            11004, -- Fearless Combatant
            11005, -- Cruel Combatant
            11008, -- Cruel Combatant
            11009, -- Ferocious Combatant
            11010, -- Ferocious Combatant
            12031, -- Fierce Combatant
            12032, -- Fierce Combatant
            12136, -- Dominant Combatant
            12137, -- Dominant Combatant
            12199, -- Demonic Combatant
            12200, -- Demonic Combatant
        }

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME7) -- Battle for Azeroth
        :Ids{
            12961, -- Gladiator: Battle for Azeroth Season 1
            13212, -- Gladiator: Battle for Azeroth Season 2
            13647, -- Gladiator: Battle for Azeroth Season 3
            13967, -- Gladiator: Battle for Azeroth Season 4
        }

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME8) -- Shadowlands
        :Ids{
            14689, -- Gladiator: Shadowlands Season 1
            14972, -- Gladiator: Shadowlands Season 2
            15352, -- Gladiator: Shadowlands Season 3
            15605, -- Gladiator: Shadowlands Season 4
        }

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME9) -- Dragonflight
        :Ids{
            15957, -- Gladiator: Dragonflight Season 1
            17740, -- Gladiator: Dragonflight Season 2
            19091, -- Gladiator: Dragonflight Season 3
            19490, -- Gladiator: Dragonflight Season 4
        }

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME10) -- The War Within
        :Ids{
            40393, -- Gladiator: The War Within Season 1
            41032, -- Gladiator: The War Within Season 2
            41049, -- Gladiator: The War Within Season 3
        }

    KAF_Sub(ACMList_Arena, _G.EXPANSION_NAME11) -- Midnight
        :Ids{
            62930, -- Gladiator: Midnight Season 2
            62955, -- Venomous Gladiator's Goredrake
        }

    ACMList_Arena:Ids{
        2091, -- Gladiator
    }

    ------
    --- Legion Achievements
    ------

    local ACMList_Legion = KAF_Cat(_G.EXPANSION_NAME6) -- Legion

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Legion:Insert(ACMChilds_Legion_FreeForAllMoreForMe)
    end

    ACMList_Legion:Ids{
        11474, -- Free for All, More For Me
    }

    ------
    --- The War Within Achievements
    ------

    local ACMList_TheWarWithin = KAF_Cat(_G.EXPANSION_NAME10) -- The War Within

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_TheWarWithin:Insert(ACMChilds_TheWarWithin_RuffioussBid)
    end

    ACMList_TheWarWithin:Ids{
        40097, -- Ruffious's Bid
    }

    local ACMList = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(21)) -- Player vs. Player
        :Insert(ACMList_Alliance)
        :Insert(ACMList_Horde)
        :Insert(ACMList_Honor)
        :Insert(ACMList_Arena)
        :Insert(ACMList_Legion)
        :Insert(ACMList_TheWarWithin)

    return ACMList
end
