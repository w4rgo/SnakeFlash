package scenes {

import flash.display.Sprite;
import flash.display.Stage;

import ui.Renderer;

public class GameplayScene extends Sprite implements IGameScene{


    private var snakeGame : SnakeGame;
    private var keyboardListener : KeyboardListener;
    private var renderer : Renderer;
    private var context: Stage;
    public function GameplayScene(context:Stage) {
        this.context=context;
    }
    public function update():void {
    }

    public function redraw():void {
    }

    public function load():void {

        renderer = new Renderer(graphics);
        keyboardListener = new KeyboardListener(context);
        snakeGame= new SnakeGame(keyboardListener,renderer);

    }

    public function unload():void {
    }
}
}
