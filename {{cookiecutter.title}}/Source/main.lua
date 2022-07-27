import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/animation"
import "CoreLibs/nineslice"

-- Globals that must be established before local imports
Gfx = playdate.graphics
Geom = playdate.geometry
Snd = playdate.sound

ScreenWidth = 400
ScreenHeight = 240

local mainFont = Gfx.font.new('Fonts/blocky')

mainFont:setTracking(1)
Gfx.setFont(mainFont)

Gfx.setBackgroundColor(Gfx.kColorWhite)
--

import 'testobject'
import 'utils'
import 'tests'
import 'menus'
import 'audio'
import 'views'
import 'handlers'
import 'statemanagers'

--Testing Block
ShouldRunTests = true

if ShouldRunTests then
	for testFunc, _ in pairs(Tests) do
		testFunc()
	end
end
--

function playdate.update()
	playdate.timer.updateTimers()

	if GameStateManager.currentState == GameStateManager.GameStates.TITLESCREEN then
		TitleView.draw()
	elseif GameStateManager.currentState == GameStateManager.GameStates.PLAYING then
		PlayingView.draw()
	end
end
