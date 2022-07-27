AudioEngine = {}
AudioEngine.__index = AudioEngine

-- AudioEngine is a wrapper object containing all of
-- the necessary functionality from playdate.sound
function AudioEngine.init(synthEngine, legato)
    if not synthEngine then
        synthEngine = Snd.kWaveSine
    end
    if not legato then
        legato = false
    end

    local mainChannel = Snd.channel.new()
    local mainSynth = Snd.synth.new(synthEngine)
    local mainInstrument = Snd.instrument.new(mainSynth)

    mainChannel:addSource(mainInstrument)
    --mainChannel:addEffect(effect)

    AudioEngine.instrument = mainInstrument
    AudioEngine.channel = mainChannel
    AudioEngine.sequences = {}

    -- Plays a single note utilizing the mainSynth
    function AudioEngine.playNote(note, volume, duration)
        AudioEngine.instrument:playNote(note, volume, duration)
    end

    -- Add a track (sequence) to the base obj AudioEngine
    -- note: timingTable must be whole integers
    function AudioEngine.addTrack(trackName, noteTable, timingTable, tempo)
        local newTrack = Snd.track.new()

        newTrack:setInstrument(AudioEngine.instrument)

        if #noteTable ~= #timingTable then
            error("noteTable must be the same length as timingTable")
        end

        for i, v in ipairs(noteTable) do
            newTrack:addNote(i, v, timingTable[i])
        end

        local newSeq = Snd.sequence.new()

        newSeq:addTrack(newTrack)
        newSeq:setTempo(tempo)

        AudioEngine.sequences[trackName] = newSeq
    end

    -- Plays the provided track name given the track exists
    function AudioEngine.playTrack(trackName)
        if not AudioEngine.sequences[trackName] then
            error(string.format("trackName %s not found", trackName))
        end

        AudioEngine.sequences[trackName]:play()

        return AudioEngine.sequences[trackName]:isPlaying()
    end
end
