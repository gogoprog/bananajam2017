package systems;

import gengine.*;
import gengine.components.*;
import ash.systems.*;
import components.*;
import gengine.math.*;
import haxe.ds.Vector;

class AudioSystem extends System
{
    static public var instance:AudioSystem;

    private var engine:Engine;
    private var sounds = new Map<String, Dynamic>();
    private var soundSources:Vector<SoundSource>;
    private var musicSource:SoundSource;
    private var nextSoundSourceIndex = 0;
    private var cameraEntity:Entity;

    private function add(name)
    {
        sounds[name] = Gengine.getResourceCache().getSound(name + ".wav", true);
    }

    public function new()
    {
        super();

        add("fall");
        add("pick");
        add("fail");
        add("hurt");

        instance = this;
    }

    override public function addToEngine(_engine:Engine)
    {
        engine = _engine;

        soundSources = new Vector<SoundSource>(32);

        for(i in 0...soundSources.length)
        {
            var e = new Entity();
            soundSources[i] = new SoundSource();
            e.add(soundSources[i]);
            engine.addEntity(e);
        }

        var e = new Entity();
        musicSource = new SoundSource();
        musicSource.setSoundType("Music");
        musicSource.setGain(0.4);
        e.add(musicSource);
    }

    public function playSound(sound:String, ?position:Vector3 = null)
    {
        var ss = soundSources[nextSoundSourceIndex++];
        ss.play1(sounds[sound]);
        ss.setGain(0.7);
        nextSoundSourceIndex %= soundSources.length;
    }

    public function playGameMusic()
    {
        var s = Gengine.getResourceCache().getSound("ramones.ogg", true);
        s.setLooped(true);
        musicSource.play1(s);
    }

    public function playMenuMusic()
    {
        var s = Gengine.getResourceCache().getSound("ramones.ogg", true);
        s.setLooped(true);
        musicSource.play1(s);
    }
}
