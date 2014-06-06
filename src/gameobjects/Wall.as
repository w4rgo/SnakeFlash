package gameobjects {
import flash.display.Sprite;

import gameobjects.GameObject;

public class Wall extends GameObject{
    public function Wall( ) {
        super(0x000000);


    }


    override public function scoreValue() : int {
        return 0;
    }

}
}
