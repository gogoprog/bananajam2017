import gengine.*;
import gengine.math.*;
import systems.*;
import components.*;

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

        var e:Entity;

        e = createSpawner();
        engine.addEntity(e);
        e.position = new Vector3(-200, 200, 0);

        e = createSpawner();
        engine.addEntity(e);
        e.position = new Vector3(200, 200, 0);
    }

    private static function createSpawner():Entity
    {
        var e = new Entity();
        e.add(new Spawner());
        return e;
    }
}
