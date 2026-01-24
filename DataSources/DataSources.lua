local ADDON_NAME = ...
local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)

---@class KAF_DataSource
---@field Name string
---@field Id number
---@field Items table
---@field ctx? table
---@field Init? fun(self: KAF_DataSource, ctx: table)
---@field Rebuild? fun(self: KAF_DataSource)
---@field GetItems? fun(self: KAF_DataSource): table

---@class KAF_DataModule : AceModule
---@field Sources table<string, KAF_DataSource>
local Data = Addon:NewModule("Data")

local function EnsureContext(self)
  if self.ctx then return end

  -- Locale must be loaded before this is called (load Locale files before DataSources in the toc).
  local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

  -- Utilities module must exist (Utilities.lua must be loaded before any source registers).
  local Utilities = Addon:GetModule("Utilities", true)
  assert(Utilities, "Utilities module not loaded. Ensure Utilities.lua is listed before DataSources in the toc.")

  self.ctx = {
    Addon = Addon,
    Utilities = Utilities,
    L = L,
  }
end

function Data:OnInitialize()
    self.Sources = self.Sources or {}
end

---@param source KAF_DataSource
function Data:RegisterSource(source)
  assert(type(source) == "table", "Data:RegisterSource expects a table")
  assert(type(source.Name) == "string" and source.Name ~= "", "Source must have a Name")
  assert(type(source.Id) == "number", "Source must have an Id (number)")
  assert(type(source.Items) == "table", "Source must have Items (table)")
  source.Items = source.Items or {}
  self.Sources = self.Sources or {}

  EnsureContext(self)

  -- Inject shared context into the source (dependency injection)
  source.ctx = self.ctx

  -- Allow source to initialize itself (create tables, etc.)
  if type(source.Init) == "function" then
    source:Init(self.ctx)
  end

  self.Sources[source.Name] = source
end

---@param name string
---@return KAF_DataSource
function Data:GetSource(name)
  return self.Sources[name]
end

function Data:GetMetaAchievements()
  return self.Sources.MetaAchievements
end

function Data:GetDecorAchievements()
  return self.Sources.DecorAchievements
end