package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import systems.*;
import components.*;
import ash.tools.ListIteratingSystem;

class SpawnerNode extends Node<SpawnerNode>
{
    public var spawner:Spawner;
}

class SpawnSystem extends ListIteratingSystem<SpawnerNode>
{
    private var time:Float = 0;
    private var timeLeft:Float = 0;
    private var engine:Engine;

    public function new()
    {
        super(SpawnerNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;

    }

    private function updateNode(node:SpawnerNode, dt:Float):Void
    {
        node.spawner.time += dt;
        node.spawner.timeLeft -= dt;
        if(node.spawner.timeLeft <= 0)
        {
            node.spawner.timeLeft = Math.random() * 2 + 3.5;
            spawn(node.entity.position);
        }
    }

    private function onNodeAdded(node:SpawnerNode)
    {
        node.spawner.time = 0;
        node.spawner.timeLeft = Math.random() * 2;
    }

    private function onNodeRemoved(node:SpawnerNode)
    {
    }

    private function spawn(position:Vector3):Void
    {
        var e = new Entity();
        e.add(new Banana());
        e.add(new StaticSprite2D());
        e.add(new Grower());
        var ss:StaticSprite2D = e.get(StaticSprite2D);
        ss.setSprite(Gengine.getResourceCache().getSprite2D("banana.png", true));
        ss.setLayer(2);
        ss.setUseHotSpot(true);
        ss.setHotSpot(new Vector2(0.5, 1));
        e.scale = new Vector3(0.25, 0.25, 0.25);
        e.position = position;
        engine.addEntity(e);

        if(Std.random(10) < 2)
        {
            e.get(Banana).good = false;
            e.get(StaticSprite2D).setColor(new Color(0.9, 0.1, 0.2, 1));
        }
    }
}
