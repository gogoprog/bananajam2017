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
            node.spawner.timeLeft = Math.random() + 0.5;
            spawn(node.entity.position);
        }
    }

    private function onNodeAdded(node:SpawnerNode)
    {
        node.spawner.time = 0;
        node.spawner.timeLeft = 1;
    }

    private function onNodeRemoved(node:SpawnerNode)
    {
    }

    private function spawn(position:Vector3):Void
    {
        var e = new Entity();
        e.add(new StaticSprite2D());
        e.add(new Fall());
        e.get(StaticSprite2D).setSprite(Gengine.getResourceCache().getSprite2D("banana.png", true));
        e.scale = new Vector3(0.25, 0.25, 0.25);
        e.position = position;
        engine.addEntity(e);
    }
}
