local M = {}

function M.init(defglot)

	-- You can use a helper module like this to set up languages in one place
	-- and then not redo init every time everywhere
	-- just run this helper's init before using DefGlot
	-- customize it how you need it to be

	if defglot.initilized == false then
		defglot.language = "en" -- if you don't set a language manually DefGlot will use OS lang
		defglot.languages = require("example.main_locale")
		defglot.init()
		print("DefGlot Helper is initilizing DefGlot")
	end

end


return M