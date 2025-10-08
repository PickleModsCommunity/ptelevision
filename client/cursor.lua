local scale = 1.5
local screenWidth = math.floor(1920 / scale)
local screenHeight = math.floor(1080 / scale)
local shouldDraw = false
local mX, mY, duiObj = nil, nil, nil

function SetInteractScreen(bool)
    if (not shouldDraw and bool) then 
        shouldDraw = true
        Citizen.CreateThread(function ()
            -- Create screen
            local nX = 0
            local nY = 0
            
            local w, h = screenWidth, screenHeight
                
            local minX, maxX = ((w - (w / 2)) / 2), (w - (w / 4))
            local totalX = maxX - minX
            
            local minY, maxY = ((h - (h / 2)) / 2), (h - (h / 4))
            local totalY = maxY - minY
            
            -- Request and wait for the texture dictionary to be loaded
            RequestStreamedTextureDict('fib_pc', true)
            while not HasStreamedTextureDictLoaded('fib_pc') do
                Wait(0)
            end

            -- Initialize cursor position if needed
            if not mX then mX = math.floor((minX + maxX) / 2) end
            if not mY then mY = math.floor((minY + maxY) / 2) end
            
            -- Update controls while active
            while shouldDraw do
                nX = GetControlNormal(0, 239) * screenWidth
                nY = GetControlNormal(0, 240) * screenHeight
                DisableControlAction(0, 1, true) -- Disable looking horizontally
                DisableControlAction(0, 2, true) -- Disable looking vertically
                DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
                DisableControlAction(0, 142, true) -- Disable aiming
                DisableControlAction(0, 106, true) -- Disable in-game mouse controls

                if nX ~= mX or nY ~= mY then
                    mX = nX; mY = nY
                    local duiX = -screenWidth * ((mX - minX) / totalX)
                    local duiY = -screenHeight * ((mY - minY) / totalY)
                    BlockWeaponWheelThisFrame()

                    -- Clamp cursor to expected bounds
                    mX = math.max(325, math.min(965, mX))
                    mY = math.max(185, math.min(545, mY))

                    if duiObj then
                        SendDuiMouseMove(duiObj, math.floor(duiX), math.floor(duiY))
                    end
                end

                -- Draw the cursor
                DrawSprite('fib_pc', 'arrow', mX / screenWidth, mY / screenHeight, 0.005, 0.01, 0.0, 255, 255, 255, 255)
        
                -- Send scroll and click events to dui
        
                if IsControlPressed(0, 177) then
                    SetInteractScreen(false)
                    OpenTVMenu()
                end -- back / cancel
                if IsControlPressed(0, 172) then
                    if duiObj then SendDuiMouseWheel(duiObj, 10, 0) end
                end -- scroll up
                if IsControlPressed(0, 173) then
                    if duiObj then SendDuiMouseWheel(duiObj, -10, 0) end
                end -- scroll down
        
                -- Map disabled control input events to Dui mouse events
                if IsDisabledControlJustPressed(0, 24) then
                    if duiObj then SendDuiMouseDown(duiObj, 'left') end
                elseif IsDisabledControlJustReleased(0, 24) then
                    if duiObj then SendDuiMouseUp(duiObj, 'left') end
                end

                if IsDisabledControlJustPressed(0, 25) then
                    if duiObj then SendDuiMouseDown(duiObj, 'right') end
                elseif IsDisabledControlJustReleased(0, 25) then
                    if duiObj then SendDuiMouseUp(duiObj, 'right') end
                end
        
                Wait(0)
            end
        end)
    else
        shouldDraw = bool
    end
end
                    if duiObj then SendDuiMouseUp(duiObj, 'left') end
                if IsDisabledControlJustPressed(0, 25) then
                    if duiObj then SendDuiMouseDown(duiObj, "right") end
                elseif IsDisabledControlJustReleased(0, 25) then
                    if duiObj then SendDuiMouseUp(duiObj, "right") end
                end
