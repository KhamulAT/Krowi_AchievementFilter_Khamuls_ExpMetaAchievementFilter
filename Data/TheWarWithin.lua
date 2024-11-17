local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for TWW
addon.Achievements.TWW = {}
addon.Achievements.TWWMetaAchievementId = 41201

local ACM_41186 = { -- Slate of the Union
    GetAchievementName(41186),
    true,
    {
        40435,
        40434,
        40606,
        40859,
        40860,
        40504
    }
}

local ACM_41187 = { -- Rage Aside the Machine
    GetAchievementName(41187),
    true,
    {
        40837,
        40724,
        40662,
        40585,
        40628,
        40473,
        40475
    }
}

local ACM_41188 = { -- Crystal Chronicled
    GetAchievementName(41188),
    true,
    {
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
}

local ACM_41189 = { -- Azj the World Turns
    GetAchievementName(41189),
    true,
    {
        40840,
        40828,
        40634,
        40633,
        40869,
        40624,
        40542,
        40629
    }
}

local ACMList = { -- meta achievements overview
    GetAchievementName(41201, "TWW - "),
    true,
    {
        IgnoreCollapsedChainFilter = true,
        Tooltip = L["Tt_ACM_41201"]
    },
    ACM_41186, -- Slate of the Union
    ACM_41187, -- Rage Aside the Machine
    ACM_41188, -- Crystal Chronicled
    ACM_41189, -- Azj the World Turns
    {
        41186,
        41187,
        41188,
        41189
    }
}

addon.Achievements.TWW = ACMList