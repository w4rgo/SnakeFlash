package gameobjects {
import flash.display.Sprite;

public class Gold extends GameObject{
    public function Gold() {
        super(0xFF3300);

    }


    override public function scoreValue() : int {
        return 10;
    }

}
}
