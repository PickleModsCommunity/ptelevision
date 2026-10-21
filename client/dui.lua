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

function RenderScaleformTV(renderTarget, scaleform, entity)
    SetTextRenderId(renderTarget)
    SetScriptGfxDrawOrder(4)
    SetScriptGfxDrawBehindPausemenu(true)
    DrawSprite("ptelevision_b_dict", "ptelevision_b_txd", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
    SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    SetScriptGfxDrawBehindPausemenu(false)
end

