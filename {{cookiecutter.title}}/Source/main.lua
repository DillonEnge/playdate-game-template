import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/animation"

local gfx = playdate.graphics
local snd = playdate.sound

local menu = playdate.getSystemMenu()

gfx.setColor(gfx.kColorBlack)
gfx.setBackgroundColor(playdate.graphics.kColorClear)

local showFrameRate = false

local mainInstrument = nil
local mainChannel = nil
local gameStartSequence = nil
local gameWonSequence = nil
local gameLossSequence = nil

local dataStore = nil

local mainBlinker = nil

local gameStarted = false
local gameOver = false

local screenWidth = 400
local screenHeight = 240

local mainFont = gfx.font.new("Fonts/Bongo-auto-16")

local backgroundImage = nil

function gameSetUp()
    math.randomseed(playdate.getSecondsSinceEpoch())

	setupAudio()

    dataStore = playdate.datastore.read()

    mainBlinker = playdate.graphics.animation.blinker.new()

    mainBlinker.offDuration = 300
    mainBlinker.onDuration = 400

    mainBlinker:startLoop()


    gfx.setFont(mainFont)

    backgroundImage = gfx.image.new( "Images/placeholder.png" )
    assert( backgroundImage )

    playdate.ui.crankIndicator:start()
end

function setupAudio()
    local genericSawSynth = snd.synth.new(snd.kWaveSawtooth)

    genericInstrument = snd.instrument.new(genericSawSynth)

    mainChannel = snd.channel.new()

    mainChannel:addSource(genericInstrument)

    local bitcrusherEffect = snd.bitcrusher.new()
    bitcrusherEffect:setAmount(1)
    bitcrusherEffect:setUndersampling(1)

    mainChannel:addEffect(bitcrusherEffect)

    local gameStartTrack = snd.track.new()
    local gameLossTrack = snd.track.new()
    local gameWonTrack = snd.track.new()

    gameStartTrack:setInstrument(genericInstrument)
    gameWonTrack:setInstrument(genericInstrument)
    gameLossTrack:setInstrument(genericInstrument)

    gameStartTrack:addNote(1, "C4", 1)
    gameStartTrack:addNote(2, "D4", 1)
    gameStartTrack:addNote(3, "C5", 2)

    gameWonTrack:addNote(1, "C4", 1)
    gameWonTrack:addNote(2, "E4", 1)
    gameWonTrack:addNote(3, "G4", 1)
    gameWonTrack:addNote(4, "C5", 5)

    gameLossTrack:addNote(1, "C5", 1)
    gameLossTrack:addNote(2, "D4", 1)
    gameLossTrack:addNote(3, "C3", 2)

    gameStartSequence = snd.sequence.new()
    gameWonSequence = snd.sequence.new()
    gameLossSequence = snd.sequence.new()

    gameStartSequence:addTrack(gameStartTrack)
    gameWonSequence:addTrack(gameWonTrack)
    gameLossSequence:addTrack(gameLossTrack)

    gameStartSequence:setTempo(6)
    gameWonSequence:setTempo(6)
    gameLossSequence:setTempo(3)
end

function processInput()
end

function drawTitleScreen()
end

function drawHUD()
end

function resetGame()
    setupAudio()

    gameOver = false
end

function debugPrint(str)
    if playdate.isSimulator then
        print(str)
    end
end

function processGameLogic()
end

function setupGameScreen()
    gameStarted = true

    gameStartSequence:play()
end

function playdate.cranked(change, acceleratedChange)
end

function playdate.crankUndocked()
    setupGameScreen()
end

gameSetUp()

function playdate.update()
    gfx.fillRect(0, 0, screenWidth, screenHeight)

    if not gameStarted then
        drawTitleScreen()
    else
        drawHUD()
        processGameLogic()
    end

    if (playdate.isSimulator and showFrameRate) then
        playdate.drawFPS(0,0)
    end

    processInput()

    if (playdate.isCrankDocked() and not gameStarted) then
        playdate.ui.crankIndicator:update()
    end
    if (gfx.sprite.spriteCount() > 0) then
        gfx.sprite.update()
    end

    playdate.graphics.animation.blinker.updateAll()

    playdate.timer.updateTimers()
end
