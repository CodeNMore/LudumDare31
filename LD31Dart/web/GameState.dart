library ld31_state_game;

import "dart:html";
import "State.dart";
import "Game.dart";
import "HUD.dart";
import "Gun.dart";
import "Player.dart";
import "EnemyManager.dart";

class GameState extends State{
  
  Player _player;
  
  GameState(HUD hud){
    _player = new Player(Game.WIDTH / 2, Game.HEIGHT / 2, hud);
    EnemyManager.init(_player);
  }
  
  void tick(final double delta){
    _player.tick(delta);
    Gun.tickBullets(delta);
    
    EnemyManager.tick(delta);
  }
    
  void render(CanvasRenderingContext2D g){
    Gun.renderBullets(g);
    _player.render(g);
    EnemyManager.render(g);
  }
    
  void onShow(){
    
  }
    
  void onHide(){
    
  }
  
}