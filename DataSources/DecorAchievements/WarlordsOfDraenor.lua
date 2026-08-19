local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingWoD()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME5) -- Warlords of Draenor
        :Ids{
            9415, -- Secrets of Skettis
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- TradeSkills
    local ACMList_TradeSkills = KAF_CatChain(_G.TRADE_SKILLS) -- Professions
        :Insert(
            KAF_CatChain(Utilities:GetAchievementCategoryNameByCategoryID(15071)) -- Archeology
                :Ids{
                    9415, -- Secrets of Skettis
                }
        )

    local ACMList = KAF_CatChain(EXPANSION_NAME5) -- Warlords of Draenor
        :Insert(ACMList_TradeSkills)

    return ACMList
end
