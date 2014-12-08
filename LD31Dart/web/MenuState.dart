library ld31_state_menu;

import "dart:html";
import "MouseManager.dart";
import "State.dart";
import "Game.dart";
import "ParticleEmitter.dart";

class MenuState extends State{
  
  List<ParticleEmitter> _emitters;
  
  bool _hover = false, _before = false;
  Rectangle _playBounds;
  
  double _timer = 0.0;
  
  MenuState(){
    _emitters = [
      new ParticleEmitter(700.0, 600.0, -1, 4, 4, "#639FC9", 2, 4, 45, 135, 1, 2, 0.0),
      new ParticleEmitter(500.0, 600.0, -1, 4, 4, "#35FF93", 2, 4, 45, 135, 1, 2, 0.0),
      new ParticleEmitter(300.0, 600.0, -1, 4, 4, "#FF66C3", 2, 4, 45, 135, 1, 2, 0.0),
      new ParticleEmitter(100.0, 600.0, -1, 4, 4, "#66C396", 2, 4, 45, 135, 1, 2, 0.0)
    ];
    
    _playBounds = new Rectangle(Game.WIDTH / 2 - 200, Game.HEIGHT / 2 + 28, 225, 100);
  }
  
  void tick(final double delta){
    for(int i = 0;i < _emitters.length;++i){
      _emitters[i].tick(delta);
    }
    
    _timer += delta;
    if(_timer > 1){
      if(_playBounds.containsRectangle(new Rectangle(MouseManager.getX(), MouseManager.getY(), 1, 1))){
       _hover = true;
       if(MouseManager.isPressed())
         State.setState(Game.gameState);
      }else
       _hover = false;
    }
  }
  
  void render(CanvasRenderingContext2D g){
    g.font = "100px Calibri";
    g.fillStyle = "#333333";
    g.fillText("BLOCK", Game.WIDTH / 2 - 250, Game.HEIGHT / 2 - 164);
    g.fillText("BRIGADE", Game.WIDTH / 2 - 200, Game.HEIGHT / 2 - 56);
    if(_hover)
      g.fillStyle = "GREEN";
    else
      g.fillStyle = "RED";
    g.fillText("PLAY!", Game.WIDTH / 2 - 200, Game.HEIGHT / 2 + 128);
    
    for(int i = 0;i < _emitters.length;++i){
      _emitters[i].render(g);
    }
  }
  
  void onShow(){
    
  }
    
  void onHide(){
    _before = false;
    _timer = 0.0;
  }
  
}