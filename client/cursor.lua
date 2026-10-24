local scale = 1.5;
local screenWidth = math.floor(1920 / scale);
local screenHeight = math.floor(1080 / scale);
shouldDraw = false;
function SetInteractScreen(bool)
	if not shouldDraw and bool then
		shouldDraw = bool;
		Citizen.CreateThread(function()
			local nX = 0;
			local nY = 0;
			local w, h = screenWidth, screenHeight;
			local minX, maxX = (w - w / 2) / 2, w - w / 4;
			local totalX = minX - maxX;
			local minY, maxY = (h - h / 2) / 2, h - h / 4;
			local totalY = minY - maxY;
			RequestTextureDictionary("fib_pc");
			while shouldDraw do
				nX = GetControlNormal(0, 239) * screenWidth;
				nY = GetControlNormal(0, 240) * screenHeight;
				DisableControlAction(0, 1, true);
				DisableControlAction(0, 2, true);
				DisablePlayerFiring(PlayerPedId(), true);
				DisableControlAction(0, 142, true);
				DisableControlAction(0, 106, true);
				DrawSprite("ptelevision_b_dict", "ptelevision_b_txd", 0.5, 0.5, 0.5, 0.5, 0, 255, 255, 255, 255);
				if nX ~= mX or nY ~= mY then
					mX = nX;
					mY = nY;
					local duiX = (-screenWidth) * ((mX - minX) / totalX);
					local duiY = (-screenHeight) * ((mY - minY) / totalY);
					BlockWeaponWheelThisFrame();
					if not (mX > 325) then
						mX = 325;
					end;
					if not (mX < 965) then
						mX = 965;
					end;
					if not (mY > 185) then
						mY = 185;
					end;
					if not (mY < 545) then
						mY = 545;
					end;
					if not duiObj then
						print("No Dui Object found.");
					else
						SendDuiMouseMove(duiObj, math.floor(duiX), math.floor(duiY));
					end;
				end;
				DrawSprite("fib_pc", "arrow", mX / screenWidth, mY / screenHeight, 0.005, 0.01, 0, 255, 255, 255, 255);
				if IsControlPressed(0, 177) then
					SetInteractScreen(false);
					OpenTVMenu();
				end;
				if IsControlPressed(0, 172) then
					if not duiObj then
						print("No Dui Object found.");
					else
						SendDuiMouseWheel(duiObj, 10, 0);
					end;
				end;
				if IsControlPressed(0, 173) then
					if not duiObj then
						print("No Dui Object found.");
					else
						SendDuiMouseWheel(duiObj, -10, 0);
					end;
				end;
				if IsDisabledControlJustPressed(0, 24) then
					if not duiObj then
						print("No Dui Object found.");
					else
						SendDuiMouseDown(duiObj, "left");
					end;
				elseif IsDisabledControlJustReleased(0, 24) then
					if not duiObj then
						print("No Dui Object found.");
					else
						SendDuiMouseUp(duiObj, "left");
						SendDuiMouseUp(duiObj, "right");
					end;
				end;
				if IsDisabledControlJustPressed(0, 25) then
					if not duiObj then
						print("No Dui Object found.");
					else
						SendDuiMouseDown(duiObj, "right");
					end;
				elseif IsDisabledControlJustReleased(0, 25) then
					if not duiObj then
						print("No Dui Object found.");
					else
						SendDuiMouseUp(duiObj, "right");
					end;
				end;
				Wait(0);
			end;
		end);
	else
		shouldDraw = bool;
	end;
end;
