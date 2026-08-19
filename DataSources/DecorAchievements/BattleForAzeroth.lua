local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingBfA()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME7) -- Battle for Azeroth
        :Ids{
            40953, -- A Farewell to Arms
            12582, -- Come Sail Away
            12997, -- The Pride of Kul Tiras
            12479, -- Zandalar Forever!
            12509, -- Ready for War
            13049, -- The Long Con
            13039, -- Paku'ai
            13038, -- Raptari Rider
            12614, -- Loa Expectations
            13018, -- Dune Rider
            13473, -- Diversified Investments
            13475, -- Junkyard Scavenger
            13477, -- Junkyard Apprentice
            13723, -- M.C., Hammered
            12733, -- Professional Zandalari Master
            12746, -- The Zandalari Menu
            12867, -- Azeroth at War: The Barrens
            12869, -- Azeroth at War: After Lordaeron
            12870, -- Azeroth at War: Kalimdor on Fire
            13284, -- Frontline Warrior
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(876) .. " & " .. Utilities:GetZoneNameByMapID(875)) -- Kul Tiras & Zandalar
        :Ids{
            12582, -- Come Sail Away
            12997, -- The Pride of Kul Tiras
            12479, -- Zandalar Forever!
            12509, -- Ready for War
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(895)) -- Tiragarde Sound
        :Ids{
            13049, -- The Long Con
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(862)) -- Zuldazar
        :Ids{
            13039, -- Paku'ai
            13038, -- Raptari Rider
            12614, -- Loa Expectations
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(864)) -- Vol'dun
        :Ids{
            13018, -- Dune Rider
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(1462)) -- Mechagon Island
        :Ids{
            13473, -- Diversified Investments
            13475, -- Junkyard Scavenger
            13477, -- Junkyard Apprentice
        }

    -- Dungeons
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS) -- Dungeons
        :Ids{
            13723, -- M.C., Hammered
        }

    local ACMList_TradeSkills = KAF_Cat(_G.TRADE_SKILLS) -- Professions

    KAF_Sub(ACMList_TradeSkills, Utilities:GetAchievementCategoryNameByCategoryID(170)) -- Cooking
        :Ids{
            12746, -- The Zandalari Menu
        }

    ACMList_TradeSkills:Ids{
        12733, -- Professional Zandalari Master
    }

    local ACMList_WarEffort = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15308)) -- War Effort
        :Ids{
            12867, -- Azeroth at War: The Barrens
            12869, -- Azeroth at War: After Lordaeron
            12870, -- Azeroth at War: Kalimdor on Fire
            13284, -- Frontline Warrior
        }

    local ACMList = KAF_Cat(EXPANSION_NAME7, -- Battle for Azeroth
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(40953)}))
        :Insert(ACMList_Zones)
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_TradeSkills)
        :Insert(ACMList_WarEffort)
        :Ids{
            40953
        }

    return ACMList
end
