GGFont
============

GGFonts makes it easy to work with custom fonts across both iOS and Android by
taking away the need to know which platform your app is on.

Basic Usage
-------------------------

##### Require the code
```lua
local GGFont = require( "GGFont" )
```

##### Create your font manager
```lua
local fontManager = GGFont:new()
```

##### Create and add a language
```lua
local language = {}
language.name = "english"
language.strings = {}
language.strings[ "greeting" ] = "Hello"

dictionary:addLanguage( language )
```

##### Add a font passing in a name for you to use, the actual name of the font ( for iOS ) and the font file ( for Android )
```lua
fontManager:add( "Menu", "Silkscreen", "slkscr.ttf" )
```

##### Get a font to be used in a text object ( platform will be worked out for you )
```lua
local font = fontManager:get( "Menu" )
display.newText( "Hello, World!", 0, 0, font, 20 )
```

##### Get a font to be used in a text object passing in an explicit platform name
```lua
local font = fontManager:get( "Menu", "Android" )
display.newText( "Hello, World!", 0, 0, font, 20 )
```

##### Get a key/value list of all fonts added to the system
```lua
local all = fontManager:getAll()
local ios = fontManager:getAll( "ios" )
```

##### Get an indexed list of all fonts added to the system
```lua
local all = fontManager:getAllIndexed()
local ios = fontManager:getAllIndexed( "ios" )
```

##### Get a list of ALL fonts on the system, regardless of whether they have been added to the font manager or not. Thanks go to lano78 on the Corona forums for this!
```lua
local fonts = fontManager:getDeviceFonts()
```

##### Get a list of ALL fonts on the system that contain a passed in string. Thanks go to lano78 on the Corona forums for this!
```lua
local helveticaFamily = fontManager:getDeviceFonts( "Helvetica" )
```

##### Display the fonts in a scrolling list. Thanks go to lano78 on the Corona forums for this!
```lua
local list = fontManager:displayFonts( fontManager:getAllIndexed() )

local list = fontManager:displayFonts( fontManager:getDeviceFonts() )

-- Don't forget to destroy the list
list:removeSelf()
list = nil
```

##### Destroy the font manager
```lua
fontManager:destroy()
fontManager = nil
```