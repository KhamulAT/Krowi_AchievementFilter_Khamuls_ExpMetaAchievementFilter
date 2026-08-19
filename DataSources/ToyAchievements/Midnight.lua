local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMNToyAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight
        :Ids{
            62388, -- Illicit Rain: Five Stars
            62125, -- Treasures of Zul'Aman
            62126, -- Treasures of Voidstorm
            63662, -- Student of Hissstory
            63167, -- Tour of Duty: The Coiled Isle
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons->Murder Row
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS) -- Dungeons

    KAF_Sub(ACMList_Dungeons, Utilities:GetDungeonNameByLFGDungeonID(3089)) -- Murder Row
        :Ids{
            62388, -- Illicit Rain: Five Stars
        }

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2437)) -- Zul'Aman
        :Ids{
            62125, -- Treasures of Zul'Aman
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2405)) -- Voidstorm
        :Ids{
            62126, -- Treasures of Voidstorm
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2512)) -- The Coiled Isle
        :Ids{
            63662, -- Student of Hissstory
            63167, -- Tour of Duty: The Coiled Isle
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight
        :Insert(ACMList_Zones)
        :Insert(ACMList_Dungeons)

    return ACMList
end
