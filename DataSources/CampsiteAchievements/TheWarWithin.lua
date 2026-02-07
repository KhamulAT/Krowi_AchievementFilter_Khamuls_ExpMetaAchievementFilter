local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWCampsiteList()
    local ACM_AllThatKhaz = {
        Utilities:GetAchievementName(41555),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40430,
            40702,
            20596,
            40762,
            41169,
            40307
        }
    }

    local ACM_FreywoldSpring = {
        Utilities:GetAchievementRewardInfo(41555),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_AllThatKhaz,
        {
            41555
        }
    }

    local ACM_GoingGoblinMode = {
        Utilities:GetAchievementName(41586),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            41216,
            41217,
            40948,
            41588,
            41589,
            41708
        }
    }

    local ACM_GallagioGrandGallery = {
        Utilities:GetAchievementRewardInfo(41586),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_GoingGoblinMode,
        {
            41586
        }
    }

    local ACM_TheFateOfTheDevoured = {
        Utilities:GetAchievementRewardInfo(41970),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            41970
        }
    }

    local ACMList = { 
        _G.EXPANSION_NAME10,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_FreywoldSpring,
        ACM_GallagioGrandGallery,
        ACM_TheFateOfTheDevoured
    }

    return ACMList
end