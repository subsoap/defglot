-- localization module
-- your fonts need to have the characters for the languages you want support!!

-- todo - 
-- make batched set text function based on list

local M = {}

M.language = nil
M.default_language = "en"
M.language_list = {"en"}

M.languages = require("game.locale.main_locale")

function M.init()
	local language = sys.get_sys_info().language
	if M.language_list[language] then
		M.language = language or M.default_langauge
	else
		M.language = M.default_language
	end
end

function M.get_langauge()
	return M.langauge
end

function M.get_text(key)
	local text = M.languages[M.language][key]
	print(text)
	if text == nil then
		print(key .. " is missing!!!")
		return M.languages.en.MISSING_KEY .. key
	else
		return text
	end
	--return M.languages[M.language][key] or M.languages.en.MISSING_KEY .. key
end

function M.autofit_text(node)
	local text_metrics = gui.get_text_metrics_from_node(node)
	local scale = math.min(1, gui.get_size(node).x / text_metrics.width)
	gui.set_scale(node, vmath.vector3(scale, scale, scale))
end


function M.set_text(node)
	local node_text_key = gui.get_text(node)
	gui.set_text(node,M.get_text(node_text_key))
	M.autofit_text(node)
end




return M