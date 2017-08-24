package components;

class Shaker
{
    public var timeLeft:Float = 0;
    public var time:Float = 0;
    public var fall = true;
    public var duration:Float;
    public var interval:Float;
    public var intensity:Float;

    public function new(duration:Float, fall:Bool, intensity:Float, interval:Float)
    {
        this.duration = duration;
        this.fall = fall;
        this.intensity = intensity;
        this.interval = interval;
    }
}
