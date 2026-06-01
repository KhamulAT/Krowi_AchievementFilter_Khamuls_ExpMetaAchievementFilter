local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetBattleForAzerothMountAchievements()

    -- Child Achievements Battle for Azeroth Keystone Master: Season Four
    local ACMChilds_BattleForAzerothKeystoneMasterSeasonFour = {
        Utilities:GetAchievementName(14145),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14144, -- Battle For Azeroth Keystone Conqueror: Season Four
        }
    }

    -- Child Achievements Glory of the Wartorn Hero
    local ACMChilds_GloryOfTheWartornHero = {
        Utilities:GetAchievementName(12812),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12550, -- Pecking Order
            12548, -- I'm in Charge Now!
            12998, -- That Sweete Booty
            12489, -- Losinng My Profession
            12495, -- Run Wild Like a Man On Fire
            12490, -- Alchemical Romance
            12600, -- Breath of the Shrine
            12601, -- The Void Lies Sleeping
            12602, -- Trust No One
            12270, -- Bringing Hexy Back
            12272, -- Gold Fever
            12273, -- It's Lit!
            12549, -- Not a Fun Guy
            12498, -- Taint Nobody Got Time For That
            12499, -- Sporely Alive
            12503, -- Snake Eyes
            12507, -- Snake Eater
            12508, -- Good Night, Sweet Prince
            12457, -- Remix to Ignition
            12462, -- Shot Through the Heart
            12855, -- Pitch Invasion
            12854, -- Ready for Raiding VI
            12727, -- Stand by Me
            12726, -- A Fish Out of Water
            12722, -- It Belongs in a Mausoleum!
            12723, -- How to Keep a Mummy
            12721 -- Wrap God
        }
    }

    -- Child Achievements Glory of the Uldir Raider
    local ACMChilds_GloryOfTheUldirRaider = {
        Utilities:GetAchievementName(12806),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12551, -- Double Dribble
            12937, -- Elevator Music
            12938, -- Parental Controls
            12823, -- Trash Mouth - All Stars
            12828, -- What's in the Box?
            12772, -- Mpw We Got Bad Blood
            12830, -- Edgelords
            12836 -- Existential Crisis
        }
    }

    -- Child Achievements Glory of the Dazar'alor Raider
    local ACMChilds_GloryOfTheDazaralorRaider = {
        Utilities:GetAchievementName(13315),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13316, -- Can I Get a Hek Hek Hek Yeah?
            13325, -- Walk the Dinosaur
            13345, -- Praise the Sunflower
            13383, -- Barrel of Monkeys
            13410, -- Snow Fun Allowed
            13401, -- I Got Next!
            13431, -- Hidden Dragon
            13430, -- De Lurker Be'loa
            13425 -- We Got Spirit, How About You?
        }
    }

    -- Child Achievements Glory of the Eternal Raider
    local ACMChilds_GloryOfTheEternalRaider = {
        Utilities:GetAchievementName(13687),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13684, -- You and What Army?
            13767, -- Fun Run
            13628, -- Intro to Marine Biology
            13629, -- Simple Geometry
            13633, -- If It Pleases the Court
            13724, -- A Smack of Jellyfish
            13716, -- Lactose Intolerant
            13768 -- The Best of Us
        }
    }

    -- Child Achievements Glory of the Ny'alotha Raider
    local ACMChilds_GloryOfTheNyalothaRaider = {
        Utilities:GetAchievementName(14146),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14019, -- Smoke Test
            14008, -- Mana Sponge
            14037, -- Phase 3: Prophet
            14024, -- Buzzer Beater
            14023, -- Realizing Your Potential
            13990, -- You Can Pet the Dog, But...
            14026, -- Temper Tantrum
            14139, -- Total Annihilation
            13999, -- How? Isn't it Obelisk?
            14038, -- Blooody Mess
            14147, -- Cleansing Treatment
            14148 -- It's Not A Cult
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true;
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(40953)})
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheWartornHero
        ACMListFlat[#ACMListFlat+1] = ACMChilds_BattleForAzerothKeystoneMasterSeasonFour
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheUldirRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheDazaralorRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheEternalRaider
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GloryOfTheNyalothaRaider
    end

    ACMListFlat[#ACMListFlat+1] = {
        12812, -- Glory of the Wartorn Hero
        14145, -- Battle for Azeroth Keystone Master: Season Four
        12806, -- Glory of the Uldir Raider
        13315, -- Glory of the Dazar'alor Raider
        13687, -- Glory of the Eternal Raider
        14146, -- Glory of the Ny'alotha Raider
        40953, -- A Farewell to Arms
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons -> Maw of Souls
    local ACMList_Dungeons= {
        _G.DUNGEONS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_GloryOfTheWartornHero
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_BattleForAzerothKeystoneMasterSeasonFour
    end

    ACMList_Dungeons[#ACMList_Dungeons+1] = {
        12812, -- Glory of the Wartorn Hero
        14145, -- Battle for Azeroth Keystone Master: Season Four
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
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheUldirRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheDazaralorRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheEternalRaider
        ACMList_Raids[#ACMList_Raids+1] = ACMChilds_GloryOfTheNyalothaRaider
    end

    ACMList_Raids[#ACMList_Raids+1] = {
        12806, -- Glory of the Uldir Raider
        13315, -- Glory of the Dazar'alor Raider
        13687, -- Glory of the Eternal Raider
        14146 -- Glory of the Ny'alotha Raider
    }

    local ACMList = {
        _G.EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true;
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(40953)})
        },
        ACMList_Dungeons,
        ACMList_Raids,
        {
            40953, -- A Farewell to Arms
        }
    }

    return ACMList
end