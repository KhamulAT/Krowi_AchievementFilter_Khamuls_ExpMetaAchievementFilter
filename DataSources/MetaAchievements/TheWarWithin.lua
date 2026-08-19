local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWAchievementId()
    return 61451
end

function GetTWWList()

    local ACM_41555 = KAF_CatChain(Utilities:GetAchievementName(41555)) -- All That Khaz
        :Ids{
            40430,
            40702,
            20596,
            40762,
            41169,
            40307
        }

    local ACM_40231 = KAF_CatChain(Utilities:GetAchievementName(40231)) -- The War Within Pathfinder
        :Ids{
            20118,
            19560,
            20598,
            19559,
            40790
        }

    local Glory_of_the_Delver_list = {
        40537,
        40506,
        40445,
        40453,
        40454,
        40538,
        42193
    }

    -- check if My New  Nemesis is already completed
    if Utilities:IsAchievementCompleted(41530) then
        table.insert(Glory_of_the_Delver_list, 41530)
    end

    -- check if My First Nemesis is already completed
    if Utilities:IsAchievementCompleted(40103) then
        table.insert(Glory_of_the_Delver_list, 40103)
    end

    local ACM_40438 = KAF_CatChain(Utilities:GetAchievementName(40438)) -- Glory of the Delver
        :Ids(Glory_of_the_Delver_list)

    local ACM_41586 = KAF_CatChain(Utilities:GetAchievementName(41586)) -- Going Goblin Mode
        :Ids{
            41216,
            41217,
            40948,
            41588,
            41589,
            41708
        }

    local ACM_60889 = KAF_CatChain(Utilities:GetAchievementName(60889)) -- Unraveled and Persevering
        :Ids{
            42761,
            42741,
            42740,
            41979,
            42729,
            42742,
            60890
        }

    local ACM_41186 = KAF_CatChain(Utilities:GetAchievementName(41186)) -- Slate of the Union
        :Ids{
            40435,
            40434,
            40606,
            40859,
            40860,
            40504
        }

    local ACM_41187 = KAF_CatChain(Utilities:GetAchievementName(41187)) -- Rage Aside the Machine
        :Ids{
            40837,
            40724,
            40662,
            40585,
            40628,
            40473,
            40475
        }

    local ACM_41188 = KAF_CatChain(Utilities:GetAchievementName(41188)) -- Crystal Chronicled
        :Ids{
            40851,
            40848,
            40625,
            40151,
            40622,
            40308,
            40311,
            40618,
            40313,
            40150
        }

    local ACM_41189 = KAF_CatChain(Utilities:GetAchievementName(41189)) -- Azj the World Turns
        :Ids{
            40840,
            40828,
            40634,
            40633,
            40869,
            40624,
            40542,
            40629
        }

    local ACM_41133 = KAF_CatChain(Utilities:GetAchievementName(41133)) -- Isle Remember You
        :Ids{
            41045,
            41042,
            41043,
            41046,
            41131,
            41050
        }

    local ACM_41201 = KAF_CatChain(Utilities:GetAchievementName(41201)) -- You Xal Not Pass
        :Insert(ACM_41186) -- Slate of the Union
        :Insert(ACM_41187) -- Rage Aside the Machine
        :Insert(ACM_41188) -- Crystal Chronicled
        :Insert(ACM_41189) -- Azj the World Turns
        :Insert(ACM_41133) -- Isle Remember You
        :Ids{
            41186,
            41187,
            41188,
            41189,
            41133
        }

    local ACMList = KAF_CatChain(Utilities:GetAchievementName(61451, "TWW - ")) -- Worldsoul-Searching
        :Insert(ACM_41555)
        :Insert(ACM_41201)
        :Insert(ACM_40231)
        :Insert(ACM_40438)
        :Insert(ACM_41586)
        :Insert(ACM_60889)
        :Ids{
            40244,
            41222,
            41598,
            41555,
            41201,
            40231,
            40438,
            41586,
            41997,
            60889
        }

    return ACMList
end
