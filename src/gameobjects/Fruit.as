package gameobjects {
import flash.display.Sprite;

public class Fruit extends GameObject{

    public function Fruit( ) {

        super(0xFF3300);

    }



    override public function scoreValue() : int {
        return 5;
    }

}
}
