local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetClassicMountAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME0) -- Classic
        :Ids{
            9550 -- Boldly, You Sought the Power of Ragnaros
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons & Raids -> Molten Core
    local ACMList_DungeonsAndRaidsMoltenCore = KAF_Cat(Utilities:GetZoneNameByMapID(232))
        :Ids{
            9550 -- Boldly, You Sought the Power of Ragnaros
        }

    -- Dungeons & Raids
    local ACMList_DungeonsAndRaids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(168)) -- Dungeons & Raids
        :Insert(ACMList_DungeonsAndRaidsMoltenCore)

    local ACMList = KAF_Cat(_G.EXPANSION_NAME0) -- Classic
        :Insert(ACMList_DungeonsAndRaids)

    return ACMList
end
