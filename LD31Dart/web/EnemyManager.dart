library ld31_enemy_manager;

import "dart:html";
import "Enemy.dart";
import "Player.dart";
import "ParticleEmitter.dart";

class EnemyManager{
  
  static List<Enemy> _enemies;
  static List<int> _toRemove, _toRemoveEmitters;
  static List<ParticleEmitter> _emitters;
  
  static Player _player;
  
  static void init(Player player){
    _enemies = [];
    _toRemove = [];
    _emitters = [];
    _toRemoveEmitters = [];
    _player = player;
        
    _enemies.add(new Enemy(100.0, 100.0, 3, player));
    _enemies.add(new Enemy(200.0, 200.0, 2, player));
    _enemies.add(new Enemy(300.0, 300.0, 1, player));
  }
  
  static void tick(final double delta){
    for(int i = 0;i < _enemies.length;++i){
      if(_enemies[i].tick(delta)){
        _toRemove.add(i);
        _emitters.add(new ParticleEmitter(_enemies[i].getX(), _enemies[i].getY(), 8, 4, 4, _enemies[i].getMainColor(), 1, 2, 0, 360, 1, 1, 0.6));
      }
    }
    
    if(_emitters.length > 0){
      for(int i = 0;i < _emitters.length;++i){
        if(_emitters[i].tick(delta))
          _toRemoveEmitters.add(i);
        }
    }
    
    _iterateToRemove();
  }
  
  static void _iterateToRemove(){
    for(int i = 0;i < _toRemove.length;++i){
      if(_toRemove[i] < _enemies.length){
        _enemies.removeAt(_toRemove[i]);
      }
    }
    _toRemove.clear();
    
    for(int i = 0;i < _toRemoveEmitters.length;++i){
      if(_toRemoveEmitters[i] < _emitters.length)
        _emitters.removeAt(_toRemoveEmitters[i]);
    }
    _toRemoveEmitters.clear();
  }
  
  static void render(CanvasRenderingContext2D g){
    for(int i = 0;i < _enemies.length;++i){
      _enemies[i].render(g);
    }
    
    for(int i = 0;i < _emitters.length;++i){
      _emitters[i].render(g);
    }
  }
  
}