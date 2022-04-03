SZKey = _G.wl_key
local PlaceId = game.PlaceId

if PlaceId == 6284583030 or PlaceId == 7722306047 then
        loadstring(game:HttpGet"https://raw.githubusercontent.com/QwertyzSZ/SAZAISBEST/main/PremiumGame/psxPremium.lua")()
else
	game.Players.LocalPlayer:kick("Wrong Game!")
	wait(1)
	game:Shutdown()
end
