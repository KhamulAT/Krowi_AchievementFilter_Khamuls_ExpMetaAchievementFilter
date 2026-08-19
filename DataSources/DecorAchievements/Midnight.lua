local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingMN()

    -- Child Achievements Omnium Folio Studies
    local ACMChilds_OmniumFolioStudies = KAF_Cat(Utilities:GetAchievementName(63325))
        :Ids{
            62606, -- The Sunstrider Omnium
            62607, -- Ritualized Arcana
            62608, -- Leyline Assaults
            62609, -- Magical Primessence
            62610, -- Off-World Magic
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME11) -- Midnight

    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_OmniumFolioStudies)
    end

    ACMListFlat:Ids{
        62387, -- It's Nearly Midnight
        62185, -- Ever Painting
        61574, -- Legends Never Die
        42788, -- Alchemizing at Midnight
        42792, -- Blacksmithing at Midnight
        42795, -- Cooking at Midnight
        42787, -- Enchanting at Midnight
        42798, -- Engineering at Midnight
        42797, -- Fishing at Midnight
        42793, -- Herbalism at Midnight
        42796, -- Inscribing at Midnight
        42789, -- Jewelcrafting at Midnight
        42786, -- Leatherworking at Midnight
        42791, -- Mining at Middnight
        42790, -- Skinning at Midnight
        42794, -- Tailoring at Midnight
        62144, -- Prey: Mad Magisters (Hard)
        62153, -- Prey: Insane Inventors (Hard)
        62154, -- Prey: A Different Kind of Void (Hard)
        62155, -- Prey: Ethereal Assassins (Hard)
        62156, -- Prey: Anger Management (Hard)
        62157, -- Prey: Sadistic Shamans (Hard)
        62158, -- Prey: The Fallen Farstriders (Hard)
        62159, -- Prey: Bloody Green Thumbs (Hard)
        62160, -- Prey: Blinded By The Light (Hard)
        62161, -- Prey: Outsmarting the Schemers (Hard)
        62162, -- Prey: Dominating the Void (Hard)
        62163, -- Prey: Chasing Death (Hard)
        62164, -- Prey: No Rest for the Wretched (Hard)
        62165, -- Prey: A Thorn in the Side (Hard)
        62166, -- Prey: Breaking the Blade (Hard)
        62167, -- Prey: Mad Magisters (Nightmare)
        62168, -- Prey: Insane Inventors (Nightmare)
        62169, -- Prey: A Different Kind of Void (Nightmare)
        62173, -- Prey: Ethereal Assassins (Nightmare)
        62174, -- Prey: Anger Management (Nightmare)
        62175, -- Prey: Sadistic Shamans (Nightmare)
        62176, -- Prey: The Fallen Farstriders (Nightmare)
        62177, -- Prey: Bloody Green Thumbs (Nightmare)
        62178, -- Prey: Blinded By The Light (Nightmare)
        62179, -- Prey: Outsmarting the Schemers (Nightmare)
        62180, -- Prey: Dominating the Void (Nightmare)
        62181, -- Prey: Chasing Death (Nightmare)
        62182, -- Prey: No Rest for the Wretched (Nightmare)
        62183, -- Prey: A Thorn in the Side (Nightmare)
        62184, -- Prey: Breaking the Blade (Nightmare),
        63325, -- Omnium Folio Studies
        61442, -- Lorewalking: The Loa
        63343, -- Goal!
        62288, -- Eversong Woods: The Highest Peaks
        61507, -- A Bloody Song
        62186, -- The Party Must Go On
        62289, -- Zul'Aman: The Highest Peaks
        62122, -- Tallest Tree in the Forest
        62290, -- Harandar: The Highest Peaks
        61264, -- Leaf None Behind
        62291, -- Voidstorm: The Highest Peaks
        62130, -- The Ultimate Predator
        63358, -- Coiled to Strike
        63432, -- Mysterious Mix Master
        63451, -- Scales for Days
        63452, -- Fangs for the Memories
        63453, -- One, Two, Ral'kala's Coming for You
        63454, -- Nine, Ten, Never Sleep Again
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zone
    local ACMList_Zones = KAF_Cat(_G.ZONE) -- Zone

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2537)) -- Quel'Thalas
        :Ids{
            63343, -- Goal!
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2395)) -- Eversong Woods
        :Ids{
            62185, -- Ever Painting
            62288, -- Eversong Woods: The Highest Peaks
            61507, -- A Bloody Song
            62186, -- The Party Must Go On
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2437)) -- Zul'Aman
        :Ids{
            62289, -- Zul'Aman: The Highest Peaks
            62122, -- Tallest Tree in the Forest
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2413)) -- Harandar
        :Ids{
            61574, -- Legends Never Die
            62290, -- Harandar: The Highest Peaks
            61264, -- Leaf None Behind
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2405)) -- Voidstorm
        :Ids{
            62291, -- Voidstorm: The Highest Peaks
            62130, -- The Ultimate Predator
        }

    KAF_Sub(ACMList_Zones, Utilities:GetZoneNameByMapID(2512)) -- The Coiled Isle
        :Ids{
            63358, -- Coiled to Strike
            63432, -- Mysterious Mix Master
        }

    -- Trade Skills
    local ACMList_Professions = KAF_Cat(_G.TRADE_SKILLS) -- Professions
        :Ids{
            42788, -- Alchemizing at Midnight
            42792, -- Blacksmithing at Midnight
            42795, -- Cooking at Midnight
            42787, -- Enchanting at Midnight
            42798, -- Engineering at Midnight
            42797, -- Fishing at Midnight
            42793, -- Herbalism at Midnight
            42796, -- Inscribing at Midnight
            42789, -- Jewelcrafting at Midnight
            42786, -- Leatherworking at Midnight
            42791, -- Mining at Middnight
            42790, -- Skinning at Midnight
            42794, -- Tailoring at Midnight
        }

    -- Prey
    local ACMList_Prey = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15605)) -- Prey

    KAF_Sub(ACMList_Prey, L["Hard"])
        :Ids{
            62144, -- Prey: Mad Magisters (Hard)
            62153, -- Prey: Insane Inventors (Hard)
            62154, -- Prey: A Different Kind of Void (Hard)
            62155, -- Prey: Ethereal Assassins (Hard)
            62156, -- Prey: Anger Management (Hard)
            62157, -- Prey: Sadistic Shamans (Hard)
            62158, -- Prey: The Fallen Farstriders (Hard)
            62159, -- Prey: Bloody Green Thumbs (Hard)
            62160, -- Prey: Blinded By The Light (Hard)
            62161, -- Prey: Outsmarting the Schemers (Hard)
            62162, -- Prey: Dominating the Void (Hard)
            62163, -- Prey: Chasing Death (Hard)
            62164, -- Prey: No Rest for the Wretched (Hard)
            62165, -- Prey: A Thorn in the Side (Hard)
            62166, -- Prey: Breaking the Blade (Hard)
        }

    KAF_Sub(ACMList_Prey, L["Nightmare"])
        :Ids{
            62167, -- Prey: Mad Magisters (Nightmare)
            62168, -- Prey: Insane Inventors (Nightmare)
            62169, -- Prey: A Different Kind of Void (Nightmare)
            62173, -- Prey: Ethereal Assassins (Nightmare)
            62174, -- Prey: Anger Management (Nightmare)
            62175, -- Prey: Sadistic Shamans (Nightmare)
            62176, -- Prey: The Fallen Farstriders (Nightmare)
            62177, -- Prey: Bloody Green Thumbs (Nightmare)
            62178, -- Prey: Blinded By The Light (Nightmare)
            62179, -- Prey: Outsmarting the Schemers (Nightmare)
            62180, -- Prey: Dominating the Void (Nightmare)
            62181, -- Prey: Chasing Death (Nightmare)
            62182, -- Prey: No Rest for the Wretched (Nightmare)
            62183, -- Prey: A Thorn in the Side (Nightmare)
            62184, -- Prey: Breaking the Blade (Nightmare)
        }

    KAF_Sub(ACMList_Prey, L["Coiled Nightmares"])
        :Ids{
            63451, -- Scales for Days
            63452, -- Fangs for the Memories
            63453, -- One, Two, Ral'kala's Coming for You
            63454, -- Nine, Ten, Never Sleep Again
        }

    -- Void Assaults
    local ACMList_VoidAssaults = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15610)) -- Void Assaults

    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements then
        ACMList_VoidAssaults:Insert(ACMChilds_OmniumFolioStudies)
    end

    ACMList_VoidAssaults:Ids{
        63325, -- Omnium Folie Studies
    }

    -- Lorewalking
    local ACMList_Lorewalking = KAF_CatChain(Utilities:GetAchievementCategoryNameByCategoryID(15552)) -- Lorewalking
        :Ids{
            61442, -- Lorewalking: The Loa
        }

    local ACMList = KAF_CatChain(_G.EXPANSION_NAME11) -- Midnight
        :Insert(ACMList_Zones)
        :Insert(ACMList_Professions)
        :Insert(ACMList_Prey)
        :Insert(ACMList_VoidAssaults)
        :Insert(ACMList_Lorewalking)
        :Ids{
            62387 -- It's Nearly Midnight
        }

    return ACMList
end
