local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCrossExpansionMountAchievements()


    -- Child Achievements 100 Exalted Reputations
    local ACMChilds_HundredExaltedReputations = {
        Utilities:GetAchievementName(12866),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            522, -- Somebody Likes Me
            523, -- 5 Exalted Reputations
            524, -- 10 Exalted Reputations
            521, -- 15 Exalted Reputations
            520, -- 20 Exalted Reputations
            519, -- 25 Exalted Reputations
            518, -- 30 Exalted Reputations
            1014, -- 35 Exalted Reputations
            1015, -- 40 Exalted Reputations
            5374, -- 45  Exalted Reputations
            5723, -- 50 Exalted Reputations
            6826, -- 55 Exalted Reputations
            6742, -- 60 Exalted Reputations
            11177, -- 70 Exalted Reputations
            12864, -- 80 Exalted Reputations
            12865, -- 90 Exalted Reputations
        }
    }

    -- Child Achievements Remember to Share
    local ACMChilds_RememberToShare = {
        Utilities:GetAchievementName(11176),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9670, -- Toying Around
            9671, -- Having a Ball
            9672, -- Tons of Toys
            9673, -- The Toymaster
            10354 -- Crashin' Trashin' Commander
        }
    }


    -- Flat achievement list
    local ACMListFlat = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_HundredExaltedReputations
        ACMListFlat[#ACMListFlat+1] = ACMChilds_RememberToShare
    end

    ACMListFlat[#ACMListFlat+1] = {
        12866, -- 100 Exalted Reputations
        11176 -- Remember to Share
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Reputation
    local ACMList_Reputation = {
        Utilities:GetAchievementCategoryNameByCategoryID(201), -- Reputation
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Reputation[#ACMList_Reputation+1] = ACMChilds_HundredExaltedReputations
    end

    ACMList_Reputation[#ACMList_Reputation+1] = {
        12866 -- 100 Exalted Reputations
    }

    -- Collections
    local ACMList_Collections = {
        Utilities:GetAchievementCategoryNameByCategoryID(15246), -- Collections
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Collections[#ACMList_Collections+1] = ACMChilds_RememberToShare
    end

    ACMList_Collections[#ACMList_Collections+1] = {
        11176 -- Remember to Share
    }

    local ACMList = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Reputation,
        ACMList_Collections
    }

    return ACMList
end