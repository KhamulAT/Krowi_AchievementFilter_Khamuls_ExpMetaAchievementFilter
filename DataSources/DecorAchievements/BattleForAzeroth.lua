local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingBfA()

    local ACM_BfA_Zones_KulTirasZandalar_Quests = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12582,
            12997,
            12479,
            12509
        }
    }

    local ACM_BfA_Zones_KulTirasZandalar = {
        SPLASH_BATTLEFORAZEROTH_BOX_RIGHT_TITLE_ALLIANCE .. " & " .. SPLASH_BATTLEFORAZEROTH_BOX_RIGHT_TITLE_HORDE,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Zones_KulTirasZandalar_Quests
    }

    local ACM_BfA_Zones_TiragardeSound_Quests = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13049
        }
    }

    local ACM_BfA_Zones_TiragardeSound = {
        Utilities:HousingUtilitiesGetZoneNameByMapID(895),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Zones_TiragardeSound_Quests
    }

    local ACM_BfA_Zones_Zuldazar_Quests = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13039,
            13038,
            12614
        }
    }

    local ACM_BfA_Zones_Zuldazar = {
        Utilities:HousingUtilitiesGetZoneNameByMapID(862),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Zones_Zuldazar_Quests
    }

    local ACM_BfA_Zones_Voldun_Exploration = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13018
        }
    }

    local ACM_BfA_Zones_Voldun = {
        Utilities:HousingUtilitiesGetZoneNameByMapID(864),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Zones_Voldun_Exploration
    }

    local ACM_BfA_Zones_MechagonIsland_Exploration = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13723,
            13473,
            13475,
            13477
        }
    }

    local ACM_BfA_Zones_MechagonIsland = {
        Utilities:HousingUtilitiesGetZoneNameByMapID(1462),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Zones_MechagonIsland_Exploration
    }

    local ACM_BfA_Zones = {
        ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Zones_KulTirasZandalar,
        ACM_BfA_Zones_TiragardeSound,
        ACM_BfA_Zones_Zuldazar,
        ACM_BfA_Zones_Voldun,
        ACM_BfA_Zones_MechagonIsland
    }

    local ACM_BfA_Dungeons_OperationMechagon = {
        Utilities:HousingUtilitiesGetDungeonNameByLFGDungeonID(2006),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13723
        }
    }

    local ACM_BfA_Dungeons = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(15272),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Dungeons_OperationMechagon
    }

    local ACM_BfA_Professions_Cooking = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(170),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12746
        }
    }

    local ACM_BfA_Professions = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(169),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACM_BfA_Professions_Cooking,
        {
            12733
        }
    }

    local ACM_BfA_WarEffort = {
        Utilities:HousingUtilitiesGetAchievementCategoryNameNyCategoryID(15308),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12867,
            12869,
            12870,
            13284
        }
    }

    local ACMList = { 
        EXPANSION_NAME7,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true,
            Tooltip = Utilities:HousingUtilitiesReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:HousingUtilitiesGetAchievementName(40953)})
        },
        ACM_BfA_Zones,
        ACM_BfA_Dungeons,
        ACM_BfA_Professions,
        ACM_BfA_WarEffort,
        {
            40953
        }

    }

    return ACMList
end