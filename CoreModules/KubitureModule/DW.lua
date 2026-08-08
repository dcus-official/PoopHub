--[[

 _          _     _ _                                      _       _      
| | ___   _| |__ (_) |_ _   _ _ __ ___ _ __ ___   ___   __| |_   _| | ___ 
| |/ / | | | '_ \| | __| | | | '__/ _ \ '_ ` _ \ / _ \ / _` | | | | |/ _ \
|   <| |_| | |_) | | |_| |_| | | |  __/ | | | | | (_) | (_| | |_| | |  __/
|_|\_\\__,_|_.__/|_|\__|\__,_|_|  \___|_| |_| |_|\___/ \__,_|\__,_|_|\___|
                                                                          
                                    By iksuwu                                  
                                                                          

]]
-- Web Downloader Module
local Downloader = {}
local DW = _G.Dw
local DL = Downloader

if DW then
	DW.GetCustom = function(path)
		local s, r = pcall(function()
			return getcustomasset(path)
		end)
		if not s and DW.Debug then
			print("[DW Loader] " .. r)
		end
		return s and r or nil
	end

	DW.makefolder = function(folder)
		local s, r = pcall(function()
			makefolder(folder)
		end)
		if not s and DW.Debug then
			print("[DW Loader] " .. r)
		end
	end

	DW.makefile = function(path, content)
		local s, r = pcall(function()
			makefile(path, content)
		end)
		if not s and DW.Debug then
			print("[DW Loader] " .. r)
		end
	end

	DW.isfile = function(path)
		local s, r = pcall(function()
			return isfile(path)
		end)
		return s and r or false
	end

	DW.isfolder = function(path)
		local s, r = pcall(function()
			return isfolder(path)
		end)
		return s and r or false
	end
end

function DL:download(pathfol, pathfi, url)
	if not pathfol or not pathfi or not url then
		print("[DW Loader] Path not found! pls setting first!")
		return
	end

	if not DW.isfolder(pathfol) then
		DW.makefolder(pathfol)
	end

	if not DW.isfile(pathfol .. pathfi) then
		local s, r = pcall(function()
			return game:HttpGetAsync(url)
		end)
		if not s and DW.Debug then
			print("[DW Loader] " .. r)
		end
		if s and r then
			DW.makefile(pathfol .. pathfi, r)
		end
	else
		if DW.Debug then
			print("[DW Loader] File already exist!")
		end
	end

	return DW.GetCustom(pathfol .. pathfi)
end

return Downloader
