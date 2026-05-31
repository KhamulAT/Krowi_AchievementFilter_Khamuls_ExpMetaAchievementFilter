local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTheWarWithinMountAchievements()

    -- Child Achievements Vigilante
    local ACMChilds_Vigilante = {
        Utilities:GetAchievementName(41980),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            41978, -- Moonlighter
            41979, -- Bounty Seeker
        }
    }

    -- Child Achievements Glory of the Nerub-ar Raider
    local ACMChilds_GloryOfTheNerubarRaider = {
        Utilities:GetAchievementName(40232),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40261, -- Slimy Yet Satisfying
            40260, -- You Can't See Me
            40255, -- Sik Parry Bro
            40262, -- Cowabunga
            40263, -- Would You Still /love Me if I Was a Worm...
            40264, -- Kill Streak
            40730, -- Love is in the Lair
            40266 -- Missed 'Em by That Much
        }
    }

    -- Child Achievements Glory of the Undermine Raider
    local ACMChilds_GloryOfTheUndermineRaider = {
        Utilities:GetAchievementName(41286),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            41208, -- Hold My Gear!
            41119, -- One Rank Higher
            41554, -- The Splash Zone
            41338, -- Just /Dance
            41711, -- Conveyor Slayer
            41596, -- Garbage In, Garbage Out
            41337, -- Sleep with the Fishes
            41347 -- Scheming on a Thing
        }
    }

    -- Child Achievements Glory of the Omega Raider
    local ACMChilds_GloryOfTheOmegaRaider = {
        Utilities:GetAchievementName(41597),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            42118, -- Of Mice and Manaforges
            41613, -- Time to Vote! Cute or Scary?
            41614, -- Mother of All Tantrums
            41615, -- Cheat Meal
            41616, -- I See... Absolutely Nothing
            41617, -- Breaking the Fourth Wall
            41618, -- King's Ransom
            41619 -- Defying Gravity
        }
    }

    -- Child Achievements Through the Depths of Visions
    local ACMChilds_ThroughTheDepthsOfVisions = {
        Utilities:GetAchievementName(41929),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            41855, -- The Most Horrific Vision of Stormwind
            41879, -- The Most Horrific Vision of Orgrimmar
            41725 -- We Have the Memories
        }
    }

    -- Child Achievements Mastering the Visions
    local ACMChilds_MasteringTheVisions = {
        Utilities:GetAchievementName(41966),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            41964, -- Beyond the Most Horrific Vision of Stormwind
            41965, -- Beyond the Most Horrific Vision of Orgrimmar
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true;
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(61451)})
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_Vigilante
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheNerubarRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheUndermineRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheOmegaRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_ThroughTheDepthsOfVisions
        ACMListFlat[#ACMListFlat+1] = ACMChilds_MasteringTheVisions
    end

    ACMListFlat[#ACMListFlat+1] = {
        41980, -- Vigilante
        61017, -- Phase-Lost-and-Found
        42212, -- Titan Console Overcharged
        40232, -- Glory of the Nerub-ar Raider
        41286, -- Glory of the Liberation of Undermine Raider
        41597, -- Glory of the Omega Raider
        40539, -- The Derby Dash
        41929, -- Through the Depths of Visions
        41966, -- Mastering the Visions
        61451, -- Worldsoul-Searching
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> K'aresh
    local ACMList_ZonesKaresh = {
        Utilities:GetZoneNameByMapID(2371),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_ZonesKaresh[#ACMList_ZonesKaresh+1] = ACMChilds_Vigilante
    end

    ACMList_ZonesKaresh[#ACMList_ZonesKaresh+1] = {
        41980, -- Vigilante
        61017, -- Phase-Lost-and-Found
    }

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_ZonesKaresh
    }

    -- Delves
    local ACMList_Delves = {
        _G.DELVES_LABEL, -- Delves
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            42212, -- Titan Console Overcharged
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
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheNerubarRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheUndermineRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheOmegaRaider
    end

    ACMList_Raids[#ACMList_Raids+1] = {
        40232, -- Glory of the Nerub-ar Raider
        41286, -- Glory of the Liberation of Undermine Raider
        41597, -- Glory of the Omega Raider
    }

    -- Professions
    local ACMList_Professions = {
        _G.TRADE_SKILLS, -- Professions
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            _G.PROFESSIONS_FISHING, -- Fishing
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                40539, -- The Derby Dash
            }
        }
    }

    local ACMList_VisionsOfNZoth = {
        Utilities:GetAchievementCategoryNameByCategoryID(15546), -- Visions of N'Zoth Revisited
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_VisionsOfNZoth[#ACMList_VisionsOfNZoth+1] = ACMChilds_ThroughTheDepthsOfVisions
        ACMList_VisionsOfNZoth[#ACMList_VisionsOfNZoth+1] = ACMChilds_MasteringTheVisions
    end

    ACMList_VisionsOfNZoth[#ACMList_VisionsOfNZoth+1] = {
        41929, -- Through the Depths of Visions
        41966, -- Mastering the Visions
    }

    local ACMList = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true;
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(61451)})
        },
        ACMList_Zones,
        ACMList_Delves,
        ACMList_Raids,
        ACMList_Professions,
        ACMList_VisionsOfNZoth,
        {
            61451, -- Worldsoul-Searching
        }
    }

    return ACMList
end