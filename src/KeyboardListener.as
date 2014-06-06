package {
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.utils.Dictionary;

public class KeyboardListener {

    private var context: Stage;
    private var keyDict: Dictionary;

    public function KeyboardListener(context:Stage) {
        this.keyDict=new Dictionary();
        this.context=context;

        addKeyListeners();
    }

    private function addKeyListeners():void {
        context.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
        context.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
    }

    public function unload():void {
        context.removeEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
        context.removeEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
    }


    private function reportKeyDown(event:KeyboardEvent):void
    {
        var func: Function;
        func = keyDict[event.keyCode];
        if(func!=null) {
            func();
        }

    }

    public function mapKey( code: int , func : Function):void {
        this.keyDict[code] = func;
    }



    private function reportKeyUp(event:KeyboardEvent):void
    {
     //  trace("Key Released: " + String.fromCharCode(event.charCode) +         " (key code: " + event.keyCode + " character code: " +         event.charCode + ")");

    }
}
}
