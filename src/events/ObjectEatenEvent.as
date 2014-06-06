package events {
import flash.events.Event;

import gameobjects.GameObject;

public class ObjectEatenEvent extends Event{

    public static const OBJECT_EATEN : String = "objectEaten";

    private var _objectEaten : GameObject;


    public function ObjectEatenEvent(type:String,objectEaten:GameObject,bubbles:Boolean=false,cancelable:Boolean=false) {
        super(type, bubbles , cancelable);
        _objectEaten = objectEaten;

    }

    public function get objectEaten():GameObject {
        return _objectEaten;
    }

    public function set objectEaten(value:GameObject):void {
        _objectEaten = value;
    }

    override public function clone():Event {
        return new ObjectEatenEvent(type,_objectEaten,bubbles,cancelable);
    }
}
}
