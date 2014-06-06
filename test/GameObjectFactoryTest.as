package {

import gameobjects.Fruit;
import gameobjects.Gold;
import gameobjects.IGameObject;
import gameobjects.SnakePart;
import gameobjects.Wall;
import gameobjects.factories.GameObjectFactory;
import gameobjects.factories.GameObjectType;
import gameobjects.factories.IGameObjectFactory;


import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;
import org.flexunit.asserts.assertTrue;

public class GameObjectFactoryTest {
    private var factory:IGameObjectFactory;

    public function GameObjectFactoryTest() {
    }

    [Before]
    public function setup():void {
        factory = new GameObjectFactory();
    }

    [After]
    public function tearDown():void {
        factory = null;
    }

    [Test(expects="Error")]
    public function cannotCreateLead():void {
        var object:IGameObject = factory.createGameObject("LEAD");

        assertNull(object);
    }

    [Test]
    public function canCreateThings():void {

        var typeClasses: Vector.<GameObjectTypeClass> = Vector.<GameObjectTypeClass>([new GameObjectTypeClass(GameObjectType.FRUIT,Fruit),
            new GameObjectTypeClass(GameObjectType.GOLD,Gold),new GameObjectTypeClass(GameObjectType.SNAKE_PART,SnakePart),new GameObjectTypeClass(GameObjectType.WALL,Wall)])

        for (var i:int; i < typeClasses.length; i++) {
            canCreateObject(typeClasses[i].type, typeClasses[i].typeClass);
        }
    }

    private function canCreateObject(type:String, typeClass:Class):void {
        var object:IGameObject = factory.createGameObject(type);

        assertNotNull(object);
        assertTrue(object is typeClass);

    }
}
}

class GameObjectTypeClass {

    private var _type:String;
    private var _typeClass:Class;

    public function GameObjectTypeClass(type:String, typeClass:Class) {
        this._type = type;
        this._typeClass = typeClass;
    }

    public function get type():String {
        return _type;
    }

    public function get typeClass():Class {
        return _typeClass;
    }
}
