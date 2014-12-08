library ld31_state_game;

import "dart:html";
import "State.dart";
import "Game.dart";
import "HUD.dart";
import "Gun.dart";
import "Player.dart";
import "EnemyManager.dart";
import "WaveManager.dart";
import "Sound.dart";

class GameState extends State{
  
  WaveManager _waveManager;
  Player _player;
  HUD _hud;
  
  GameState(HUD hud){
    _hud = hud;
    _player = new Player(Game.WIDTH / 2, Game.HEIGHT / 2, hud);
    EnemyManager.init(_player);
    
    _waveManager = new WaveManager(_player, hud);
  }
  
  void tick(final double delta){
    _player.tick(delta);
    EnemyManager.tick(delta);
    Gun.tickBullets(delta);
    
    _waveManager.tick(delta);
  }
    
  void render(CanvasRenderingContext2D g){
    Gun.renderBullets(g);
    _player.render(g);
    EnemyManager.render(g);
    
    _waveManager.render(g);
  }
    
  void onShow(){
    EnemyManager.reset();
    _player.reset();
    Gun.reset();
    _waveManager.reset();
    _hud.reset(_player.getHealth());
  }
    
  void onHide(){
    
  }
  
}