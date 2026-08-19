local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetPlayerVsPlayerToyAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(21)) -- Player vs. Player
        :Ids{
            12894, -- Honor Level 10
            12902, -- Honor Level 30
            12905, -- Honor Level 60
            12908, -- Honor Level 90
            12912, -- Honor Level 175
            19304, -- Legend: Dragonflight Season 3
            19500, -- Legend: Dragonflight Season 4
            40233, -- Strategist: The War Within Season 1
            40395, -- Legend: The War Within Season 1
            40792, -- Solo Shuffle Medic: The War Within
            41358, -- Legend: The War Within Season 2
            41363, -- Strategist: The War Within Season 2
            42023, -- Legend: The War Within Season 3
            42024, -- Strategist: The War Within Season 3
            61190, -- Legend: Midnight Season 1
            61194, -- Strategist: Midnight Season 1
            61199, -- Solo Shuffle Medic: Midnight
            61200, -- Battleground Blitz Medic: Midnight
            62932, -- Legend: Midnight Season 2
            62950, -- Strategist: Midnight Season 2
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Honor
    local ACMList_Honor = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15266)) -- Honor
        :Ids{
            12894, -- Honor Level 10
            12902, -- Honor Level 30
            12905, -- Honor Level 60
            12908, -- Honor Level 90
            12912, -- Honor Level 175
        }

    -- Dragonflight
    local ACMList_Dragonflight = KAF_Cat(_G.EXPANSION_NAME9) -- Dragonflight
        :Ids{
            19304, -- Legend: Dragonflight Season 3
            19500, -- Legend: Dragonflight Season 4
        }

    -- The War Within
    local ACMList_TheWarWithin = KAF_Cat(_G.EXPANSION_NAME10) -- The War Within
        :Ids{
            40233, -- Strategist: The War Within Season 1
            40395, -- Legend: The War Within Season 1
            40792, -- Solo Shuffle Medic: The War Within
            41358, -- Legend: The War Within Season 2
            41363, -- Strategist: The War Within Season 2
            42023, -- Legend: The War Within Season 3
            42024, -- Strategist: The War Within Season 3
        }

    -- Midnight
    local ACMList_Midnight = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight
        :Ids{
            61190, -- Legend: Midnight Season 1
            61194, -- Strategist: Midnight Season 1
            61199, -- Solo Shuffle Medic: Midnight
            61200, -- Battleground Blitz Medic: Midnight
            62932, -- Legend: Midnight Season 2
            62950, -- Strategist: Midnight Season 2
        }

    local ACMList = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(21)) -- Player vs. Player
        :Insert(ACMList_Honor)
        :Insert(ACMList_Dragonflight)
        :Insert(ACMList_TheWarWithin)
        :Insert(ACMList_Midnight)

    return ACMList
end
