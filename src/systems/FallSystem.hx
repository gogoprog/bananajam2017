package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import systems.*;
import components.*;

import ash.tools.ListIteratingSystem;
import ash.core.NodeList;

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

    }

    private function onNodeAdded(node:FallNode)
    {
    }

    private function onNodeRemoved(node:FallNode)
    {
    }


}
