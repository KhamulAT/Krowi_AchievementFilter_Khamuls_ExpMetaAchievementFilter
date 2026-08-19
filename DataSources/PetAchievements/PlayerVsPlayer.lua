local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetPlayerVsPlayerPetAchievements()
    -- Flat achievement list
    local ACMListFlat = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(21)) -- Player vs. Player
        :Ids{
            12893, -- Honor Level 5
            12900, -- Honor Level 20
            12916, -- Honor Level 400
            40088, -- A Champion's Tour: The War Within
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Honor
    local ACMList_Honor = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15266)) -- Honor
        :Ids{
            12893, -- Honor Level 5
            12900, -- Honor Level 20
            12916, -- Honor Level 400
        }

    -- World
    local ACMList_KhazAlgar = KAF_Cat(Utilities:GetZoneNameByMapID(2274)) -- Khaz Algar
        :Ids{
            40088, -- A Champion's Tour: The War Within
        }

    local ACMList = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(21)) -- Player vs. Player
        :Insert(ACMList_Honor)
        :Insert(ACMList_KhazAlgar)

    return ACMList
end
