package {
import flash.display.Sprite;
import flash.display.Stage;

import scenes.GameSceneManager;

import scenes.GameplayScene;
import scenes.MainScene;

public class Main extends Sprite{
    public var gameSceneManagerInstance:GameSceneManager;


    public function Main() {

        this.gameSceneManagerInstance = GameSceneManager.getInstance( this );

        //var menuScene:MenuScene = new MenuScene();
        GameSceneManager.changeScene( new MainScene(stage) );
    }




}
}
