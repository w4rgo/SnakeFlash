package {
import events.ObjectEatenEvent;
import events.SnakeEvents;

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.utils.Dictionary;
import flash.utils.Timer;

import gameobjects.GameObject;
import gameobjects.IGameObject;
import gameobjects.factories.GameObjectFactory;
import gameobjects.factories.GameObjectType;
import gameobjects.factories.IGameObjectFactory;

import mx.charts.chartClasses.RenderData;

import org.as3commons.collections.LinkedList;
import org.as3commons.collections.framework.IIterator;

import ui.Renderer;

import utils.FPSCounter;

public class SnakeGame  {

    private var squareSize:int = Configuration.SQUARE_SIZE;
    private var speed:int = 100;
    private var snakeOne:Snake;
    private var fruits:LinkedList;
    private var numFruits:int = 5;
    private var playerOneScore:TextField;
    private var playerTwoScore:TextField;
    private var offsetX:int = 0;
    private var offsetY:int = squareSize * 10;
    private var boardSizeX:int = 40 * squareSize;
    private var boardSizeY:int = 40 * squareSize;
    private var startX:int = boardSizeX / 2 + offsetX;
    private var startY:int = boardSizeY / 2 + offsetY;
    private var boundaries:LinkedList;
    private var gameOver:Boolean;
    private var board:Array;
    private var renderer:Renderer;
    private var keyboardListener: KeyboardListener;

    //public function SnakeGame(context: Stage) {
    public function SnakeGame(keyboardListener: KeyboardListener , renderer:Renderer) {
        //this.context= context;
        this.renderer= renderer;
        this.keyboardListener = keyboardListener;
        startGame();

    }

    private function startGame():void {

        fruits = new LinkedList();
        boundaries = new LinkedList();
        snakeOne = new Snake(squareSize, startX, startY);
        initScoreboard();
        generateBoundaries();
        //setupEventHandlers();
        setupTimer();
        keyboardSetup();
        generateFruits();
       // addChild(new FPSCounter());
        //renderer = new Renderer(context.graphics);


    }

    private function generateBoard():void {
        board = new Array();
        for (var i:int = 0; i < boardSizeY; i++) {

            board[i] = new Array();


        }
    }

    private function initScoreboard():void {
        playerOneScore = new TextField();
        playerTwoScore = new TextField();
        gameOver = false;
        playerOneScore.autoSize = "left";
        playerOneScore.background = true;
        playerOneScore.border = true;
        playerOneScore.x = boardSizeX + 10;
        playerOneScore.y = offsetY + 10;
        playerOneScore.text = "0";
        //addChild(playerOneScore);
    }

    private function setupTimer():void {
        var snakeTimer:Timer = new Timer(speed, 0);
        snakeTimer.start();
        snakeTimer.addEventListener(TimerEvent.TIMER, ticker);
    }

    private function ticker(event:TimerEvent):void {
        if (gameOver == false) {
            snakeOne.advance();
            this.checkObjectCollisions();

            renderer.clear();
            renderer.paintLinkedList(fruits);
            renderer.paintLinkedList(boundaries);
            renderer.paintLinkedList(snakeOne.snakeBody);
        }
    }

    /*private function setupEventHandlers():void {

        addEventListener(ObjectEatenEvent.OBJECT_EATEN, objectEatenHandler);
        addEventListener(SnakeEvents.WALL_COLLISION, wallCollisionHandler);
    }*/

    private function keyboardSetup():void {
        //var keyBoardListener : KeyboardListener= new KeyboardListener(context);
        keyboardListener.mapKey(37,snakeOne.moveSnakeLeft);
        keyboardListener.mapKey(38,snakeOne.moveSnakeUp);
        keyboardListener.mapKey(39,snakeOne.moveSnakeRight);
        keyboardListener.mapKey(40,snakeOne.moveSnakeDown);
    }

    private function generateFruits(e:TimerEvent = null):void {
        //  var fruit:Fruit = new Fruit(squareSize,randomizeCoordX(),randomizeCoordY());
        var factory:IGameObjectFactory = new GameObjectFactory();
        var gameObject:IGameObject = factory.createGameObject(GameObjectType.FRUIT);
        gameObject.move(randomizeCoordX(), randomizeCoordY());

        fruits.add(gameObject);

    }

    private function generateBoundaries():void {
        var lenght:int = boardSizeX;
        var height:int = boardSizeY;

        var factory:IGameObjectFactory = new GameObjectFactory();


        for (var i:int = 0; i < lenght; i++) {
            var wall:IGameObject = factory.createGameObject(GameObjectType.WALL);
            wall.move(i, 0 + offsetY)
            boundaries.add(wall);

            wall = factory.createGameObject(GameObjectType.WALL);
            wall.move(i, height + offsetY)
            boundaries.add(wall);

        }

        for (var i:int = 0 + offsetY; i < height + offsetY; i++) {
            var wall:IGameObject = factory.createGameObject(GameObjectType.WALL);
            wall.move(0, i);

            boundaries.add(wall);


            wall = factory.createGameObject(GameObjectType.WALL);
            wall.move(lenght, i);

            boundaries.add(wall);

        }
    }


    private function randomizeCoordX():int {

        var max:int = boardSizeX + offsetX - (squareSize);
        var min:int = offsetX + (squareSize);
        var num:int = (Math.floor((Math.random() * (max - min) / squareSize))) * squareSize + min;
        return num;

    }


    private function randomizeCoordY():int {

        var max:int = boardSizeY + offsetY - (squareSize);
        var min:int = offsetY + (squareSize);
        var num:int = (Math.floor((Math.random() * (max - min) / squareSize))) * squareSize + min;
        return num;

    }

    private function checkObjectCollisions():void {

        if (snakeOne.checkCollisions()) {
            playerOneScore.text = "GAME OVER, Points: " + snakeOne.snakeScore;
            this.gameOver = true;
        }
        //checking collisions with the fruits
        var iter:IIterator = fruits.iterator();
        while (iter.hasNext()) {


            var object:GameObject = iter.next();
            if (object.collides(snakeOne.getHead())) {
               // dispatchEvent(new ObjectEatenEvent(ObjectEatenEvent.OBJECT_EATEN, object));
                objectEaten(object);
            }
        }
        //check collisions with the boundaries
        var iter:IIterator = boundaries.iterator();
        while (iter.hasNext()) {
            var object:GameObject = iter.next();
            if (object.collides(snakeOne.getHead())) {
              //  dispatchEvent(new Event(SnakeEvents.WALL_COLLISION));
                wallCollision();
            }
        }

    }


    private function wallCollision():void {
        playerOneScore.text = "GAME OVER, Points: " + snakeOne.snakeScore;
        //snakeOne.getHead().setHitColor();
        this.gameOver = true;

    }
    private function  objectEaten(object :IGameObject) : void {



      //  var object:GameObject = object;

        snakeOne.snakeScore = snakeOne.snakeScore + object.scoreValue();

        playerOneScore.text = snakeOne.snakeScore.toString();
        snakeOne.snakeTotalSize += 1;
        generateFruits();
        if (speed > 30) {
            speed = speed - 5;
        }

        fruits.remove(object);
    }

    private function wallCollisionHandler(event:Event) {
        playerOneScore.text = "GAME OVER, Points: " + snakeOne.snakeScore;
        //snakeOne.getHead().setHitColor();
        this.gameOver = true;
    }

    private function objectEatenHandler(event:ObjectEatenEvent):void {

        var object:GameObject = event.objectEaten;

        snakeOne.snakeScore = snakeOne.snakeScore + object.scoreValue();

        playerOneScore.text = snakeOne.snakeScore.toString();
        snakeOne.snakeTotalSize += 1;
        generateFruits();
        if (speed > 30) {
            speed = speed - 5;
        }

        fruits.remove(object);

    }

}
}
