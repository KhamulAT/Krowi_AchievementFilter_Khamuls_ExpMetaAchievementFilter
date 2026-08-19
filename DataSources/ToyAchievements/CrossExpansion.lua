local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCrossExpansionToyAchievements()

    -- Child Achievements The Toymaster
    local ACMChilds_TheToymaster = KAF_Cat(Utilities:GetAchievementName(9673))
        :Ids{
            9670, -- Toying Around
            9671, -- Having a Ball
            6340, -- Tons of Toys
            9673, -- The Toymaster
        }

    -- Child Achievements The Joy of Toy
    local ACMChilds_TheJoyOfToy = KAF_Cat(Utilities:GetAchievementName(15781))
        :Ids{
            9670, -- Toying Around
            9671, -- Having a Ball
            6340, -- Tons of Toys
            9673, -- The Toymaster
            10354, -- Crashin' Trashin' Commander
            11176, -- Remember to Share
            12996, -- Toybox Tycoon
            15781, -- The Joy of Toy
        }

    -- Child Achievements The Shadows Revealed
    local ACMChilds_TheShadowsRevealed = KAF_Cat(Utilities:GetAchievementName(14021))
        :Ids{
            11765, -- Pet Battle Challenge: Wailing Caverns
            11856, -- Pet Battle Challenge: Deadmines
            13269, -- Pet Battle Challenge: Gnomeregan
            13627, -- Pet Battle Challenge: Stratholme
            14020, -- Pet Battle Challenge: Blackrock Depths
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(L["Cross-Expansion"])

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_TheToymaster)
        ACMListFlat:Insert(ACMChilds_TheJoyOfToy)
        ACMListFlat:Insert(ACMChilds_TheShadowsRevealed)
    end

    ACMListFlat:Ids{
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
    local ACMList_Professions_Fishing = KAF_Cat(_G.TRADE_SKILLS)

    KAF_Sub(ACMList_Professions_Fishing, _G.PROFESSIONS_FISHING)
        :Ids{
            13502, -- Secret Fish and Where to Find Them
            17207, -- Discomobberlated
        }

    -- Collections
    local ACMList_Collections = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15246)) -- Collections
        :Ids{
            9673, -- The Toymaster
            15781, -- The Joy of Toy
        }

    -- PetBattles
    local ACMList_PetBattles = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15219)) -- Pet Battles

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles:Insert(ACMChilds_TheShadowsRevealed)
    end

    ACMList_PetBattles:Ids{
        14021, -- The Shadows Revealed
    }

    -- World Events
    local ACMList_WorldEvents = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(155)) -- World Events

    KAF_Sub(ACMList_WorldEvents, Utilities:GetAchievementCategoryNameByCategoryID(15101)) -- Darkmoon Faire
        :Ids{
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

    ACMList_WorldEvents:Ids{
        9394, -- They Really Love Me! (Love is in the Air)
    }

    -- Hearthstone
    local ACMList_Hearthstone = KAF_Cat(L["Hearthstone"])
        :Ids{
            20033, -- Hearthstone Beginner
        }

    local ACMList = KAF_Cat(L["Cross-Expansion"])
        :Insert(ACMList_Professions_Fishing)
        :Insert(ACMList_Collections)
        :Insert(ACMList_PetBattles)
        :Insert(ACMList_WorldEvents)
        :Insert(ACMList_Hearthstone)

    return ACMList
end
