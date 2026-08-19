local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetDragonflightMountAchievements()

    -- Child Achievements Glory of the Dragonflight Hero
    local ACMChilds_GloryOfTheDragonflightHero = KAF_Cat(Utilities:GetAchievementName(16295))
        :Ids{
            16434, -- See Me After Class
            16329, -- Duck, Duck, Spruce!
            16441, -- Squad Goals
            16296, -- Growlbossify
            16430, -- All Bark, All Bite
            16404, -- So You Can Kill This in a Way That Matters...
            16517, -- Toxicity Strike Team
            16426, -- Hungry Hungry Hornswog
            16427, -- Go With the Flow
            16438, -- Knowledge is... Preserved?
            16432, -- Ready for Raiding VIII
            16453, -- Liquid Hot Magma
            16440, -- Are You My Broodmother?
            16402, -- Dragon Kill Points
            16320, -- Does Steam Do Fire Damage?
            16330, -- You Must Be Made of Hide
            16445, -- Icy What You Did There
            16331, -- The Cracked Crystal
            16447, -- What Are The Chances...
            16456, -- Weapons of the Maruukai
            16620, -- Ohuna Incubation
            16602, -- Nokhud Deed Goes Unnoticed
            16337, -- It's a Trogg Eat Trogg World
            16282, -- No, You're Stunning!
            16281 -- Like Sands Through the Hourglass
        }

    -- Child Achievements Glory of the Vault Raider
    local ACMChilds_GloryOfTheVaultRaider = KAF_Cat(Utilities:GetAchievementName(16355))
        :Ids{
            16335, -- What Froozen Things Do
            16365, -- Little Friends
            16364, -- The Lunker Below
            16419, -- I Was Saving That For Later
            16458, -- Nothing But Air
            16450, -- The Power is MINE!
            16442, -- Incubation Extermination
            16451 -- The Ol Raszle Daszle
        }

    -- Child Achievements Glory of the Aberrus Raider
    local ACMChilds_GloryOfTheAberrusRaider = KAF_Cat(Utilities:GetAchievementName(18251))
        :Ids{
            18229, -- Cosplate
            18168, -- I'll Make My Own Shadowflame
            18173, -- Tabula Rasa
            18228, -- Are You Even Trying?
            18230, -- Whac-A-Swog
            18193, -- Eggscellent Eggsecution
            18172, -- Escar-Go-Go-Go
            18149, -- Objects in Transit May Shatter
            17877 -- We'll Never See That Again, Surely
        }

    -- Child Achievements Glory of the Dream Raider
    local ACMChilds_GloryOfTheDreamRaider = KAF_Cat(Utilities:GetAchievementName(19349))
        :Ids{
            19322, -- Meaner Pastures
            19320, -- Cruelty Free
            19321, -- Swog Champion
            19193, -- Ducks In A Row
            19089, -- Don't Let the Doe Hit You On The Way Out
            19394, -- A Dream Within a Dream
            19319, -- Haven't We Done This Before?
            19393, -- Whelp, I'm Lost
            19390 -- Memories of Teldrassil
        }

    -- Child Achievements Awakening the Dragonflight Raids
    local ACMChilds_AwakeningTheDragonflightRaids = KAF_Cat(Utilities:GetAchievementName(19574))
        :Ids{
            19564, -- Awakened Storms
            19567, -- Awakened Shadows
            19570 -- Awakened Flames
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(_G.EXPANSION_NAME9, -- Dragonflight
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(19458)}))

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_GloryOfTheDragonflightHero)
        ACMListFlat:Insert(ACMChilds_GloryOfTheVaultRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheAberrusRaider)
        ACMListFlat:Insert(ACMChilds_GloryOfTheDreamRaider)
        ACMListFlat:Insert(ACMChilds_AwakeningTheDragonflightRaids)
    end

    ACMListFlat:Ids{
        16295, -- Glory of the Dragonflight Hero
        16355, -- Glory of the Vault Raider
        18251, -- Glory of the Aberrus Raider
        19349, -- Glory of the Dream Raider
        19574, -- Awakening the Dragonflight Raids,
        19458, -- A World Awoken
        15916, -- Waking Shores: Silver
        15928, -- Waking Shores Advanced: Silver
        15919, -- Ohn'ahran Plains: Silver
        15931, -- Ohn'ahran Plains Advanced: Silver
        15922, -- Azure Span: Silver
        15934, -- Azure Span Advanced: Silver
        15925, -- Thaldraszus: Silver
        15937, -- Thaldraszus Advanced: Silver
        17484, -- Zaralek Cavern: Silver
        17487, -- Zaralek Cavern Advanced: Silver
        15833, -- Thanks for the Carry!
        15834, -- Thanks for the Carry!
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons
    local ACMList_Dungeons = KAF_Cat(_G.DUNGEONS)

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons:Insert(ACMChilds_GloryOfTheDragonflightHero)
    end

    ACMList_Dungeons:Ids{
        16295, -- Glory of the Dragonflight Hero
    }

    local ACMList_Raids = KAF_Cat(Utilities:GetAchievementCategoryNameByCategoryID(15271)) -- Raids

    if KhamulsAchievementFilter.db.profile.mountAchievementsSettings.includeChildAchievements then
        ACMList_Raids:Insert(ACMChilds_GloryOfTheVaultRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheAberrusRaider)
        ACMList_Raids:Insert(ACMChilds_GloryOfTheDreamRaider)
        ACMList_Raids:Insert(ACMChilds_AwakeningTheDragonflightRaids)
    end

    ACMList_Raids:Ids{
        16355, -- Glory of the Vault Raider
        18251, -- Glory of the Aberrus Raider
        19349, -- Glory of the Dream Raider
        19574, -- Awakening the Dragonflight Raids
    }

    -- Skyriding Races
    local ACMList_SkyridingRaces = KAF_Cat(_G.MOUNT_JOURNAL_FILTER_DRAGONRIDING) -- Skyriding

    KAF_Sub(ACMList_SkyridingRaces, Utilities:GetZoneNameByMapID(2022)) -- The Waking Shores
        :Ids{
            15916, -- Waking Shores: Silver
            15928, -- Waking Shores Advanced: Silver
        }

    KAF_Sub(ACMList_SkyridingRaces, Utilities:GetZoneNameByMapID(2023)) -- Ohn'ahran Plains
        :Ids{
            15919, -- Ohn'ahran Plains: Silver
            15931, -- Ohn'ahran Plains Advanced: Silver
        }

    KAF_Sub(ACMList_SkyridingRaces, Utilities:GetZoneNameByMapID(2024)) -- The Azure Span
        :Ids{
            15922, -- Azure Span: Silver
            15934, -- Azure Span Advanced: Silver
        }

    KAF_Sub(ACMList_SkyridingRaces, Utilities:GetZoneNameByMapID(2025)) -- Thaldraszus
        :Ids{
            15925, -- Thaldraszus: Silver
            15937, -- Thaldraszus Advanced: Silver
        }

    KAF_Sub(ACMList_SkyridingRaces, Utilities:GetZoneNameByMapID(2133)) -- Zaralek Cavern
        :Ids{
            17484, -- Zaralek Cavern: Silver
            17487, -- Zaralek Cavern Advanced: Silver
        }

    ACMList_SkyridingRaces:Ids{
        -- Both faction variants are listed; only the character's own is earnable
        15833, -- Thanks for the Carry!
        15834, -- Thanks for the Carry!
    }

    local ACMList = KAF_Cat(_G.EXPANSION_NAME9, -- Dragonflight
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(19458)}))
        :Insert(ACMList_Dungeons)
        :Insert(ACMList_Raids)
        :Insert(ACMList_SkyridingRaces)
        :Ids{
            19458, -- A World Awoken
        }

    return ACMList
end
