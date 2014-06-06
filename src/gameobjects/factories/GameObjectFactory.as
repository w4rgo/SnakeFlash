package gameobjects.factories {
import gameobjects.Fruit;
import gameobjects.Gold;
import gameobjects.IGameObject;
import gameobjects.SnakePart;
import gameobjects.Wall;

public class GameObjectFactory implements IGameObjectFactory {
    public function GameObjectFactory() {
    }


    public function createGameObject(type:String):IGameObject {
        switch (type) {
            case GameObjectType.WALL: return new Wall();
            case GameObjectType.GOLD: return new Gold();
            case GameObjectType.FRUIT: return new Fruit();
            case GameObjectType.SNAKE_PART: return new SnakePart();

        }
        throw(new Error("There isn't an implementation for this type: " + type));
        return null;

    }
}
}
