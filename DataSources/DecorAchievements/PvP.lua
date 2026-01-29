local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingPvP()

    local ACM_WarsongGulch = {
        Utilities:GetAchievementCategoryNameNyCategoryID(14804),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            167,
            200
        }
    }

    local ACM_ArathiBasin = {
        Utilities:GetAchievementCategoryNameNyCategoryID(14802),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            158,
            1153
        }
    }

    local ACM_EyeOfTheStorm = {
        Utilities:GetAchievementCategoryNameNyCategoryID(14803),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            212,
            213
        }
    }

    local ACM_AlteracValley = {
        Utilities:GetAchievementCategoryNameNyCategoryID(14801),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            221,
            222
        }
    }

    local ACM_BattleForGilneas = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15073),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            5245
        }
    }

    local ACM_TwinPeaks = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15074),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            5223
        }
    }

    local ACM_TempleOfKotmogu = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15163),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            6981
        }
    }

    local ACM_DeephaulRavine = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15525),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40210,
            40612
        }
    }

    local ACMList = { 
        Utilities:GetAchievementCategoryNameNyCategoryID(15279),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_WarsongGulch,
        ACM_ArathiBasin,
        ACM_EyeOfTheStorm,
        ACM_AlteracValley,
        ACM_BattleForGilneas,
        ACM_TwinPeaks,
        ACM_TempleOfKotmogu,
        ACM_DeephaulRavine,
        {
            61683,
            61684,
            61685,
            61686,
            61687,
            61688,
            229,
            231,
            1157
        }

    }

    return ACMList
end