local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetBfaToyAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME7) -- Battle for Azeroth
        :Ids{
            13285, -- Upright Citizens
            13489, -- Secret Fish of Mechagon
            12936, -- Battle on Zandalar and Kul Tiras
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Tiragarde Sound
    local ACMList_Zones_TiragardeSound = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones_TiragardeSound, Utilities:GetZoneNameByMapID(895))
        :Ids{
            13285, -- Upright Citizens
        }

    -- Professions -> Fishing
    local ACMList_Professions_Fishing = KAF_Cat(_G.TRADE_SKILLS) -- Professions

    KAF_Sub(ACMList_Professions_Fishing, _G.PROFESSIONS_FISHING) -- Fishing
        :Ids{
            13489, -- Secret Fish of Mechagon
        }

    -- Pet Battle
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles
        :Ids{
            12936, -- Battle on Zandalar and Kul Tiras
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME7) -- Battle for Azeroth
        :Insert(ACMList_Zones_TiragardeSound)
        :Insert(ACMList_Professions_Fishing)
        :Insert(ACMList_PetBattles)

    return ACMList
end
