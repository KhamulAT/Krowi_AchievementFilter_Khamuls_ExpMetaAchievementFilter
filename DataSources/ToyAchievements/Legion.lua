local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetLegionToyAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME6) -- Legion
        :Ids{
            10774, -- Hatchling or the Talon
            11427, -- No Shellfish Endeavor
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE)

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(650))
        :Ids{
            10774, -- Hatchling or the Talon
        }

    KAF_Sub(ACMList_Zones, _G.CLUB_FINDER_MULTIPLE_CHECKED .. " " .. _G.ZONE) -- Multiple Zone
        :Ids{
            11427, -- No Shellfish Endeavor
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME6) -- Legion
        :Insert(ACMList_Zones)

    return ACMList
end
