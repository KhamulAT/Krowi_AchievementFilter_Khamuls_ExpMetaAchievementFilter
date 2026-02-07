local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true)

if not L then return end

-- Globals
L["Khamuls Achievement Lists for Krowi's Achievement Filter"] = "Khamuls Achievement Lists for Krowi's Achievement Filter"
L["Khamul's Meta-Expansion Achievement List"] = "Khamul's Meta-Mount Collection"
L["Khamul's House Decor Achievement List"] = "Khamul's Decor Collection"
L["Khamul's Campsite Achievement List"] = "Khamul's Campsite Collection"
L["Khamul's Battle Pet Achievement List"] = "Khamul's Pet Collection"
L["Unknown Achievement"] = "Unknown Achievement"

-- Special categories
L["Cross-Expansion"] = "Cross-Expansion"

-- Missing category titles
L["Hard"] = "Hard"
L["Nightmare"] = "Nightmare"

-- Tooltips
L["Tt_ACM_15035"] = "Only 4 needed to complete the Meta-Achievement"
L["Tt_UseMetaAchievementPlugin"] = "Use \"Khamul's Meta-Mount Collection\" category, to get an detailed overview for \"{1}\"."

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "Krowi's Achievement Filter Addon not loaded!"

-- Options
L["Show List for Expansion Meta Achievements"] = "Show List for Expansion Meta Achievements"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "If enabled, a list with all achievements required for expansion meta achievements will be shown"
L["Show List for Achievements with decors as reward"] = "Show List for Achievements with decors as reward"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "If enabled, a list with all achievements, which have a decor as reward, will be shown"
L["Show List for Achievements with warband campsites as reward"] = "Show List for Achievements with warband campsites as reward"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"
L["Show List for Achievements with battle pets as reward"] = "Show List for Achievements with battle pets as reward"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "If enabled, a list with all achievements, which have a battle pet as reward, will be shown"
L["Krowi AchievementFilter status: "] = "Krowi AchievementFilter status: "
L["detected"] = "detected"
L["not detected"] = "not detected"
