package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import components.*;

import ash.tools.ListIteratingSystem;

class GrowerNode extends Node<GrowerNode>
{
    public var grower:Grower;
}

class GrowSystem extends ListIteratingSystem<GrowerNode>
{
    private var duration = 2.5;
    private var engine:Engine;

    public function new()
    {
        super(GrowerNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;
    }

    private function updateNode(node:GrowerNode, dt:Float):Void
    {
        node.grower.time += dt;

        var f = node.grower.time / duration;
        var s = f * 0.35;

        node.entity.scale = new Vector3(s, s, s);

        if(f > 1)
        {
            var e = node.entity;
            e.remove(Grower);
            e.add(new Shaker());
        }

    }

    private function onNodeAdded(node:GrowerNode)
    {
        node.grower.time = 0;
        node.entity.scale = new Vector3(0.01, 0.01, 0.01);
    }

    private function onNodeRemoved(node:GrowerNode)
    {
    }


}
