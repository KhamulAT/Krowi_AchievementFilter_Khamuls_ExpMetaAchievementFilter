local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingSL()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME8) -- Shadowlands
        :Ids{
            20501, -- Back from the Beyond
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList = KAF_CatChain(EXPANSION_NAME8, -- Shadowlands
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(20501)}))
        :Ids{
            20501, -- Back from the Beyond
        }

    return ACMList
end
