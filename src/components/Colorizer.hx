package components;

import gengine.math.*;

class Colorizer
{
    public var time:Float = 0;

    public var duration:Float;
    public var color:Color;

    public var initialColor:Color;

    public function new(duration, color)
    {
        this.duration = duration;
        this.color = color;
    }
}
