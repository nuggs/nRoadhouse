local class = select(2,UnitClass("player"))
local kick = GetSpellInfo(1766)
local spearhand = GetSpellInfo(116705)

local nRoadhouse = CreateFrame("Frame")
local player = UnitGUID("player")

function nRoadhouse:PLAYER_LOGIN()
	nRoadhouse:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	nRoadhouse:UnregisterEvent("PLAYER_LOGIN");
end

function nRoadhouse:COMBAT_LOG_EVENT_UNFILTERED(...)
	local _, event, _, guid, _, _, _, _, _, destFlags, _, _, spellName = ...

    if event == "PARTY_KILL" and guid == player and bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
		SendChatMessage("Road House", "SAY")
	end

	if event == "SPELL_INTERRUPT" and guid == UnitGUID("player") and (spellName == kick and class == "ROGUE") or (spellName == spearhand and class == "MONK") then
		SendChatMessage("Round House", "SAY")
	end
end

nRoadhouse:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
nRoadhouse:RegisterEvent("PLAYER_LOGIN")