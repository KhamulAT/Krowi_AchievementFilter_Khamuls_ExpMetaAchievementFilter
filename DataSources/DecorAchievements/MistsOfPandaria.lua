local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingMoP()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME4) -- Mists of Pandaria
        :Ids{
            8316, -- Blood in the Snow
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_Scenarios = KAF_CatChain(Utilities:GetAchievementCategoryNameByCategoryID(15302)) -- Pandaria Scenarios
        :Insert(
            KAF_CatChain(Utilities:GetDungeonNameByLFGDungeonID(646)) -- Blood in the Snow
                :Ids{
                    8316, -- Blood in the Snow
                }
        )

    local ACMList = KAF_CatChain(EXPANSION_NAME4) -- Mists of Pandaria
        :Insert(ACMList_Scenarios)

    return ACMList
end
