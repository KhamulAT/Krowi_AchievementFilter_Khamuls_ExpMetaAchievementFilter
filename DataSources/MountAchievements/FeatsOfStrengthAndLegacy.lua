local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetFeatsOfStrengthAndLegacyMountAchievements()
    -- Flat achievement list
    local ACMListFlat = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(81) .. " & " .. Utilities:GetAchievementCategoryNameByCategoryID(15176)) -- Feats of Strength & Legacy
        :Ids{
            19876, -- Vale of Eternal Blossoms
            20593, -- Time Trial
            60817, -- Explore Argus
            19079, -- Master of the Turbulent Timeways
            41056, -- Master of the Turbulent Timeways II
            41779, -- Master of the Turbulent Timeways III
            61394, -- Master of the Turbulent Timeways IV
            61463, -- Master of the Turbulent Timeways V
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Remix: Mists of Pandaria
    local ACMList_RemixMistsOfPandaria = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15536)) -- "Remix: Mists of Pandaria"
        :Ids{
            19876, -- Vale of Eternal Blossoms
            20593, -- Time Trial
        }

    -- Remix: Legion
    local ACMList_RemixLegion = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15562)) -- "Legion Remix"
        :Ids{
            60817, -- Explore Argus
        }

    -- Events
    local ACMList_Events = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15274)) -- Events
        :Ids{
            19079, -- Master of the Turbulent Timeways
            41056, -- Master of the Turbulent Timeways II
            41779, -- Master of the Turbulent Timeways III
            61394, -- Master of the Turbulent Timeways IV
            61463, -- Master of the Turbulent Timeways V
        }

    local ACMList = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(81) .. " & " .. Utilities:GetAchievementCategoryNameByCategoryID(15176)) -- Feats of Strength & Legacy
        :Insert(ACMList_RemixMistsOfPandaria)
        :Insert(ACMList_RemixLegion)
        :Insert(ACMList_Events)

    return ACMList
end
