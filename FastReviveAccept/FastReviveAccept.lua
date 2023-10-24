local L = LibStub("AceLocale-3.0"):GetLocale("FastReviveAccept", false)

print(L["loading"])

local Addonloadframe = CreateFrame("Frame", nil, UIParent);
Addonloadframe:RegisterEvent("ADDON_LOADED")
Addonloadframe:RegisterEvent("PLAYER_LOGOUT")
Addonloadframe:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "FastReviveAccept" then
		if FRAPartyAutoRes == nil and FRARaidAutoRes == nil then
			FRAPartyAutoRes = true
			FRARaidAutoRes = true
			print(L["settingsdefault"])
		else
			print(L["settingsloaded"])
			if FRAPartyAutoRes == true then
				print(L["enpartties"])
			else
				print(L["disparties"])
			end
			if FRARaidAutoRes == true then
				print(L["enraid"])
			else
				print(L["disraid"])
			end
			
		end
	elseif event == "PLAYER_LOGOUT" then
		print("")
	end 
end)
print(L["commands"])
local frame = CreateFrame("Frame", nil, UIParent);
frame:RegisterEvent("RESURRECT_REQUEST");
frame:SetScript("onEvent",function(self, event, name)
	if IsInGroup() and not IsInRaid() then 
		if FRAPartyAutoRes == true then
			print(L["resurrection"].. name .. " .")
			HideUIPanel(StaticPopup1);
			AcceptResurrect();
			SendChatMessage(L["thxwhisper"], "WHISPER", nil, name);
			C_Timer.After(1, function(self, event, arg1)
				SendChatMessage(L["Resurrectedby"].. name .." !", "PARTY", nil, nil);
			end)
		else
			print(L["disparties"])
		end
	elseif IsInRaid() then 
		if FRARaidAutoRes == true then
			print(L["resurrection"].. name .. " .")
			HideUIPanel(StaticPopup1);
			AcceptResurrect();
			SendChatMessage(L["thxwhisper"], "WHISPER", nil, name);
			C_Timer.After(1, function(self, event, arg1)
				SendChatMessage(L["Resurrectedby"].. name .." !", "YELL", nil, nil);
			end)
		else
			print(L["disraid"])
		end
	else 
		print(L["resurrection"].. name .. " .")
		HideUIPanel(StaticPopup1);
		AcceptResurrect();
		SendChatMessage(L["thxwhisper"], "WHISPER", nil, name);
	end
end);
SLASH_FRA1 = "/FRA"
function SlashCmdList.FRA(msg)
    if msg == "raid" then 
		if FRARaidAutoRes == true then 
			FRARaidAutoRes = false
			print(L["disraid"])
		else 
			FRARaidAutoRes = true
			print(L["enraid"])
		end
	elseif msg == "party" then
		if FRAPartyAutoRes == true then 
			FRAPartyAutoRes = false
			print(L["disparties"])
		else
			FRAPartyAutoRes = true 
			print(L["enpartties"])
		end
	else
		print(L["commandtoggle"])
	end
end
