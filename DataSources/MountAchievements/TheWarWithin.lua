local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTheWarWithinMountAchievements()

    -- Child Achievements Vigilante
    local ACMChilds_Vigilante = KAF_Cat(Utilities:GetAchievementName(41980))
        :Ids{
            41978, -- Moonlighter
            41979, -- Bounty Seeker
        }

    -- Child Achievements Glory of the Nerub-ar Raider
    local ACMChilds_GloryOfTheNerubarRaider = KAF_Cat(Utilities:GetAchievementName(40232))
        :Ids{
            40261, -- Slimy Yet Satisfying
            40260, -- You Can't See Me
            40255, -- Sik Parry Bro
            40262, -- Cowabunga
            40263, -- Would You Still /love Me if I Was a Worm...
            40264, -- Kill Streak
            40730, -- Love is in the Lair
            40266 -- Missed 'Em by That Much
        }

    -- Child Achievements Glory of the Undermine Raider
    local ACMChilds_GloryOfTheUndermineRaider = KAF_Cat(Utilities:GetAchievementName(41286))
        :Ids{
            41208, -- Hold My Gear!
            41119, -- One Rank Higher
            41554, -- The Splash Zone
            41338, -- Just /Dance
            41711, -- Conveyor Slayer
            41596, -- Garbage In, Garbage Out
            41337, -- Sleep with the Fishes
            41347 -- Scheming on a Thing
        }

    -- Child Achievements Glory of the Omega Raider
    local ACMChilds_GloryOfTheOmegaRaider = KAF_Cat(Utilities:GetAchievementName(41597))
        :Ids{
            42118, -- Of Mice and Manaforges
            41613, -- Time to Vote! Cute or Scary?
            41614, -- Mother of All Tantrums
            41615, -- Cheat Meal
            41616, -- I See... Absolutely Nothing
            41617, -- Breaking the Fourth Wall
            41618, -- King's Ransom
            41619 -- Defying Gravity
        }

    -- Child Achievements Through the Depths of Visions
    local ACMChilds_ThroughTheDepthsOfVisions = KAF_Cat(Utilities:GetAchievementName(41929))
        :Ids{
            41855, -- The Most Horrific Vision of Stormwind
            41879, -- The Most Horrific Vision of Orgrimmar
            41725 -- We Have the Memories
        }

    -- Child Achievements Mastering the Visions
    local ACMChilds_MasteringTheVisions = KAF_Cat(Utilities:GetAchievementName(41966))
        :Ids{
            41964, -- Beyond the Most Horrific Vision of Stormwind
            41965, -- Beyond the Most Horrific Vision of Orgrimmar
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME10, -- The War Within
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(61451)}))

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_Vigilante)
        ACMListFlat:Insert(ACMChilds_GloryOfTheNerubarRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheUndermineRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheOmegaRaider)
        ACMListFlat:Insert(ACMChilds_ThroughTheDepthsOfVisions)
        ACMListFlat:Insert(ACMChilds_MasteringTheVisions)
    end

    ACMListFlat:Ids{
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
        40433, -- Let Me Solo Him: Zekvir
        41530, -- My New Nemesis
        41210, -- Let Me Solo Him: The Underpin
        42190, -- Let Me Solo Her: Nexus-Princess Ky'veza
        41081, -- Undermine Breaknecking: Bronze
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> K'aresh
    local ACMList_ZonesKaresh = KAF_Cat(Utilities:GetZoneNameByMapID(2371))

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_ZonesKaresh:Insert(ACMChilds_Vigilante)
    end

    ACMList_ZonesKaresh:Ids{
        41980, -- Vigilante
        61017, -- Phase-Lost-and-Found
    }

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone
        :Insert(ACMList_ZonesKaresh)

    -- Delves
    local ACMList_Delves = KAF_Cat(_G.DELVES_LABEL) -- Delves
        :Ids{
            42212, -- Titan Console Overcharged
            40433, -- Let Me Solo Him: Zekvir
            41530, -- My New Nemesis
            41210, -- Let Me Solo Him: The Underpin
            42190, -- Let Me Solo Her: Nexus-Princess Ky'veza
        }

    -- Raids
    local ACMList_Raids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15271)) -- Raids

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Raids:Insert(ACMChilds_GloryOfTheNerubarRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheUndermineRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheOmegaRaider)
    end

    ACMList_Raids:Ids{
        40232, -- Glory of the Nerub-ar Raider
        41286, -- Glory of the Liberation of Undermine Raider
        41597, -- Glory of the Omega Raider
    }

    -- Professions
    local ACMList_Professions = KAF_Cat(_G.TRADE_SKILLS) -- Professions

    KAF_Sub(ACMList_Professions, _G.PROFESSIONS_FISHING) -- Fishing
        :Ids{
            40539, -- The Derby Dash
        }

    -- Breaknecking Races
    local ACMList_BreakneckingRaces = KAF_Cat(L["Breaknecking Races"])

    KAF_Sub(ACMList_BreakneckingRaces, Utilities:GetZoneNameByMapID(2346)) -- Undermine
        :Ids{
            41081, -- Undermine Breaknecking: Bronze
        }

    local ACMList_VisionsOfNZoth = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15546)) -- Visions of N'Zoth Revisited

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_VisionsOfNZoth:Insert(ACMChilds_ThroughTheDepthsOfVisions)
        ACMList_VisionsOfNZoth:Insert(ACMChilds_MasteringTheVisions)
    end

    ACMList_VisionsOfNZoth:Ids{
        41929, -- Through the Depths of Visions
        41966, -- Mastering the Visions
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME10, -- The War Within
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(61451)}))
        :Insert(ACMList_Zones)
        :Insert(ACMList_Delves)
        :Insert(ACMList_Raids)
        :Insert(ACMList_Professions)
        :Insert(ACMList_BreakneckingRaces)
        :Insert(ACMList_VisionsOfNZoth)
        :Ids{
            61451, -- Worldsoul-Searching
        }

    return ACMList
end
