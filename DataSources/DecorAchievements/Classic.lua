local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingClassic()

    local ACM_Classic_NorthernStranglethorn = {
        Utilities:HousingUtilitiesGetZoneNameByMapID(50),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            940
        }
    }

    local ACM_Classic_EasternPlaguelands = {
        Utilities:HousingUtilitiesGetZoneNameByMapID(23),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            5442
        }
    }

    local ACM_Classic_EasternKingdoms = {
        Utilities:HousingUtilitiesGetZoneNameByMapID(13),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Classic_EasternPlaguelands,
        ACM_Classic_NorthernStranglethorn,
        {
            19719
        }
    }

    local ACM_Classic_Zones = {
        ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Classic_EasternKingdoms
    }

    local ACM_Classic_TradeSkills_Archaeology = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(15071),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            4859
        }
    }

    local ACM_Classic_TradeSkills = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(169),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Classic_TradeSkills_Archaeology
    }

    local ACMList = { 
        EXPANSION_NAME0 .. " & " .. EXPANSION_NAME3,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Classic_Zones,
        ACM_Classic_TradeSkills
    }

    return ACMList
end