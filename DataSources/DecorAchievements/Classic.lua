local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingClassic()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME0 .. " & " .. EXPANSION_NAME3) -- Classic & Cataclysm
        :Ids{
            19719,  -- Reclamation of Gilneas
            5442, -- Full Caravan
            940, -- The Green Hills of Stranglethorn
            4859, -- Kings Under the Mountain
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones_EasternKingdoms = KAF_CatChain(Utilities:GetZoneNameByMapID(13)) -- Eastern Kingdoms

    ACMList_Zones_EasternKingdoms:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(23)) -- Eastern Plaguelands
            :Ids{
                5442, -- Full Caravan
            }
    )

    ACMList_Zones_EasternKingdoms:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(50)) -- Northern Stranglethorn
            :Ids{
                940, -- The Green Hills of Stranglethorn
            }
    )

    ACMList_Zones_EasternKingdoms:Ids{
        19719,  -- Reclamation of Gilneas
    }

    local ACMList_Zones = KAF_CatChain(_G.ZONE) -- Zone
        :Insert(ACMList_Zones_EasternKingdoms)

    local ACMList_TradeSkills = KAF_CatChain(_G.TRADE_SKILLS) -- Professions
        :Insert(
            KAF_CatChain(Utilities:GetAchievementCategoryNameByCategoryID(15071)) -- Archeology
                :Ids{
                    4859, -- Kings Under the Mountain
                }
        )

    local ACMList = KAF_CatChain(EXPANSION_NAME0 .. " & " .. EXPANSION_NAME3) -- Classic & Cataclysm
        :Insert(ACMList_Zones)
        :Insert(ACMList_TradeSkills)

    return ACMList
end
