package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import components.*;

import ash.tools.ListIteratingSystem;

class ShakerNode extends Node<ShakerNode>
{
    public var shaker:Shaker;
}

class ShakeSystem extends ListIteratingSystem<ShakerNode>
{
    private var engine:Engine;

    public function new()
    {
        super(ShakerNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;
    }

    private function updateNode(node:ShakerNode, dt:Float):Void
    {
        node.shaker.time += dt;
        node.shaker.timeLeft -= dt;

        if(node.shaker.timeLeft < 0)
        {
            node.shaker.timeLeft = node.shaker.interval;
            node.entity.setRotation2D(node.shaker.intensity * Math.random());
        }

        if(node.shaker.time > node.shaker.duration)
        {
            var e = node.entity;
            e.setRotation2D(0);
            e.remove(Shaker);

            if(node.shaker.fall)
            {
                e.add(new Fall());
            }
        }
    }

    private function onNodeAdded(node:ShakerNode)
    {
        node.shaker.time = 0;
        node.shaker.timeLeft = 0.1;
    }

    private function onNodeRemoved(node:ShakerNode)
    {
    }


}
