local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMythicPlusMountAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.PLAYER_DIFFICULTY_MYTHIC_PLUS, -- Mythic+
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14145, -- Battle for Azeroth Keystone Master: Seson Four
            14532, -- Shadowlands Keystone Master: Season One
            15078, -- Shadowlands Keystone Master: Season Two
            15499, -- Shadowlands Keystone Master: Season Three
            15690, -- Shadowlands Keystone Master: Season Four
            16649, -- Dragonflight Keystone Master: Season One
            17844, -- Dragonflight Keystone Master: Season Two
            19011, -- Dragonflight Keystone Master: Season Three
            19782, -- Dragonflight Keystone Master: Season Four
            20525, -- The War Within Keystone Master: Season One
            41533, -- The War Within Keystone Master: Season Two
            40951, -- The War Within Keystone Legend: Season One
            41973, -- The War Within Keystone Master: Season Three
            42172, -- The War Within Keystone Legend: Season Three
            61256, -- Midnight Keystone Master: Season One
            61258, -- Midnight Keystone Legend: Season One
            63097, -- Midnight Keystone Myth: Season One
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end


    -- Battle for Azeroth
    local ACMList_BattleForAzeroth = {
        _G.EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14145, -- Battle for Azeroth Keystone Master: Seson Four
        }
    }

    -- Shadowlands
    local ACMList_Shadowlands = {
        _G.EXPANSION_NAME8, -- Shadowlands
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14532, -- Shadowlands Keystone Master: Season One
            15078, -- Shadowlands Keystone Master: Season Two
            15499, -- Shadowlands Keystone Master: Season Three
            15690, -- Shadowlands Keystone Master: Season Four
        }
    }

    -- Dragonflight
    local ACMList_Dragonflight = {
        _G.EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            16649, -- Dragonflight Keystone Master: Season One
            17844, -- Dragonflight Keystone Master: Season Two
            19011, -- Dragonflight Keystone Master: Season Three
            19782, -- Dragonflight Keystone Master: Season Four
        }
    }

    -- The War Within
    local ACMList_TheWarWithin = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            20525, -- The War Within Keystone Master: Season One
            41533, -- The War Within Keystone Master: Season Two
            40951, -- The War Within Keystone Legend: Season One
            41973, -- The War Within Keystone Master: Season Three
            42172, -- The War Within Keystone Legend: Season Three
        }
    }

    -- Midnight
    local ACMList_Midnight = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61256, -- Midnight Keystone Master: Season One
            61258, -- Midnight Keystone Legend: Season One
            63097, -- Midnight Keystone Myth: Season One
        }
    }

    local ACMList = {
        _G.PLAYER_DIFFICULTY_MYTHIC_PLUS, -- Mythic+
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_BattleForAzeroth,
        ACMList_Shadowlands,
        ACMList_Dragonflight,
        ACMList_TheWarWithin,
        ACMList_Midnight
    }

    return ACMList
end