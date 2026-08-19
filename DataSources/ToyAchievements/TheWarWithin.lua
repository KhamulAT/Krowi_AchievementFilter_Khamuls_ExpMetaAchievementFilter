local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWToyAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME10) -- The War Within
        :Ids{
            40314, -- Fragments of Memories
            41588, -- Read Between the Lines
            42241, -- Overcharged Delver
            41211, -- A Good Day to Dye Hard
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2274)) -- Khaz Algar
        :Ids{
            40314, -- Fragments of Memories
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2346)) -- Undermine
        :Ids{
            41588, -- Read Between the Lines
        }

    -- Delves
    local ACMList_Delves = KAF_Cat(_G.DELVES_LABEL) -- Delves
        :Ids{
            42241, -- Overcharged Delver
        }

    -- Raids->Liberation of Undermine
    local ACMList_Raids = KAF_Cat(_G.RAIDS) -- Raids

    KAF_Sub(ACMList_Raids, Utilities:GetDungeonNameByLFGDungeonID(2779)) -- Liberation of Undermine
        :Ids{
            41211, -- A Good Day to Dye Hard
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME10) -- The War Within
        :Insert(ACMList_Zones)
        :Insert(ACMList_Delves)
        :Insert(ACMList_Raids)

    return ACMList
end
