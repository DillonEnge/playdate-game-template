TitleView = {}
TitleView.__index = TitleView
TitleView.context = {}

function TitleView.setup()
    local menuHeight = 30
    local menuWidth = ScreenWidth - 40
    local mainMenuOpts = { "Play Game", "High Scores" }

    AudioEngine.init()

    TitleView.context.mainMenu = Menu:new(
        20, 180,
        menuWidth, menuHeight,
        nil,
        { 10, 10, 0, 0 },
        true,
        mainMenuOpts,
        nil,
        Menu.HORIZONTAL
    )
    TitleView.context.mainMenuOpts = mainMenuOpts
end

function TitleView.draw()
    TitleView.context.mainMenu:update()
end

PlayingView = {}
PlayingView.__index = PlayingView
PlayingView.context = {}

function PlayingView.setup()
end

function PlayingView.draw()
    Gfx.sprite.update()
end
