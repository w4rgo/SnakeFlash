package ui {
import flash.display.Graphics;

import gameobjects.IDrawableGameObject;

import gameobjects.IDrawableGameObject;

import org.as3commons.collections.LinkedList;
import org.as3commons.collections.framework.IIterator;


public class Renderer {

    private var graphics:Graphics;


    public function Renderer(graphics:Graphics) {
        this.graphics = graphics;
    }

    public function paint(array:Vector.<IDrawableGameObject>) {

        for each (var object:IDrawableGameObject in array) {
            paintObject(object);
        }
    }

    private function paintObject(object:IDrawableGameObject):void {
        this.graphics.lineStyle(1, 0x000000);
        this.graphics.beginFill(object.color);
        this.graphics.drawRect(object.x, object.y, object.size, object.size);
        this.graphics.endFill();
    }

    public function paintLinkedList(array:LinkedList) {

        var iterator:IIterator = array.iterator();
        while (iterator.hasNext()) {
            var object:IDrawableGameObject = iterator.next();
            paintObject(object);
        }
    }

    public function clear() {
        graphics.clear();
    }
}
}
