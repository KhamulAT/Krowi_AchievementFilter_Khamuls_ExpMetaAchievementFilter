local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMoPToyAchievements()

    -- Child Avhievements Pub Crawl
    local ACMChilds_PubCrawl = KAF_Cat(Utilities:GetAchievementName(7385))
        :Ids{
            7231, -- Spill No Evil
            6930, -- Yaungolian Barbecue
            6931, -- Binan Village All-Star
            7232, -- The Keg Runner
            7239, -- Monkey in the Middle
            7248, -- Monkey See, Monkey Kill
            7257, -- Don't Shake the Keg
            7258, -- Party of Six
            7261, -- The Perfect Pour
            7266, -- Save it for Later
            7267, -- Perfect Delivery
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME4) -- Mists of Pandaria

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_PubCrawl)
    end

    ACMListFlat:Ids{
        7385, -- Pub Crawl
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Scenarios
    local ACMList_Scenarios = KAF_Cat(_G.SCENARIOS) -- Scenarios

    if KhamulsAchievementFilter.db.profile.toyAchievementsSettings.includeChildAchievements then
        ACMList_Scenarios:Insert(ACMChilds_PubCrawl)
    end

    ACMList_Scenarios:Ids{
        7385, -- Pub Crawl
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME4) -- Mists of Pandaria
        :Insert(ACMList_Scenarios)

    return ACMList
end
