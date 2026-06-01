local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetWoDMountAchievements()

    local factionSpecificAchievements = {
        { -- Alliance
            9833, -- Loremaster of Draenor
            9564, -- Securing Draenor
            10350 -- Tanaan Diplomat
        },
        { -- Horde
            9923, -- Loremaster of Draenor
            9562, -- Securing Draenor
            10349 -- Tanaann Diplomat
        }
    }

    -- Child Achievements Draenor Dungeon Hero
    local ACMChilds_DraeonorDungeonHero = {
        Utilities:GetAchievementName(9391),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9046, -- Heroic: Blooodmaul Slag Mines
            9047, -- Heroic: Iron Docks
            9049, -- Heroic: Auchindoun
            8844, -- Heroic: Skyreach
            9053, -- Heroic: The Everbloom
            9052, -- Heroic: Grimrail Depot
            9054, -- Heroic: Shadowmoon Burial Grounds
            9055 -- Heroic: Upper Blackrock Spire
        }
    }

    -- Child Achievements Glory of the Draenor Hero
    local ACMChilds_GloryOfTheDraenorHero = {
        Utilities:GetAchievementName(9396),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMChilds_DraeonorDungeonHero,
        {
            9391, -- Draenor Dungeon Hero
            8993, -- A Gift of Earth and Fire
            9005, -- Come With Me If You Want to Live
            9008, -- Is Draenor on Fire?
            9083, -- Militaristic, Expannsionist
            9081, -- Expert Timing
            9082, -- Take Cover!
            9023, -- ...They All Fall Down
            9024, -- This Is Why We Can't Have Nice Thinngs
            9007, -- No Ticket
            9017, -- Water Management
            9223, -- Weed Whacker
            9018, -- Whats Your Sign?
            9025, -- Icky Ichors
            9026, -- Souls of the Lost
            9045, -- Magnnets, How Do they Work?
            9058, -- Leeeeeeeeeeeeeroy...?
            9056, -- Bridge Over Troubled Fire
            9057 -- Dragonmaw? More Like Dragonfall!
        }
    }

    -- Child Achievements Glory of the Draenor Raider
    local ACMChilds_GloryOfTheDraenorRaider = {
        Utilities:GetAchievementName(8985),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            8948, -- Flame On!
            8647, -- Hurry Up, Maggot!
            8974, -- More Like Wrecked-us
            8975, -- A Fungus Among Us
            8858, -- Brother in Arms
            8976, -- Pair Annihilation
            8977, -- Lineage of Power
            8978, -- The Iron Price
            8979, -- He Shoots, He Ores
            8980, -- Stamp Stamp Revolution
            8981, -- Fain Would Lie Down
            8929, -- The Steel Has Been Brought
            8982, -- There's Always a Bigger Train
            8930, -- Ya, We've Got Time
            8983, -- Would You Give Me a Hand?
            8984, -- Be Quick or Be Dead
            8952 -- Ashes, Ashes
        }
    }

    -- Child Achievements Glory of the Hellfire Raider
    local ACMChilds_GloryOfTheHellfireRaider = {
        Utilities:GetAchievementName(10149),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            10026, -- Nearly Indestructible
            10057, -- Turning the Tide
            10013, -- Waves Came Crashing Down All Around
            10054, -- Don't Fear the Reaper
            9972, -- A Race Against Slime
            9979, -- Get In My Belly!
            9988, -- Pro Toss
            10086, -- I'm a Soul Man
            10012, -- This Land Was Green and Good Until...
            10087, -- You Gotta Keep 'em Separated
            9989, -- Non-Lethal Enforcer
            10030, -- Bad Manner(oth)
            10073 -- Echoes of Doomfire
        }
    }

    -- Child Achievements Draenor Pathfinder
    local ACMChilds_DraenorPathfinder = {
        Utilities:GetAchievementName(10018),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetAchievementName(8935), -- Draenor Explorer
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                8937, -- Explore Frostfire Ridge
                8938, -- Expore Shadowmoon Valley
                8939, -- Explore Gorgrond
                8940, -- Explore Talador
                8941, -- Explore Spires of Arak
                8942 -- Explore Nagrand
            }
        },
        {
            Utilities:GetAchievementName(9833), -- Loremaster of Draenor
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                8845, -- As I Walk Through the Valley of the Shadow of Moon
                8923, -- Putting the Gore inn Gorgrond
                8920, -- Don't Let the Tala-door Hit You on the Way Out
                8925, -- Between Arak and a Hard Place
                8927 -- Nagrandeur
            }
        },
        {
            Utilities:GetAchievementName(10348), -- Master Treasure Hunter
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                9726, -- Treasure Hunter
                9727 -- Expert Treasure Hunter
            }
        },
        {
            8935, -- Draenor Explorer
            Utilities:AchievementShowDecider(9833, 9923, factionSpecificAchievements), -- Loremaster of Draenor
            Utilities:AchievementShowDecider(9564, 9562, factionSpecificAchievements), -- Securing Draenor
            10348, -- Master Dreasure Hunter
            Utilities:AchievementShowDecider(10350, 10349, factionSpecificAchievements) -- Tanaan Diplomat
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME5, -- Warlords of Draenor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_DraenorPathfinder
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheDraenorHero
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheDraenorRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheHellfireRaider
    end

    ACMListFlat[#ACMListFlat+1] = {
        10018, -- Draenor Pathfinder
        9396, -- Glory of the Draenor Hero
        8898, -- Challenge Warlord: Silver
        8985, -- Glory of the Draenor Raider
        10149 -- Glory of the Hellfire Raider
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Zones[#ACMList_Zones+1] = ACMChilds_DraenorPathfinder
    end

    ACMList_Zones[#ACMList_Zones+1] = {
        10018 -- Draenor Pathfinder
    }

    -- Dungeons
    local ACMList_Dungeons = {
        _G.DUNGEONS, -- Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_GloryOfTheDraenorHero
    end

    ACMList_Dungeons[#ACMList_Dungeons+1] = {
        9396, -- Glory of the Draenor Hero
        8898, -- Challenge Warlord: Silver
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
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheDraenorRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheHellfireRaider
    end

    ACMList_Raids[#ACMList_Raids+1] = {
        8985, -- Glory of the Draenor Raider
        10149 -- Glory of the Hellfire Raider
    }


    local ACMList = {
        _G.EXPANSION_NAME5, -- Warlords of Draenor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Dungeons,
        ACMList_Raids
    }

    return ACMList
end