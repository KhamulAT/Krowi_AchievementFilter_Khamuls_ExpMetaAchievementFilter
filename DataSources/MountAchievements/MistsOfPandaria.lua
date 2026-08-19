local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMoPMountAchievements()

    -- Child Achievements Pandaria Dungeon Hero
    local ACMChilds_PandariaDungeonHero = KAF_Cat(Utilities:GetAchievementName(6925))
        :Ids{
            6758, -- Heroic: Temple of the Jade Serpent
            6456, -- Heroic: Stormstout Brewery
            6756, -- Heroic: Mogu'shan Palace
            6470, -- Heroic: Shado-Pan Monastery
            6759, -- Heroic: Gate of the Setting Sun
            6760, -- Heroic: Scarlet Halls
            6761, -- Heroic: Scarlet Monastery
            6762, -- Heroic: Scholomance
            6763 -- Heroic: Siege of Niuzao Temple
        }

    -- Child Achievements Glory of the Pandaria Hero
    local ACMChilds_GloryOfThePandariaHero = KAF_Cat(Utilities:GetAchievementName(6927))
        :Insert(ACMChilds_PandariaDungeonHero)
        :Ids{
            6925, -- Pandaria Dungeon Hero
            6460, -- Hdydrophobia
            6475, -- Cleaning Up
            6671, -- Seeds of Doubt
            6420, -- Hopocalypse Now!
            6089, -- Keep Rollin' Rollin' Rollin'
            6400, -- How Did He Get Up There?
            6402, -- Ling'Ting's Herbal Journey
            6478, -- Glintrok N' Roll
            6736, -- What Does This Button Do?
            6713, -- Quarrelsome Quilen Quintet
            6477, -- Respect
            6472, -- The Obvious Solution
            6471, -- Hate Leads to Suffering
            6479, -- Bomberman
            6476, -- Conscripinator
            6684, -- Humane Society
            6427, -- Mosh Pit
            6928, -- Burning  Man
            6929, -- And Stay Dead!
            6531, -- Attention to Detail
            6394, -- Rattle No More
            6396, -- Sanguinarian
            6821, -- School's Pit Forever
            6688, -- Where's My Air Support?
            6485, -- Return to Sender
            6822, -- Run with the Wind
            6715 -- Ployformic Acid Science
        }

    -- Child Achievements Glory of the Pandaria Raider
    local ACMChilds_GloryOfThePandariaRaider = KAF_Cat(Utilities:GetAchievementName(6932))
        :Ids{
            6823, -- Must Love Dogs
            6674, -- Anything You Can Do, I Can Do Better...
            7056, -- Sorry, Were You Looking for This?
            6686, -- Straight Six
            6937, -- Overzealous
            6936, -- Candle in the Wind
            6553, -- Like an Arrow to the Face
            6683, -- Less Than Three
            6518, -- I Heard You Like Amber...
            6922, -- Timing is Everything
            6717, -- Power Overwhelming
            6824, -- Face Clutchers
            6933, -- Who's Got Two Green Thumbs?
            6825, -- The Mind-Killer
            6719, -- Heroic: Stone Guard
            6720, -- Heroic: Feng the Accursed
            6721, -- Heroic: Gara'jal the Spiritbinder
            6722, -- Heroic: Four Kings
            6723, -- Heroic: Elegon
            6724, -- Heroic: Will of the Emperor
            6725, -- Heroic: Imperial Vizier Zor'lok
            6726, -- Heroic: Blade Lord Ta'yak
            6727, -- Heroic: Garalon
            6728, -- Heroic: Wind Lord Mel'jarak
            6729, -- Heroic: Amber-Shaper Un'sok
            6730, -- Heroic: Grand Empress Shek'zeer
            6731, -- Heroic: Protectors of the Endless
            6732, -- Heroic: Tsulong
            6733 -- Heroic: Lei Shi
        }

    -- Child Achievements Glory of the Thundering Raider
    local ACMChilds_GloryOfTheThunderingRaider = KAF_Cat(Utilities:GetAchievementName(8124))
        :Ids{
            8056, -- Heroic: Jin'rokh the Breaker
            8057, -- Heroic: Horridon
            8058, -- Heroic: Council of Elders
            8059, -- Heroic: Tortos
            8060, -- Heroic: Megaera
            8061, -- Heroic: Ji-Kun
            8062, -- Heroic: Durumu the Forgotten
            8063, -- Heroic: Primordius
            8064, -- Heroic: Dark Animus
            8065, -- Heroic: Iron Qon
            8066, -- Heroic: Twin Empyreans
            8094, -- Lighting Overload
            8038, -- Cretaceaous Collector
            8073, -- Cae Match
            8077, -- One-Up
            8082, -- Head Case
            8097, -- Soft Hands
            8098, -- You Said Crossing the Streams Was Bad
            8037, -- Genetically Unmodified Organism
            8081, -- Ritualist Who?
            8087, -- Can't Touch This
            8086, -- From Dusk 'til Dawn
            8090 -- A Complete Circuit
        }

    -- Child Achievements Glory of the Orgrimmar Raider
    local ACMChilds_GloryOfTheOrgrimmarRaider = KAF_Cat(Utilities:GetAchievementName(8454))
        :Ids{
            8536, -- No More Tears
            8528, -- Go Long
            8532, -- None Shall Pass
            8521, -- Shallow Your Pride
            8530, -- The Immortal Vanguard
            8520, -- Fire in the Hole!
            8453, -- Rescue Raiders
            8448, -- Gamon Will Save Us!
            8538, -- Unlimited Potential
            8529, -- Criss Cross
            8527, -- Giant Dinosaur vs. Mega Snail
            8543, -- Lasers and Magnets and Drills! Oh My!
            8531, -- Now we are the Paragon
            8537 -- Strike
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME4) -- Mists of Pandaria

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_GloryOfThePandariaHero)
        ACMListFlat:Insert(ACMChilds_GloryOfThePandariaRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheThunderingRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheOrgrimmarRaider)
    end

    ACMListFlat:Ids{
        6828, -- Pandaren Ambassador
        6927, -- Glory of the Pandaria Hero
        6375, -- Challenge Conqueror: Silver
        6932, -- Glory of the Pandaria Raider
        8124, -- Glory of the Thundering Raider
        8454, -- Glory of the Orgrimmar Raider
        8398, -- Ahead of the Curve: Garrosh Hellscream (10 player)
        8399 -- Ahead of the Curve: Garrosh Hellscream (25 player)
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Reputation
    local ACMList_Reputation = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(201)) -- Reputation
        :Ids{
            6828 -- Pandaren Ambassador
        }

    -- Dungeons
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS) -- Dungeons

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons:Insert(ACMChilds_GloryOfThePandariaHero)
    end

    ACMList_Dungeons:Ids{
        6927, -- Glory of the Pandaria Hero
        6375 -- Challenge Conqueror: Silver
    }

    -- Raids
    local ACMList_Raids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15271)) -- Raids

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Raids:Insert(ACMChilds_GloryOfThePandariaRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheThunderingRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheOrgrimmarRaider)
    end

    KAF_Sub(ACMList_Raids, Utilities:GetDungeonNameByLFGDungeonID(714)) -- Siege of Orgrimmar
        :Ids{
            8398, -- Ahead of the Curve: Garrosh Hellscream (10 player)
            8399 -- Ahead of the Curve: Garrosh Hellscream (25 player)
        }

    ACMList_Raids:Ids{
        6932, -- Glory of the Pandaria Raider
        8124, -- Glory of the Thundering Raider
        8454, -- Glory of the Orgrimmar Raider
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME4) -- Mists of Pandaria
        :Insert(ACMList_Reputation)
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_Raids)

    return ACMList
end
