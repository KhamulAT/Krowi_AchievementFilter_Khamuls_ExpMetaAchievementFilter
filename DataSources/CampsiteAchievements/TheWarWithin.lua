local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWCampsiteList()

    -- Child Achievements All That Khaz
    local ACMChilds_AllThatKhaz = KAF_Cat(Utilities:GetAchievementName(41555))
        :Ids{
            40430, -- Khaz Algar Flight Master
            40702, -- Khaz Algar Glyph Hunter
            20596, -- Loremaster of Khaz Algar
            40762, -- Khaz Algar Lore Hunter
            41169, -- Khaz Algar Diplomat
            40307 -- Allied Races: Earthen
        }

    -- Child Achievements Going Goblin Mode
    local ACMChilds_GoingGoblinMode = KAF_Cat(Utilities:GetAchievementName(41586))
        :Ids{
            41216, -- Adventurer of Undermine
            41217, -- Treasures of Undermine
            40948, -- Nine-Tenths of the Law
            41588, -- Read Between the Lines
            41589, -- That Can-Do Attitude
            41708 -- You're My Friend Now
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME10) -- The War Within

    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_AllThatKhaz)
        ACMListFlat:Insert(ACMChilds_GoingGoblinMode)
    end

    ACMListFlat:Ids{
        41555, -- All That Khaz
        41586, -- Going Goblin Mode
        41970, -- The Knife's Edge
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Freywold Spring
    local ACMList_FreywoldSpring = KAF_CatChain(Utilities:GetAchievementRewardInfo(41555))

    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements then
        ACMList_FreywoldSpring:Insert(ACMChilds_AllThatKhaz)
    end

    ACMList_FreywoldSpring:Ids{
        41555, -- All That Khaz
    }

    -- Gallagio Grand Gallery
    local ACMList_GallagioGrandGallery = KAF_CatChain(Utilities:GetAchievementRewardInfo(41586))

    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements then
        ACMList_GallagioGrandGallery:Insert(ACMChilds_GoingGoblinMode)
    end

    ACMList_GallagioGrandGallery:Ids{
        41586, -- Going Goblin Mode
    }

    -- The Fate of the Devoured
    local ACMList_TheFateOfTheDevoured = KAF_CatChain(Utilities:GetAchievementRewardInfo(41970))
        :Ids{
            41970, -- The Knife's Edge
        }

    local ACMList = KAF_CatChain(_G.EXPANSION_NAME10) -- The War Within
        :Insert(ACMList_FreywoldSpring)
        :Insert(ACMList_GallagioGrandGallery)
        :Insert(ACMList_TheFateOfTheDevoured)

    return ACMList
end
