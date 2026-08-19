local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetDFToyAchievements()

    -- Child Achievements Dragonriding Challenge: Dragon Isles: Bronze
    local ACMChilds_DragonridingChallenge_DragonIsles_Bronze = KAF_Cat(Utilities:GetAchievementName(18790))
        :Ids{
            18748, -- Waking Shores Challenge: Bronze
            18754, -- Ohn'ahran Plains Challenge: Bronze
            18757, -- Azure Span Challenge: Bronze
            18760, -- Thaldraszus Challenge: Bronze
            18779, -- Forbidden Reach Challenge: Bronze
            18786, -- Zaralek Cavern Challenge: Bronze
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME9) -- Dragonflight

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_DragonridingChallenge_DragonIsles_Bronze)
    end

    ACMListFlat:Ids{
        17782, -- Daycare Derby
        18559, -- Many Boxes, Many Rockses
        16423, -- Honor Our Ancestors
        15889, -- River Rapids Wrangler
        18100, -- Cavern Clawbbering
        16762, -- The Vegetarian Diet
        18790, -- Dragonriding Challenge: Dragon Isles: Bronze
        18554, -- Temporal Acquisitions Specialist
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zone
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2112)) -- Valdrakken
        :Ids{
            17782, -- Daycare Derby
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2022)) -- The Waking Shores
        :Ids{
            18559, -- Many Boxes, Many Rockses
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2023)) -- Ohn'ahran Plains
        :Ids{
            16423, -- Honor Our Ancestors
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2024)) -- The Azure Span
        :Ids{
            15889, -- River Rapids Wrangler
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2133)) -- Zaralek Cavern
        :Ids{
            18100, -- Cavern Clawbbering
        }

    -- Dungeons->Brackenhide Hollow
    local ACMList_Dungeons_BrackenhideHollow = KAF_Cat(_G.DUNGEONS) -- Dungeons

    KAF_Sub(ACMList_Dungeons_BrackenhideHollow, Utilities:GetDungeonNameByLFGDungeonID(2362))
        :Ids{
            16762, -- The Vegetarian Diet
        }

    -- Skyriding
    local ACMList_Skyriding = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15462)) -- Skyriding

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_Skyriding:Insert(ACMChilds_DragonridingChallenge_DragonIsles_Bronze)
    end

    ACMList_Skyriding:Ids{
        18790, -- Dragonriding Challenge: Dragon Isles: Bronze
    }

    -- Time Rifts
    local ACMList_TimeRifts = KAF_Cat(L["Time Rifts"])
        :Ids{
            18554, -- Temporal Acquisitions Specialist
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME9) -- Dragonflight
        :Insert(ACMList_Zones)
        :Insert(ACMList_Dungeons_BrackenhideHollow)
        :Insert(ACMList_Skyriding)
        :Insert(ACMList_TimeRifts)

    return ACMList
end
