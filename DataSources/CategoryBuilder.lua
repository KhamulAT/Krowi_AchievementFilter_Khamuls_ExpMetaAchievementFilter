local ADDON_NAME = ...

--[[
    V2 category-building helpers.

    Krowi's V2 API (Api/CategoryDataBuilder.lua) builds category nodes through
    builder objects instead of positional tables. The builder itself IS the data
    node, so the parser fields the V1 format expressed as a trailing options
    table -- IgnoreCollapsedChainFilter, IgnoreFactionFilter, Tooltip -- are set
    directly on the node (see ParseCategoryV2 in Api/CategoryDataApi.lua).

    Nearly every category in this plugin opts out of the same filters, so rather
    than repeat that on every node these factories bake the combination into the
    name:

      KAF_Cat        ignore collapsed-chain and faction filters (the common case)
      KAF_CatChain   ignore the collapsed-chain filter only
      KAF_CatFaction ignore the faction filter only
      KAF_CatPlain   no filter opt-outs

    Each returns a Krowi CategoryBuilder node, so the full V2 surface is
    available on the result: :Ids{...}, :Insert(node), :Named(name, ids),
    :Merge(). KAF_Sub attaches a flagged child and returns it, which is the V2
    equivalent of nesting a group table inside its parent.

    V1 and V2 nodes interoperate in both directions inside Krowi's parser, so a
    partially migrated tree is still valid.
]]

local IGNORE_CHAIN, IGNORE_FACTION = 1, 2

-- Builds a detached node through the public V2 API. NewRootCategory appends to
-- the table it is given; we pass a throwaway one because the node is parented
-- later via KAF_Sub / :Insert rather than registered as a root.
local function NewCategory(name, mode, tooltip)
    local node = KrowiAF.NewRootCategory({}, name)

    if mode == nil or mode == IGNORE_CHAIN then
        node.IgnoreCollapsedChainFilter = true
    end
    if mode == nil or mode == IGNORE_FACTION then
        node.IgnoreFactionFilter = true
    end
    if tooltip then
        node.Tooltip = tooltip
    end

    return node
end

---Category that ignores both the collapsed-chain and faction filters.
---@param name string
---@param tooltip? string
function KAF_Cat(name, tooltip)
    return NewCategory(name, nil, tooltip)
end

---Category that ignores the collapsed-chain filter only.
---@param name string
---@param tooltip? string
function KAF_CatChain(name, tooltip)
    return NewCategory(name, IGNORE_CHAIN, tooltip)
end

---Category that ignores the faction filter only.
---@param name string
---@param tooltip? string
function KAF_CatFaction(name, tooltip)
    return NewCategory(name, IGNORE_FACTION, tooltip)
end

---Category with no filter opt-outs.
---@param name string
---@param tooltip? string
function KAF_CatPlain(name, tooltip)
    return NewCategory(name, 0, tooltip)
end

---Attaches a KAF_Cat child to parent and returns the child.
---@param parent table
---@param name string
---@param tooltip? string
function KAF_Sub(parent, name, tooltip)
    local child = KAF_Cat(name, tooltip)
    parent:Insert(child)
    return child
end
