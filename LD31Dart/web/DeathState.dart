library ld31_state_death;

import "dart:html";
import "State.dart";
import "Game.dart";
import "MouseManager.dart";

class DeathState extends State{
  
  static int _wave;
  
  Rectangle _playBounds;
  bool _hover;
  double _timer = 0.0;
  
  DeathState(){
    _playBounds = new Rectangle(Game.WIDTH / 2 - 200, Game.HEIGHT / 2 + 28, 325, 100);
    _hover = false;
  }
  
  void tick(final double delta){
    
    _timer += delta;
    if(_timer > 1){
      if(_playBounds.containsRectangle(new Rectangle(MouseManager.getX(), MouseManager.getY(), 1, 1))){
       _hover = true;
       if(MouseManager.isPressed())
         State.setState(Game.menuState);
      }else
       _hover = false;
    }
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillStyle = "#333333";
    g.font = "64px Calibri";
    g.fillText("You made it to wave: ", Game.WIDTH / 2 - 300, Game.HEIGHT / 2 - 200);
    g.font = "100px Calibri";
    g.fillStyle = "GREEN";
    g.fillText(_wave.toString(), Game.WIDTH / 2 - 50, Game.HEIGHT / 2 - 100);
    
    if(_hover)
      g.fillStyle = "GREEN";
    else
      g.fillStyle = "RED";
    g.fillText("MENU!", Game.WIDTH / 2 - 200, Game.HEIGHT / 2 + 128);
  }
  
  void onShow(){
    _timer = 0.0;
  }
  
  void onHide(){
    _wave = 0;
  }
  
  static void setWave(int i){
    _wave = i;
  }
  
}