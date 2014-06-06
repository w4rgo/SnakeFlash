package mousetrailer {
import animals.Animal;

import flash.display.DisplayObject;

import flash.display.DisplayObjectContainer;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import animals.*;

import utils.FPSCounter;

[SWF (frameRate=60)]
public class Starter_1 extends Sprite {
    private var tField:TextField= new TextField();
    private var mouseTrailer : MouseTrailer;

    public function Starter_1() {

        var animal: Animal = new Dog("DOG");

        mouseTrailer = new MouseTrailer();
        addChild(new FPSCounter());

        addChild(mouseTrailer);
        mouseTrailer.init();


        initText();
        addChild(tField);
        addEventListener(Event.ENTER_FRAME, onEnterFrameLoop);
       // var container : DisplayObjectContainer = new DisplayObjectContainer();


      //  container.addChild(mouseTrailer.createShape("circle"));
       // myTest(animal);
    }

    private function onEnterFrameLoop(event:Event):void
    {

        myTest(mouseTrailer.particleNum);
    }

    private function initText() : void {
        tField.autoSize = "left";
        tField.background = true;
        tField.border = true;
        tField.x = 50;
        tField.y = 75;
    }
    private function myTest(particleNum: int):void {
        //tField = new TextField();

        tField.text = particleNum.toString();


    }
}



}