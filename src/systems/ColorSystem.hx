package systems;

import gengine.*;
import gengine.math.*;
import gengine.components.*;
import components.*;

import ash.tools.ListIteratingSystem;

class ColorizerNode extends Node<ColorizerNode>
{
    public var colorizer:Colorizer;
    public var sprite:StaticSprite2D;
}

class ColorSystem extends ListIteratingSystem<ColorizerNode>
{
    private var engine:Engine;

    public function new()
    {
        super(ColorizerNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    override public function addToEngine(engine:Engine):Void
    {
        super.addToEngine(engine);
        this.engine = engine;
    }

    private function updateNode(node:ColorizerNode, dt:Float):Void
    {
        var t = node.colorizer.time;
        t += dt;
        node.colorizer.time = t;

        var f = t / node.colorizer.duration;
        var color:Color;

        if(f < 0.5)
        {
            var f = f * 2;

            color = node.colorizer.initialColor + (node.colorizer.color - node.colorizer.initialColor) * f;
        }
        else if( f < 1 )
        {
            var f = (f - 0.5) * 2;

            color = node.colorizer.color + (node.colorizer.initialColor - node.colorizer.color) * f;
        }
        else
        {
            color = node.colorizer.initialColor;
            node.entity.remove(Colorizer);
        }

        node.sprite.setColor(color);
    }

    private function onNodeAdded(node:ColorizerNode)
    {
        node.colorizer.time = 0;
        node.colorizer.initialColor = node.sprite.getColor();
    }

    private function onNodeRemoved(node:ColorizerNode)
    {
    }


}
