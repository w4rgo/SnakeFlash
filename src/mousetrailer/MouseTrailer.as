package mousetrailer {

import flash.display.Sprite;
import flash.events.Event;

import org.as3commons.collections.LinkedList;
import org.as3commons.collections.framework.IIterator;

public class MouseTrailer extends Sprite {

    // Vars
    private var particleArray:LinkedList;
    private var notShownParticles:LinkedList;

    // Settings
    private var particleMaxSpeed:Number = 1;
    private var particleFadeSpeed:Number = .05;
    private var particleTotal:Number = 25;
    private var particleRange:Number = 50;
    private var particleCurrentAmount:Number = 0;
    private var particleTotalFrames:int = 10;

    public function MouseTrailer() {

    }

    public function init():void {
        particleArray = new LinkedList();
        notShownParticles = new LinkedList();
        initParticles();
        addEventListener(Event.ENTER_FRAME, onEnterFrameLoop);
    }

    public function stop():void {
        removeEventListener(Event.ENTER_FRAME,onEnterFrameLoop);
        particleArray=null;
        notShownParticles=null;


    }

    public function initParticles():void {

        for (var i:int = 0; i < particleTotal * (particleTotalFrames + 1) ; i++) {
            notShownParticles.add(new Particle());
        }

    }

    private function onEnterFrameLoop(event:Event):void {
        createParticle(stage.mouseX, stage.mouseY);
        updateParticle();

    }

    public function get particleNum():int {
        return particleArray.size;
    }

    /**
     * createParticle(target X position, target Y position)
     */
    public function createParticle(targetX:Number, targetY:Number):void {
        //run for loop based on particleTotal
        for (var i:Number = 0; i < particleTotal; i++) {

            //  var particle_mc:MovieClip =new MovieClip();
            trace(notShownParticles.size + " - " + particleArray.size);
            var particle_mc:Particle = notShownParticles.first;
            notShownParticles.remove(particle_mc);

            var shapeRandom:int = Math.random() * 3;

            if (shapeRandom >= 0 && shapeRandom < 1) {
                particle_mc.createShape("circle", 3);
            } else if (shapeRandom >= 1 && shapeRandom < 2) {
                particle_mc.createShape("triangle", 3);
            } else if (shapeRandom >= 2 && shapeRandom < 3) {
                particle_mc.createShape("square", 3);
            }


            //set position & rotation, alpha
            particle_mc.x = targetX;
            particle_mc.y = targetY;
            particle_mc.rotation = Math.random() * 360;
            particle_mc.alpha = Math.random() * .5 + .5;
            particle_mc.lifeTime = 0;

            //set particle boundry
            particle_mc.boundyLeft = targetX - particleRange;
            particle_mc.boundyTop = targetY - particleRange;
            particle_mc.boundyRight = targetX + particleRange;
            particle_mc.boundyBottom = targetY + particleRange;

            //set speed/direction of fragment
            particle_mc.speedX = Math.random() * particleMaxSpeed - Math.random() * particleMaxSpeed;
            particle_mc.speedY = Math.random() * particleMaxSpeed - Math.random() * particleMaxSpeed;
            particle_mc.speedX *= particleMaxSpeed;
            particle_mc.speedY *= particleMaxSpeed;

            //set fade out speed
            particle_mc.fadeSpeed = Math.random() * particleFadeSpeed;

            //just a visual particle counter
            particleCurrentAmount++;

            // add to array
            particleArray.add(particle_mc);

            // add to display list
            addChild(particle_mc);
        }
    }

    private function updateParticle():void {

        var iterator : IIterator = particleArray.iterator();
        while (iterator.hasNext()) {

            var tempParticle:Particle = iterator.next();
            //update alpha, x, y
            //tempParticle.alpha -= tempParticle.fadeSpeed;
            tempParticle.x += tempParticle.speedX;
            tempParticle.y += tempParticle.speedY;
            tempParticle.lifeTime += 1;

            // if fragment is invisible remove it
            if (tempParticle.lifeTime > particleTotalFrames) {
                destroyParticle(tempParticle);
            }
            // if fragment is out of bounds, increase fade out speed
            else if (tempParticle.x < tempParticle.boundyLeft ||
                    tempParticle.x > tempParticle.boundyRight ||
                    tempParticle.y < tempParticle.boundyTop ||
                    tempParticle.y > tempParticle.boundyBottom) {
                tempParticle.fadeSpeed += .05;
            }
        }


    }

    private function destroyParticle(particle:Particle):void {


        particleCurrentAmount--;
        notShownParticles.add(particle);
        particleArray.remove(particle);
        removeChild(particle);

    }


}
}
