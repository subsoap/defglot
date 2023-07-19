-- DefGlot is a localization module for Defold
-- Your fonts need to have the characters for the languages you want support!!


local M = {}

M.language = nil
M.default_language = "en"
M.language_list = {en = "en"}
M.initilized = false
M.use_default_if_missing = false

M.locale_data = {}

local function is_gui_context()
	if pcall(go.get_id) then
		return false
	else
		return true
	end
end

function M.init()
	local language = M.language or sys.get_sys_info().language
	if M.language_list[language] then
		M.language = language
	else
		if M.language_list[M.default_language] then
			M.language = M.default_language
		else
			print("DefGlot: The default language is not in your language list!")
		end
	end
	M.initilized = true
end

function M.get_langauge()
	return M.language
end

function M.get_text(key)
	if next(M.locale_data) == nil then
		print("DefGlot: You have not set any language data. Check the example.")
	end
	
	local text = M.locale_data[M.language][key]
	if text == nil then
		if M.use_default_if_missing then
			text = M.locale_data[M.default_language][key]
			if text ~= nil then
				print("DefGlot: Warning using default for " .. key)
				return text
			else
				print("DefGlot: " .. key .. " is missing for " .. M.language )
				return M.locale_data.en.MISSING_KEY .. key					
			end
		else
			print("DefGlot: " .. key .. " is missing for " .. M.language )
			return M.locale_data.en.MISSING_KEY .. key			
		end

	else
		return text
	end
end

function M.autofit_text(node, set_scale)
	if set_scale == nil then
		set_scale = 1
	end
	local text_metrics = gui.get_text_metrics_from_node(node)
	local scale = math.min(1, gui.get_size(node).x / text_metrics.width)*set_scale
	gui.set_scale(node, vmath.vector3(scale, scale, scale))
end


function M.set_text(target, key, scale)

	if M.initilized == false then 
		print("DefGlot: You should init DefGlot with defglot.init() in your script's init!")
		print("DefGlot: Check the DefGlot example for the defglot_helper.lua usage")
	end
	
	if is_gui_context() then
	
		if key == nil then -- set text based on current text of label
			local node_text_key = gui.get_text(target)
			gui.set_text(target,M.get_text(node_text_key))
		else -- set text based on passed key value
			gui.set_text(target,M.get_text(key))
		end
		M.autofit_text(target, scale)
	else
		if key == nil then
			print("DefGlot: You must always pass a key when setting GO label text as there is currently no label.get_text")
			label.set_text(target, "YOU MUST SET WITH A KEY!")
		else
			label.set_text(target, M.get_text(key))
		end
		
	end
end




return M
