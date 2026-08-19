local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetSLToyAchievements()

    -- Child Achievements Twisting Corridors: Layer 4
    local ACMChilds_TwistingCorridors = KAF_Cat(Utilities:GetAchievementName(14471))
        :Ids{
            14468, -- Twisting Corridors: Layer 1
            14469, -- Twisting Corridors: Layer 2
            14470, -- Twisting Corridors: Layer 3
        }

    -- Child Achievements The Jailer's Gauntlet: Layer 2
    local ACMChilds_TheJailersGauntlet = KAF_Cat(Utilities:GetAchievementName(15252))
        :Ids{
            15251, -- The Jailer's Gauntlet: Layer 1
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME8) -- Shadowlands

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_TwistingCorridors)
        ACMListFlat:Insert(ACMChilds_TheJailersGauntlet)
    end

    ACMListFlat:Ids{
        14721, -- It's In The Mix
        14634, -- Nine Afterlives
        14766, -- Parasoling
        15229, -- Traversing the Spheres
        15211, -- Completing the Code
        14471, -- Twisting Corridors: Layer 4
        15252, -- The Jailer's Gauntlet: Layer 2
        14625, -- Battle in the Shadowlands
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(1536)) -- Maldraxxus
        :Ids{
            14721, -- It's In The Mix
            14634, -- Nine Afterlives
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(1525)) -- Rivendreth
        :Ids{
            14766, -- Parasoling
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(1970)) -- Zereth Mortis
        :Ids{
            15229, -- Traversing the Spheres
            15211, -- Completing the Code
        }

    -- Torghast
    local ACMList_Torghast = KAF_Cat(Utilities:GetZoneNameByMapID(1618)) -- Torghast

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_Torghast:Insert(ACMChilds_TwistingCorridors)
        ACMList_Torghast:Insert(ACMChilds_TheJailersGauntlet)
    end

    ACMList_Torghast:Ids{
        14471, -- Twisting Corridors: Layer 4
        15252, -- The Jailer's Gauntlet: Layer 2
    }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles
        :Ids{
            14625, -- Battle in the Shadowlands
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME8) -- Shadowlands
        :Insert(ACMList_Zones)
        :Insert(ACMList_Torghast)
        :Insert(ACMList_PetBattles)

    return ACMList
end
