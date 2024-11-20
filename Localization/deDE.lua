local addonName, addon = ...;
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "deDE")
if not L then return end
addon.L = L;

-- Globals
L["Khamul's Meta-Expansion Achievement List"] = "Khamul's Meta-Achievement Liste"
L["Unknown Achievement"] = "Unknown Achievement"

-- Tooltips
L["Tt_ACM_15035"] = "Nur 4 erforderlich, um die Meta-Errungenschaft abzuschließen"