local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetWoDPetAchievements()

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME5) -- Warlords of Draenor
        :Ids{
            9685, -- Draenor Safari
            9069, -- An Awfully Big Adventure
        }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Pet Battle Dungeons
    local ACMList_PetBattleDungeons = KAF_Cat(_G.BATTLE_PET_SOURCE_5 .. " " .. _G.DUNGEONS) -- Pet Battle Dungeons
        :Ids{
            9685, -- Draenor Safari
            9069, -- An Awfully Big Adventure
        }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME5) -- Warlords of Draenor
        :Insert(ACMList_PetBattleDungeons)

    return ACMList
end
