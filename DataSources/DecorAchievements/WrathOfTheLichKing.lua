local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingWotLk()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME2) -- Wrath of the Lich King
        :Ids{
            938, -- The Snows of Northrend
            4405, -- More Dots! (25 player)
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_Zones = KAF_CatChain(_G.ZONE) -- Zone
        :Insert(
            KAF_CatChain(Utilities:GetZoneNameByMapID(119)) -- Sholazar Basin
                :Ids{
                    938, -- The Snows of Northrend
                }
        )

    local ACMList_Raids = KAF_CatChain(_G.RAIDS) -- Raids
        :Insert(
            KAF_CatChain(Utilities:GetDungeonNameByLFGDungeonID(257)) -- Onyxia's Lair
                :Insert(
                    KAF_CatChain(_G.RAID_DIFFICULTY2) -- 25 Player
                        :Ids{
                            4405, -- More Dots! (25 player)
                        }
                )
        )

    local ACMList = KAF_CatChain(EXPANSION_NAME2)
        :Insert(ACMList_Zones)
        :Insert(ACMList_Raids)

    return ACMList
end
