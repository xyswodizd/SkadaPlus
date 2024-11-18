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


