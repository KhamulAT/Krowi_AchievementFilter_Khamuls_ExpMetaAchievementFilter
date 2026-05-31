local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetLegionMountAchievements()

    -- Child Achievements ..And Chew Mana Buns
    local ACMChilds_AndChewManaBuns = {
        Utilities:GetAchievementName(12103),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12101, -- We Came Here For Two Reasons
            12102, -- To Kill Demons...
        }
    }

    -- Child Achievements Glory of the Legion Hero
    local ACMChilds_GloryOfTheLegionHero = {
        Utilities:GetAchievementName(11163),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            10456, -- But You Say He's Just a Friend
            10457, -- Stay Salty
            10458, -- Ready for Raiding V
            10766, -- Egg-cellent!
            10769, -- Burning Down the House
            10996, -- Got to Ketchum All
            10875, -- Can't Eat Just One
            10544, -- Stag Party
            10542, -- I Got What You Mead
            10543, -- Surge Protector
            10554, -- I Made a Fool
            10553, -- You're Just Making It WORSE!
            10680, -- Who's Afraid of the Dark?
            10707, -- A Specter, Illuminated
            10709, -- You Used to Scrawl Me In Your Fel Tome
            10710, -- Black Rook Moan
            10711, -- Adds? More Like Bads
            10413, -- Instant Karma
            10411, -- Helheim Hath No Fury
            10412, -- Poor Unfortunate Souls
            10776, -- No Time to Waste
            10775, -- Clean House
            10773, -- Arcanic Cling
            10610, -- Waiting for Gerdo
            10611 -- Dropping Some Eaves
        }
    }

    -- Child Achievements Glory of the Legion Raider
    local ACMChilds_GloryOfTheLegionRaider = {
        Utilities:GetAchievementName(11180),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            10555, -- Buggy Fight
            10771, -- Webbing Crashers
            10753, -- Scare Bear
            10830, -- Took the Red Eye Down
            10663, -- Imagined Dragonns World Tour
            10772, -- Use the Force(s)
            10755, -- I Attack the Darkness
            10678, -- Cage Rematch
            10697, -- Grand Opening
            10742, -- Gluten Free
            10817, -- A Change In Scenery
            10851, -- Elementalry!
            10704, -- Not For You
            10575, -- Burning Bridges
            10699, -- Infinitesimal
            10696 -- I've Got My Eyes On You
        }
    }

    -- Child Achievements Glory of the Argus Raider
    local ACMChilds_GloryOfTheArgusRaider = {
        Utilities:GetAchievementName(11987),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            11949, -- Hard to Kill
            11948, -- Together We Stand
            11930, -- Worm-monger
            11928, -- Portal Combat
            11915, -- Don't Sweat the Technique
            12065, -- Hounds Good To Me
            12129, -- This is the War Room!
            12067, -- Spheres of Influence
            12030, -- The World Revolves Around Me
            12046, -- Remeber the Titans
            12257 -- Stardust Crusaders
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME6, -- Legion
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_AndChewManaBuns
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheLegionHero
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheLegionRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheArgusRaider
    end

    ACMListFlat[#ACMListFlat+1] = {
        12103, -- ...And Chew Mana Buns
        11163, -- Glory of the Legion Hero
        11180, -- Glory of the Legion Raider
        11987, -- Glory of the Argus Raider
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- ACMList_Zones_Dalaran
    local ACMList_Zones_Dalaran = {
        Utilities:GetZoneNameByMapID(627),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            11066, -- Underbelly Tycoon
        }
    }

    -- Zones -> Dalaran -> Argus
    local ACMList_Zones_Argus = {
        Utilities:GetZoneNameByMapID(905),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Zones_Argus[#ACMList_Zones_Argus+1] = ACMChilds_AndChewManaBuns
    end

    ACMList_Zones_Argus[#ACMList_Zones_Argus+1] = {
        12103 -- ...And Chew Mana Buns
    }

    -- Zones
    local ACMList_Zones = {
        _G.ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_Dalaran,
        ACMList_Zones_Argus
    }

    -- Dungeons
    local ACMList_Dungeons= {
        _G.DUNGEONS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_GloryOfTheLegionHero
    end

    ACMList_Dungeons[#ACMList_Dungeons+1] = {
        11163, -- Glory of the Legion Hero
    }

    local ACMList_Raids = {
        Utilities:GetAchievementCategoryNameByCategoryID(15271), -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheLegionRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheArgusRaider
    end

    ACMList_Raids[#ACMList_Raids+1] = {
        11180, -- Glory of the Legion Raider
        11987, -- Glory of the Argus Raider
    }

    local ACMList = {
        _G.EXPANSION_NAME6, -- Legion
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