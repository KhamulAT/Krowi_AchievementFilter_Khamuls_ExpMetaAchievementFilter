local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingTWW()

    local ACM_TWW_Zones_IsleOfDorn_Quests = {
        Utilities:GetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            20595
        }
    }

    local ACM_TWW_Zones_IsleOfDorn_Exploration = {
        Utilities:GetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40859
        }
    }


    local ACM_TWW_Zones_IsleOfDorn = {
        Utilities:GetZoneNameByMapID(2248),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_TWW_Zones_IsleOfDorn_Quests,
        ACM_TWW_Zones_IsleOfDorn_Exploration,
        {
            41186
        }
    }

    local ACM_TWW_Zones_TheRingingDeeps_Exploration = {
        Utilities:GetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40504
        }
    }

    local ACM_TWW_Zones_TheRingingDeeps = {
        Utilities:GetZoneNameByMapID(2214),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_TWW_Zones_TheRingingDeeps_Exploration
    }

    local ACM_TWW_Zones_AzjKahet_Exploration = {
        Utilities:GetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40542
        }
    }

    local ACM_TWW_Zones_AzjKahet = {
        Utilities:GetZoneNameByMapID(2255),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_TWW_Zones_AzjKahet_Exploration
    }

    local ACM_TWW_Zones_Undermine_Quests = {
        Utilities:GetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40894
        }
    }

    local ACM_TWW_Zones_Undermine = {
        Utilities:GetZoneNameByMapID(2346),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_TWW_Zones_Undermine_Quests
    }

    local ACM_TWW_Zones = {
        ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_TWW_Zones_IsleOfDorn,
        ACM_TWW_Zones_TheRingingDeeps,
        ACM_TWW_Zones_AzjKahet,
        ACM_TWW_Zones_Undermine
    }

    local ACM_TWW_Raids_LiberationOfUndermine = {
        Utilities:GetDungeonNameByLFGDungeonID(2779),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            41119
        }
    }

    local ACM_TWW_Raids = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15278),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_TWW_Raids_LiberationOfUndermine
    }

    local ACM_TWW_TradeSkills = {
        Utilities:GetAchievementCategoryNameNyCategoryID(169),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            19408
        }
    }

    local ACM_TWW_Lorewalking = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15552),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            42187,
            42188,
            42189,
            61467
        }
    }

    local ACMList = { 
        EXPANSION_NAME10,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(61451)})
        },
        ACM_TWW_Zones,
        ACM_TWW_Raids,
        ACM_TWW_TradeSkills,
        ACM_TWW_Lorewalking,
        {
            61451
        }
    }

    return ACMList
end