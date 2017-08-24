import gengine.*;
import gengine.math.*;
import gengine.graphics.*;
import systems.*;
import components.*;
import gengine.components.*;
import js.jquery.*;
import js.UIPages;
import js.PagesSet;

class ExitSystem extends System
{
    public function new()
    {
        super();
    }

    override public function update(dt:Float):Void
    {
        if(Gengine.getInput().getScancodePress(41))
        {
            Gengine.exit();
        }
    }
}

class Application
{
    private static var engine:Engine;
    private static var pages:PagesSet;
    private static var basket:Entity;

    public static function init()
    {
        Gengine.setWindowSize(new IntVector2(512, 512));
        Gengine.setWindowTitle("bananajam2017");
        Gengine.setGuiFilename("gui/gui.html");
    }

    public static function start(_engine:Engine)
    {
        engine = _engine;

        Gengine.getRenderer().getDefaultZone().setFogColor(new Color(1,1,1,1));

        createCamera();

        var e:Entity;

        e = createBackground();
        engine.addEntity(e);

        e = createTree();
        engine.addEntity(e);
        e.position = new Vector3(0, 26, 0);

        basket = createBasket();

        createSpawner(-100, 200);
        createSpawner(100, 200);
        createSpawner(80, 150);
        createSpawner(-120, 120);
        createSpawner(-80, 100);
        createSpawner(50, 100);
        createSpawner(20, 230);
        createSpawner(-20, 230);

        engine.addSystem(new ExitSystem(), 0);
        engine.addSystem(new AudioSystem(), 0);
        engine.addSystem(new BasketSystem(), 0);

        AudioSystem.instance.playGameMusic();
    }

    private static function createSpawner(x, y):Entity
    {
        var e = new Entity();
        e.add(new Spawner());
        e.position = new Vector3(x, y, 0);
        engine.addEntity(e);
        return e;
    }

    private static function createTree():Entity
    {
        var e = new Entity();
        e.name = "tree";
        e.add(new StaticSprite2D());
        e.get(StaticSprite2D).setSprite(Gengine.getResourceCache().getSprite2D("banana-tree.png", true));
        e.get(StaticSprite2D).setLayer(1);
        e.scale = new Vector3(2.2, 2.2, 1);
        return e;
    }

    private static function createBasket():Entity
    {
        var e = new Entity();
        e.add(new StaticSprite2D());
        e.add(new Basket());
        e.get(StaticSprite2D).setSprite(Gengine.getResourceCache().getSprite2D("crate.png", true));
        e.get(StaticSprite2D).setLayer(1);
        e.scale = new Vector3(1, 1, 1);
        e.name = "basket";
        e.position = new Vector3(0, -200, 0);
        return e;
    }

    private static function createBackground():Entity
    {
        var e = new Entity();
        e.add(new StaticSprite2D());
        e.get(StaticSprite2D).setSprite(Gengine.getResourceCache().getSprite2D("background.png", true));
        e.get(StaticSprite2D).setLayer(0);
        return e;
    }

    private static function createCamera():Entity
    {
        var e = new Entity();
        e.name = "camera";
        e.add(new Camera());
        e.get(Camera).setOrthoSize(new Vector2(512, 512));
        e.get(Camera).setOrthographic(true);
        engine.addEntity(e);
        var viewport:Viewport = new Viewport(Gengine.getContext());
        viewport.setScene(Gengine.getScene());
        viewport.setCamera(e.get(Camera));
        Gengine.getRenderer().setViewport(0, viewport);
        return e;
    }

    public static function onGuiLoaded()
    {
        pages = UIPages.createSet(new JQuery("#body"));

        pages.showPage(".menu");

        new JQuery(".menu").click(
            function(e)
            {
                engine.addEntity(basket);
                engine.addSystem(new SpawnSystem(), 0);
                engine.addSystem(new FallSystem(), 0);
                engine.addSystem(new GrowSystem(), 0);
                engine.addSystem(new ShakeSystem(), 0);
                pages.showPage(".hud");
            }
            );
    }
}
