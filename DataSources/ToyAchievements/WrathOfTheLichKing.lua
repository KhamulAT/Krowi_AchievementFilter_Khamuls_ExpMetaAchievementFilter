local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetWotLKToyAchievements()

    -- Child Achievements The Coin Master
    local ACMChilds_TheCoinMaster = KAF_Cat(Utilities:GetAchievementName(2096))
        :Ids{
            2094, -- A Penny For Your Thougths
            2095, -- Silver in the City
            1957, -- There's Gold In That There Fountain
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME2) -- Wrath of the Lich King

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_TheCoinMaster)
    end

    ACMListFlat:Ids{
        1956, -- Higher Learning
        2096, -- The Coin Master
        18725, -- Best Stellar
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zones

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(41)) -- Dalaram
        :Ids{
            1956, -- Higher Learing
        }

    -- Professions->Fishing
    local ACMList_Professions_Fishing = KAF_Cat(_G.PROFESSIONS_FISHING)

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_Professions_Fishing:Insert(ACMChilds_TheCoinMaster)
    end

    ACMList_Professions_Fishing:Ids{
        2096, -- The Coin Master
    }

    -- Professions->Inscription
    local ACMList_Professions_Inscription = KAF_Cat(_G.INSCRIPTION)
        :Ids{
            18725, -- Best Stellar
        }

    -- Professions
    local ACMList_Professions = KAF_Cat(_G.TRADE_SKILLS)
        :Insert(ACMList_Professions_Fishing)
        :Insert(ACMList_Professions_Inscription)

    local ACMList = KAF_Cat(_G.EXPANSION_NAME2) -- Wrath of the Lich King
        :Insert(ACMList_Zones)
        :Insert(ACMList_Professions)

    return ACMList
end
