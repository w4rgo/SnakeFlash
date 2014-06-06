package gameobjects {
import flash.display.Sprite;

public interface IGameObject extends IDrawableGameObject{

   // function buildGraphics(size:int):void;

    function move ( x:int ,y :int):void;

    function collides(part: IGameObject):Boolean;

    function scoreValue():int;

}
}
