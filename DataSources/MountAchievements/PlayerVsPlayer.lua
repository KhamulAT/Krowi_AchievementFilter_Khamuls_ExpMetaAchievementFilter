local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetPlayerVsPlayerMountAchievements()

    -- Child Achievements For the Horde!
    local ACMChilds_ForTheHorde = {
        Utilities:GetAchievementName(619),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            616, -- Overthrow the Council
            618 -- Puttinng Out the Light
        }
    }

    -- Child Achievements For the Alliance!
    local ACMChilds_ForTheAlliance = {
        Utilities:GetAchievementName(614),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            613, -- Killed in Quel'Thalas
            14817 -- Opposing Orgrimmar
        }
    }

    ------
    --- Legion Achievements
    ------
    
    -- Child Achievements Free For All More For Me
    local ACMChilds_Legion_FreeForAllMoreForMe = {
        Utilities:GetAchievementName(11474),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            11475, -- Mission Accomplished
            11476, -- Saddle Sore
            11477, -- Off the Top Rock
            11478 -- The Darkbrul-oh
        }
    }

    ------
    --- The War Within Achievements
    ------
    
    -- Child Achievements Ruffious's Bid
    local ACMChilds_TheWarWithin_RuffioussBid = {
        Utilities:GetAchievementName(40067),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40087, -- Unbound Battle
            40088, -- A Champion's Tour: The War Within
            40083, -- Tour of Duty: Isle of Dorn
            40084, -- Tour of Duty: The Ringing Deeps
            40084, -- Tour of Duty: Hallowfall
            40086 -- Tour of Duty: Azj-Kahet
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        Utilities:GetAchievementCategoryNameByCategoryID(21), -- Player vs. Player
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_ForTheHorde
        ACMListFlat[#ACMListFlat+1] = ACMChilds_ForTheAlliance
        ACMListFlat[#ACMListFlat+1] = ACMChilds_Legion_FreeForAllMoreForMe
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TheWarWithin_RuffioussBid
    end

    ACMListFlat[#ACMListFlat+1] = {
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
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Alliance
    local ACMList_Alliance = {
        _G.FACTION_ALLIANCE, -- Alliance
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Alliance[#ACMList_Alliance+1] = ACMChilds_ForTheAlliance
    end

    ACMList_Alliance[#ACMList_Alliance+1] = {
        Utilities:GetAchievementCategoryNameByCategoryID(15092), -- Rated Battlegrounds
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            5328, -- Veteran of the Alliance
            5823, -- Veteran of the Alliance II
            5329, -- Warbound Veteran of the Alliance
        }
    }

    ACMList_Alliance[#ACMList_Alliance+1] = {
        614 -- For the Alliance!
    }

    -- Horde
    local ACMList_Horde = {
        _G.FACTION_HORDE, -- Horde
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Horde[#ACMList_Horde+1] = ACMChilds_ForTheHorde
    end

    ACMList_Horde[#ACMList_Horde+1] = {
        Utilities:GetAchievementCategoryNameByCategoryID(15092), -- Rated Battlegrounds
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            5325, -- Veteran of the Horde
            5824, -- Veteran of the Horde II
            5326, -- Warbringer of the Horde
        }
    }

    ACMList_Horde[#ACMList_Horde+1] = {
        619 -- For the Horde!
    }

    -- Honor
    local ACMList_Honor = {
        Utilities:GetAchievementCategoryNameByCategoryID(15266), -- Honor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12895, -- Honor Level 15
            12903, -- Honor Level 40
            12906, -- Honor Level 70
            12910, -- Honor Level 125
            12911, -- Honor Level 150
            12914, -- Honor Level 250
            12917, -- Honor Level 500
        }
    }

    -- Arena
    local ACMList_Arena = {
        Utilities:GetAchievementCategoryNameByCategoryID(165), -- Honor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            2091, -- Gladiator
        }
    }
    
    ------
    --- Legion Achievements
    ------

    local ACMList_Legion = {
        _G.EXPANSION_NAME6, -- Legion
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Legion[#ACMList_Legion+1] = ACMChilds_Legion_FreeForAllMoreForMe
    end

    ACMList_Legion[#ACMList_Legion+1] = {
        11474, -- Free for All, More For Me
    }

    ------
    --- The War Within Achievements
    ------

    local ACMList_TheWarWithin = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_TheWarWithin[#ACMList_TheWarWithin+1] = ACMChilds_TheWarWithin_RuffioussBid
    end

    ACMList_TheWarWithin[#ACMList_TheWarWithin+1] = {
        40097, -- Ruffious's Bid
    }

    local ACMList = {
        Utilities:GetAchievementCategoryNameByCategoryID(21), -- Player vs. Player
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Alliance,
        ACMList_Horde,
        ACMList_Honor,
        ACMList_Arena,
        ACMList_Legion,
        ACMList_TheWarWithin
    }

    return ACMList
end
