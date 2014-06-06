package gameobjects.factories {
import gameobjects.*;

public interface IGameObjectFactory {


    function createGameObject(type:String):IGameObject;

}
}
