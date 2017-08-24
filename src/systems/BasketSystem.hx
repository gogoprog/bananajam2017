package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import components.*;

import ash.tools.ListIteratingSystem;

class BasketNode extends Node<BasketNode>
{
    public var basket:Basket;
}

class BasketSystem extends ListIteratingSystem<BasketNode>
{
    private var engine:Engine;
    private var camera:Camera;

    public function new()
    {
        super(BasketNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;
        camera = engine.getEntityByName("camera").get(Camera);
    }

    private function updateNode(node:BasketNode, dt:Float):Void
    {
        var input = Gengine.getInput();
        var mousePosition = input.getMousePosition();
        var mouseScreenPosition = new Vector2(mousePosition.x / 512, mousePosition.y / 512);
        var mouseWorldPosition = camera.screenToWorldPoint(new Vector3(mouseScreenPosition.x, mouseScreenPosition.y, 0));

        var p = node.entity.position;
        p.x = mouseWorldPosition.x;
        node.entity.position = p;
    }

    private function onNodeAdded(node:BasketNode)
    {
        node.basket.score = 0;
    }

    private function onNodeRemoved(node:BasketNode)
    {
    }
}
