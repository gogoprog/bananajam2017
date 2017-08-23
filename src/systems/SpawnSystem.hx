package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import systems.*;
import components.*;

class SpawnSystem extends System
{
    private var time:Float = 0;
    private var timeLeft:Float = 0;
    private var engine:Engine;

    public function new()
    {
        super();
    }

    override public function addToEngine(engine:Engine):Void
    {
        this.engine = engine;
    }

    override public function update(dt:Float):Void
    {
        time += dt;

        timeLeft -= dt;

        if(timeLeft <= 0)
        {
            spawn();
        }
    }

    private function spawn():Void
    {
        var e = new Entity();
        e.add(new StaticSprite2D());
        e.add(new Fall());
        e.get(StaticSprite2D).setSprite(Gengine.getResourceCache().getSprite2D("banana.png", true));
        e.scale = new Vector3(0.25, 0.25, 0.25);
        engine.addEntity(e);
    }
}
