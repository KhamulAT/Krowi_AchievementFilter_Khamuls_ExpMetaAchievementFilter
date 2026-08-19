local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetDFAchievementId()
    return 19458
end

function GetDFList()

    local ACM_16339 = KAF_CatPlain(Utilities:GetAchievementName(16339)) -- Myths of the Dragonflight Dungeons
        :Ids{
            16271,
            16257,
            16262,
            16265,
            16268,
            16274,
            16277,
            16280
        }

    local ACM_16585 = KAF_CatPlain(Utilities:GetAchievementName(16585)) -- Loremaster of the Dragon Isles
        :Ids{
            16334,
            16401,
            15394,
            16405,
            16336,
            16428,
            16363,
            16398
        }

    local ACM_19463 = KAF_CatPlain(Utilities:GetAchievementName(19463)) -- Dragon Quests
        :Ids{
            17773,
            17734,
            18958,
            17546,
            16683,
            19507
        }

    local ACM_19466 = KAF_CatPlain(Utilities:GetAchievementName(19466)) -- Oh My God, They Were Clutchmates
        :Ids{
            41174,
            41180,
            16529,
            41182,
            17763,
            41177,
            18615,
            16494,
            16760,
            16539,
            16537,
            17427
        }

    local ACM_19307 = KAF_CatPlain(Utilities:GetAchievementName(19307)) -- Dragon Isles Pathfinder
        :Ids{
            16334,
            15394,
            16336,
            16363,
            17739,
            16761,
            17766,
            19309
        }

    local ACM_19486 = KAF_CatPlain(Utilities:GetAchievementName(19486)) -- Accross the Isles

    ACM_19486:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(19479)):Merge()
            :Ids{
                16570,
                16587,
                15890,
                16676,
                16568,
                16588,
                16571,
                16297
            }
    )

    ACM_19486:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(19481))
            :Ids{
                16540,
                16545,
                16543,
                16677,
                16541,
                16542,
                16424,
                16299
            }
    )

    ACM_19486:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(19482))
            :Ids{
                16443,
                16444,
                16317,
                16553,
                16563,
                16580,
                16678,
                16300
            }
    )

    ACM_19486:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(19483))
            :Ids{
                16411,
                16412,
                16495,
                18384,
                18383,
                16301,
                16410,
                16497,
                16496,
                17782,
                16679
            }
    )

    ACM_19486:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(19485))
            :Ids{
                17342,
                18635,
                18637,
                18636,
                18638,
                18639,
                18640,
                18641,
                18703,
                18704
            }
    )

    local ACM_16490 = KAF_CatPlain(Utilities:GetAchievementName(16490))

    ACM_16490:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(16468))
            :Ids{
                16463,
                16465,
                16466,
                16467
            }
    )

    ACM_16490:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(16476))
            :Ids{
                16475,
                16478,
                16477,
                16479
            }
    )

    ACM_16490:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(16484))
            :Ids{
                16480,
                16481,
                16482,
                16483
            }
    )

    ACM_16490:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(16489))
            :Ids{
                16485,
                16486,
                16487,
                16488
            }
    )

    ACM_16490:Ids{
        16468,
        16476,
        16484,
        16489
    }

    ACM_19486:Insert(
        KAF_CatPlain(Utilities:GetAchievementName(16492))
            :Insert(ACM_16490)
            :Ids{
                16490,
                16461,
                16500,
                16502
            }
    )

    ACM_19486:Ids{
        19479,
        19481,
        19482,
        19483,
        19485,
        16492,
        18209,
        18867,
        19008
    }

    local ACM_17543 = KAF_CatPlain(Utilities:GetAchievementName(17543)) -- You Know How to Reach Me
        :Ids{
            17534,
            17526,
            17528,
            17525,
            17529,
            17530,
            17532,
            17540,
            17413,
            17509,
            17315
        }

    local ACM_17785 = KAF_CatChain(Utilities:GetAchievementName(17785)) -- Que Zara(lek), Zara(lek)
        :Ids{
            17739,
            17783,
            17781,
            17766,
            17763,
            17786,
            17832
        }

    local ACM_19318 = KAF_CatPlain(Utilities:GetAchievementName(19318)) -- Dream On
        :Ids{
            19026,
            19316,
            19317,
            19013,
            19309,
            19312
        }

    local ACM_19478 = KAF_CatChain(Utilities:GetAchievementName(19478)) -- Now THIS is Dragon Racing!
        :Ids{
            15939,
            17492,
            16575,
            16577,
            17411,
            19306,
            17294,
            19118,
            16576,
            16578,
            18150
        }

    local ACMList = KAF_CatChain(Utilities:GetAchievementName(19458, "DF - ")) -- meta achievements overview
        :Insert(ACM_16339) -- Myths of the Dragonflight Dungeons
        :Insert(ACM_16585) -- Loremaster of the Dragon Isles
        :Insert(ACM_19463) -- Dragon Quests
        :Insert(ACM_19466) -- Oh My God, They Were Clutchmates
        :Insert(ACM_19307) -- Dragon Isles Pathfinder
        :Insert(ACM_19486) -- Accross the Isles
        :Insert(ACM_17543) -- You Know How to Reach Me
        :Insert(ACM_17785) -- Que Zara(lek), Zara(lek)
        :Insert(ACM_19318) -- Dream On
        :Insert(ACM_19478) -- Now THIS is Dragon Racing!
        :Ids{
            16343,
            18160,
            19331,
            16339,
            16585,
            16808,
            19463,
            19466,
            19307,
            19486,
            17543,
            17785,
            19318,
            19478
        }

    return ACMList
end
