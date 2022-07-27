GameStateManager = {}
GameStateManager.__init = GameStateManager
GameStateManager.GameStates = {
    PLAYING = 1,
    TITLESCREEN = 0
}

function GameStateManager.changeGameState(newState)
    if newState == GameStateManager.GameStates.PLAYING then
        GameStateManager.currentState = GameStateManager.GameStates.PLAYING
        playdate.inputHandlers.push(Handlers.playing)
        PlayingView.setup()
    elseif newState == GameStateManager.GameStates.TITLESCREEN then
        GameStateManager.currentState = GameStateManager.GameStates.TITLESCREEN
        playdate.inputHandlers.push(Handlers.mainMenu)
        TitleView.setup()
    end
end

GameStateManager.changeGameState(GameStateManager.GameStates.TITLESCREEN)
