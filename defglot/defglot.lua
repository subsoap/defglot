-- localization module
-- your fonts need to have the characters for the languages you want support!!

-- todo - 
-- make batched set text function based on list

local M = {}

M.language = nil
M.default_language = "en"
M.language_list = {en = "en"}
M.initilized = false
M.use_default_if_missing = false

M.locale_data = {}

local function is_gui_context()
	if pcall(gui.hide_keyboard) then
		return true
	else
		return false
	end
end

function M.init()
	local language = M.language or sys.get_sys_info().language
	if M.language_list[language] then
		M.language = language or M.default_langauge
	else
		M.language = M.default_language
	end
	M.initilized = true
end

function M.get_langauge()
	return M.langauge
end

function M.get_text(key)
	print(is_gui_context())
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

function M.autofit_text(node)
	local text_metrics = gui.get_text_metrics_from_node(node)
	local scale = math.min(1, gui.get_size(node).x / text_metrics.width)
	gui.set_scale(node, vmath.vector3(scale, scale, scale))
end


function M.set_text(target, key)
	if M.initilized == false then 
		print("DefGlot: You should init DefGlot with defglot.init() in your GUI's init!")
	end
	
	if is_gui_context() then
	
		if key == nil then -- set text based on current text of label
			local node_text_key = gui.get_text(target)
			gui.set_text(target,M.get_text(node_text_key))
		else -- set text based on passed key value
			gui.set_text(target,M.get_text(key))
		end
		M.autofit_text(target)
	else
		print("How?")
		if key == nil then
			print("DefGlot: You must always pass a key when setting GO label text as there is currently no label.get_text")
			label.set_text(target, "YOU MUST SET WITH A KEY!")
		else
			label.set_text(target, M.get_text(key))
		end
		
	end
end




return M