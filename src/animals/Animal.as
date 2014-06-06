package animals {
import flash.text.TextField;

public class Animal {

    private var legs:int;
    private var name:String;
    public function Animal(name : String = "NO NAME") {
        this.name =  name;
        legs = 2;
    }

    public function get getLegs():int {
        return legs;
    }

    public function set setLegs(numLegs: int ) {
        legs = numLegs;
    }



    public function talk():String {
        return "TALK";
    }


    public function toString():String {
        return "I am " + name + " and I " +talk() + " and I have " +getLegs+ " legs! " ;
    }
}
}
