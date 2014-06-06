package animals {
public class Dog extends Animal {



    public function Dog(name : String) {

        super(name);
        
        setLegs=4;

    }

    override public function talk():String {
        return "BARK";
    }
}
}
