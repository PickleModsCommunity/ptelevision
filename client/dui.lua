function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end

function RequestTextureDictionary(dict)
	RequestStreamedTextureDict(dict)
	while not HasStreamedTextureDictLoaded(dict) do Wait(0) end
	return dict
end

function LoadModel(model)
	if not IsModelInCdimage(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	return model
end

function RenderScaleformTV(renderTarget, scaleform, entity)
	SetTextRenderId(renderTarget) -- set render target
	-- call the available 2d layer function if present (different runtimes may expose different names)
	if Set2dLayer then
		Set2dLayer(4)
	elseif Set_2dLayer then
		Set_2dLayer(4)
	end

	-- call the correctly-cased pause-menu draw function if available, with fallbacks
	if SetScriptGfxDrawBehindPauseMenu then
		SetScriptGfxDrawBehindPauseMenu(true)
	elseif SetScriptGfxDrawBehindPausemenu then
		SetScriptGfxDrawBehindPausemenu(1)
	end

	--DrawRect(0.5, 0.5, 1.0, 0.5, 255, 0, 0, 255); -- WOAH!
	local coords = GetEntityCoords(entity)
	local rot = GetEntityRotation(entity)
	DrawSprite("ptelevision_b_dict", "ptelevision_b_txd", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)

	SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- reset

	if SetScriptGfxDrawBehindPauseMenu then
		SetScriptGfxDrawBehindPauseMenu(false)
	elseif SetScriptGfxDrawBehindPausemenu then
		SetScriptGfxDrawBehindPausemenu(0)
	end
end

