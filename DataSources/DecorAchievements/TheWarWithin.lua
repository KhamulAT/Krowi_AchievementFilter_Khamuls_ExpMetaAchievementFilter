local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingTWW()

    -- Child Achievements Slate of the Union
    local ACMChilds_SlateOfTheUnion = KAF_Cat(Utilities:GetAchievementName(41186))
        :Ids{
            40435, -- Adventurer of the Isle of Dorn
            40434, -- Treasures of the Isle of Dorn
            40606, -- Flat Earthen
            40859, -- We're Here All Night
            40860, -- A Star of Dorn
            40504, -- Rocked to Sleep
        }

    -- Flat achievement list
    local ACMListFlat = KAF_Cat(EXPANSION_NAME10) -- The War Within

    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements then
        ACMListFlat:Insert(ACMChilds_SlateOfTheUnion)
    end

    ACMListFlat:Ids{
        61451, -- Worldsoul-Searching
        41186, -- Slate or the Union
        20595, -- Sojurner of Isle of Dorn
        40859, -- We're All Night
        40504, -- Rocked to Sleep
        40542, -- Smelling History
        40894, -- Sojourner of Undermine
        41119, -- One Rank Higher
        19408, -- Professional Algari Master
        42187, -- Lorewalking: Ethereal Wisdon
        42188, -- Lorewalking: Blade's Bane
        42189, -- Lorewalking: The Lich King
        61467, -- Lorewalking: The Elves of Quel'Thalas
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_Zones_IsleOfDorn = KAF_CatChain(Utilities:GetZoneNameByMapID(2248)) -- Isle of Dorn

    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements then
        ACMList_Zones_IsleOfDorn:Insert(ACMChilds_SlateOfTheUnion)
    end

    ACMList_Zones_IsleOfDorn:Ids{
        41186, -- Slate or the Union
        20595, -- Sojurner of Isle of Dorn
        40859, -- We're All Night
    }

    -- Zones
    local ACMList_Zones = KAF_CatChain(_G.ZONE) -- Zone
        :Insert(ACMList_Zones_IsleOfDorn)

    ACMList_Zones:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(2214)) -- The Ringing Deeps
            :Ids{
                40504, -- Rocked to Sleep
            }
    )

    ACMList_Zones:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(2255)) -- Azj-Kahet
            :Ids{
                40542, -- Smelling History
            }
    )

    ACMList_Zones:Insert(
        KAF_CatChain(Utilities:GetZoneNameByMapID(2346)) -- Undermine
            :Ids{
                40894, -- Sojourner of Undermine
            }
    )

    -- Raids
    local ACMList_Raids = KAF_CatChain(_G.RAIDS) -- Raids
        :Insert(
            KAF_CatChain(Utilities:GetDungeonNameByLFGDungeonID(2779))
                :Ids{
                    41119, -- One Rank Higher
                }
        )

    -- Trade Skills
    local ACMList_TradeSkills = KAF_CatChain(_G.TRADE_SKILLS) -- Professions
        :Ids{
            19408, -- Professional Algari Master
        }

    -- Lorewalking
    local ACMList_Lorewalking = KAF_CatChain(Utilities:GetAchievementCategoryNameByCategoryID(15552)) -- Lorewalking
        :Ids{
            42187, -- Lorewalking: Ethereal Wisdon
            42188, -- Lorewalking: Blade's Bane
            42189, -- Lorewalking: The Lich King
            61467, -- Lorewalking: The Elves of Quel'Thalas
        }

    local ACMList = KAF_CatChain(EXPANSION_NAME10, -- The War Within
            Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(61451)}))
        :Insert(ACMList_Zones)
        :Insert(ACMList_Raids)
        :Insert(ACMList_TradeSkills)
        :Insert(ACMList_Lorewalking)
        :Ids{
            61451
        }

    return ACMList
end
