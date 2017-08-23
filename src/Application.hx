import gengine.*;
import gengine.math.*;
import systems.*;

class ExitSystem extends System
{
    public function new()
    {
        super();
    }

    override public function update(dt:Float):Void
    {
        if(Gengine.getInput().getScancodePress(41))
        {
            Gengine.exit();
        }
    }
}

class Application
{
    public static function init()
    {
        Gengine.setWindowSize(new IntVector2(512, 512));
        Gengine.setWindowTitle("bananajam2017");
    }

    public static function start(engine:Engine)
    {
        engine.addSystem(new ExitSystem(), 0);
        engine.addSystem(new FallSystem(), 0);
        engine.addSystem(new SpawnSystem(), 0);

        Gengine.getRenderer().getDefaultZone().setFogColor(new Color(1,1,1,1));
    }
}
