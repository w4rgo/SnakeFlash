package scenes {
import flash.display.Sprite;
import flash.display.Stage;
import flash.text.TextField;

import mousetrailer.MouseTrailer;

public class MainScene extends Sprite implements IGameScene{
    private var title : TextField;
    private var keyboardListener: KeyboardListener;
    private var mouseTrailer: MouseTrailer;
    private var context: Stage;
    public function MainScene(context:Stage) {
        this.context=context;
    }
    public function update():void {
    }

    public function redraw():void {
    }

    public function load():void {

        keyboardListener = new KeyboardListener(context);
        keyboardListener.mapKey(13,startGame);
        initText();
        mouseTrailer = new MouseTrailer();

        addChild(mouseTrailer);
        mouseTrailer.init();

    }

    private function startGame():void {

        GameSceneManager.changeScene( new GameplayScene(context));
    }

    public function unload():void {
        keyboardListener.unload();
        keyboardListener=null;
        removeChild(title);
        removeChild(mouseTrailer);
        mouseTrailer.stop();
        mouseTrailer=null;
    }

    private function initText() : void {
        title=new TextField();
        title.autoSize = "left";
        title.background = true;
        title.border = true;
        title.x = 50;
        title.y = 75;
        title.text="SNAKE GAME, click anywhere and press ENTER to start!";
        addChild(title);
    }
}
}
