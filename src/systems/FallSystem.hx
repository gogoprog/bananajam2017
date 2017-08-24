package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import components.*;

import ash.tools.ListIteratingSystem;

class FallNode extends Node<FallNode>
{
    public var sprite:StaticSprite2D;
    public var fall:Fall;
}

class FallSystem extends ListIteratingSystem<FallNode>
{
    private var engine:Engine;

    public function new()
    {
        super(FallNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;
    }

    private function updateNode(node:FallNode, dt:Float):Void
    {
        node.fall.time += dt;
        var t = node.fall.time;
        var y = node.fall.startY - 981 * t * t * 0.5;
        var p = node.entity.position;
        node.entity.setPosition(new Vector3(p.x, y, p.z));

        if(y < -256)
        {
            AudioSystem.instance.playSound("fail");
            engine.removeEntity(node.entity);
        }
    }

    private function onNodeAdded(node:FallNode)
    {
        node.fall.startY = node.entity.position.y;
        node.fall.time = 0;
        AudioSystem.instance.playSound("fall");
    }

    private function onNodeRemoved(node:FallNode)
    {
    }


}
