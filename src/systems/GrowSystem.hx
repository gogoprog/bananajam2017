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
    private var tree:Entity;

    public function new()
    {
        super(GrowerNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;
        tree = cast engine.getEntityByName("tree");
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
            e.add(new Shaker(1, true, 10, 0.1));

            var treeShaker:Shaker;

            if(tree.has(Shaker))
            {
                treeShaker = tree.get(Shaker);
                treeShaker.duration += 0.15;
            }
            else
            {
                treeShaker = new Shaker(0.15, false, 0.9, 0.01);
                tree.add(treeShaker);
            }
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
