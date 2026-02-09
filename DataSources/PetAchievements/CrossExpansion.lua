local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCrossExpansionPetAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            4478, -- Looking for Multitudes
            7934, -- Raiding with Leashes
            17736, -- The Gift of Cheese
            7521, -- Time to Open a Pet Store
            1250, -- Shop Smart, Shop Pet...Smart
            2516, -- Lil' Game Hunter
            5876, -- Petting Zoo
            5877, -- Menagerie
            5875, -- Littlest Pet Shop
            7500, -- Going to Need More Leashes
            7501, -- That's a Lot of Pet Food
            9643, -- So. Many. Pets.
            12992, -- Pet Emporium
            12958, -- Master of Minions
            15641, -- Many More Mini Minions
            15642, -- Proven Pet Parent
            15643, -- What Can I Say? They Love Me.
            15644, -- Good Things Come in Small Packages
            6556, -- Going to Need More Traps
            8300, -- Brutal Pet Brawler
            6582, -- Pro Pet Mob
            12996, -- Toybox Tycoon,
            9983, -- That's Wwhack!
            18644, -- Community Rumor Mill
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons & Raids
    local ACMList_DungeonsAndRaids = {
        _G.DUNGEONS .. " & " .. _G.RAIDS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            4478, -- Looking for Multitudes
            7934, -- Raiding with Leashes
        }
    }

    -- Professions -> Cooking
    local ACMList_Professions_Cooking = {
        _G.TRADE_SKILLS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            _G.PROFESSIONS_COOKING,
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                17736 -- The Gift of Cheese
            }
        }
    }

    -- PetBattles -> Collect, Battle, Level
    local ACMList_PetBattles_CollectBattleLevel = {
        _G.SHOW_PET_BATTLES_ON_MAP_TEXT,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            _G.WEEKLY_REWARDS_GET_CONCESSION, -- Collect
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                7521, -- Time to Open a Pet Store
                1250, -- Shop Smart, Shop Pet...Smart
                2516, -- Lil' Game Hunter
                5876, -- Petting Zoo
                5877, -- Menagerie
                5875, -- Littlest Pet Shop
                7500, -- Going to Need More Leashes
                7501, -- That's a Lot of Pet Food
                9643, -- So. Many. Pets.
                12992, -- Pet Emporium
                12958, -- Master of Minions
                15641, -- Many More Mini Minions
                15642, -- Proven Pet Parent
                15643, -- What Can I Say? They Love Me.
                15644, -- Good Things Come in Small Packages
                6556, -- Going to Need More Traps
            }
        },
        {
            _G.ARENA_RATED, -- Battle
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                8300 -- Brutal Pet Brawler
            }
        },
        {
            _G.LEVEL, -- Level
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                6582
            }
        }
    }

    -- Collections
    ACMList_Collections = {
        _G.AUCTION_HOUSE_FILTER_CATEGORY_COLLECTIONS, -- Collections
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12996 -- Toybox Tycoon
        }
    }


    -- Darkmoon Faire
    ACMList_DarkmoonFaire = {
        Utilities:GetAchievementCategoryNameNyCategoryID(15101),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9983, -- That's Whack!
        }
    }

    -- Zones
    ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            18644, -- Community Rumor Mill
        }
    }

    local ACMList = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Collections,
        ACMList_DarkmoonFaire,
        ACMList_DungeonsAndRaids,
        ACMList_PetBattles_CollectBattleLevel,
        ACMList_Professions_Cooking,
        ACMList_Zones,
    }

    return ACMList
end