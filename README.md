# DefGlot
A localization module for Defold

Easily support multiple translations of your game.

## Installation
You can use DefGlot in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

	https://github.com/subsoap/defglot/archive/master.zip
  
Once added, you must require the main Lua module in your GUI scripts via

```
local defglot = require("defglot.defglot")
```

Then add your list of languages, language data, init, and set GUI text based on current language.

```
function init(self)
	defglot.language = "ru" -- if you do not define the language DefGlot will attempt to use OS lang
	defglot.language_list.ru = "ru" -- add one or more langauges to in use language list
	defglot.languages = require("example.main_locale") -- this is the locale data
	defglot.init() -- you must init DefGlot so that it can ensure proper setup
	
	defglot.set_text(gui.get_node("btn_start/label"))
	defglot.set_text(gui.get_node("btn_about/label"))
	defglot.set_text(gui.get_node("btn_exit/label"))
	defglot.set_text(gui.get_node("btn_toggle_profiler/label")) 
	-- the toggle profiler text is missing so it will load missing string text in English
end

```