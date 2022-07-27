Handlers = {}
Handlers.__index = Handlers

Handlers.mainMenu = {
    AButtonDown = function()
        if TitleView.context.mainMenu:getOptionAtSelected() == TitleView.context.mainMenuOpts[1] then
            AudioEngine.playNote("C4", 0.75, 0.1)
            GameStateManager.changeGameState(GameStateManager.GameStates.PLAYING)
        end
    end,

    rightButtonDown = function()
        AudioEngine.playNote("F6", 0.8, 0.05)
        TitleView.context.mainMenu:selectNext(true)
    end,

    leftButtonDown = function()
        AudioEngine.playNote("F6", 0.8, 0.05)
        TitleView.context.mainMenu:selectPrevious(true)
    end
}

Handlers.playing = {
    AButtonDown = function()
    end,

    BButtonDown = function()
    end,

    rightButtonDown = function()
    end,

    leftButtonDown = function()
    end
}
