local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingLegion()

    local ACM_Legion_ValSharah_Exploration = {
        Utilities:GetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            11258
        }
    }

    local ACM_Legion_Valsharah_Quests = {
        Utilities:GetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            10698
        }
    }

    local ACM_Legion_Valsharah = {
        Utilities:GetZoneNameByMapID(641),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_Valsharah_Quests,
        ACM_Legion_ValSharah_Exploration
    }

    local ACM_Legion_Highmountain_Quests = {
        Utilities:GetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            10398
        }
    }

    local ACM_Legion_Highmountain_Exploration = {
        Utilities:GetAchievementCategoryNameNyCategoryID(97),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            11257
        }
    }

    local ACM_Legion_Highmountain = {
        Utilities:GetZoneNameByMapID(650),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_Highmountain_Quests,
        ACM_Legion_Highmountain_Exploration
    }

    local ACM_Legion_Suramar_Quests = {
        Utilities:GetAchievementCategoryNameNyCategoryID(96),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            11124,
            11340
        }
    }

    local ACM_Legion_Suramar = {
        Utilities:GetZoneNameByMapID(680),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_Suramar_Quests
    }

    local ACM_Legion_Zones = {
        ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_Valsharah,
        ACM_Legion_Highmountain,
        ACM_Legion_Suramar
    }

    local ACM_Legion_Dungeons_NeltharionsLair = {
        Utilities:GetDungeonNameByLFGDungeonID(1206),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            10996
        }
    }

    local ACM_Legion_Dungeons = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15272),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_Dungeons_NeltharionsLair
    }

    local ACM_Legion_Raids_TombOfSargeras = {
        Utilities:GetDungeonNameByLFGDungeonID(1525),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            11699
        }
    }

    local ACM_Legion_Raids = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15278),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_Raids_TombOfSargeras
    }

    local ACM_Legion_OrderHalls_ALegendaryCampaign = {
        Utilities:GetAchievementName(11137),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            42270,
            42271,
            42272,
            42273,
            42274,
            42275,
            42276,
            42277,
            42279,
            42280,
            42281,
            42282
        }
    }

    local ACM_Legion_OrderHalls_RaiseAnArmy = {
        Utilities:GetAchievementName(11212),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            60981,
            60982,
            60983,
            60984,
            60985,
            60986,
            60987,
            60988,
            60989,
            60990,
            60991,
            60992
        }
    }

    local ACM_Legion_OrderHalls_LegendaryResearch = {
        Utilities:GetAchievementName(11223),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            60962,
            60963,
            60964,
            60965,
            60966,
            60967,
            60968,
            60969,
            60970,
            60971,
            60972,
            60973
        }
    }

    local ACM_Legion_OrderHalls_HiddenPotential = {
        Utilities:GetAchievementName(10460),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            42287,
            42288,
            42289,
            42290,
            42291,
            42292,
            42293,
            42294,
            42295,
            42296,
            42297,
            42298
        }
    }

    local ACM_Legion_OrderHalls = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15304),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_OrderHalls_ALegendaryCampaign,
        ACM_Legion_OrderHalls_RaiseAnArmy,
        ACM_Legion_OrderHalls_LegendaryResearch,
        ACM_Legion_OrderHalls_HiddenPotential
    }

    local ACMList = { 
        EXPANSION_NAME6,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_Legion_Zones,
        ACM_Legion_Dungeons,
        ACM_Legion_Raids,
        ACM_Legion_OrderHalls
    }

    return ACMList
end