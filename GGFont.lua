-- Project: GGFont
--
-- Date: December 18, 2012
--
-- File name: GGFont.lua
--
-- Author: Graham Ranson of Glitch Games - www.glitchgames.co.uk
--
-- Comments: 
-- 
--		GGFonts makes it easy to work with custom fonts across both iOS and Android by
--		taking away the need to know which platform your app is on.	
--
-- Copyright (C) 2012 Graham Ranson, Glitch Games Ltd.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this 
-- software and associated documentation files (the "Software"), to deal in the Software 
-- without restriction, including without limitation the rights to use, copy, modify, merge, 
-- publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
-- to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or 
-- substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.
--
----------------------------------------------------------------------------------------------------

local GGFont = {}
local GGFont_mt = { __index = GGFont }

local widget = require( "widget" )
local find = string.find

--- Initiates a new GGFont object.
-- @return The new object.
function GGFont:new()
    
    local self = {}
    
    setmetatable( self, GGFont_mt )
    
    self.fonts = {}
    
    return self
    
end

--- Adds a font to the system.
-- @param name The name of the font that you will use in your app.
-- @param ios The name of the actual font.
-- @param android The name of the file including the extension.
function GGFont:add( name, ios, android )
	self.fonts[ name ] = { ios = ios, android = android }
end

--- Gets a font from the system.
-- @param name The name of the font.
-- @param platform The name of platform to retrieve. Optional, defaults to system.getInfo( "platformName" )
-- @return The font.
function GGFont:get( name, platform )

	if not platform then
		platform = system.getInfo( "platformName" )		
	end	
	
	if platform == "Android" then
		platform = "android"
	else
		platform = "ios"
	end
	
	return self.fonts[ name ][ platform ]
	
end

--- Gets a key/value list of all fonts in the system.
-- @param platform The name of platform to retrieve. Optional, defaults to system.getInfo( "platformName" )
-- @return The list of fonts.
function GGFont:getAll( platform )
	local fonts = {}
	for k, v in pairs( self.fonts ) do
		fonts[ k ] = self:get( k, platform )
	end
	return fonts
end

--- Gets an indexed list of all fonts in the system.
-- @param platform The name of platform to retrieve. Optional, defaults to system.getInfo( "platformName" )
-- @return The list of fonts.
function GGFont:getAllIndexed( platform )
	local fonts = self:getAll( platform )
	local indexedFonts = {}
	for k, v in pairs( fonts ) do
		indexedFonts[ #indexedFonts + 1 ] = v
	end
	return indexedFonts
end

--- Displays a list of fonts in a scrollable display object.
-- @param fonts The indexed list of fonts.
function GGFont:displayFonts( fonts )

	if not fonts then
		return
	end
	
	local foundCount = #fonts
	local group = display.newGroup()
	local fontGroup = display.newGroup()
	
	local options = 
	{
		left = 0,
		top = 0,
		width = 320,
		height = display.contentHeight,
		bgColor = {0},
		hideScrollBar = false,
		hideBackground = false,
		friction = 0.965,
		scrollWidth = 320,
		scrollHeight = display.contentHeight
	}
	
	local fontList = widget.newScrollView( options )
	
	fontList:setReferencePoint( display.TopLeftReferencePoint )
	fontList.x = 0
	fontList.y = 0
	group:insert( fontList )
	
	for i, fontName in ipairs( fonts ) do
		local fontName = display.newText( fontName, 10, ( i - 1 ) * 26, fontName, 14 )
		fontGroup:insert( fontName )
		fontName:setTextColor( 255, 255, 255 )
	end
	
	fontList:insert( fontGroup )
	
	return fontList
	
end

--- Gets an indexed list of all fonts on the device regardless of whether they have been added to the system or not.
-- @param letterOrFamily A string to search for fonts based on. Optional, defaults to an empty string.
-- @return The list of fonts.
function GGFont:getDeviceFonts( letterOrFamily )
        
	local allFonts = native.getFontNames()
	
	local foundFonts = {}
	local searchString = letterOrFamily or "" 
	
	local j, k
	
	for i, fontName in ipairs( allFonts ) do
		
		j, k = find( fontName, searchString )
		
		if j ~= nil then
			foundFonts[ #foundFonts + 1 ] = fontName
		end
		
	end
	
	return foundFonts
	
end

--- Destroys this GGFont object.
function GGFont:destroy()
	self.fonts = nil
end

return GGFont