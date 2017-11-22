-- localization module
-- your fonts need to have the characters for the languages you want support!!

-- todo - 
-- make batched set text function based on list

local M = {}

M.language = nil
M.default_language = "en"
M.language_list = {en = "en"}
M.initilized = false

M.locale_data = {}

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
	if next(M.locale_data) == nil then
		print("DefGlot: You have not set any language data. Check the example.")
	end
	
	local text = M.locale_data[M.language][key]
	if text == nil then
		print(key .. " is missing for " .. M.language )
		return M.locale_data.en.MISSING_KEY .. key
	else
		return text
	end
end

function M.autofit_text(node)
	local text_metrics = gui.get_text_metrics_from_node(node)
	local scale = math.min(1, gui.get_size(node).x / text_metrics.width)
	gui.set_scale(node, vmath.vector3(scale, scale, scale))
end


function M.set_text(node, key)
	if M.initilized == false then 
		print("DefGlot: You should init DefGlot with defglot.init() in your GUI's init!")
	end
	if key == nil then
		local node_text_key = gui.get_text(node)
		gui.set_text(node,M.get_text(node_text_key))
	else
		gui.set_text(node,M.get_text(key))
	end
	M.autofit_text(node)
end




return M