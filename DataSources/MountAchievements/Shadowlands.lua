local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetShadowlandsMountAchievements()

    -- Child Achievements On the Offensive
    -- (also nested under Breaking the Chains, which is why it is built once here)
    local ACMChilds_OnTheOffensive = KAF_Cat(Utilities:GetAchievementName(15035))
        :Ids{
            15000, -- United Front
            15001, -- Jailer's Personal Stash
            15037, -- This Army
            15039, -- Up For Grabs
            15041, -- The Zovall Shuffle
            15043, -- Hoarders of Thorghast
            15004, -- A Sly Fox
            15042, -- Tea for the Troubled
            15044 -- Krrprripripkraak's Heroes
        }

    -- Child Achievements Breaking the Chains
    local ACMChilds_BreakingTheChains = KAF_Cat(Utilities:GetAchievementName(15064))
        :Insert(ACMChilds_OnTheOffensive)
        :Ids{
            14961, -- Chains of Domination
            15035, -- On the Offensive
            15054, -- Minions of the Cold Dark
            15066, -- Reliquary Restoration
            15053, -- Explore Korthia
            15059, -- Death's Advance
            15069, -- The Archivists' Codex
            15099, -- Treasures of Korthia
            15107 -- Conquering Korthia
        }

    -- Child Achievements Glory of the Shadowlands Hero
    local ACMChilds_GloryOfTheShadowlandsHero = KAF_Cat(Utilities:GetAchievementName(14322))
        :Ids{
            14295, -- Bountiful Harvest
            14320, -- Surgeon's Supplies
            14285, -- Ready for Raiding VII
            14503, -- Hooked On Hydroponics
            14291, -- Someone Could Trip onn These!
            14375, -- Hunger for Knowledge
            14347, -- Full Gores Meal
            14296, -- Going Viral
            14292, -- Riding with my Slimes
            14567, -- Picking Up the Pieces
            14284, -- Breaking Bad
            14352, -- Nobody Puts Denathrius in a Corner
            14374, -- Couple's Therapy
            14354, -- Highly Communicable
            14606, -- Thinking with...
            14331, -- Goliath Offline
            14323, -- ExSPEARiential
            14327, -- I Can See My House From Here
            14297, -- Three Choose One
            14607, -- Fresh Meat!
            14533, -- Royal Rumble
            14286, -- Residue Evil
            14290, -- I Only Have Eyes For You
            14289 -- Kall-ed Shot
        }

    -- Child Achievements Glory of the Nathria Raider
    local ACMChilds_GloryOfTheNathriaRaider = KAF_Cat(Utilities:GetAchievementName(14355))
        :Ids{
            14293, -- Blind as a Bat
            14523, -- Taking Care of Business
            14608, -- Burning Bright
            14617, -- Private Stock
            14376, -- Feed the Beast
            14524, -- I Don't Know What I Expected
            14619, -- Pour Decision Making
            14294, -- Dirtflap's Revenge
            14525, -- Feed Me, Seymour!
            14610 -- Clear Conscience
        }

    -- Child Achievements Glory of the Dominnant Raider
    local ACMChilds_GloryOfTheDominantRaider = KAF_Cat(Utilities:GetAchievementName(15130))
        :Ids{
            14998, -- Name A Better Duo, I'll Wait
            15065, -- Eye Wish You Were Here
            15003, -- To the Nines
            15105, -- Tormentor's Tango
            15058, -- I Used to Bullseye Deeprun Rats Back Home
            15131, -- Whack-A-Soul
            15132, -- Knowledge is Power
            15040, -- Flawless Fate
            15108, -- Together Forever
            15133 -- This World is a Prism
        }

    -- Child Achievements Glory of the Sepulcher Raider
    local ACMChilds_GloryOfTheSepulcherRaider = KAF_Cat(Utilities:GetAchievementName(15491))
        :Ids{
            15315, -- Amidst Ourselves
            15397, -- Four Fing Circus
            15381, -- Power ON
            15386, -- Shimmering Secrets
            15419, -- The Protoform Matrix
            15396, -- We Are All Made of Stars
            15400, -- Where the Wild Corgis Are
            15401, -- Wisdom Comes From the Desert
            15398, -- Xy Never, Ever Marks the Spot.
            15494 -- Damnation Aviation
        }

    -- Child Achievements Fates of the Shadowlands Raids
    local ACMChilds_FatesOfTheShadowlandsRaids = KAF_Cat(Utilities:GetAchievementName(15684))
        :Ids{
            15663, -- Fate of Nathria
            15667, -- Fate of Domination
            15681 -- Fate of the Sepulcher
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME8, -- Shadowlands
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(20501)}))

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_BreakingTheChains)
        ACMListFlat:Insert(ACMChilds_GloryOfTheShadowlandsHero)
        ACMListFlat:Insert(ACMChilds_GloryOfTheNathriaRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheDominantRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheSepulcherRaider)
        ACMListFlat:Insert(ACMChilds_FatesOfTheShadowlandsRaids)
    end

    ACMListFlat:Ids{
        15064, -- Breaking the Chains
        14322, -- Glory of the Shadowlands Hero
        14355, -- Glory of the Nathria Raider
        15130, -- Glory of the Dominant Raider
        15491, -- Glory of  the Sepulcher Raider
        15684, -- Fates of the Shadowlands Raids
        20501, -- Back from the Beyond
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = KAF_Cat(_G.ZONE)

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Zones:Insert(ACMChilds_BreakingTheChains)
    end

    ACMList_Zones:Ids{
        15064, -- Breaking the Chains
    }

    -- Dungeons
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS)

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons:Insert(ACMChilds_GloryOfTheShadowlandsHero)
    end

    ACMList_Dungeons:Ids{
        14322, -- Glory of the Shadowlands Hero
    }

    local ACMList_Raids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15271)) -- Raids

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Raids:Insert(ACMChilds_GloryOfTheNathriaRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheDominantRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheSepulcherRaider)
        ACMList_Raids:Insert(ACMChilds_FatesOfTheShadowlandsRaids)
    end

    ACMList_Raids:Ids{
        14355, -- Glory of the Nathria Raider
        15130, -- Glory of the Dominant Raider
        15491, -- Glory of  the Sepulcher Raider
        15684, -- Fates of the Shadowlands Raids
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME8, -- Shadowlands
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(20501)}))
        :Insert(ACMList_Zones)
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_Raids)
        :Ids{
            20501, -- Back from the Beyond
        }

    return ACMList
end
