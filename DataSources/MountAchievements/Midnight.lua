local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMidnightMountAchievements()

    -- Child Achievements Midnight Glyph Hunter
    local ACMChilds_MidnightGlyphHunter = KAF_Cat(Utilities:GetAchievementName(61584))
        :Ids{
            61576, -- Eversong Woods Glyph Hunter
            61581, -- Zul'Aman Glyph Hunter
            61582, -- Harandar Glyph Hunter
            61583, -- Voidstorm Glyph Hunter
        }

    -- Child Achievements Glory of the Midnight Delver
    local ACMChilds_GloryOfTheMidnightDelver = KAF_Cat(Utilities:GetAchievementName(61906))
        :Ids{
            61741, -- Delve Loremaster: Midnight
            61901, -- Midnight: Leave No Treasure Unfounnd
            61723, -- Curio Fanatic: Midnight
            61797, -- My Shady Nemesis
        }

    -- Child Achievements Glory of the Midnight Raider
    local ACMChilds_GloryOfTheMidnightRaider = KAF_Cat(Utilities:GetAchievementName(61380))
        :Ids{
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

    -- Child Achievements Glory of the Venomous Raider
    local ACMChilds_GloryOfTheVenomousRaider = KAF_Cat(Utilities:GetAchievementName(63254))
        :Ids{
            63418, -- Well, Well, Little Sky
            63250, -- Is Venom Stasis A Joke To You?
            63645, -- Accidental Inclusion
            63397, -- Kept You Waiting Huh?
            63391, -- Jumping Through Hoops
            63656, -- Taking a Bite out of Slime
            63669, -- Watch Out Behind You
            63609, -- No Egg Scramble
        }

    -- Child Achievements Void Response Team
    local ACMChilds_VoidResponseTeam = KAF_Cat(Utilities:GetAchievementName(62563))
        :Ids{
            62498, -- Void Assault: Eversong
            62499, -- Void Assault: Zul'Aman
            62508, -- Void Eradicator: Eversong
            62511, -- Void Eradicator: Zul'Aman
            62513, -- Outstanding in the Field
            62518, -- Cosmic Exterminator
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_MidnightGlyphHunter)
        ACMListFlat:Insert(ACMChilds_GloryOfTheMidnightDelver)
        ACMListFlat:Insert(ACMChilds_GloryOfTheMidnightRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheVenomousRaider)
        ACMListFlat:Insert(ACMChilds_VoidResponseTeam)
    end

    ACMListFlat:Ids{
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
    local ACMList_Zones_QuelThalas = KAF_Cat(Utilities:GetZoneNameByMapID(2561)) -- Quel'Thalas

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Zones_QuelThalas:Insert(ACMChilds_MidnightGlyphHunter)
    end

    ACMList_Zones_QuelThalas:Ids{
        61584, -- Midnight Glyph Hunter
    }

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone
        :Insert(ACMList_Zones_QuelThalas)

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2395)) -- Eversong Woods
        :Ids{
            62190, -- Life of the Party
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2413)) -- Harandar
        :Ids{
            61263, -- Treasures of Harandar
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2405)) -- Voidstorm
        :Ids{
            62385, -- Staring Into The void
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2512)) -- The Coiled Isle
        :Ids{
            63359, -- Treasures of the Coiled Isle
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2509)) -- Vaults of Atal'Utek
        :Ids{
            63630, -- Assault the Vault
            63653, -- Pro Poison Patroller
        }

    ACMList_Zones:Ids{
        62386, -- Light Up the Night
    }

    -- Delves
    local ACMList_Delves = KAF_Cat(_G.DELVES_LABEL) -- Delves

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Delves:Insert(ACMChilds_GloryOfTheMidnightDelver)
    end

    ACMList_Delves:Ids{
        61906, -- Glory of the Midnight Delver
    }

    KAF_Sub(ACMList_Delves, Utilities:GetDungeonNameByLFGDungeonID(3071)) -- Torment's Rise
        :Ids{
            61799, -- Let Me Solo Him: Nullaeus
        }

    -- Raids
    local ACMList_Raids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15271)) -- Raids

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Raids:Insert(ACMChilds_GloryOfTheMidnightRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheVenomousRaider)
    end

    ACMList_Raids:Ids{
        61380, -- Glory of the Midnight Raider
        63254, -- Glory of the Venomous Raider
    }

    -- Prey
    local ACMList_Prey = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15605)) -- Prey

    KAF_Sub(ACMList_Prey, L["Nightmare"])
        :Ids{
            42703, -- Prey: Nightmare Mode III
        }

    -- Void Assaults
    local ACMList_VoidAssaults = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15610)) -- Void Assaults

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_VoidAssaults:Insert(ACMChilds_VoidResponseTeam)
    end

    ACMList_VoidAssaults:Ids{
        62563, -- Void Response Team
        62873, -- A Trip Around the Stars
        62874, -- A Trip Through the Stars
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight
        :Insert(ACMList_Zones)
        :Insert(ACMList_Delves)
        :Insert(ACMList_Raids)
        :Insert(ACMList_Prey)
        :Insert(ACMList_VoidAssaults)

    return ACMList
end
