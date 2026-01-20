local addonName, addon = ...;
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end
addon.L = L;

-- Globals
L["Khamul's Meta-Expansion Achievement List"] = "Khamul's Meta成就"
L["Unknown Achievement"] = "未知成就"

-- Tooltips
L["Tt_ACM_15035"] = "仅需4项即可完成元成就"