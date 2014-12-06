library ld31_state_game;

import "dart:html";
import "State.dart";
import "Game.dart";

import "Player.dart";

class GameState extends State{
  
  Player _player;
  
  GameState(){
    _player = new Player(Game.WIDTH / 2, Game.HEIGHT / 2);
  }
  
  void tick(final double delta){
    _player.tick(delta);
  }
    
  void render(CanvasRenderingContext2D g){
    _player.render(g);
  }
    
  void onShow(){
    
  }
    
  void onHide(){
    
  }
  
}