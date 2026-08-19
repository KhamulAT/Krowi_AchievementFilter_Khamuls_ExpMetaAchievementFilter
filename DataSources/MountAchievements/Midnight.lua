local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMidnightMountAchievements()

    -- Child Achievements Midnight Glyph Hunter
    local ACMChilds_MidnightGlyphHunter = {
        Utilities:GetAchievementName(61584),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61576, -- Eversong Woods Glyph Hunter
            61581, -- Zul'Aman Glyph Hunter
            61582, -- Harandar Glyph Hunter
            61583, -- Voidstorm Glyph Hunter
        }
    }

    -- Child Achievements Glory of the Midnight Delver
    local ACMChilds_GloryOfTheMidnightDelver = {
        Utilities:GetAchievementName(61906),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61741, -- Delve Loremaster: Midnight
            61901, -- Midnight: Leave No Treasure Unfounnd
            61723, -- Curio Fanatic: Midnight
            61797, -- My Shady Nemesis
        }
    }

    -- Child Achievements Glory of the Midnight Raider
    local ACMChilds_GloryOfTheMidnightRaider = {
        Utilities:GetAchievementName(61380),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            62352, -- Nothing to see Here
            62106, -- The Only Winning Move Is Not To Play
            62058, -- Hungry Hungry Hatchlings
            61514, -- It's Treason Then
            61911, -- Ready, Set, Snap!
            61936, -- Aura Farming
            61346, -- We Will, In Fact, See It Again
            61454, -- Falling Between The Quacks
            61381, -- Eggsistential Crisis,
            62406 -- All the Things She Said
        }
    }

    -- Child Achievements Glory of the Venomous Raider
    local ACMChilds_GloryOfTheVenomousRaider = {
        Utilities:GetAchievementName(63254),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            63418, -- Well, Well, Little Sky
            63250, -- Is Venom Stasis A Joke To You?
            63645, -- Accidental Inclusion
            63397, -- Kept You Waiting Huh?
            63391, -- Jumping Through Hoops
            63656, -- Taking a Bite out of Slime
            63669, -- Watch Out Behind You
            63609, -- No Egg Scramble
        }
    }

    -- Child Achievements Void Response Team
    local ACMChilds_VoidResponseTeam = {
        Utilities:GetAchievementName(62563),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            62498, -- Void Assault: Eversong
            62499, -- Void Assault: Zul'Aman
            62508, -- Void Eradicator: Eversong
            62511, -- Void Eradicator: Zul'Aman
            62513, -- Outstanding in the Field
            62518, -- Cosmic Exterminator
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_MidnightGlyphHunter
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheMidnightDelver
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheMidnightRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheVenomousRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_VoidResponseTeam
    end

    ACMListFlat[#ACMListFlat+1] = {
        61584, -- Midnight Glyph Hunter
        62190, -- Life of the Party
        61263, -- Treasures of Harandar
        62385, -- Staring Into The Void
        61906, -- Glory of the Midnight Delver
        61380, -- Glory of the Midnight Raider
        42703, -- Prey: Nightmare Mode III
        62563, -- Void Response Team
        63359, -- Treasures of the Coiled Isle
        63630, -- Assault the Vault
        63653, -- Pro Poison Patroller
        63254, -- Glory of the Venomous Raider
        62386, -- Light Up the Night
        62873, -- A Trip Around the Stars
        62874, -- A Trip Through the Stars
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Quel'Thalas
    local ACMList_Zones_QuelThalas = {
        Utilities:GetZoneNameByMapID(2561), -- Quel'Thalas
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Zones_QuelThalas[#ACMList_Zones_QuelThalas+1] = ACMChilds_MidnightGlyphHunter
    end

    ACMList_Zones_QuelThalas[#ACMList_Zones_QuelThalas+1] = {
        61584, -- Midnight Glyph Hunter
    }

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_QuelThalas,
        {
            Utilities:GetZoneNameByMapID(2395), -- Eversong Woods
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                62190, -- Life of the Party
            }
        },
        {
            Utilities:GetZoneNameByMapID(2413), -- Harandar
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                61263, -- Treasures of Harandar
            }
        },
        {
            Utilities:GetZoneNameByMapID(2405), -- Voidstorm
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                62385, -- Staring Into The void
            }
        },
        {
            Utilities:GetZoneNameByMapID(2512), -- The Coiled Isle
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                63359, -- Treasures of the Coiled Isle
            }
        },
        {
            Utilities:GetZoneNameByMapID(2509), -- Vaults of Atal'Utek
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                63630, -- Assault the Vault
                63653, -- Pro Poison Patroller
            }
        },
        {
            62386, -- Light Up the Night
        }
    }

    -- Delves
    local ACMList_Delves = {
        _G.DELVES_LABEL, -- Delves
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Delves[#ACMList_Delves+1] = ACMChilds_GloryOfTheMidnightDelver
    end

    ACMList_Delves[#ACMList_Delves+1] = {
        61906, -- Glory of the Midnight Delver
    }

    ACMList_Delves[#ACMList_Delves+1] = {
        Utilities:GetDungeonNameByLFGDungeonID(3071), -- Torment's Rise
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61799, -- Let Me Solo Him: Nullaeus
        }
    }

    -- Raids
    local ACMList_Raids = {
        Utilities:GetAchievementCategoryNameByCategoryID(15271), -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheMidnightRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheVenomousRaider
    end

    ACMList_Raids[#ACMList_Raids+1] = {
        61380, -- Glory of the Midnight Raider
        63254, -- Glory of the Venomous Raider
    }

    -- Prey
    local ACMList_Prey = {
        Utilities:GetAchievementCategoryNameByCategoryID(15605),  -- Prey
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            L["Nightmare"],
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                42703, -- Prey: Nightmare Mode III
            }
        }
    }

    -- Void Assaults
    local ACMList_VoidAssaults = {
        Utilities:GetAchievementCategoryNameByCategoryID(15610),  -- Void Assaults
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_VoidAssaults[#ACMList_VoidAssaults+1] = ACMChilds_VoidResponseTeam
    end

    ACMList_VoidAssaults[#ACMList_VoidAssaults+1] = {
        62563, -- Void Response Team
        62873, -- A Trip Around the Stars
        62874, -- A Trip Through the Stars
    }

    local ACMList = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Delves,
        ACMList_Raids,
        ACMList_Prey,
        ACMList_VoidAssaults
    }

    return ACMList
end