local function Event(event, handler)
    if _G.event == nil then
        _G.event = CreateFrame("Frame")
        _G.event.handler = {}
        _G.event.OnEvent = function(frame, event, ...)
            for key, handler in pairs(_G.event.handler[event]) do
                handler(...)
            end
        end
        _G.event:SetScript("OnEvent", _G.event.OnEvent)
    end
    if _G.event.handler[event] == nil then
        _G.event.handler[event] = {}
        _G.event:RegisterEvent(event)
    end
    table.insert(_G.event.handler[event], handler)
end

local function HookFormatNumber()
    Skada.FormatNumber = function(self, number)
       if number then
		if self.db.profile.numberformat == 1 then
			if number > 100000000 then
				return ("%02.3f亿"):format(number / 100000000)
			elseif number > 10000 then
				return ("%02.2f万"):format(number / 10000)
			elseif number > 1000 then
				return ("%02.1f千"):format(number / 1000)
			end
		end
		return math.floor(number)
	end
    end
end

Event("PLAYER_ENTERING_WORLD", function()
    HookFormatNumber()
end)
-- 隐藏玩家头像伤害治疗数字
PlayerFrame:UnregisterEvent("UNIT_COMBAT")
--隐藏宠物头像伤害治疗数字
PetFrame:UnregisterEvent("UNIT_COMBAT")
--鼠标提示信息跟随鼠标锚点
hooksecurefunc("GameTooltip_SetDefaultAnchor", function (t,p)t:SetOwner(p, "ANCHOR_CURSOR_RIGHT", 40, -120)end)
-- 鼠标提示名字染色
function GameTooltip_UnitColor(unit)
	local r, g, b
	local reaction = UnitReaction(unit, "player")
	if reaction then
		r = FACTION_BAR_COLORS[reaction].r
		g = FACTION_BAR_COLORS[reaction].g
		b = FACTION_BAR_COLORS[reaction].b
	else
		r = 1.0
		g = 1.0
		b = 1.0
	end

	if UnitIsPlayer(unit) then
		local class = select(2, UnitClass(unit))
		r = RAID_CLASS_COLORS[class].r
		g = RAID_CLASS_COLORS[class].g
		b = RAID_CLASS_COLORS[class].b
	end
	return r, g, b
end

