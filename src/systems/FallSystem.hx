package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import components.*;
import js.jquery.*;
import ash.tools.ListIteratingSystem;

class FallNode extends Node<FallNode>
{
    public var sprite:StaticSprite2D;
    public var fall:Fall;
    public var banana:Banana;
}

class FallSystem extends ListIteratingSystem<FallNode>
{
    private var engine:Engine;
    private var basket:Entity;

    public function new()
    {
        super(FallNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;

        basket = cast engine.getEntityByName("basket");
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

        p = node.entity.position;
        var bp = basket.position;
        var bs = 32;

        if(p.y < bp.y + bs && p.y > bp.y - bs && p.x < bp.x + bs && p.x > bp.x - bs)
        {
            engine.removeEntity(node.entity);
            if(node.banana.good)
            {
                AudioSystem.instance.playSound("pick");
                basket.get(Basket).score += 100;
                (new JQuery(".score")).text(Std.string(basket.get(Basket).score));
            }
            else
            {
                AudioSystem.instance.playSound("hurt");
                basket.get(Basket).life -= 1;
                (new JQuery(".life")).text(Std.string(basket.get(Basket).life));

                var shaker:Shaker;

                if(basket.has(Shaker))
                {
                    shaker= basket.get(Shaker);
                    shaker.duration += 0.45;
                }
                else
                {
                    shaker = new Shaker(0.45, false, 10, 0.05);
                    basket.add(shaker);
                }

                if(basket.get(Basket).life <= 0)
                {
                    Application.gameOver();
                }
            }
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
