package {
import gameobjects.IGameObject;
import gameobjects.factories.GameObjectFactory;
import gameobjects.factories.GameObjectType;
import gameobjects.factories.IGameObjectFactory;
import org.as3commons.collections.LinkedList;
import org.as3commons.collections.framework.IIterator;

public class Snake {


    private var snakeDir:String = "south";
    private var snakeY:int = 0;
    private var snakeX:int = 0;
    private var _snakeTotalSize:int = 4;
    private var partSize:int = 3;
    private var _snakeBody:LinkedList;
    private var _snakeScore:int = 0;


    public function Snake(squareSize:int, startX:int, startY:int) {
        snakeY = startY;
        snakeX = startX;
        partSize = Configuration.SQUARE_SIZE;
        _snakeBody = new LinkedList();
    }


    public function get snakeBody():LinkedList {
        return _snakeBody;
    }

    public function get snakeTotalSize():int {
        return _snakeTotalSize;
    }

    public function set snakeTotalSize(value:int):void {
        _snakeTotalSize = value;
    }

    public function getHead():IGameObject {
        return _snakeBody.last;
    }

    public function get snakeScore():int {
        return _snakeScore;
    }

    public function set snakeScore(value:int):void {
        _snakeScore = value;
    }

    public function checkCollisions():Boolean {
        var result:Boolean = false;
        var iter:IIterator = _snakeBody.iterator();
        while (iter.hasNext()) {
            var part:IGameObject = iter.next();

            var innerIter:IIterator = _snakeBody.iterator();
            while (innerIter.hasNext()) {
                var part2:IGameObject = innerIter.next();

                if (part.collides(part2)) {

                    result = true;
                }
            }
        }
        return result;
    }

    public function advance():void {

        switch (snakeDir) {
            case "south" :

                snakeY = snakeY + partSize;
                break;
            case "north":
                snakeY = snakeY - partSize;
                break;
            case "west":
                snakeX = snakeX - partSize;
                break;
            case "east":
                snakeX = snakeX + partSize;
                break;
        }

        var part:IGameObject;
        if (_snakeBody.size > _snakeTotalSize) {
            part = _snakeBody.first;
            //removeChild(part);
            _snakeBody.removeFirst();
            part.move(snakeX, snakeY);
            _snakeBody.add(part);

        } else {
            var factory:IGameObjectFactory = new GameObjectFactory();
            part = factory.createGameObject(GameObjectType.SNAKE_PART);
            part.move(snakeX,snakeY);
            _snakeBody.add(part);


        }
        //checkCollisions();

    }


    public function moveSnakeDown():void {

        if (snakeDir != "north" && snakeDir != "south") {

            snakeDir = "south";
        }


    }

    public function moveSnakeLeft():void {

        if (snakeDir != "east" && snakeDir != "west") {
            snakeDir = "west";
        }

    }

    public function moveSnakeRight():void {
        if (snakeDir != "west" && snakeDir != "east") {
            snakeDir = "east";
        }

    }

    public function moveSnakeUp():void {

        if (snakeDir != "south" && snakeDir != "north") {
            snakeDir = "north";
        }
    }


}
}
