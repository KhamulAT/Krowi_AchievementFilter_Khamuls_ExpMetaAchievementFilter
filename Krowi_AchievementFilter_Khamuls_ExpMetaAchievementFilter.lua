local addonName, addon = ...;

addon.Achievements = addon.Achievements or {}

if not KrowiAF then 
    print("Krowi's Achievement Filter Addon not loaded!")
    return -- Exit the script
end

-- add all meta achievements to 
local aggregatedAchievementsList = {
    971,
    {
        addon.L["Khamul's Meta-Expansion Achievement List"],
        addon.Achievements.BfA,
        addon.Achievements.SL,
        {
            addon.Achievements.BfAMetaAchievementId,
            addon.Achievements.SLMetaAchievementId,
        }
    }
}

KrowiAF.CategoryData.KhamulsExpansionMetaAchievementLists = aggregatedAchievementsList