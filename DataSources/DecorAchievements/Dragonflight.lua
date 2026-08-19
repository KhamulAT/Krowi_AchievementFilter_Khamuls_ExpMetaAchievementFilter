local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingDF()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME9) -- Dragonflight
        :Ids{
            19458, -- A World Awoken
            17773, -- A Blue Dawn
            19507, -- Fringe Benefits
            17529, -- Forbidden  Spoils
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = KAF_CatChain(_G.ZONE) -- Zone

    ACMList_Zones:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(2024)) -- Azure Span
            :Ids{
                17773, -- A Blue Dawn
            }
    )

    ACMList_Zones:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(2025)) -- Thaldraszus
            :Ids{
                19507, -- Fringe Benefits
            }
    )

    ACMList_Zones:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(2151)) -- Forbidden Reach
            :Ids{
                17529, -- Forbidden  Spoils
            }
    )

    local ACMList = KAF_CatChain(EXPANSION_NAME9, -- Dragonflight
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(19458)}))
        :Insert(ACMList_Zones)
        :Ids{
            19458, -- A World Awoken
        }

    return ACMList
end
