local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetFeatsOfStrengthAndLegacyPetAchievements()
    -- Flat achievement list
    local ACMListFlat = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(81) .. " & " .. Utilities:GetAchievementCategoryNameByCategoryID(15176)) -- Feats of Strength & Legacy
        :Ids{
            8820, -- WoW's 10th Anniversary
            19877, -- Townlong Steppes,
            20003, -- Timeless Isle
            42319, -- Azsuna
            42541, -- Highmountain
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Remix: Mists of Pandaria
    local ACMList_RemixMistsOfPandaria = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15536)) -- "Remix: Mists of Pandaria"
        :Ids{
            19877, -- Townlong Steppes,
            20003, -- Timeless Isle
        }

    -- Remix: Legion
    local ACMList_RemixLegion = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15562)) -- "Legion Remix"
        :Ids{
            42319, -- Azsuna
            42541, -- Highmountain
        }

    local ACMList = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(81) .. " & " .. Utilities:GetAchievementCategoryNameByCategoryID(15176)) -- Feats of Strength & Legacy
        :Insert(ACMList_RemixMistsOfPandaria)
        :Insert(ACMList_RemixLegion)
        :Ids{
            8820, -- WoW's 10th Anniversaryv
        }

    return ACMList
end
