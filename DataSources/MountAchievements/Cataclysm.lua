local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCataMountAchievements()

    -- Child Achievements Cataclysm Dungeon Hero
    local ACMChilds_CataclysmDungeonHero = {
        Utilities:GetAchievementName(4844),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            5060, -- Heroic: Blackrock Caverns
            5061, -- Heroic: Throne of the Tides
            5063, -- Heroic: The Stonecore
            5064, -- Heroic: The Vortex Pinnacle
            5062, -- Heroic: Grim Batol
            5065, -- Heroic: Halls of Origination
            5066, -- Heroic: Lost City of the Tol'vir
            5083, -- Heroic: Deadmines
            5093 -- Heroic: Shadowfang Keep
        }
    }

    -- Child Achievements Glory of the Cataclysm Hero
    local ACMChilds_GloryOfTheCataclysmHero = {
        Utilities:GetAchievementName(4845),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMChilds_CataclysmDungeonHero,
        {
            4844, -- Cataclysm Dungeon Hero
            5281, -- Crushing Bones and Cracking Skulls
            5282, -- Arrested Development
            5283, -- Too Hot to Handle
            5284, -- Ascendant Descending
            5287, -- Rotten to the Core
            5288, -- No Static at All
            5289, -- Extra Credit Bonus Stage
            5290, -- Kill It With Fire!
            5291, -- Acrocalypse Now
            5292, -- Headed South
            5293, -- I Hate That Song
            5294, -- Straw That Broke the Camel's Back
            5295, -- Sun of a....
            5296, -- Faster Than the Speed of Light
            5366, -- Ready for Raiding
            5367, -- Rat Pack
            5368, -- Prototype Prodigy
            5369, -- It's Frost Damage
            5370, -- I'm on a Diet
            5371, -- Vigorous VanCleef Vvindicator
            5503, -- Pardon Denied
            5504, -- To the Ground!
            5505, -- Bullet Time
            5298 -- Don't Need to Break Eggs to Make an Omelet
        }
    }

    -- Child Achievements Glory of the Cataclysm Raider
    local ACMChilds_GloryOfTheCataclysmRaider = {
        Utilities:GetAchievementName(4853),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            5094, -- Heroic: Magmaw
            5107, -- Heroic: Omnotron Defense System
            5108, -- Heroic: Maloriak
            5109, -- Heroic: Atramedes
            5115, -- Heroic: Chimaeron
            5116, -- Heroic: Nefarian
            5118, -- Heroic: Halfus Wyrmbreaker
            5117, -- Heroic: Valiona and Theralion
            5119, -- Heroic: Ascendant Council
            5120, -- Heroic: Cho'gall
            5122, -- Heroic: Conclave of Wind
            5123, -- Heroic: Al'Akir
            5306, -- Parasite Evening
            5307, -- Achieve-a-tron
            5308, -- Silence is Golden
            5309, -- Full of Sound and Fury
            5310, -- Aberrant Behavior
            5849, -- Keeping it in the Family
            5300, -- The Only Escape
            4852, -- Double Dragon
            5311, -- Elementary
            5312, -- The Abyss Will Gaze Back Into You
            5304, -- Stay Chill
            5305 -- Four Play
        }
    }

    -- Child Achievements Glory of the Firelands Raider
    local ACMChilds_GloryOfTheFirelandsRaider = {
        Utilities:GetAchievementName(5828),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            5807, -- Heroic: Beth'tilac
            5808, -- Heroic: Lord Rhyolith
            5806, -- Heroic: Shannox
            5809, -- Heroic: Alysrazor
            5805, -- Heroic: Baleroc
            5804, -- Heroic: Majordomo Fandral Staghelm
            5821, -- Death from Above
            5810, -- Not an Ambi-Turner
            5813, -- Do a Berrel Roll!
            5829, -- Bucket List
            5830, -- Share the Pain
            5799 -- Only the Penitent...
        }
    }

    -- Child Achievements Glory of the Dragon Soul Raider
    local ACMChilds_GloryOfTheDragonSoulRaider = {
        Utilities:GetAchievementName(6169),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            6109, -- Heroic: Morchok
            6110, -- Heroic: Warlord Zon'ozz
            6111, -- Heroic: Yor'sahj the Unsleeping
            6112, -- Heroic: Hagara the Stormbinder
            6113, -- Heroic: Ultraxion
            6114, -- Heroic: Warmaster Blackhorn
            6174, -- Don't Stand So Close to Me
            6129, -- Taste the Rainbow!
            6128, -- Ping Pong Champion
            6084, -- Minutes to Midnight
            6105, -- Deck Defender
            6133, -- Maybe He'll Get Dizzy...
            6180 -- Chromatic Champion
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME3, -- Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheCataclysmHero
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheCataclysmRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheFirelandsRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheDragonSoulRaider
    end

    ACMListFlat[#ACMListFlat+1] = {
        5866, -- The Molten Front Offensive
        42300, -- Two Minutes to Midnight
        5866, -- The Molten Front Offensive
        4845, -- Glory of the Cataclysm Hero
        4853, -- Glory of the Cataclysm Raider
        5828, -- Glory of the Firelands Raider
        6169 -- Glory of the Dragon Soul Raider
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones_MountHyjalTwilightHighlandsMoltenFront = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        -- Mount Hyjal
        {
            Utilities:GetZoneNameByMapID(198), -- Mount Hyjal
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                5866 -- The Molten Front Offensive
            }
        },
        -- Twilight Highlands
        {
            Utilities:GetZoneNameByMapID(241), -- Twilight Highlands
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                42300 -- Two Minutes to Mitnight
            }
        },
        -- Molten Front
        {
            Utilities:GetZoneNameByMapID(338), -- Molten Front
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                5866 -- The Molten Front Offensive
            }
        }
    }

    -- Dungeons
    local ACMList_Dungeons = {
        Utilities:GetAchievementCategoryNameByCategoryID(15272), -- Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_GloryOfTheCataclysmHero
    end

    ACMList_Dungeons[#ACMList_Dungeons+1] = {
        4845 -- Glory of the Cataclysm Hero
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
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheCataclysmRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheFirelandsRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheDragonSoulRaider
    end

    ACMList_Raids[#ACMList_Raids+1] = {
        4853, -- Glory of the Cataclysm Raider
        5828, -- Glory of the Firelands Raider
        6169 -- Glory of the Dragon Soul Raider
    }

    local ACMList = {
        _G.EXPANSION_NAME3, -- Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_MountHyjalTwilightHighlandsMoltenFront,
        ACMList_Dungeons,
        ACMList_Raids
    }

    return ACMList
end