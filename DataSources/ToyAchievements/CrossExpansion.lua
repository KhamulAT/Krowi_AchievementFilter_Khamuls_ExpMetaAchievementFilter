local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCrossExpansionToyAchievements()

    -- Child Achievements The Toymaster
    local ACMChilds_TheToymaster = {
        Utilities:GetAchievementName(9673),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9670, -- Toying Around
            9671, -- Having a Ball
            6340, -- Tons of Toys
            9673, -- The Toymaster
        }
    }


    -- Child Achievements The Joy of Toy
    local ACMChilds_TheJoyOfToy = {
        Utilities:GetAchievementName(15781),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9670, -- Toying Around
            9671, -- Having a Ball
            6340, -- Tons of Toys
            9673, -- The Toymaster
            10354, -- Crashin' Trashin' Commander
            11176, -- Remember to Share
            12996, -- Toybox Tycoon
            15781, -- The Joy of Toy
        }
    }

    -- Child Achievements The Shadows Revealed
    local ACMChilds_TheShadowsRevealed = {
        Utilities:GetAchievementName(14021),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            11765, -- Pet Battle Challenge: Wailing Caverns
            11856, -- Pet Battle Challenge: Deadmines
            13269, -- Pet Battle Challenge: Gnomeregan
            13627, -- Pet Battle Challenge: Stratholme
            14020, -- Pet Battle Challenge: Blackrock Depths
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TheToymaster
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TheJoyOfToy
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TheShadowsRevealed
    end

    ACMListFlat[#ACMListFlat+1] = {
        13502, -- Secret Fish and Where to Find Them
        17207, -- Discomobberlated
        9673, -- The Toymaster
        15781, -- The Joy of Toy
        14021, -- The Shadows Revealed
        20033, -- Hearthstone Beginner
        9394, -- They Really Love Me!
        9885, -- Ace Tonk Commander
        9894, -- Triumphant Turtle Tossing
        9761, -- Darkmoon Racer Roadhog
        9764, -- Rocketeer: Gold
        9792, -- Wanderluster: Gold
        9785, -- Powermonger: Gold
        9799, -- Big Race Roadhog
        9805, -- Big Rocketeer: Gold
        9811, -- Big Wanderluster: Gold
        9817, -- Big Powermonger: Gold
        15221, -- Dancing Machine
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Professions -> Fishing
    local ACMList_Professions_Fishing = {
        _G.TRADE_SKILLS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            _G.PROFESSIONS_FISHING,
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13502, -- Secret Fish and Where to Find Them
                17207, -- Discomobberlated
            }
        }
    }

    -- Collections
    local ACMList_Collections = {
        Utilities:GetAchievementCategoryNameByCategoryID(15246), -- Collections
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9673, -- The Toymaster
            15781, -- The Joy of Toy
        }
    }

    -- PetBattles
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_TheShadowsRevealed
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        14021, -- The Shadows Revealed
    }

    -- World Events
    local ACMList_WorldEvents = {
        Utilities:GetAchievementCategoryNameByCategoryID(155), -- World Events
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetAchievementCategoryNameByCategoryID(15101), -- Darkmoon Faire
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                9885, -- Ace Tonk Commander
                9894, -- Triumphant Turtle Tossing
                9761, -- Darkmoon Racer Roadhog
                9764, -- Rocketeer: Gold
                9792, -- Wanderluster: Gold
                9785, -- Powermonger: Gold
                9799, -- Big Race Roadhog
                9805, -- Big Rocketeer: Gold
                9811, -- Big Wanderluster: Gold
                9817, -- Big Powermonger: Gold
                15221, -- Dancing Machine
            }
        },
        {
            9394, -- They Really Love Me! (Love is in the Air)
        }
    }

    -- Hearthstone
    local ACMList_Hearthstone = {
        L["Hearthstone"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            20033, -- Hearthstone Beginner
        }
    }

    local ACMList = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Professions_Fishing,
        ACMList_Collections,
        ACMList_PetBattles,
        ACMList_WorldEvents,
        ACMList_Hearthstone
    }

    return ACMList
end