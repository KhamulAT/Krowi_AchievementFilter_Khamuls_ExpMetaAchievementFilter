local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCrossExpansionMountAchievements()

    -- Child Achievements 100 Exalted Reputations
    local ACMChilds_HundredExaltedReputations = KAF_Cat(Utilities:GetAchievementName(12866))
        :Ids{
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

    -- Child Achievements Remember to Share
    local ACMChilds_RememberToShare = KAF_Cat(Utilities:GetAchievementName(11176))
        :Ids{
            9670, -- Toying Around
            9671, -- Having a Ball
            9672, -- Tons of Toys
            9673, -- The Toymaster
            10354 -- Crashin' Trashin' Commander
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(L["Cross-Expansion"])

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_HundredExaltedReputations)
        ACMListFlat:Insert(ACMChilds_RememberToShare)
    end

    ACMListFlat:Ids{
        12866, -- 100 Exalted Reputations
        11176, -- Remember to Share
        -- Mount collection milestones
        2143, -- Leading the Cavalry
        2536, -- Mountain o' Mounts
        7860, -- We're Going to Need More Saddles
        8302, -- Mount Parade
        9598, -- Mountacular
        9713, -- Awake the Drakes
        10355, -- Lord of the Reins
        12931, -- No Stable Big Enough
        12933, -- A Horde of Hoofbeats
        62096, -- Insurmountable Collection
        9909, -- Heirloom Hoarder
        -- World Events
        2144, -- What a Long, Strange Trip It's Been
        15310, -- A Tour of Towers
        18646, -- Whodunnit?
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Reputation
    local ACMList_Reputation = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(201)) -- Reputation

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Reputation:Insert(ACMChilds_HundredExaltedReputations)
    end

    ACMList_Reputation:Ids{
        12866 -- 100 Exalted Reputations
    }

    -- Collections
    local ACMList_Collections = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15246)) -- Collections

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Collections:Insert(ACMChilds_RememberToShare)
    end

    ACMList_Collections:Ids{
        11176, -- Remember to Share
        9909, -- Heirloom Hoarder
    }

    KAF_Sub(ACMList_Collections, _G.MOUNTS) -- Mounts
        :Ids{
            2143, -- Leading the Cavalry
            2536, -- Mountain o' Mounts
            7860, -- We're Going to Need More Saddles
            8302, -- Mount Parade
            9598, -- Mountacular
            9713, -- Awake the Drakes
            10355, -- Lord of the Reins
            12931, -- No Stable Big Enough
            12933, -- A Horde of Hoofbeats
            62096, -- Insurmountable Collection
        }

    -- World Events
    local ACMList_WorldEvents = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(155)) -- World Events
        :Ids{
            2144, -- What a Long, Strange Trip It's Been
            15310, -- A Tour of Towers
            18646, -- Whodunnit?
        }

    local ACMList = KAF_Cat(L["Cross-Expansion"])
        :Insert(ACMList_Reputation)
        :Insert(ACMList_Collections)
        :Insert(ACMList_WorldEvents)

    return ACMList
end
